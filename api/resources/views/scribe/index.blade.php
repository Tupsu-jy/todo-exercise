<!doctype html>
<html lang="en">
<head>
    <meta charset="utf-8">
    <meta content="IE=edge,chrome=1" http-equiv="X-UA-Compatible">
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
    <title>Laravel API Documentation</title>

    <link href="https://fonts.googleapis.com/css?family=Open+Sans&display=swap" rel="stylesheet">

    <link rel="stylesheet" href="{{ asset("/vendor/scribe/css/theme-default.style.css") }}" media="screen">
    <link rel="stylesheet" href="{{ asset("/vendor/scribe/css/theme-default.print.css") }}" media="print">

    <script src="https://cdn.jsdelivr.net/npm/lodash@4.17.10/lodash.min.js"></script>

    <link rel="stylesheet"
          href="https://unpkg.com/@highlightjs/cdn-assets@11.6.0/styles/obsidian.min.css">
    <script src="https://unpkg.com/@highlightjs/cdn-assets@11.6.0/highlight.min.js"></script>

    <script src="https://cdnjs.cloudflare.com/ajax/libs/jets/0.14.1/jets.min.js"></script>

    <style id="language-style">
        /* starts out as display none and is replaced with js later  */
                    body .content .bash-example code { display: none; }
                    body .content .javascript-example code { display: none; }
            </style>

    <script>
        var tryItOutBaseUrl = "http://localhost";
        var useCsrf = Boolean();
        var csrfUrl = "/sanctum/csrf-cookie";
    </script>
    <script src="{{ asset("/vendor/scribe/js/tryitout-5.1.0.js") }}"></script>

    <script src="{{ asset("/vendor/scribe/js/theme-default-5.1.0.js") }}"></script>

</head>

<body data-languages="[&quot;bash&quot;,&quot;javascript&quot;]">

<a href="#" id="nav-button">
    <span>
        MENU
        <img src="{{ asset("/vendor/scribe/images/navbar.png") }}" alt="navbar-image"/>
    </span>
</a>
<div class="tocify-wrapper">
    
            <div class="lang-selector">
                                            <button type="button" class="lang-button" data-language-name="bash">bash</button>
                                            <button type="button" class="lang-button" data-language-name="javascript">javascript</button>
                    </div>
    
    <div class="search">
        <input type="text" class="search" id="input-search" placeholder="Search">
    </div>

    <div id="toc">
                    <ul id="tocify-header-introduction" class="tocify-header">
                <li class="tocify-item level-1" data-unique="introduction">
                    <a href="#introduction">Introduction</a>
                </li>
                            </ul>
                    <ul id="tocify-header-authenticating-requests" class="tocify-header">
                <li class="tocify-item level-1" data-unique="authenticating-requests">
                    <a href="#authenticating-requests">Authenticating requests</a>
                </li>
                            </ul>
                    <ul id="tocify-header-cv-management" class="tocify-header">
                <li class="tocify-item level-1" data-unique="cv-management">
                    <a href="#cv-management">CV Management</a>
                </li>
                                    <ul id="tocify-subheader-cv-management" class="tocify-subheader">
                                                    <li class="tocify-item level-2" data-unique="cv-management-GETapi-cv">
                                <a href="#cv-management-GETapi-cv">Get CV Components</a>
                            </li>
                                                                        </ul>
                            </ul>
                    <ul id="tocify-header-company-management" class="tocify-header">
                <li class="tocify-item level-1" data-unique="company-management">
                    <a href="#company-management">Company Management</a>
                </li>
                                    <ul id="tocify-subheader-company-management" class="tocify-subheader">
                                                    <li class="tocify-item level-2" data-unique="company-management-GETapi-companies--company_slug-">
                                <a href="#company-management-GETapi-companies--company_slug-">Get Company Details</a>
                            </li>
                                                                        </ul>
                            </ul>
                    <ul id="tocify-header-cover-letter-management" class="tocify-header">
                <li class="tocify-item level-1" data-unique="cover-letter-management">
                    <a href="#cover-letter-management">Cover Letter Management</a>
                </li>
                                    <ul id="tocify-subheader-cover-letter-management" class="tocify-subheader">
                                                    <li class="tocify-item level-2" data-unique="cover-letter-management-GETapi-cover-letters--id-">
                                <a href="#cover-letter-management-GETapi-cover-letters--id-">Get Cover Letter</a>
                            </li>
                                                                        </ul>
                            </ul>
                    <ul id="tocify-header-notepad-management" class="tocify-header">
                <li class="tocify-item level-1" data-unique="notepad-management">
                    <a href="#notepad-management">Notepad Management</a>
                </li>
                                    <ul id="tocify-subheader-notepad-management" class="tocify-subheader">
                                                    <li class="tocify-item level-2" data-unique="notepad-management-GETapi-notepads--company_id-">
                                <a href="#notepad-management-GETapi-notepads--company_id-">List Company Notepads</a>
                            </li>
                                                                                <li class="tocify-item level-2" data-unique="notepad-management-POSTapi-notepads--company_id-">
                                <a href="#notepad-management-POSTapi-notepads--company_id-">Create Notepad</a>
                            </li>
                                                                        </ul>
                            </ul>
                    <ul id="tocify-header-todo-management" class="tocify-header">
                <li class="tocify-item level-1" data-unique="todo-management">
                    <a href="#todo-management">Todo Management</a>
                </li>
                                    <ul id="tocify-subheader-todo-management" class="tocify-subheader">
                                                    <li class="tocify-item level-2" data-unique="todo-management-PATCHapi-todo-order-reorder">
                                <a href="#todo-management-PATCHapi-todo-order-reorder">Reorder Todos</a>
                            </li>
                                                                                <li class="tocify-item level-2" data-unique="todo-management-GETapi-notepads--notepad--todos">
                                <a href="#todo-management-GETapi-notepads--notepad--todos">Get All Todos</a>
                            </li>
                                                                                <li class="tocify-item level-2" data-unique="todo-management-POSTapi-notepads--notepad--todos">
                                <a href="#todo-management-POSTapi-notepads--notepad--todos">Create Todo</a>
                            </li>
                                                                                <li class="tocify-item level-2" data-unique="todo-management-DELETEapi-todos--id-">
                                <a href="#todo-management-DELETEapi-todos--id-">Delete Todo</a>
                            </li>
                                                                                <li class="tocify-item level-2" data-unique="todo-management-PUTapi-todos--id-">
                                <a href="#todo-management-PUTapi-todos--id-">Update Todo</a>
                            </li>
                                                                                <li class="tocify-item level-2" data-unique="todo-management-PATCHapi-todos--id--status">
                                <a href="#todo-management-PATCHapi-todos--id--status">Toggle Todo Status</a>
                            </li>
                                                                        </ul>
                            </ul>
            </div>

    <ul class="toc-footer" id="toc-footer">
                    <li style="padding-bottom: 5px;"><a href="{{ route("scribe.postman") }}">View Postman collection</a></li>
                            <li style="padding-bottom: 5px;"><a href="{{ route("scribe.openapi") }}">View OpenAPI spec</a></li>
                <li><a href="http://github.com/knuckleswtf/scribe">Documentation powered by Scribe ✍</a></li>
    </ul>

    <ul class="toc-footer" id="last-updated">
        <li>Last updated: March 25, 2025</li>
    </ul>
</div>

<div class="page-wrapper">
    <div class="dark-box"></div>
    <div class="content">
        <h1 id="introduction">Introduction</h1>
<aside>
    <strong>Base URL</strong>: <code>http://localhost</code>
</aside>
<pre><code>This documentation aims to provide all the information you need to work with our API.

&lt;aside&gt;As you scroll, you'll see code examples for working with the API in different programming languages in the dark area to the right (or as part of the content on mobile).
You can switch the language used with the tabs at the top right (or from the nav menu at the top left on mobile).&lt;/aside&gt;</code></pre>

        <h1 id="authenticating-requests">Authenticating requests</h1>
<p>This API is not authenticated.</p>

        <h1 id="cv-management">CV Management</h1>

    <p>APIs for retrieving CV components and their mappings.
The CV is structured as ordered components that can be displayed in both English and Finnish.</p>

                                <h2 id="cv-management-GETapi-cv">Get CV Components</h2>

<p>
</p>

<p>Retrieves all components of a CV in their defined display order.
Components are returned as a mapped object where keys are the display order
and values contain the component data in both English and Finnish.</p>

<span id="example-requests-GETapi-cv">
<blockquote>Example request:</blockquote>


<div class="bash-example">
    <pre><code class="language-bash">curl --request GET \
    --get "http://localhost/api/cv?cv_id=0195bd90-4b5f-72e6-baa2-18b5343dc7e7" \
    --header "Content-Type: application/json" \
    --header "Accept: application/json"</code></pre></div>


<div class="javascript-example">
    <pre><code class="language-javascript">const url = new URL(
    "http://localhost/api/cv"
);

const params = {
    "cv_id": "0195bd90-4b5f-72e6-baa2-18b5343dc7e7",
};
Object.keys(params)
    .forEach(key =&gt; url.searchParams.append(key, params[key]));

const headers = {
    "Content-Type": "application/json",
    "Accept": "application/json",
};

fetch(url, {
    method: "GET",
    headers,
}).then(response =&gt; response.json());</code></pre></div>

</span>

<span id="example-responses-GETapi-cv">
            <blockquote>
            <p>Example response (200):</p>
        </blockquote>
                <pre>

