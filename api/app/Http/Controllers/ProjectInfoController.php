<?php

namespace App\Http\Controllers;

use App\Models\ProjectInfo;
use Illuminate\Http\Request;

class ProjectInfoController extends Controller
{
    /**
     * Get the latest project info
     *
     * @return \Illuminate\Http\JsonResponse
     */
    public function getLatest()
    {
        $projectInfo = ProjectInfo::orderBy('id', 'desc')->first();
        
        if (!$projectInfo) {
            return response()->json(['message' => 'Project info not found'], 404);
        }

        return response()->json([
            'text_en' => $projectInfo->text_en,
            'text_fi' => $projectInfo->text_fi
        ]);
    }
}