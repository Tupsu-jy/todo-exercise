<?php

/**
 * Created by Reliese Model.
 */

namespace App\Models;

use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Factories\HasFactory;

/**
 * Class CvComponentMapping
 * 
 * @property int $id
 * @property uuid $cv_id
 * @property uuid $component_id
 * @property int|null $display_order
 * 
 * @property Cv $cv
 * @property CvComponent $cv_component
 *
 * @package App\Models
 */
class CvComponentMapping extends Model
{
	use HasFactory;

	protected $table = 'cv_component_mappings';
	public $incrementing = true;
	public $timestamps = false;

	protected $casts = [
		'cv_id' => 'string',
		'component_id' => 'string',
		'display_order' => 'int'
	];

	protected $fillable = [
		'cv_id',
		'component_id',
		'display_order'
	];

	public function cv()
	{
		return $this->belongsTo(Cv::class, 'cv_id');
	}

	public function cv_component()
	{
		return $this->belongsTo(CvComponent::class, 'component_id');
	}
}