<code class="language-json" style="max-height: 300px;">{
    &quot;1&quot;: {
        &quot;category&quot;: &quot;job_title&quot;,
        &quot;text_en&quot;: &quot;Full Stack Developer&quot;,
        &quot;text_fi&quot;: &quot;Full Stack Kehitt&auml;j&auml;&quot;
    },
    &quot;2&quot;: {
        &quot;category&quot;: &quot;contact_info&quot;,
        &quot;text_en&quot;: &quot;john.doe@example.com\n+358 40 123 4567&quot;,
        &quot;text_fi&quot;: &quot;john.doe@example.com\n+358 40 123 4567&quot;
    },
    &quot;3&quot;: {
        &quot;category&quot;: &quot;entry&quot;,
        &quot;text_en&quot;: {
            &quot;title&quot;: &quot;Work Experience&quot;,
            &quot;items&quot;: [
                &quot;Senior Developer at Tech Corp&quot;,
                &quot;Full Stack Developer at Startup Inc&quot;
            ]
        },
        &quot;text_fi&quot;: {
            &quot;title&quot;: &quot;Ty&ouml;kokemus&quot;,
            &quot;items&quot;: [
                &quot;Senior Kehitt&auml;j&auml;, Tech Corp&quot;,
                &quot;Full Stack Kehitt&auml;j&auml;, Startup Inc&quot;
            ]
        }
    }
}</code>
 </pre>
            <blockquote>
            <p>Example response (400):</p>
        </blockquote>
                <pre>

<code class="language-json" style="max-height: 300px;">{
    &quot;message&quot;: &quot;CV ID is required&quot;
}</code>
 </pre>
            <blockquote>
            <p>Example response (404):</p>
        </blockquote>
                <pre>

<code class="language-json" style="max-height: 300px;">{
    &quot;message&quot;: &quot;CV not found&quot;
}</code>
 </pre>
    </span>
<span id="execution-results-GETapi-cv" hidden>
    <blockquote>Received response<span
                id="execution-response-status-GETapi-cv"></span>:
    </blockquote>
    <pre class="json"><code id="execution-response-content-GETapi-cv"
      data-empty-response-text="<Empty response>" style="max-height: 400px;"></code></pre>
</span>
<span id="execution-error-GETapi-cv" hidden>
    <blockquote>Request failed with error:</blockquote>
    <pre><code id="execution-error-message-GETapi-cv">

Tip: Check that you&#039;re properly connected to the network.
If you&#039;re a maintainer of ths API, verify that your API is running and you&#039;ve enabled CORS.
You can check the Dev Tools console for debugging information.</code></pre>
</span>
<form id="form-GETapi-cv" data-method="GET"
      data-path="api/cv"
      data-authed="0"
      data-hasfiles="0"
      data-isarraybody="0"
      autocomplete="off"
      onsubmit="event.preventDefault(); executeTryOut('GETapi-cv', this);">
    <h3>
        Request&nbsp;&nbsp;&nbsp;
                    <button type="button"
                    style="background-color: #8fbcd4; padding: 5px 10px; border-radius: 5px; border-width: thin;"
                    id="btn-tryout-GETapi-cv"
                    onclick="tryItOut('GETapi-cv');">Try it out ⚡
            </button>
            <button type="button"
                    style="background-color: #c97a7e; padding: 5px 10px; border-radius: 5px; border-width: thin;"
                    id="btn-canceltryout-GETapi-cv"
                    onclick="cancelTryOut('GETapi-cv');" hidden>Cancel 🛑
            </button>&nbsp;&nbsp;
            <button type="submit"
                    style="background-color: #6ac174; padding: 5px 10px; border-radius: 5px; border-width: thin;"
                    id="btn-executetryout-GETapi-cv"
                    data-initial-text="Send Request 💥"
                    data-loading-text="⏱ Sending..."
                    hidden>Send Request 💥
            </button>
            </h3>
            <p>
            <small class="badge badge-green">GET</small>
            <b><code>api/cv</code></b>
        </p>
                <h4 class="fancy-heading-panel"><b>Headers</b></h4>
                                <div style="padding-left: 28px; clear: unset;">
                <b style="line-height: 2;"><code>Content-Type</code></b>&nbsp;&nbsp;
&nbsp;
 &nbsp;
                <input type="text" style="display: none"
                              name="Content-Type"                data-endpoint="GETapi-cv"
               value="application/json"
               data-component="header">
    <br>
<p>Example: <code>application/json</code></p>
            </div>
                                <div style="padding-left: 28px; clear: unset;">
                <b style="line-height: 2;"><code>Accept</code></b>&nbsp;&nbsp;
&nbsp;
 &nbsp;
                <input type="text" style="display: none"
                              name="Accept"                data-endpoint="GETapi-cv"
               value="application/json"
               data-component="header">
    <br>
<p>Example: <code>application/json</code></p>
            </div>
                            <h4 class="fancy-heading-panel"><b>Query Parameters</b></h4>
                                    <div style="padding-left: 28px; clear: unset;">
                <b style="line-height: 2;"><code>cv_id</code></b>&nbsp;&nbsp;
<small>string</small>&nbsp;
 &nbsp;
                <input type="text" style="display: none"
                              name="cv_id"                data-endpoint="GETapi-cv"
               value="0195bd90-4b5f-72e6-baa2-18b5343dc7e7"
               data-component="query">
    <br>
<p>The UUID of the CV to retrieve. Example: <code>0195bd90-4b5f-72e6-baa2-18b5343dc7e7</code></p>
            </div>
                </form>

                <h1 id="company-management">Company Management</h1>

    <p>APIs for managing company information.
Companies are identified by unique slugs and contain references to customized materials.</p>

                                <h2 id="company-management-GETapi-companies--company_slug-">Get Company Details</h2>

<p>
</p>

<p>Retrieves company information including references to the associated CV and cover letter.
The company is identified by its unique slug, which is typically derived from the company name.</p>

<span id="example-requests-GETapi-companies--company_slug-">
<blockquote>Example request:</blockquote>


<div class="bash-example">
    <pre><code class="language-bash">curl --request GET \
    --get "http://localhost/api/companies/architecto" \
    --header "Content-Type: application/json" \
    --header "Accept: application/json"</code></pre></div>


<div class="javascript-example">
    <pre><code class="language-javascript">const url = new URL(
    "http://localhost/api/companies/architecto"
);

const headers = {
    "Content-Type": "application/json",
    "Accept": "application/json",
};

fetch(url, {
    method: "GET",
    headers,
}).then(response =&gt; response.json());</code></pre></div>

</span>

<span id="example-responses-GETapi-companies--company_slug-">
            <blockquote>
            <p>Example response (200):</p>
        </blockquote>
                <pre>

<code class="language-json" style="max-height: 300px;">{
    &quot;id&quot;: &quot;0195bd90-4b5f-72e6-baa2-18b5343dc7e7&quot;,
    &quot;company_slug&quot;: &quot;reaktor&quot;,
    &quot;cv_id&quot;: &quot;0195bd90-4b67-73ce-9409-08595c3a4910&quot;,
    &quot;cover_letter_id&quot;: &quot;0195bd90-4b67-73ce-9409-08595c3a4911&quot;,
    &quot;created_at&quot;: &quot;2024-03-24T12:00:00Z&quot;,
    &quot;updated_at&quot;: &quot;2024-03-24T12:00:00Z&quot;
}</code>
 </pre>
            <blockquote>
            <p>Example response (400):</p>
        </blockquote>
                <pre>

<code class="language-json" style="max-height: 300px;">{
    &quot;message&quot;: &quot;Invalid company slug format&quot;
}</code>
 </pre>
            <blockquote>
            <p>Example response (404):</p>
        </blockquote>
                <pre>

<code class="language-json" style="max-height: 300px;">{
    &quot;message&quot;: &quot;Company not found&quot;
}</code>
 </pre>
    </span>
<span id="execution-results-GETapi-companies--company_slug-" hidden>
    <blockquote>Received response<span
                id="execution-response-status-GETapi-companies--company_slug-"></span>:
    </blockquote>
    <pre class="json"><code id="execution-response-content-GETapi-companies--company_slug-"
      data-empty-response-text="<Empty response>" style="max-height: 400px;"></code></pre>
</span>
<span id="execution-error-GETapi-companies--company_slug-" hidden>
    <blockquote>Request failed with error:</blockquote>
    <pre><code id="execution-error-message-GETapi-companies--company_slug-">

Tip: Check that you&#039;re properly connected to the network.
If you&#039;re a maintainer of ths API, verify that your API is running and you&#039;ve enabled CORS.
You can check the Dev Tools console for debugging information.</code></pre>
</span>
<form id="form-GETapi-companies--company_slug-" data-method="GET"
      data-path="api/companies/{company_slug}"
      data-authed="0"
      data-hasfiles="0"
      data-isarraybody="0"
      autocomplete="off"
      onsubmit="event.preventDefault(); executeTryOut('GETapi-companies--company_slug-', this);">
    <h3>
        Request&nbsp;&nbsp;&nbsp;
                    <button type="button"
                    style="background-color: #8fbcd4; padding: 5px 10px; border-radius: 5px; border-width: thin;"
                    id="btn-tryout-GETapi-companies--company_slug-"
                    onclick="tryItOut('GETapi-companies--company_slug-');">Try it out ⚡
            </button>
            <button type="button"
                    style="background-color: #c97a7e; padding: 5px 10px; border-radius: 5px; border-width: thin;"
                    id="btn-canceltryout-GETapi-companies--company_slug-"
                    onclick="cancelTryOut('GETapi-companies--company_slug-');" hidden>Cancel 🛑
            </button>&nbsp;&nbsp;
            <button type="submit"
                    style="background-color: #6ac174; padding: 5px 10px; border-radius: 5px; border-width: thin;"
                    id="btn-executetryout-GETapi-companies--company_slug-"
                    data-initial-text="Send Request 💥"
                    data-loading-text="⏱ Sending..."
                    hidden>Send Request 💥
            </button>
            </h3>
            <p>
            <small class="badge badge-green">GET</small>
            <b><code>api/companies/{company_slug}</code></b>
        </p>
                <h4 class="fancy-heading-panel"><b>Headers</b></h4>
                                <div style="padding-left: 28px; clear: unset;">
                <b style="line-height: 2;"><code>Content-Type</code></b>&nbsp;&nbsp;
&nbsp;
 &nbsp;
                <input type="text" style="display: none"
                              name="Content-Type"                data-endpoint="GETapi-companies--company_slug-"
               value="application/json"
               data-component="header">
    <br>
<p>Example: <code>application/json</code></p>
            </div>
                                <div style="padding-left: 28px; clear: unset;">
                <b style="line-height: 2;"><code>Accept</code></b>&nbsp;&nbsp;
