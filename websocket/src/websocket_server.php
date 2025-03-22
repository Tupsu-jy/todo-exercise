<?php
// websocket_server.php
require __DIR__ . '/../vendor/autoload.php';

use Ratchet\Server\IoServer;
use Ratchet\Http\HttpServer;
use Ratchet\WebSocket\WsServer;
use Ratchet\MessageComponentInterface;
use Ratchet\ConnectionInterface;
use React\EventLoop\Factory;
use React\Socket\Server as SocketServer;
use Predis\Async\Client as AsyncRedisClient;

class TodoWebSocketServer implements MessageComponentInterface {
    protected $clients;
    protected $subscriptions = []; // Map connection IDs to notepad IDs

    public function __construct() {
        $this->clients = new \SplObjectStorage;
        echo "WebSocket server started!\n";
    }

    public function onOpen(ConnectionInterface $conn) {
        $this->clients->attach($conn);
        echo "New connection! ({$conn->resourceId})\n";
        
        // Extract notepad ID from query parameters
        $query = $conn->httpRequest->getUri()->getQuery();
        parse_str($query, $params);
        
        if (isset($params['notepad_id'])) {
            $notepadId = $params['notepad_id'];
            $this->subscriptions[$conn->resourceId] = $notepadId;
            echo "Connection {$conn->resourceId} subscribed to notepad {$notepadId}\n";
        }
    }

    public function onMessage(ConnectionInterface $from, $msg) {
        $data = json_decode($msg, true);
        echo "Received message: " . $msg . "\n";
        
        // Handle client messages if needed
        if (isset($data['type']) && $data['type'] === 'subscribe') {
            $this->subscriptions[$from->resourceId] = $data['notepad_id'];
            echo "Connection {$from->resourceId} subscribed to notepad {$data['notepad_id']}\n";
        }
    }

    public function onClose(ConnectionInterface $conn) {
        $this->clients->detach($conn);
        unset($this->subscriptions[$conn->resourceId]);
        echo "Connection {$conn->resourceId} has disconnected\n";
    }

    public function onError(ConnectionInterface $conn, \Exception $e) {
        echo "An error has occurred: {$e->getMessage()}\n";
        $conn->close();
    }

    // Method to broadcast updates to clients subscribed to a notepad
    public function broadcastUpdate($notepadId, $update) {
        foreach ($this->clients as $client) {
            if (isset($this->subscriptions[$client->resourceId]) && 
                $this->subscriptions[$client->resourceId] === $notepadId) {
                $client->send(json_encode($update));
            }
        }
    }
}

// Create event loop
$loop = Factory::create();
$wsServer = new TodoWebSocketServer();

// Set up Predis client for Redis pub/sub
// Note: For React PHP compatibility, we use a synchronous Predis client
// with periodic polling rather than the async client
$redisClient = new \Predis\Client([
    'host' => 'redis',  // Docker service name
    'port' => 6379
]);

// Subscribe to Redis channels with the synchronous client and poll
$loop->addPeriodicTimer(0.1, function() use ($redisClient, $wsServer) {
    // Use PUBSUB CHANNELS to list active channels
    $channels = $redisClient->pubsub('channels', 'notepad:*');
    
    foreach ($channels as $channel) {
        // Get the latest message for each channel
        $message = $redisClient->get("latest:$channel");
        if ($message) {
            $redisClient->del("latest:$channel"); // Clean up
            
            // Extract notepad ID from channel name
            $notepadId = str_replace('notepad:', '', $channel);
            $data = json_decode($message, true);
            
            // Broadcast to WebSocket clients
            $wsServer->broadcastUpdate($notepadId, $data);
            echo "Broadcasting update from Redis to notepad $notepadId\n";
        }
    }
});

// Create socket and server
$socket = new SocketServer('0.0.0.0:8080', $loop);
$server = new IoServer(
    new HttpServer(
        new WsServer(
            $wsServer
        )
    ),
    $socket,
    $loop
);

echo "WebSocket server running on port 8080\n";
$server->run();
