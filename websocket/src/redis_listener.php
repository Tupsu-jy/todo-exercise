<?php
// redis_listener.php
require __DIR__ . '/vendor/autoload.php';

$redis = new Predis\Client([
    'host' => 'redis',
    'port' => 6379
]);

$pubsub = $redis->pubSubLoop();
$pubsub->subscribe('updates');
$pubsub->subscribe('notepad:*');

echo "Redis listener started, waiting for messages...\n";

foreach ($pubsub as $message) {
    if ($message->kind === 'message') {
        $channel = $message->channel;
        $payload = $message->payload;
        
        // Store latest message for each channel
        $redis->set("latest:$channel", $payload);
        
        echo "Received message on channel $channel\n";
    }
}
