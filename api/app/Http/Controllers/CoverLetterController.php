<?php

namespace App\Http\Controllers;

use App\Models\CoverLetter;
use Illuminate\Http\Request;

/**
 * @group Cover Letter Management
 *
 * APIs for retrieving cover letters in multiple languages.
 * Cover letters are customized for each company and available in both English and Finnish.
 */
class CoverLetterController extends Controller
{
    /**
     * Get Cover Letter
     *
     * Retrieves a specific cover letter by its ID. The cover letter is returned
     * with both English and Finnish versions, along with its category identifier.
     *
     * @urlParam id string required The UUID of the cover letter. Example: 0195bd90-4b5f-72e6-baa2-18b5343dc7e7
     *
     * @response 200 {
     *   "category": "cover_letter",
     *   "text_en": "Dear Hiring Manager,\n\nI am writing to express my strong interest in the Full Stack Developer position at your company. With my extensive experience in both frontend and backend development...",
     *   "text_fi": "Hyvä rekrytoija,\n\nHaen Full Stack Developer -työpaikkaa yrityksessänne. Minulla on laaja kokemus sekä frontend- että backend-kehityksestä..."
     * }
     *
     * @response 404 {
     *   "message": "Cover letter not found"
     * }
     *
     * @response 400 {
     *   "message": "Invalid cover letter ID"
     * }
     */
    public function getCoverLetter($id)
    {
        $coverLetter = CoverLetter::where('id', $id)->first();
        
        return response()->json([
            'category' => 'cover_letter',
            'text_en' => $coverLetter->letter_en,
            'text_fi' => $coverLetter->letter_fi,
        ]);
    }
} 