&nbsp;
 &nbsp;
                <input type="text" style="display: none"
                              name="Accept"                data-endpoint="GETapi-companies--company_slug-"
               value="application/json"
               data-component="header">
    <br>
<p>Example: <code>application/json</code></p>
            </div>
                        <h4 class="fancy-heading-panel"><b>URL Parameters</b></h4>
                    <div style="padding-left: 28px; clear: unset;">
                <b style="line-height: 2;"><code>company_slug</code></b>&nbsp;&nbsp;
<small>string</small>&nbsp;
 &nbsp;
                <input type="text" style="display: none"
                              name="company_slug"                data-endpoint="GETapi-companies--company_slug-"
               value="architecto"
               data-component="url">
    <br>
<p>The slug of the company. Example: <code>architecto</code></p>
            </div>
                    <div style="padding-left: 28px; clear: unset;">
                <b style="line-height: 2;"><code>companySlug</code></b>&nbsp;&nbsp;
<small>string</small>&nbsp;
 &nbsp;
                <input type="text" style="display: none"
                              name="companySlug"                data-endpoint="GETapi-companies--company_slug-"
               value="reaktor"
               data-component="url">
    <br>
<p>The unique identifier for the company. Example: <code>reaktor</code></p>
            </div>
                    </form>

                <h1 id="cover-letter-management">Cover Letter Management</h1>

    <p>APIs for retrieving cover letters in multiple languages.
Cover letters are customized for each company and available in both English and Finnish.</p>

                                <h2 id="cover-letter-management-GETapi-cover-letters--id-">Get Cover Letter</h2>

<p>
</p>

<p>Retrieves a specific cover letter by its ID. The cover letter is returned
with both English and Finnish versions, along with its category identifier.</p>

<span id="example-requests-GETapi-cover-letters--id-">
<blockquote>Example request:</blockquote>


<div class="bash-example">
    <pre><code class="language-bash">curl --request GET \
    --get "http://localhost/api/cover-letters/0195bd90-4b5f-72e6-baa2-18b5343dc7e7" \
    --header "Content-Type: application/json" \
    --header "Accept: application/json"</code></pre></div>


<div class="javascript-example">
    <pre><code class="language-javascript">const url = new URL(
    "http://localhost/api/cover-letters/0195bd90-4b5f-72e6-baa2-18b5343dc7e7"
);

const headers = {
    "Content-Type": "application/json",
    "Accept": "application/json",
};

fetch(url, {
    method: "GET",
    headers,
}).then(response =&gt; response.json());</code></pre></div>

</span>

<span id="example-responses-GETapi-cover-letters--id-">
            <blockquote>
            <p>Example response (200):</p>
        </blockquote>
                <pre>

<code class="language-json" style="max-height: 300px;">{
    &quot;category&quot;: &quot;cover_letter&quot;,
    &quot;text_en&quot;: &quot;Dear Hiring Manager,\n\nI am writing to express my strong interest in the Full Stack Developer position at your company. With my extensive experience in both frontend and backend development...&quot;,
    &quot;text_fi&quot;: &quot;Hyv&auml; rekrytoija,\n\nHaen Full Stack Developer -ty&ouml;paikkaa yrityksess&auml;nne. Minulla on laaja kokemus sek&auml; frontend- ett&auml; backend-kehityksest&auml;...&quot;
}</code>
 </pre>
            <blockquote>
            <p>Example response (400):</p>
        </blockquote>
                <pre>

<code class="language-json" style="max-height: 300px;">{
    &quot;message&quot;: &quot;Invalid cover letter ID&quot;
}</code>
 </pre>
            <blockquote>
            <p>Example response (404):</p>
        </blockquote>
                <pre>

<code class="language-json" style="max-height: 300px;">{
    &quot;message&quot;: &quot;Cover letter not found&quot;
}</code>
 </pre>
    </span>
<span id="execution-results-GETapi-cover-letters--id-" hidden>
    <blockquote>Received response<span
                id="execution-response-status-GETapi-cover-letters--id-"></span>:
    </blockquote>
    <pre class="json"><code id="execution-response-content-GETapi-cover-letters--id-"
      data-empty-response-text="<Empty response>" style="max-height: 400px;"></code></pre>
</span>
<span id="execution-error-GETapi-cover-letters--id-" hidden>
    <blockquote>Request failed with error:</blockquote>
    <pre><code id="execution-error-message-GETapi-cover-letters--id-">

Tip: Check that you&#039;re properly connected to the network.
If you&#039;re a maintainer of ths API, verify that your API is running and you&#039;ve enabled CORS.
You can check the Dev Tools console for debugging information.</code></pre>
</span>
<form id="form-GETapi-cover-letters--id-" data-method="GET"
      data-path="api/cover-letters/{id}"
      data-authed="0"
      data-hasfiles="0"
      data-isarraybody="0"
      autocomplete="off"
      onsubmit="event.preventDefault(); executeTryOut('GETapi-cover-letters--id-', this);">
    <h3>
        Request&nbsp;&nbsp;&nbsp;
                    <button type="button"
                    style="background-color: #8fbcd4; padding: 5px 10px; border-radius: 5px; border-width: thin;"
                    id="btn-tryout-GETapi-cover-letters--id-"
                    onclick="tryItOut('GETapi-cover-letters--id-');">Try it out ⚡
            </button>
            <button type="button"
                    style="background-color: #c97a7e; padding: 5px 10px; border-radius: 5px; border-width: thin;"
                    id="btn-canceltryout-GETapi-cover-letters--id-"
                    onclick="cancelTryOut('GETapi-cover-letters--id-');" hidden>Cancel 🛑
            </button>&nbsp;&nbsp;
            <button type="submit"
                    style="background-color: #6ac174; padding: 5px 10px; border-radius: 5px; border-width: thin;"
                    id="btn-executetryout-GETapi-cover-letters--id-"
                    data-initial-text="Send Request 💥"
                    data-loading-text="⏱ Sending..."
                    hidden>Send Request 💥
            </button>
            </h3>
            <p>
            <small class="badge badge-green">GET</small>
            <b><code>api/cover-letters/{id}</code></b>
        </p>
                <h4 class="fancy-heading-panel"><b>Headers</b></h4>
                                <div style="padding-left: 28px; clear: unset;">
                <b style="line-height: 2;"><code>Content-Type</code></b>&nbsp;&nbsp;
&nbsp;
 &nbsp;
                <input type="text" style="display: none"
                              name="Content-Type"                data-endpoint="GETapi-cover-letters--id-"
               value="application/json"
               data-component="header">
    <br>
<p>Example: <code>application/json</code></p>
            </div>
                                <div style="padding-left: 28px; clear: unset;">
                <b style="line-height: 2;"><code>Accept</code></b>&nbsp;&nbsp;
&nbsp;
 &nbsp;
                <input type="text" style="display: none"
                              name="Accept"                data-endpoint="GETapi-cover-letters--id-"
               value="application/json"
               data-component="header">
    <br>
<p>Example: <code>application/json</code></p>
            </div>
                        <h4 class="fancy-heading-panel"><b>URL Parameters</b></h4>
                    <div style="padding-left: 28px; clear: unset;">
                <b style="line-height: 2;"><code>id</code></b>&nbsp;&nbsp;
<small>string</small>&nbsp;
 &nbsp;
                <input type="text" style="display: none"
                              name="id"                data-endpoint="GETapi-cover-letters--id-"
               value="0195bd90-4b5f-72e6-baa2-18b5343dc7e7"
               data-component="url">
    <br>
<p>The UUID of the cover letter. Example: <code>0195bd90-4b5f-72e6-baa2-18b5343dc7e7</code></p>
            </div>
                    </form>

                <h1 id="notepad-management">Notepad Management</h1>

    <p>APIs for managing notepads within companies. Notepads are collections of todos
that belong to a specific company application process.</p>

                                <h2 id="notepad-management-GETapi-notepads--company_id-">List Company Notepads</h2>

<p>
</p>

<p>Retrieves all notepads belonging to a specific company.
Notepads are returned in chronological order by creation date.</p>

<span id="example-requests-GETapi-notepads--company_id-">
<blockquote>Example request:</blockquote>


<div class="bash-example">
    <pre><code class="language-bash">curl --request GET \
    --get "http://localhost/api/notepads/architecto" \
    --header "Content-Type: application/json" \
    --header "Accept: application/json"</code></pre></div>


<div class="javascript-example">
    <pre><code class="language-javascript">const url = new URL(
    "http://localhost/api/notepads/architecto"
);

const headers = {
    "Content-Type": "application/json",
    "Accept": "application/json",
};

fetch(url, {
    method: "GET",
    headers,
}).then(response =&gt; response.json());</code></pre></div>

</span>

<span id="example-responses-GETapi-notepads--company_id-">
            <blockquote>
            <p>Example response (200):</p>
        </blockquote>
                <pre>

<code class="language-json" style="max-height: 300px;">[
    {
        &quot;id&quot;: &quot;0195bd90-4b67-73ce-9409-08595c3a4910&quot;,
        &quot;name&quot;: &quot;Interview Preparation&quot;,
        &quot;company_id&quot;: &quot;0195bd90-4b5f-72e6-baa2-18b5343dc7e7&quot;,
        &quot;created_at&quot;: &quot;2024-03-24T12:00:00Z&quot;,
        &quot;updated_at&quot;: &quot;2024-03-24T12:00:00Z&quot;
    }
]</code>
 </pre>
            <blockquote>
            <p>Example response (404):</p>
        </blockquote>
                <pre>

<code class="language-json" style="max-height: 300px;">{
    &quot;message&quot;: &quot;Company not found&quot;
}</code>
 </pre>
    </span>
<span id="execution-results-GETapi-notepads--company_id-" hidden>
    <blockquote>Received response<span
                id="execution-response-status-GETapi-notepads--company_id-"></span>:
    </blockquote>
    <pre class="json"><code id="execution-response-content-GETapi-notepads--company_id-"
      data-empty-response-text="<Empty response>" style="max-height: 400px;"></code></pre>
