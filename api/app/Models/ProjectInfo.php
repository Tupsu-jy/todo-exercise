<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class ProjectInfo extends Model
{
	public $timestamps = false;

    protected $fillable = [
        'text_en',
        'text_fi'
    ];
}