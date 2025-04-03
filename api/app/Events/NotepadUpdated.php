<?php

namespace App\Events;

use Illuminate\Broadcasting\Channel;
use Illuminate\Broadcasting\InteractsWithSockets;
use Illuminate\Contracts\Broadcasting\ShouldBroadcastNow;
use Illuminate\Foundation\Events\Dispatchable;
use Illuminate\Queue\SerializesModels;

class NotepadUpdated implements ShouldBroadcastNow
{
    use Dispatchable, InteractsWithSockets, SerializesModels;

    public $notepad;

    public function __construct($notepad)
    {
        $this->notepad = $notepad;
    }

    public function broadcastOn()
    {
        return new Channel('notepads');
    }

    public function broadcastAs()
    {
        return 'notepad.updated';
    }

    public function broadcastWith()
    {
        return [
            'notepad' => $this->notepad
        ];
    }
}
