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
 * Class CoverLetter
 * 
 * @property uuid $id
 * @property string|null $name
 * @property string|null $letter_en
 * @property string|null $letter_fi
 * 
 * @property Collection|Company[] $companies
 *
 * @package App\Models
 */
class CoverLetter extends Model
{
	use HasFactory, HasUuids;

	protected $table = 'cover_letters';
	public $incrementing = false;
	public $timestamps = false;

	protected $casts = [
		'id' => 'string'
	];

	protected $fillable = [
		'name',
		'letter_en',
		'letter_fi'
	];

	public function companies()
	{
		return $this->hasMany(Company::class);
	}
}
