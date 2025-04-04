<?php

namespace App\Events;

use Illuminate\Broadcasting\Channel;
use Illuminate\Broadcasting\InteractsWithSockets;
use Illuminate\Contracts\Broadcasting\ShouldBroadcastNow;
use Illuminate\Foundation\Events\Dispatchable;
use Illuminate\Queue\SerializesModels;

class TodoCreated implements ShouldBroadcastNow
{
    use Dispatchable, InteractsWithSockets, SerializesModels;

    public $todo;
    public $orderIndex;

    public function __construct($todo, $orderIndex)
    {
        $this->todo = $todo;
        $this->orderIndex = $orderIndex;
    }

    public function broadcastOn()
    {
        return new Channel('todos');
    }

    public function broadcastAs()
    {
        return 'todo.created';
    }

    public function broadcastWith()
    {
        return [
            'todo' => $this->todo,
            'order_index' => $this->orderIndex
        ];
    }
}
