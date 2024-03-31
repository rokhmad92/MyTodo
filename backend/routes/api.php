<?php

use App\Http\Controllers\ApiTokenController;
use App\Http\Controllers\RepositoryController;
use App\Http\Resources\tasksResource;
use App\Http\Resources\todosResource;
use App\Models\Task;
use App\Models\Title;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Route;

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
Route::middleware('auth:sanctum')->group(function () {
    Route::get('/todo', function () {
        $data = Title::all();
        return new todosResource($data);
    });
    Route::get('/task/{id}', function ($todoId) {
        $data = Task::where('title_id', $todoId)->get();
        return new tasksResource($data);
    });
});