</span>
<span id="execution-error-GETapi-notepads--company_id-" hidden>
    <blockquote>Request failed with error:</blockquote>
    <pre><code id="execution-error-message-GETapi-notepads--company_id-">

Tip: Check that you&#039;re properly connected to the network.
If you&#039;re a maintainer of ths API, verify that your API is running and you&#039;ve enabled CORS.
You can check the Dev Tools console for debugging information.</code></pre>
</span>
<form id="form-GETapi-notepads--company_id-" data-method="GET"
      data-path="api/notepads/{company_id}"
      data-authed="0"
      data-hasfiles="0"
      data-isarraybody="0"
      autocomplete="off"
      onsubmit="event.preventDefault(); executeTryOut('GETapi-notepads--company_id-', this);">
    <h3>
        Request&nbsp;&nbsp;&nbsp;
                    <button type="button"
                    style="background-color: #8fbcd4; padding: 5px 10px; border-radius: 5px; border-width: thin;"
                    id="btn-tryout-GETapi-notepads--company_id-"
                    onclick="tryItOut('GETapi-notepads--company_id-');">Try it out ⚡
            </button>
            <button type="button"
                    style="background-color: #c97a7e; padding: 5px 10px; border-radius: 5px; border-width: thin;"
                    id="btn-canceltryout-GETapi-notepads--company_id-"
                    onclick="cancelTryOut('GETapi-notepads--company_id-');" hidden>Cancel 🛑
            </button>&nbsp;&nbsp;
            <button type="submit"
                    style="background-color: #6ac174; padding: 5px 10px; border-radius: 5px; border-width: thin;"
                    id="btn-executetryout-GETapi-notepads--company_id-"
                    data-initial-text="Send Request 💥"
                    data-loading-text="⏱ Sending..."
                    hidden>Send Request 💥
            </button>
            </h3>
            <p>
            <small class="badge badge-green">GET</small>
            <b><code>api/notepads/{company_id}</code></b>
        </p>
                <h4 class="fancy-heading-panel"><b>Headers</b></h4>
                                <div style="padding-left: 28px; clear: unset;">
                <b style="line-height: 2;"><code>Content-Type</code></b>&nbsp;&nbsp;
&nbsp;
 &nbsp;
                <input type="text" style="display: none"
                              name="Content-Type"                data-endpoint="GETapi-notepads--company_id-"
               value="application/json"
               data-component="header">
    <br>
<p>Example: <code>application/json</code></p>
            </div>
                                <div style="padding-left: 28px; clear: unset;">
                <b style="line-height: 2;"><code>Accept</code></b>&nbsp;&nbsp;
&nbsp;
 &nbsp;
                <input type="text" style="display: none"
                              name="Accept"                data-endpoint="GETapi-notepads--company_id-"
               value="application/json"
               data-component="header">
    <br>
<p>Example: <code>application/json</code></p>
            </div>
                        <h4 class="fancy-heading-panel"><b>URL Parameters</b></h4>
                    <div style="padding-left: 28px; clear: unset;">
                <b style="line-height: 2;"><code>company_id</code></b>&nbsp;&nbsp;
<small>string</small>&nbsp;
 &nbsp;
                <input type="text" style="display: none"
                              name="company_id"                data-endpoint="GETapi-notepads--company_id-"
               value="architecto"
               data-component="url">
    <br>
<p>The ID of the company. Example: <code>architecto</code></p>
            </div>
                    <div style="padding-left: 28px; clear: unset;">
                <b style="line-height: 2;"><code>companyId</code></b>&nbsp;&nbsp;
<small>string</small>&nbsp;
 &nbsp;
                <input type="text" style="display: none"
                              name="companyId"                data-endpoint="GETapi-notepads--company_id-"
               value="0195bd90-4b5f-72e6-baa2-18b5343dc7e7"
               data-component="url">
    <br>
<p>The UUID of the company. Example: <code>0195bd90-4b5f-72e6-baa2-18b5343dc7e7</code></p>
            </div>
                    </form>

                    <h2 id="notepad-management-POSTapi-notepads--company_id-">Create Notepad</h2>

<p>
</p>

<p>Creates a new notepad for a specific company.
Each notepad can contain multiple todos and helps organize different aspects
of the job application process.</p>

<span id="example-requests-POSTapi-notepads--company_id-">
<blockquote>Example request:</blockquote>


<div class="bash-example">
    <pre><code class="language-bash">curl --request POST \
    "http://localhost/api/notepads/architecto" \
    --header "Content-Type: application/json" \
    --header "Accept: application/json" \
    --data "{
    \"name\": \"Technical Interview Notes\"
}"
</code></pre></div>


<div class="javascript-example">
    <pre><code class="language-javascript">const url = new URL(
    "http://localhost/api/notepads/architecto"
);

const headers = {
    "Content-Type": "application/json",
    "Accept": "application/json",
};

let body = {
    "name": "Technical Interview Notes"
};

fetch(url, {
    method: "POST",
    headers,
    body: JSON.stringify(body),
}).then(response =&gt; response.json());</code></pre></div>

</span>

<span id="example-responses-POSTapi-notepads--company_id-">
            <blockquote>
            <p>Example response (201):</p>
        </blockquote>
                <pre>

<code class="language-json" style="max-height: 300px;">{
    &quot;id&quot;: &quot;0195bd90-4b67-73ce-9409-08595c3a4910&quot;,
    &quot;name&quot;: &quot;Technical Interview Notes&quot;,
    &quot;company_id&quot;: &quot;0195bd90-4b5f-72e6-baa2-18b5343dc7e7&quot;,
    &quot;created_at&quot;: &quot;2024-03-24T12:00:00Z&quot;,
    &quot;updated_at&quot;: &quot;2024-03-24T12:00:00Z&quot;
}</code>
 </pre>
            <blockquote>
            <p>Example response (422):</p>
        </blockquote>
                <pre>

<code class="language-json" style="max-height: 300px;">{
    &quot;message&quot;: &quot;The name field is required.&quot;,
    &quot;errors&quot;: {
        &quot;name&quot;: [
            &quot;The name field is required.&quot;
        ]
    }
}</code>
 </pre>
            <blockquote>
            <p>Example response (500):</p>
        </blockquote>
                <pre>

<code class="language-json" style="max-height: 300px;">{
    &quot;error&quot;: &quot;Failed to create notepad&quot;
}</code>
 </pre>
    </span>
<span id="execution-results-POSTapi-notepads--company_id-" hidden>
    <blockquote>Received response<span
                id="execution-response-status-POSTapi-notepads--company_id-"></span>:
    </blockquote>
    <pre class="json"><code id="execution-response-content-POSTapi-notepads--company_id-"
      data-empty-response-text="<Empty response>" style="max-height: 400px;"></code></pre>
</span>
<span id="execution-error-POSTapi-notepads--company_id-" hidden>
    <blockquote>Request failed with error:</blockquote>
    <pre><code id="execution-error-message-POSTapi-notepads--company_id-">

Tip: Check that you&#039;re properly connected to the network.
If you&#039;re a maintainer of ths API, verify that your API is running and you&#039;ve enabled CORS.
You can check the Dev Tools console for debugging information.</code></pre>
</span>
<form id="form-POSTapi-notepads--company_id-" data-method="POST"
      data-path="api/notepads/{company_id}"
      data-authed="0"
      data-hasfiles="0"
      data-isarraybody="0"
      autocomplete="off"
      onsubmit="event.preventDefault(); executeTryOut('POSTapi-notepads--company_id-', this);">
    <h3>
        Request&nbsp;&nbsp;&nbsp;
                    <button type="button"
                    style="background-color: #8fbcd4; padding: 5px 10px; border-radius: 5px; border-width: thin;"
                    id="btn-tryout-POSTapi-notepads--company_id-"
                    onclick="tryItOut('POSTapi-notepads--company_id-');">Try it out ⚡
            </button>
            <button type="button"
                    style="background-color: #c97a7e; padding: 5px 10px; border-radius: 5px; border-width: thin;"
                    id="btn-canceltryout-POSTapi-notepads--company_id-"
                    onclick="cancelTryOut('POSTapi-notepads--company_id-');" hidden>Cancel 🛑
            </button>&nbsp;&nbsp;
            <button type="submit"
                    style="background-color: #6ac174; padding: 5px 10px; border-radius: 5px; border-width: thin;"
                    id="btn-executetryout-POSTapi-notepads--company_id-"
                    data-initial-text="Send Request 💥"
                    data-loading-text="⏱ Sending..."
                    hidden>Send Request 💥
            </button>
            </h3>
            <p>
            <small class="badge badge-black">POST</small>
            <b><code>api/notepads/{company_id}</code></b>
        </p>
                <h4 class="fancy-heading-panel"><b>Headers</b></h4>
                                <div style="padding-left: 28px; clear: unset;">
                <b style="line-height: 2;"><code>Content-Type</code></b>&nbsp;&nbsp;
&nbsp;
 &nbsp;
                <input type="text" style="display: none"
                              name="Content-Type"                data-endpoint="POSTapi-notepads--company_id-"
               value="application/json"
               data-component="header">
    <br>
<p>Example: <code>application/json</code></p>
            </div>
                                <div style="padding-left: 28px; clear: unset;">
                <b style="line-height: 2;"><code>Accept</code></b>&nbsp;&nbsp;
&nbsp;
 &nbsp;
                <input type="text" style="display: none"
                              name="Accept"                data-endpoint="POSTapi-notepads--company_id-"
               value="application/json"
               data-component="header">
    <br>
<p>Example: <code>application/json</code></p>
            </div>
                        <h4 class="fancy-heading-panel"><b>URL Parameters</b></h4>
                    <div style="padding-left: 28px; clear: unset;">
                <b style="line-height: 2;"><code>company_id</code></b>&nbsp;&nbsp;
<small>string</small>&nbsp;
 &nbsp;
                <input type="text" style="display: none"
                              name="company_id"                data-endpoint="POSTapi-notepads--company_id-"
               value="architecto"
               data-component="url">
    <br>
