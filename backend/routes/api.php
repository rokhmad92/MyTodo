<?php

use App\Http\Controllers\ApiTokenController;
use App\Http\Controllers\RepositoryController;
use App\Http\Resources\tasksResource;
use App\Http\Resources\todosResource;
use App\Models\Task;
use App\Models\Title;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Route;
use Illuminate\Support\Facades\Validator;

Route::middleware('auth:sanctum')->get('/user', function (Request $request) {
    return $request->user();
});

Route::post('/auth/login', [ApiTokenController::class, 'login']);
Route::post('/auth/register', [ApiTokenController::class, 'register']);
Route::middleware('auth:sanctum')->post('/auth/logout', [ApiTokenController::class, 'logout']);

Route::middleware('auth:sanctum')->get('/repo', [RepositoryController::class, 'index']);
//Route::middleware(['auth:sanctum', 'abilities:repo-view'])->get('/repo', [RepositoryController::class, 'index']);

Route::middleware('auth:sanctum')->post('/repo', [RepositoryController::class, 'store']);
//Route::middleware(['auth:sanctum', 'abilities:repo-create'])->post('/repo', [RepositoryController::class, 'index']);

// get data with token
// Route::middleware('auth:sanctum')->group(function () {
Route::get('/count', function () {
    $todo = Title::count();
    $done = Task::where('done', true)->count();
    $proses = Task::where('done', false)->count();
    $data = [
        'total' => $todo,
        'done' => $done,
        'proses' => $proses,
    ];

    return response()->json([
        'data' => $data,
    ]);
});
Route::get('/todos', function () {
    $data = Title::all();
    return new todosResource($data);
});
Route::post('/todos', function (Request $request) {
    $validateData = Validator::make($request->input(), [
        'name' => 'required',
    ]);

    if ($validateData->fails()) {
        return response()->json([
            'message' => $validateData->errors()->all(),
        ], 422);
    }

    Title::create($request->input());

    return response()->json([
        'message' => 'Berhasil create data',
    ], 201);
});
Route::get('/task/{id}', function ($todoId) {
    $data = Task::with('title')->where('title_id', $todoId)->orderBy('done', 'DESC')->get();
    return new tasksResource($data);
});
// });
