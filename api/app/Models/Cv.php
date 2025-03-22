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
 * Class Cv
 * 
 * @property uuid $id
 * @property string|null $version_name
 * 
 * @property Collection|CvComponent[] $cv_components
 * @property Collection|Company[] $companies
 *
 * @package App\Models
 */
class Cv extends Model
{
	use HasFactory, HasUuids;

	protected $table = 'cvs';
	public $incrementing = false;
	public $timestamps = false;

	protected $casts = [
		'id' => 'string'
	];

	protected $fillable = [
		'version_name'
	];

	public function components()
	{
		return $this->belongsToMany(CvComponent::class, 'cv_component_mappings', 'cv_id', 'component_id')
					->withPivot('display_order');
	}

	public function companies()
	{
		return $this->hasMany(Company::class);
	}
}
