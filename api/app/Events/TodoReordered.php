<?php

namespace App\Events;

use Illuminate\Broadcasting\Channel;
use Illuminate\Broadcasting\InteractsWithSockets;
use Illuminate\Broadcasting\PresenceChannel;
use Illuminate\Broadcasting\PrivateChannel;
use Illuminate\Contracts\Broadcasting\ShouldBroadcast;
use Illuminate\Contracts\Broadcasting\ShouldBroadcastNow;
use Illuminate\Foundation\Events\Dispatchable;
use Illuminate\Queue\SerializesModels;

class TodoReordered implements ShouldBroadcastNow
{
    use Dispatchable, InteractsWithSockets, SerializesModels;

    public $todoId;
    public $newOrder;
    public $orderVersion;
    /**
     * Create a new event instance.
     */
    public function __construct($todoId, $newOrder, $orderVersion)
    {
        $this->todoId = $todoId;
        $this->newOrder = $newOrder;
        $this->orderVersion = $orderVersion;
    }

    public function broadcastOn()
    {
        return new Channel('todos');
    }

    public function broadcastAs()
    {
        return 'todo.reordered';
    }

    public function broadcastWith()
    {
        return [
            'todoId' => $this->todoId,
            'order_index' => $this->newOrder,
            'order_version' => $this->orderVersion
        ];
    }
}