<p>The ID of the company. Example: <code>architecto</code></p>
            </div>
                    <div style="padding-left: 28px; clear: unset;">
                <b style="line-height: 2;"><code>companyId</code></b>&nbsp;&nbsp;
<small>string</small>&nbsp;
 &nbsp;
                <input type="text" style="display: none"
                              name="companyId"                data-endpoint="POSTapi-notepads--company_id-"
               value="0195bd90-4b5f-72e6-baa2-18b5343dc7e7"
               data-component="url">
    <br>
<p>The UUID of the company. Example: <code>0195bd90-4b5f-72e6-baa2-18b5343dc7e7</code></p>
            </div>
                            <h4 class="fancy-heading-panel"><b>Body Parameters</b></h4>
        <div style=" padding-left: 28px;  clear: unset;">
            <b style="line-height: 2;"><code>name</code></b>&nbsp;&nbsp;
<small>string</small>&nbsp;
 &nbsp;
                <input type="text" style="display: none"
                              name="name"                data-endpoint="POSTapi-notepads--company_id-"
               value="Technical Interview Notes"
               data-component="body">
    <br>
<p>The name of the notepad. Example: <code>Technical Interview Notes</code></p>
        </div>
        </form>

                <h1 id="todo-management">Todo Management</h1>

    <p>APIs for managing todos within notepads</p>

                                <h2 id="todo-management-PATCHapi-todo-order-reorder">Reorder Todos</h2>

<p>
</p>

<p>Reorders a todo by placing it between two other todos.
Uses a numeric ordering system to maintain todo positions.</p>

<span id="example-requests-PATCHapi-todo-order-reorder">
<blockquote>Example request:</blockquote>


<div class="bash-example">
    <pre><code class="language-bash">curl --request PATCH \
    "http://localhost/api/todo-order/reorder" \
    --header "Content-Type: application/json" \
    --header "Accept: application/json"</code></pre></div>


<div class="javascript-example">
    <pre><code class="language-javascript">const url = new URL(
    "http://localhost/api/todo-order/reorder"
);

const headers = {
    "Content-Type": "application/json",
    "Accept": "application/json",
};

fetch(url, {
    method: "PATCH",
    headers,
}).then(response =&gt; response.json());</code></pre></div>

</span>

<span id="example-responses-PATCHapi-todo-order-reorder">
            <blockquote>
            <p>Example response (200):</p>
        </blockquote>
                <pre>

<code class="language-json" style="max-height: 300px;">{
    &quot;success&quot;: true
}</code>
 </pre>
            <blockquote>
            <p>Example response (422):</p>
        </blockquote>
                <pre>

<code class="language-json" style="max-height: 300px;">{
    &quot;message&quot;: &quot;The todo_id field is required.&quot;,
    &quot;errors&quot;: {
        &quot;todo_id&quot;: [
            &quot;The todo_id field is required.&quot;
        ]
    }
}</code>
 </pre>
            <blockquote>
            <p>Example response (500):</p>
        </blockquote>
                <pre>

<code class="language-json" style="max-height: 300px;">{
    &quot;error&quot;: &quot;Failed to move todo&quot;
}</code>
 </pre>
    </span>
<span id="execution-results-PATCHapi-todo-order-reorder" hidden>
    <blockquote>Received response<span
                id="execution-response-status-PATCHapi-todo-order-reorder"></span>:
    </blockquote>
    <pre class="json"><code id="execution-response-content-PATCHapi-todo-order-reorder"
      data-empty-response-text="<Empty response>" style="max-height: 400px;"></code></pre>
</span>
<span id="execution-error-PATCHapi-todo-order-reorder" hidden>
    <blockquote>Request failed with error:</blockquote>
    <pre><code id="execution-error-message-PATCHapi-todo-order-reorder">

Tip: Check that you&#039;re properly connected to the network.
If you&#039;re a maintainer of ths API, verify that your API is running and you&#039;ve enabled CORS.
You can check the Dev Tools console for debugging information.</code></pre>
</span>
<form id="form-PATCHapi-todo-order-reorder" data-method="PATCH"
      data-path="api/todo-order/reorder"
      data-authed="0"
      data-hasfiles="0"
      data-isarraybody="0"
      autocomplete="off"
      onsubmit="event.preventDefault(); executeTryOut('PATCHapi-todo-order-reorder', this);">
    <h3>
        Request&nbsp;&nbsp;&nbsp;
                    <button type="button"
                    style="background-color: #8fbcd4; padding: 5px 10px; border-radius: 5px; border-width: thin;"
                    id="btn-tryout-PATCHapi-todo-order-reorder"
                    onclick="tryItOut('PATCHapi-todo-order-reorder');">Try it out ⚡
            </button>
            <button type="button"
                    style="background-color: #c97a7e; padding: 5px 10px; border-radius: 5px; border-width: thin;"
                    id="btn-canceltryout-PATCHapi-todo-order-reorder"
                    onclick="cancelTryOut('PATCHapi-todo-order-reorder');" hidden>Cancel 🛑
            </button>&nbsp;&nbsp;
            <button type="submit"
                    style="background-color: #6ac174; padding: 5px 10px; border-radius: 5px; border-width: thin;"
                    id="btn-executetryout-PATCHapi-todo-order-reorder"
                    data-initial-text="Send Request 💥"
                    data-loading-text="⏱ Sending..."
                    hidden>Send Request 💥
            </button>
            </h3>
            <p>
            <small class="badge badge-purple">PATCH</small>
            <b><code>api/todo-order/reorder</code></b>
        </p>
                <h4 class="fancy-heading-panel"><b>Headers</b></h4>
                                <div style="padding-left: 28px; clear: unset;">
                <b style="line-height: 2;"><code>Content-Type</code></b>&nbsp;&nbsp;
&nbsp;
 &nbsp;
                <input type="text" style="display: none"
                              name="Content-Type"                data-endpoint="PATCHapi-todo-order-reorder"
               value="application/json"
               data-component="header">
    <br>
<p>Example: <code>application/json</code></p>
            </div>
                                <div style="padding-left: 28px; clear: unset;">
                <b style="line-height: 2;"><code>Accept</code></b>&nbsp;&nbsp;
&nbsp;
 &nbsp;
                <input type="text" style="display: none"
                              name="Accept"                data-endpoint="PATCHapi-todo-order-reorder"
               value="application/json"
               data-component="header">
    <br>
<p>Example: <code>application/json</code></p>
            </div>
                        <h4 class="fancy-heading-panel"><b>URL Parameters</b></h4>
                    <div style="padding-left: 28px; clear: unset;">
                <b style="line-height: 2;"><code>todo_id</code></b>&nbsp;&nbsp;
<small>string</small>&nbsp;
 &nbsp;
                <input type="text" style="display: none"
                              name="todo_id"                data-endpoint="PATCHapi-todo-order-reorder"
               value="550e8400-e29b-41d4-a716-446655440000"
               data-component="url">
    <br>
<p>UUID of the todo to move. Example: <code>550e8400-e29b-41d4-a716-446655440000</code></p>
            </div>
                    <div style="padding-left: 28px; clear: unset;">
                <b style="line-height: 2;"><code>before_id</code></b>&nbsp;&nbsp;
<small>string</small>&nbsp;
<i>optional</i> &nbsp;
                <input type="text" style="display: none"
                              name="before_id"                data-endpoint="PATCHapi-todo-order-reorder"
               value="550e8400-e29b-41d4-a716-446655440001"
               data-component="url">
    <br>
<p>UUID of the todo that will be before the moved todo. Example: <code>550e8400-e29b-41d4-a716-446655440001</code></p>
            </div>
                    <div style="padding-left: 28px; clear: unset;">
                <b style="line-height: 2;"><code>after_id</code></b>&nbsp;&nbsp;
<small>string</small>&nbsp;
<i>optional</i> &nbsp;
                <input type="text" style="display: none"
                              name="after_id"                data-endpoint="PATCHapi-todo-order-reorder"
               value="550e8400-e29b-41d4-a716-446655440002"
               data-component="url">
    <br>
<p>UUID of the todo that will be after the moved todo. Example: <code>550e8400-e29b-41d4-a716-446655440002</code></p>
            </div>
                    <div style="padding-left: 28px; clear: unset;">
                <b style="line-height: 2;"><code>notepad_id</code></b>&nbsp;&nbsp;
<small>string</small>&nbsp;
 &nbsp;
                <input type="text" style="display: none"
                              name="notepad_id"                data-endpoint="PATCHapi-todo-order-reorder"
               value="550e8400-e29b-41d4-a716-446655440003"
               data-component="url">
    <br>
<p>UUID of the notepad. Example: <code>550e8400-e29b-41d4-a716-446655440003</code></p>
            </div>
                    </form>

                    <h2 id="todo-management-GETapi-notepads--notepad--todos">Get All Todos</h2>

<p>
</p>

<p>Retrieves all todos for a specific notepad, ordered by their position.</p>

<span id="example-requests-GETapi-notepads--notepad--todos">
<blockquote>Example request:</blockquote>


<div class="bash-example">
    <pre><code class="language-bash">curl --request GET \
    --get "http://localhost/api/notepads/architecto/todos" \
    --header "Content-Type: application/json" \
    --header "Accept: application/json"</code></pre></div>


<div class="javascript-example">
    <pre><code class="language-javascript">const url = new URL(
    "http://localhost/api/notepads/architecto/todos"
);

const headers = {
    "Content-Type": "application/json",
    "Accept": "application/json",
};

fetch(url, {
    method: "GET",
    headers,
}).then(response =&gt; response.json());</code></pre></div>

</span>

<span id="example-responses-GETapi-notepads--notepad--todos">
            <blockquote>
            <p>Example response (200):</p>
        </blockquote>
                <pre>

<code class="language-json" style="max-height: 300px;">[
    {
        &quot;id&quot;: &quot;550e8400-e29b-41d4-a716-446655440000&quot;,
        &quot;notepad_id&quot;: &quot;550e8400-e29b-41d4-a716-446655440001&quot;,
        &quot;description&quot;: &quot;Buy milk&quot;,
        &quot;is_completed&quot;: false,
        &quot;created_at&quot;: &quot;2024-03-24T12:00:00Z&quot;,
        &quot;updated_at&quot;: &quot;2024-03-24T12:00:00Z&quot;
    }
]</code>
 </pre>
    </span>
