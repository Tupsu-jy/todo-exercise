<?php

namespace App\Events;

use Illuminate\Broadcasting\Channel;
use Illuminate\Broadcasting\InteractsWithSockets;
use Illuminate\Contracts\Broadcasting\ShouldBroadcastNow;
use Illuminate\Foundation\Events\Dispatchable;
use Illuminate\Queue\SerializesModels;

class NotepadDeleted implements ShouldBroadcastNow
{
    use Dispatchable, InteractsWithSockets, SerializesModels;

    public $notepadId;

    public function __construct($notepadId)
    {
        $this->notepadId = $notepadId;
    }

    public function broadcastOn()
    {
        return new Channel('notepads');
    }

    public function broadcastAs()
    {
        return 'notepad.deleted';
    }

    public function broadcastWith()
    {
        return [
            'notepadId' => $this->notepadId
        ];
    }
}
