<?php

/**
 * Created by Reliese Model.
 */

namespace App\Models;

use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Concerns\HasUuids;

/**
 * Class CvComponent
 * 
 * @property uuid $id
 * @property uuid|null $cv_id
 * @property string|null $category
 * @property string|null $text_en
 * @property string|null $text_fi
 * @property int|null $display_order
 * 
 * @property Cv|null $cv
 *
 * @package App\Models
 */
class CvComponent extends Model
{
	use HasFactory, HasUuids;

	protected $table = 'cv_components';
	public $incrementing = false;
	public $timestamps = false;

	protected $casts = [
		'id' => 'string',
		'text_en' => 'array',
		'text_fi' => 'array',
	];

	protected $fillable = [
		'category',
		'text_en',
		'text_fi'
	];

	public function cvs()
	{
		return $this->belongsToMany(Cv::class, 'cv_component_mappings', 'component_id', 'cv_id')
					->withPivot('display_order');
	}
}
