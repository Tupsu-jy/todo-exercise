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
 * Class Notepad
 * 
 * @property uuid $id
 * @property string $name
 * @property uuid|null $company_id
 * @property int|null $order_version
 * 
 * @property Company|null $company
 * @property Collection|Todo[] $todos
 * @property Collection|TodoOrder[] $todo_orders
 *
 * @package App\Models
 */
class Notepad extends Model
{
	use HasFactory, HasUuids;

	protected $table = 'notepads';
	public $incrementing = false;
	public $timestamps = false;

	protected $casts = [
		'id' => 'string',
		'company_id' => 'string',
		'order_version' => 'int'
	];

	protected $fillable = [
		'name',
		'company_id',
		'order_version'
	];

	public function company()
	{
		return $this->belongsTo(Company::class);
	}

	public function todos()
	{
		return $this->hasMany(Todo::class);
	}

	public function todo_orders()
	{
		return $this->hasMany(TodoOrder::class);
	}
}
