<?php

/**
 * Created by Reliese Model.
 */

namespace App\Models;

use Illuminate\Database\Eloquent\Collection;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Concerns\HasUuids;

/**
 * Class Todo
 * 
 * @property uuid $id
 * @property uuid|null $notepad_id
 * @property string $description
 * @property bool $is_completed
 * 
 * @property Notepad|null $notepad
 * @property Collection|TodoOrder[] $todo_orders
 *
 * @package App\Models
 */
class Todo extends Model
{
	use HasFactory, HasUuids;

	protected $table = 'todos';
	public $incrementing = false;
	public $timestamps = false;

	protected $casts = [
		'id' => 'string',
		'notepad_id' => 'string',
		'is_completed' => 'bool'
	];

	protected $fillable = [
		'notepad_id',
		'description',
		'is_completed'
	];

	public function notepad()
	{
		return $this->belongsTo(Notepad::class);
	}

	public function todo_orders()
	{
		return $this->hasMany(TodoOrder::class);
	}
}
