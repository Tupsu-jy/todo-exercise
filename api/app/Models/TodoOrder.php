<?php

/**
 * Created by Reliese Model.
 */

namespace App\Models;

use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Concerns\HasUuids;

/**
 * Class TodoOrder
 * 
 * @property uuid $id
 * @property uuid|null $notepad_id
 * @property uuid|null $todo_id
 * @property int $order_index
 * 
 * @property Notepad|null $notepad
 * @property Todo|null $todo
 *
 * @package App\Models
 */
class TodoOrder extends Model
{
	use HasFactory, HasUuids;

	protected $table = 'todo_orders';
	public $incrementing = false;
	public $timestamps = false;

	protected $casts = [
		'id' => 'string',
		'notepad_id' => 'string',
		'todo_id' => 'string',
		'order_index' => 'int'
	];

	protected $fillable = [
		'notepad_id',
		'todo_id',
		'order_index'
	];

	public function notepad()
	{
		return $this->belongsTo(Notepad::class);
	}

	public function todo()
	{
		return $this->belongsTo(Todo::class);
	}
}
