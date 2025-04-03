<?php

/**
 * Created by Reliese Model.
 */

namespace App\Models;

use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Concerns\HasUuids;

/**
 * Class NotepadOrder
 * 
 * @property uuid $id
 * @property uuid|null $company_id
 * @property uuid|null $notepad_id
 * @property int $order_index
 * 
 * @property Company|null $company
 * @property Notepad|null $notepad
 *
 * @package App\Models
 */
class NotepadOrder extends Model
{
    use HasFactory, HasUuids;

    protected $table = 'notepad_orders';
    public $incrementing = false;
    public $timestamps = false;

    protected $casts = [
        'id' => 'string',
        'company_id' => 'string',
        'notepad_id' => 'string',
        'order_index' => 'int'
    ];

    protected $fillable = [
        'company_id',
        'notepad_id',
        'order_index'
    ];

    public function company()
    {
        return $this->belongsTo(Company::class);
    }

    public function notepad()
    {
        return $this->belongsTo(Notepad::class);
    }
}
