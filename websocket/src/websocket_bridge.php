<?php
// websocket_bridge.php

require __DIR__ . '/../vendor/autoload.php';
use Predis\Client as RedisClient;

class WebSocketBridge {
    private $redis;
    
    public function __construct($redisConfig = ['host' => 'redis', 'port' => 6379]) {
        try {
            $this->redis = new RedisClient($redisConfig);
            // Test connection
            $this->redis->ping();
        } catch (\Exception $e) {
            error_log("Redis connection failed: " . $e->getMessage());
            // Fallback to in-memory mode or other behavior
            // For now, we'll still create the client but log the error
        }
    }
    
    public function sendUpdate($notepadId, $type, $data) {
        try {
            $message = [
                'type' => $type,
                'notepad_id' => $notepadId,
                'data' => $data,
                'timestamp' => microtime(true)
            ];
            
            // Publish to a channel named after the notepad ID
            $this->redis->publish("notepad:$notepadId", json_encode($message));
            
            // Also publish to a global channel for updates
            $this->redis->publish("updates", json_encode($message));
            
            return true;
        } catch (\Exception $e) {
            error_log("Failed to send update via Redis: " . $e->getMessage());
            return false;
        }
    }
}
