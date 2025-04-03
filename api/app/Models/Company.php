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
 * Class Company
 * 
 * @property uuid $id
 * @property string|null $company_slug
 * @property uuid|null $cv_id
 * @property uuid|null $cover_letter_id
 * 
 * @property Cv|null $cv
 * @property CoverLetter|null $cover_letter
 * @property Collection|Notepad[] $notepads
 *
 * @package App\Models
 */
class Company extends Model
{
	use HasFactory, HasUuids;

	protected $table = 'companies';
	public $incrementing = false;
	public $timestamps = false;

	protected $casts = [
		'id' => 'string',
		'cv_id' => 'string',
		'cover_letter_id' => 'string',
		'order_version' => 'int'
	];

	protected $fillable = [
		'company_slug',
		'cv_id',
		'cover_letter_id',
		'order_version'
	];

	public function cv()
	{
		return $this->belongsTo(Cv::class);
	}

	public function cover_letter()
	{
		return $this->belongsTo(CoverLetter::class);
	}

	public function notepads()
	{
		return $this->hasMany(Notepad::class);
	}
}