<span id="execution-results-GETapi-notepads--notepad--todos" hidden>
    <blockquote>Received response<span
                id="execution-response-status-GETapi-notepads--notepad--todos"></span>:
    </blockquote>
    <pre class="json"><code id="execution-response-content-GETapi-notepads--notepad--todos"
      data-empty-response-text="<Empty response>" style="max-height: 400px;"></code></pre>
</span>
<span id="execution-error-GETapi-notepads--notepad--todos" hidden>
    <blockquote>Request failed with error:</blockquote>
    <pre><code id="execution-error-message-GETapi-notepads--notepad--todos">

Tip: Check that you&#039;re properly connected to the network.
If you&#039;re a maintainer of ths API, verify that your API is running and you&#039;ve enabled CORS.
You can check the Dev Tools console for debugging information.</code></pre>
</span>
<form id="form-GETapi-notepads--notepad--todos" data-method="GET"
      data-path="api/notepads/{notepad}/todos"
      data-authed="0"
      data-hasfiles="0"
      data-isarraybody="0"
      autocomplete="off"
      onsubmit="event.preventDefault(); executeTryOut('GETapi-notepads--notepad--todos', this);">
    <h3>
        Request&nbsp;&nbsp;&nbsp;
                    <button type="button"
                    style="background-color: #8fbcd4; padding: 5px 10px; border-radius: 5px; border-width: thin;"
                    id="btn-tryout-GETapi-notepads--notepad--todos"
                    onclick="tryItOut('GETapi-notepads--notepad--todos');">Try it out ⚡
            </button>
            <button type="button"
                    style="background-color: #c97a7e; padding: 5px 10px; border-radius: 5px; border-width: thin;"
                    id="btn-canceltryout-GETapi-notepads--notepad--todos"
                    onclick="cancelTryOut('GETapi-notepads--notepad--todos');" hidden>Cancel 🛑
            </button>&nbsp;&nbsp;
            <button type="submit"
                    style="background-color: #6ac174; padding: 5px 10px; border-radius: 5px; border-width: thin;"
                    id="btn-executetryout-GETapi-notepads--notepad--todos"
                    data-initial-text="Send Request 💥"
                    data-loading-text="⏱ Sending..."
                    hidden>Send Request 💥
            </button>
            </h3>
            <p>
            <small class="badge badge-green">GET</small>
            <b><code>api/notepads/{notepad}/todos</code></b>
        </p>
                <h4 class="fancy-heading-panel"><b>Headers</b></h4>
                                <div style="padding-left: 28px; clear: unset;">
                <b style="line-height: 2;"><code>Content-Type</code></b>&nbsp;&nbsp;
&nbsp;
 &nbsp;
                <input type="text" style="display: none"
                              name="Content-Type"                data-endpoint="GETapi-notepads--notepad--todos"
               value="application/json"
               data-component="header">
    <br>
<p>Example: <code>application/json</code></p>
            </div>
                                <div style="padding-left: 28px; clear: unset;">
                <b style="line-height: 2;"><code>Accept</code></b>&nbsp;&nbsp;
&nbsp;
 &nbsp;
                <input type="text" style="display: none"
                              name="Accept"                data-endpoint="GETapi-notepads--notepad--todos"
               value="application/json"
               data-component="header">
    <br>
<p>Example: <code>application/json</code></p>
            </div>
                        <h4 class="fancy-heading-panel"><b>URL Parameters</b></h4>
                    <div style="padding-left: 28px; clear: unset;">
                <b style="line-height: 2;"><code>notepad</code></b>&nbsp;&nbsp;
<small>string</small>&nbsp;
 &nbsp;
                <input type="text" style="display: none"
                              name="notepad"                data-endpoint="GETapi-notepads--notepad--todos"
               value="architecto"
               data-component="url">
    <br>
<p>The notepad. Example: <code>architecto</code></p>
            </div>
                    <div style="padding-left: 28px; clear: unset;">
                <b style="line-height: 2;"><code>notepad_id</code></b>&nbsp;&nbsp;
<small>string</small>&nbsp;
 &nbsp;
                <input type="text" style="display: none"
                              name="notepad_id"                data-endpoint="GETapi-notepads--notepad--todos"
               value="550e8400-e29b-41d4-a716-446655440000"
               data-component="url">
    <br>
<p>UUID of the notepad. Example: <code>550e8400-e29b-41d4-a716-446655440000</code></p>
            </div>
                    </form>

                    <h2 id="todo-management-POSTapi-notepads--notepad--todos">Create Todo</h2>

<p>
</p>

<p>Creates a new todo in the specified notepad and assigns it the last position.</p>

<span id="example-requests-POSTapi-notepads--notepad--todos">
<blockquote>Example request:</blockquote>


<div class="bash-example">
    <pre><code class="language-bash">curl --request POST \
    "http://localhost/api/notepads/architecto/todos" \
    --header "Content-Type: application/json" \
    --header "Accept: application/json" \
    --data "{
    \"description\": \"Buy groceries\"
}"
</code></pre></div>


<div class="javascript-example">
    <pre><code class="language-javascript">const url = new URL(
    "http://localhost/api/notepads/architecto/todos"
);

const headers = {
    "Content-Type": "application/json",
    "Accept": "application/json",
};

let body = {
    "description": "Buy groceries"
};

fetch(url, {
    method: "POST",
    headers,
    body: JSON.stringify(body),
}).then(response =&gt; response.json());</code></pre></div>

</span>

<span id="example-responses-POSTapi-notepads--notepad--todos">
            <blockquote>
            <p>Example response (201):</p>
        </blockquote>
                <pre>

<code class="language-json" style="max-height: 300px;">{
    &quot;id&quot;: &quot;550e8400-e29b-41d4-a716-446655440000&quot;,
    &quot;notepad_id&quot;: &quot;550e8400-e29b-41d4-a716-446655440001&quot;,
    &quot;description&quot;: &quot;Buy groceries&quot;,
    &quot;is_completed&quot;: false,
    &quot;created_at&quot;: &quot;2024-03-24T12:00:00Z&quot;,
    &quot;updated_at&quot;: &quot;2024-03-24T12:00:00Z&quot;
}</code>
 </pre>
            <blockquote>
            <p>Example response (422):</p>
        </blockquote>
                <pre>

<code class="language-json" style="max-height: 300px;">{
    &quot;message&quot;: &quot;The description field is required.&quot;,
    &quot;errors&quot;: {
        &quot;description&quot;: [
            &quot;The description field is required.&quot;
        ]
    }
}</code>
 </pre>
            <blockquote>
            <p>Example response (500):</p>
        </blockquote>
                <pre>

<code class="language-json" style="max-height: 300px;">{
    &quot;error&quot;: &quot;Failed to create todo&quot;
}</code>
 </pre>
    </span>
<span id="execution-results-POSTapi-notepads--notepad--todos" hidden>
    <blockquote>Received response<span
                id="execution-response-status-POSTapi-notepads--notepad--todos"></span>:
    </blockquote>
    <pre class="json"><code id="execution-response-content-POSTapi-notepads--notepad--todos"
      data-empty-response-text="<Empty response>" style="max-height: 400px;"></code></pre>
</span>
<span id="execution-error-POSTapi-notepads--notepad--todos" hidden>
    <blockquote>Request failed with error:</blockquote>
    <pre><code id="execution-error-message-POSTapi-notepads--notepad--todos">

Tip: Check that you&#039;re properly connected to the network.
If you&#039;re a maintainer of ths API, verify that your API is running and you&#039;ve enabled CORS.
You can check the Dev Tools console for debugging information.</code></pre>
</span>
<form id="form-POSTapi-notepads--notepad--todos" data-method="POST"
      data-path="api/notepads/{notepad}/todos"
      data-authed="0"
      data-hasfiles="0"
      data-isarraybody="0"
      autocomplete="off"
      onsubmit="event.preventDefault(); executeTryOut('POSTapi-notepads--notepad--todos', this);">
    <h3>
        Request&nbsp;&nbsp;&nbsp;
                    <button type="button"
                    style="background-color: #8fbcd4; padding: 5px 10px; border-radius: 5px; border-width: thin;"
                    id="btn-tryout-POSTapi-notepads--notepad--todos"
                    onclick="tryItOut('POSTapi-notepads--notepad--todos');">Try it out ⚡
            </button>
            <button type="button"
                    style="background-color: #c97a7e; padding: 5px 10px; border-radius: 5px; border-width: thin;"
                    id="btn-canceltryout-POSTapi-notepads--notepad--todos"
                    onclick="cancelTryOut('POSTapi-notepads--notepad--todos');" hidden>Cancel 🛑
            </button>&nbsp;&nbsp;
            <button type="submit"
                    style="background-color: #6ac174; padding: 5px 10px; border-radius: 5px; border-width: thin;"
                    id="btn-executetryout-POSTapi-notepads--notepad--todos"
                    data-initial-text="Send Request 💥"
                    data-loading-text="⏱ Sending..."
                    hidden>Send Request 💥
            </button>
            </h3>
            <p>
            <small class="badge badge-black">POST</small>
            <b><code>api/notepads/{notepad}/todos</code></b>
        </p>
                <h4 class="fancy-heading-panel"><b>Headers</b></h4>
                                <div style="padding-left: 28px; clear: unset;">
                <b style="line-height: 2;"><code>Content-Type</code></b>&nbsp;&nbsp;
&nbsp;
 &nbsp;
                <input type="text" style="display: none"
                              name="Content-Type"                data-endpoint="POSTapi-notepads--notepad--todos"
               value="application/json"
               data-component="header">
    <br>
<p>Example: <code>application/json</code></p>
            </div>
                                <div style="padding-left: 28px; clear: unset;">
                <b style="line-height: 2;"><code>Accept</code></b>&nbsp;&nbsp;
