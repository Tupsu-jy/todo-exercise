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

class NotepadReordered implements ShouldBroadcastNow
{
    use Dispatchable, InteractsWithSockets, SerializesModels;

    public $notepadId;
    public $newOrder;

    /**
     * Create a new event instance.
     */
    public function __construct($notepadId, $newOrder)
    {
        $this->notepadId = $notepadId;
        $this->newOrder = $newOrder;
    }

    public function broadcastOn()
    {
        return new Channel('notepads');
    }

    public function broadcastAs()
    {
        return 'notepad.reordered';
    }

    public function broadcastWith()
    {
        return [
            'notepadId' => $this->notepadId,
            'order_index' => $this->newOrder
        ];
    }
}
