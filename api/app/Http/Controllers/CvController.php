<?php
namespace App\Http\Controllers;

use App\Events\TodoUpdated;
use App\Models\Todo;
use Illuminate\Http\Request;
use App\Models\Company;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Log;
use App\Models\CvComponent;
use App\Models\CoverLetter;
use App\Models\CvComponentMapping;

/**
 * @group CV Management
 *
 * APIs for retrieving CV components and their mappings.
 * The CV is structured as ordered components that can be displayed in both English and Finnish.
 */
class CvController extends Controller
{
    /**
     * Get CV Components
     *
     * Retrieves all components of a CV in their defined display order.
     * Components are returned as a mapped object where keys are the display order
     * and values contain the component data in both English and Finnish.
     *
     * @queryParam cv_id string required The UUID of the CV to retrieve. Example: 0195bd90-4b5f-72e6-baa2-18b5343dc7e7
     *
     * @response 200 {
     *   "1": {
     *     "category": "job_title",
     *     "text_en": "Full Stack Developer",
     *     "text_fi": "Full Stack Kehittäjä"
     *   },
     *   "2": {
     *     "category": "contact_info",
     *     "text_en": "john.doe@example.com\n+358 40 123 4567",
     *     "text_fi": "john.doe@example.com\n+358 40 123 4567"
     *   },
     *   "3": {
     *     "category": "entry",
     *     "text_en": {
     *       "title": "Work Experience",
     *       "items": [
     *         "Senior Developer at Tech Corp",
     *         "Full Stack Developer at Startup Inc"
     *       ]
     *     },
     *     "text_fi": {
     *       "title": "Työkokemus",
     *       "items": [
     *         "Senior Kehittäjä, Tech Corp",
     *         "Full Stack Kehittäjä, Startup Inc"
     *       ]
     *     }
     *   }
     * }
     *
     * @response 404 {
     *   "message": "CV not found"
     * }
     *
     * @response 400 {
     *   "message": "CV ID is required"
     * }
     */
    public function getCv(Request $request)
    {
        $cvId = $request->query('cv_id');
        
        if (!$cvId) {
            return response()->json(['message' => 'CV ID is required'], 400);
        }
        
        $cvComponentMappings = CvComponentMapping::where('cv_id', $cvId)
            ->orderBy('display_order')
            ->get();
        
        if ($cvComponentMappings->isEmpty()) {
            return response()->json(['message' => 'CV not found'], 404);
        }

        $cvComponents = CvComponent::whereIn('id', $cvComponentMappings->pluck('component_id'))->get();
        $response = [];

        foreach ($cvComponentMappings as $mapping) {
            $component = $cvComponents->firstWhere('id', $mapping->component_id);
            if ($component) {
                $response[$mapping->display_order] = [
                    'category' => $component->category,
                    'text_en' => $component->text_en,
                    'text_fi' => $component->text_fi,
                ];
            }
        }
        
        return response()->json($response);
    }
}