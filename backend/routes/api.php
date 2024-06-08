<?php

use App\Models\Task;
use App\Models\Title;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;
use App\Http\Resources\tasksResource;
use App\Http\Resources\todosResource;
use Illuminate\Support\Facades\Route;
use Illuminate\Support\Facades\Validator;
use App\Http\Controllers\ApiTokenController;
use App\Http\Controllers\RepositoryController;
use App\Http\Resources\todoResource;

Route::middleware('auth:sanctum')->get('/user', function (Request $request) {
    return $request->user();
});

// auth
Route::post('/auth/login', [ApiTokenController::class, 'login']);
Route::post('/auth/register', [ApiTokenController::class, 'register']);
Route::middleware('auth:sanctum')->post('/auth/logout', [ApiTokenController::class, 'logout']);

Route::middleware('auth:sanctum')->get('/repo', [RepositoryController::class, 'index']);
//Route::middleware(['auth:sanctum', 'abilities:repo-view'])->get('/repo', [RepositoryController::class, 'index']);

Route::middleware('auth:sanctum')->post('/repo', [RepositoryController::class, 'store']);
//Route::middleware(['auth:sanctum', 'abilities:repo-create'])->post('/repo', [RepositoryController::class, 'index']);

// get data with token
Route::middleware('auth:sanctum')->group(function () {
    Route::get('/count', function () {
        $getData = Title::user()->get();
        $totalTodo = $getData->count(); // total

        // perhitungan done & proses
        $todoResources = new todosResource($getData);
        $done = 0;
        $proses = 0;
        foreach ($todoResources as $item) {
            $todoResource = new todoResource($item);
            if ($todoResource->toArray(null)['countTask'] === $todoResource->toArray(null)['countDone']) {
                $done++;
            } else {
                $proses++;
            }
        }

        $data = [
            'total' => $totalTodo,
            'done' => $done,
            'proses' => $proses,
        ];

        return response()->json([
            'data' => $data,
        ]);
    });

    Route::get('/todos', function () {
        $data = Title::user()->get();
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

        Title::create([
            'name' => $request->input('name'),
            'user_id' => $request->user()->id,
        ]);

        return response()->json([
            'message' => 'Berhasil create data',
        ], 201);
    });
    Route::delete('/todos/{id}', function ($id) {
        DB::transaction(function () use ($id) {
            Task::where('title_id', $id)->delete();
            Title::findOrFail($id)->delete();
        });

        return response()->json([
            'message' => 'Todo Berhasil Di Hapus',
        ], 201);
    });

    Route::get('/task/{id}', function ($todoId) {
        $data = Task::with('title')->where('title_id', $todoId)->orderBy('done', 'ASC')->get();
        return new tasksResource($data);
    });
    Route::post('task/{id}', function (Request $request, $id) {
        $validateData = Validator::make($request->input(), [
            'name' => 'required',
        ]);

        if ($validateData->fails()) {
            return response()->json([
                'message' => $validateData->errors()->all(),
            ], 422);
        }

        Task::create([
            'title_id' => $id,
            'name' => $request->input('name'),
        ]);

        return response()->json([
            'message' => 'Berhasil create data',
        ], 201);
    });
    Route::put('task/{id}', function ($id) {
        $data = Task::findOrFail($id);
        if ($data->done == true) {
            $data->update(['done' => false]);
            return response()->json([
                'message' => 'Task Dibuka',
            ], 201);
        } else {
            $data->update(['done' => true]);
            return response()->json([
                'message' => 'Task Berhasil Di Selesaikan',
            ], 201);
        }
    });
    Route::delete('task/{id}', function ($id) {
        Task::findOrFail($id)->delete();

        return response()->json([
            'message' => 'Task Berhasil Di Hapus',
        ], 201);
    });
});
