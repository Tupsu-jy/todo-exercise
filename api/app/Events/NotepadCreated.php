<?php

namespace App\Events;

use Illuminate\Broadcasting\Channel;
use Illuminate\Broadcasting\InteractsWithSockets;
use Illuminate\Contracts\Broadcasting\ShouldBroadcastNow;
use Illuminate\Foundation\Events\Dispatchable;
use Illuminate\Queue\SerializesModels;

class NotepadCreated implements ShouldBroadcastNow
{
    use Dispatchable, InteractsWithSockets, SerializesModels;

    public $notepad;
    public $orderIndex;

    public function __construct($notepad, $orderIndex)
    {
        $this->notepad = $notepad;
        $this->orderIndex = $orderIndex;
    }

    public function broadcastOn()
    {
        return new Channel('notepads');
    }

    public function broadcastAs()
    {
        return 'notepad.created';
    }

    public function broadcastWith()
    {
        return [
            'notepad' => $this->notepad,
            'order_index' => $this->orderIndex
        ];
    }
}