&nbsp;
 &nbsp;
                <input type="text" style="display: none"
                              name="Accept"                data-endpoint="POSTapi-notepads--notepad--todos"
               value="application/json"
               data-component="header">
    <br>
<p>Example: <code>application/json</code></p>
            </div>
                        <h4 class="fancy-heading-panel"><b>URL Parameters</b></h4>
                    <div style="padding-left: 28px; clear: unset;">
                <b style="line-height: 2;"><code>notepad</code></b>&nbsp;&nbsp;
<small>string</small>&nbsp;
 &nbsp;
                <input type="text" style="display: none"
                              name="notepad"                data-endpoint="POSTapi-notepads--notepad--todos"
               value="architecto"
               data-component="url">
    <br>
<p>The notepad. Example: <code>architecto</code></p>
            </div>
                    <div style="padding-left: 28px; clear: unset;">
                <b style="line-height: 2;"><code>notepad_id</code></b>&nbsp;&nbsp;
<small>string</small>&nbsp;
 &nbsp;
                <input type="text" style="display: none"
                              name="notepad_id"                data-endpoint="POSTapi-notepads--notepad--todos"
               value="550e8400-e29b-41d4-a716-446655440000"
               data-component="url">
    <br>
<p>UUID of the notepad. Example: <code>550e8400-e29b-41d4-a716-446655440000</code></p>
            </div>
                            <h4 class="fancy-heading-panel"><b>Body Parameters</b></h4>
        <div style=" padding-left: 28px;  clear: unset;">
            <b style="line-height: 2;"><code>description</code></b>&nbsp;&nbsp;
<small>string</small>&nbsp;
 &nbsp;
                <input type="text" style="display: none"
                              name="description"                data-endpoint="POSTapi-notepads--notepad--todos"
               value="Buy groceries"
               data-component="body">
    <br>
<p>The todo description. Example: <code>Buy groceries</code></p>
        </div>
        </form>

                    <h2 id="todo-management-DELETEapi-todos--id-">Delete Todo</h2>

<p>
</p>

<p>Deletes a specific todo by its ID.</p>

<span id="example-requests-DELETEapi-todos--id-">
<blockquote>Example request:</blockquote>


<div class="bash-example">
    <pre><code class="language-bash">curl --request DELETE \
    "http://localhost/api/todos/550e8400-e29b-41d4-a716-446655440000" \
    --header "Content-Type: application/json" \
    --header "Accept: application/json"</code></pre></div>


<div class="javascript-example">
    <pre><code class="language-javascript">const url = new URL(
    "http://localhost/api/todos/550e8400-e29b-41d4-a716-446655440000"
);

const headers = {
    "Content-Type": "application/json",
    "Accept": "application/json",
};

fetch(url, {
    method: "DELETE",
    headers,
}).then(response =&gt; response.json());</code></pre></div>

</span>

<span id="example-responses-DELETEapi-todos--id-">
            <blockquote>
            <p>Example response (200):</p>
        </blockquote>
                <pre>

<code class="language-json" style="max-height: 300px;">{
    &quot;success&quot;: true
}</code>
 </pre>
            <blockquote>
            <p>Example response (404):</p>
        </blockquote>
                <pre>

<code class="language-json" style="max-height: 300px;">{
    &quot;message&quot;: &quot;Todo not found&quot;
}</code>
 </pre>
            <blockquote>
            <p>Example response (500):</p>
        </blockquote>
                <pre>

<code class="language-json" style="max-height: 300px;">{
    &quot;error&quot;: &quot;Failed to delete todo&quot;
}</code>
 </pre>
    </span>
<span id="execution-results-DELETEapi-todos--id-" hidden>
    <blockquote>Received response<span
                id="execution-response-status-DELETEapi-todos--id-"></span>:
    </blockquote>
    <pre class="json"><code id="execution-response-content-DELETEapi-todos--id-"
      data-empty-response-text="<Empty response>" style="max-height: 400px;"></code></pre>
</span>
<span id="execution-error-DELETEapi-todos--id-" hidden>
    <blockquote>Request failed with error:</blockquote>
    <pre><code id="execution-error-message-DELETEapi-todos--id-">

Tip: Check that you&#039;re properly connected to the network.
If you&#039;re a maintainer of ths API, verify that your API is running and you&#039;ve enabled CORS.
You can check the Dev Tools console for debugging information.</code></pre>
</span>
<form id="form-DELETEapi-todos--id-" data-method="DELETE"
      data-path="api/todos/{id}"
      data-authed="0"
      data-hasfiles="0"
      data-isarraybody="0"
      autocomplete="off"
      onsubmit="event.preventDefault(); executeTryOut('DELETEapi-todos--id-', this);">
    <h3>
        Request&nbsp;&nbsp;&nbsp;
                    <button type="button"
                    style="background-color: #8fbcd4; padding: 5px 10px; border-radius: 5px; border-width: thin;"
                    id="btn-tryout-DELETEapi-todos--id-"
                    onclick="tryItOut('DELETEapi-todos--id-');">Try it out ⚡
            </button>
            <button type="button"
                    style="background-color: #c97a7e; padding: 5px 10px; border-radius: 5px; border-width: thin;"
                    id="btn-canceltryout-DELETEapi-todos--id-"
                    onclick="cancelTryOut('DELETEapi-todos--id-');" hidden>Cancel 🛑
            </button>&nbsp;&nbsp;
            <button type="submit"
                    style="background-color: #6ac174; padding: 5px 10px; border-radius: 5px; border-width: thin;"
                    id="btn-executetryout-DELETEapi-todos--id-"
                    data-initial-text="Send Request 💥"
                    data-loading-text="⏱ Sending..."
                    hidden>Send Request 💥
            </button>
            </h3>
            <p>
            <small class="badge badge-red">DELETE</small>
            <b><code>api/todos/{id}</code></b>
        </p>
                <h4 class="fancy-heading-panel"><b>Headers</b></h4>
                                <div style="padding-left: 28px; clear: unset;">
                <b style="line-height: 2;"><code>Content-Type</code></b>&nbsp;&nbsp;
&nbsp;
 &nbsp;
                <input type="text" style="display: none"
                              name="Content-Type"                data-endpoint="DELETEapi-todos--id-"
               value="application/json"
               data-component="header">
    <br>
<p>Example: <code>application/json</code></p>
            </div>
                                <div style="padding-left: 28px; clear: unset;">
                <b style="line-height: 2;"><code>Accept</code></b>&nbsp;&nbsp;
&nbsp;
 &nbsp;
                <input type="text" style="display: none"
                              name="Accept"                data-endpoint="DELETEapi-todos--id-"
               value="application/json"
               data-component="header">
    <br>
<p>Example: <code>application/json</code></p>
            </div>
                        <h4 class="fancy-heading-panel"><b>URL Parameters</b></h4>
                    <div style="padding-left: 28px; clear: unset;">
                <b style="line-height: 2;"><code>id</code></b>&nbsp;&nbsp;
<small>string</small>&nbsp;
 &nbsp;
                <input type="text" style="display: none"
                              name="id"                data-endpoint="DELETEapi-todos--id-"
               value="550e8400-e29b-41d4-a716-446655440000"
               data-component="url">
    <br>
<p>UUID of the todo. Example: <code>550e8400-e29b-41d4-a716-446655440000</code></p>
            </div>
                    </form>

                    <h2 id="todo-management-PUTapi-todos--id-">Update Todo</h2>

<p>
</p>

<p>Updates the description of a specific todo.</p>

<span id="example-requests-PUTapi-todos--id-">
<blockquote>Example request:</blockquote>


<div class="bash-example">
    <pre><code class="language-bash">curl --request PUT \
    "http://localhost/api/todos/550e8400-e29b-41d4-a716-446655440000" \
    --header "Content-Type: application/json" \
    --header "Accept: application/json" \
    --data "{
    \"description\": \"Buy milk and bread\"
}"
</code></pre></div>


<div class="javascript-example">
    <pre><code class="language-javascript">const url = new URL(
    "http://localhost/api/todos/550e8400-e29b-41d4-a716-446655440000"
);

const headers = {
    "Content-Type": "application/json",
    "Accept": "application/json",
};

let body = {
    "description": "Buy milk and bread"
};

fetch(url, {
    method: "PUT",
    headers,
    body: JSON.stringify(body),
}).then(response =&gt; response.json());</code></pre></div>

</span>

<span id="example-responses-PUTapi-todos--id-">
            <blockquote>
            <p>Example response (200):</p>
        </blockquote>
                <pre>

<code class="language-json" style="max-height: 300px;">{
    &quot;id&quot;: &quot;550e8400-e29b-41d4-a716-446655440000&quot;,
    &quot;description&quot;: &quot;Buy milk and bread&quot;,
    &quot;is_completed&quot;: false,
    &quot;updated_at&quot;: &quot;2024-03-24T12:00:00Z&quot;
}</code>
 </pre>
            <blockquote>
            <p>Example response (422):</p>
        </blockquote>
                <pre>

<code class="language-json" style="max-height: 300px;">{
    &quot;message&quot;: &quot;The description field is required.&quot;
}</code>
 </pre>
    </span>
<span id="execution-results-PUTapi-todos--id-" hidden>
    <blockquote>Received response<span
                id="execution-response-status-PUTapi-todos--id-"></span>:
    </blockquote>
    <pre class="json"><code id="execution-response-content-PUTapi-todos--id-"
      data-empty-response-text="<Empty response>" style="max-height: 400px;"></code></pre>
</span>
<span id="execution-error-PUTapi-todos--id-" hidden>
    <blockquote>Request failed with error:</blockquote>
    <pre><code id="execution-error-message-PUTapi-todos--id-">

