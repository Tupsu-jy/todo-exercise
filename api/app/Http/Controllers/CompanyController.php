<?php
namespace App\Http\Controllers;

use App\Events\TodoUpdated;
use App\Models\Todo;
use Illuminate\Http\Request;
use App\Models\Company;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Log;

/**
 * @group Company Management
 *
 * APIs for managing company information.
 * Companies are identified by unique slugs and contain references to customized materials.
 */
class CompanyController extends Controller
{
    /**
     * Get Company Details
     *
     * Retrieves company information including references to the associated CV and cover letter.
     * The company is identified by its unique slug, which is typically derived from the company name.
     *
     * @urlParam companySlug string required The unique identifier for the company. Example: reaktor
     *
     * @response 200 {
     *   "id": "0195bd90-4b5f-72e6-baa2-18b5343dc7e7",
     *   "company_slug": "reaktor",
     *   "cv_id": "0195bd90-4b67-73ce-9409-08595c3a4910",
     *   "cover_letter_id": "0195bd90-4b67-73ce-9409-08595c3a4911",
     *   "created_at": "2024-03-24T12:00:00Z",
     *   "updated_at": "2024-03-24T12:00:00Z"
     * }
     *
     * @response 404 {
     *   "message": "Company not found"
     * }
     *
     * @response 400 {
     *   "message": "Invalid company slug format"
     * }
     */
    public function getCompany($companySlug)
    {
        $company = Company::where('company_slug', $companySlug)->first();
        return response()->json($company);
    }
}