Tip: Check that you&#039;re properly connected to the network.
If you&#039;re a maintainer of ths API, verify that your API is running and you&#039;ve enabled CORS.
You can check the Dev Tools console for debugging information.</code></pre>
</span>
<form id="form-PUTapi-todos--id-" data-method="PUT"
      data-path="api/todos/{id}"
      data-authed="0"
      data-hasfiles="0"
      data-isarraybody="0"
      autocomplete="off"
      onsubmit="event.preventDefault(); executeTryOut('PUTapi-todos--id-', this);">
    <h3>
        Request&nbsp;&nbsp;&nbsp;
                    <button type="button"
                    style="background-color: #8fbcd4; padding: 5px 10px; border-radius: 5px; border-width: thin;"
                    id="btn-tryout-PUTapi-todos--id-"
                    onclick="tryItOut('PUTapi-todos--id-');">Try it out ⚡
            </button>
            <button type="button"
                    style="background-color: #c97a7e; padding: 5px 10px; border-radius: 5px; border-width: thin;"
                    id="btn-canceltryout-PUTapi-todos--id-"
                    onclick="cancelTryOut('PUTapi-todos--id-');" hidden>Cancel 🛑
            </button>&nbsp;&nbsp;
            <button type="submit"
                    style="background-color: #6ac174; padding: 5px 10px; border-radius: 5px; border-width: thin;"
                    id="btn-executetryout-PUTapi-todos--id-"
                    data-initial-text="Send Request 💥"
                    data-loading-text="⏱ Sending..."
                    hidden>Send Request 💥
            </button>
            </h3>
            <p>
            <small class="badge badge-darkblue">PUT</small>
            <b><code>api/todos/{id}</code></b>
        </p>
                <h4 class="fancy-heading-panel"><b>Headers</b></h4>
                                <div style="padding-left: 28px; clear: unset;">
                <b style="line-height: 2;"><code>Content-Type</code></b>&nbsp;&nbsp;
&nbsp;
 &nbsp;
                <input type="text" style="display: none"
                              name="Content-Type"                data-endpoint="PUTapi-todos--id-"
               value="application/json"
               data-component="header">
    <br>
<p>Example: <code>application/json</code></p>
            </div>
                                <div style="padding-left: 28px; clear: unset;">
                <b style="line-height: 2;"><code>Accept</code></b>&nbsp;&nbsp;
&nbsp;
 &nbsp;
                <input type="text" style="display: none"
                              name="Accept"                data-endpoint="PUTapi-todos--id-"
               value="application/json"
               data-component="header">
    <br>
<p>Example: <code>application/json</code></p>
            </div>
                        <h4 class="fancy-heading-panel"><b>URL Parameters</b></h4>
                    <div style="padding-left: 28px; clear: unset;">
                <b style="line-height: 2;"><code>id</code></b>&nbsp;&nbsp;
<small>string</small>&nbsp;
 &nbsp;
                <input type="text" style="display: none"
                              name="id"                data-endpoint="PUTapi-todos--id-"
               value="550e8400-e29b-41d4-a716-446655440000"
               data-component="url">
    <br>
<p>UUID of the todo. Example: <code>550e8400-e29b-41d4-a716-446655440000</code></p>
            </div>
                            <h4 class="fancy-heading-panel"><b>Body Parameters</b></h4>
        <div style=" padding-left: 28px;  clear: unset;">
            <b style="line-height: 2;"><code>description</code></b>&nbsp;&nbsp;
<small>string</small>&nbsp;
 &nbsp;
                <input type="text" style="display: none"
                              name="description"                data-endpoint="PUTapi-todos--id-"
               value="Buy milk and bread"
               data-component="body">
    <br>
<p>The new todo description. Example: <code>Buy milk and bread</code></p>
        </div>
        </form>

                    <h2 id="todo-management-PATCHapi-todos--id--status">Toggle Todo Status</h2>

<p>
</p>

<p>Toggles the completion status of a specific todo.</p>

<span id="example-requests-PATCHapi-todos--id--status">
<blockquote>Example request:</blockquote>


<div class="bash-example">
    <pre><code class="language-bash">curl --request PATCH \
    "http://localhost/api/todos/550e8400-e29b-41d4-a716-446655440000/status" \
    --header "Content-Type: application/json" \
    --header "Accept: application/json" \
    --data "{
    \"is_completed\": true
}"
</code></pre></div>


<div class="javascript-example">
    <pre><code class="language-javascript">const url = new URL(
    "http://localhost/api/todos/550e8400-e29b-41d4-a716-446655440000/status"
);

const headers = {
    "Content-Type": "application/json",
    "Accept": "application/json",
};

let body = {
    "is_completed": true
};

fetch(url, {
    method: "PATCH",
    headers,
    body: JSON.stringify(body),
}).then(response =&gt; response.json());</code></pre></div>

</span>

<span id="example-responses-PATCHapi-todos--id--status">
            <blockquote>
            <p>Example response (200):</p>
        </blockquote>
                <pre>

<code class="language-json" style="max-height: 300px;">{
    &quot;id&quot;: &quot;550e8400-e29b-41d4-a716-446655440000&quot;,
    &quot;description&quot;: &quot;Buy groceries&quot;,
    &quot;is_completed&quot;: true,
    &quot;updated_at&quot;: &quot;2024-03-24T12:00:00Z&quot;
}</code>
 </pre>
            <blockquote>
            <p>Example response (422):</p>
        </blockquote>
                <pre>

<code class="language-json" style="max-height: 300px;">{
    &quot;message&quot;: &quot;The is_completed field is required.&quot;
}</code>
 </pre>
    </span>
<span id="execution-results-PATCHapi-todos--id--status" hidden>
    <blockquote>Received response<span
                id="execution-response-status-PATCHapi-todos--id--status"></span>:
    </blockquote>
    <pre class="json"><code id="execution-response-content-PATCHapi-todos--id--status"
      data-empty-response-text="<Empty response>" style="max-height: 400px;"></code></pre>
</span>
<span id="execution-error-PATCHapi-todos--id--status" hidden>
    <blockquote>Request failed with error:</blockquote>
    <pre><code id="execution-error-message-PATCHapi-todos--id--status">

Tip: Check that you&#039;re properly connected to the network.
If you&#039;re a maintainer of ths API, verify that your API is running and you&#039;ve enabled CORS.
You can check the Dev Tools console for debugging information.</code></pre>
</span>
<form id="form-PATCHapi-todos--id--status" data-method="PATCH"
      data-path="api/todos/{id}/status"
      data-authed="0"
      data-hasfiles="0"
      data-isarraybody="0"
      autocomplete="off"
      onsubmit="event.preventDefault(); executeTryOut('PATCHapi-todos--id--status', this);">
    <h3>
        Request&nbsp;&nbsp;&nbsp;
                    <button type="button"
                    style="background-color: #8fbcd4; padding: 5px 10px; border-radius: 5px; border-width: thin;"
                    id="btn-tryout-PATCHapi-todos--id--status"
                    onclick="tryItOut('PATCHapi-todos--id--status');">Try it out ⚡
            </button>
            <button type="button"
                    style="background-color: #c97a7e; padding: 5px 10px; border-radius: 5px; border-width: thin;"
                    id="btn-canceltryout-PATCHapi-todos--id--status"
                    onclick="cancelTryOut('PATCHapi-todos--id--status');" hidden>Cancel 🛑
            </button>&nbsp;&nbsp;
            <button type="submit"
                    style="background-color: #6ac174; padding: 5px 10px; border-radius: 5px; border-width: thin;"
                    id="btn-executetryout-PATCHapi-todos--id--status"
                    data-initial-text="Send Request 💥"
                    data-loading-text="⏱ Sending..."
                    hidden>Send Request 💥
            </button>
            </h3>
            <p>
            <small class="badge badge-purple">PATCH</small>
            <b><code>api/todos/{id}/status</code></b>
        </p>
                <h4 class="fancy-heading-panel"><b>Headers</b></h4>
                                <div style="padding-left: 28px; clear: unset;">
                <b style="line-height: 2;"><code>Content-Type</code></b>&nbsp;&nbsp;
&nbsp;
 &nbsp;
                <input type="text" style="display: none"
                              name="Content-Type"                data-endpoint="PATCHapi-todos--id--status"
               value="application/json"
               data-component="header">
    <br>
<p>Example: <code>application/json</code></p>
            </div>
                                <div style="padding-left: 28px; clear: unset;">
                <b style="line-height: 2;"><code>Accept</code></b>&nbsp;&nbsp;
&nbsp;
 &nbsp;
                <input type="text" style="display: none"
                              name="Accept"                data-endpoint="PATCHapi-todos--id--status"
               value="application/json"
               data-component="header">
    <br>
<p>Example: <code>application/json</code></p>
            </div>
                        <h4 class="fancy-heading-panel"><b>URL Parameters</b></h4>
                    <div style="padding-left: 28px; clear: unset;">
                <b style="line-height: 2;"><code>id</code></b>&nbsp;&nbsp;
<small>string</small>&nbsp;
 &nbsp;
                <input type="text" style="display: none"
                              name="id"                data-endpoint="PATCHapi-todos--id--status"
               value="550e8400-e29b-41d4-a716-446655440000"
               data-component="url">
    <br>
<p>UUID of the todo. Example: <code>550e8400-e29b-41d4-a716-446655440000</code></p>
            </div>
                            <h4 class="fancy-heading-panel"><b>Body Parameters</b></h4>
        <div style=" padding-left: 28px;  clear: unset;">
            <b style="line-height: 2;"><code>is_completed</code></b>&nbsp;&nbsp;
<small>boolean</small>&nbsp;
 &nbsp;
                <label data-endpoint="PATCHapi-todos--id--status" style="display: none">
            <input type="radio" name="is_completed"
                   value="true"
                   data-endpoint="PATCHapi-todos--id--status"
                   data-component="body"             >
            <code>true</code>
        </label>
        <label data-endpoint="PATCHapi-todos--id--status" style="display: none">
            <input type="radio" name="is_completed"
                   value="false"
                   data-endpoint="PATCHapi-todos--id--status"
                   data-component="body"             >
            <code>false</code>
        </label>
    <br>
<p>The new completion status. Example: <code>true</code></p>
        </div>
        </form>

            

        
    </div>
    <div class="dark-box">
                    <div class="lang-selector">
                                                        <button type="button" class="lang-button" data-language-name="bash">bash</button>
                                                        <button type="button" class="lang-button" data-language-name="javascript">javascript</button>
                            </div>
            </div>
</div>
</body>
</html>
