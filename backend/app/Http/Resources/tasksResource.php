<?php

namespace App\Http\Resources;

use Illuminate\Http\Request;
use Illuminate\Http\Resources\Json\ResourceCollection;

class tasksResource extends ResourceCollection
{
    /**
     * Transform the resource collection into an array.
     *
     * @return array<int|string, mixed>
     */
    public function toArray(Request $request): array
    {
        return [
            'name' => $this->collection->map(function ($item) {
                return $item->title->name;
            })->first(),
            'total' => count($this->collection),
            'data' => taskResource::collection($this->collection)
        ];
    }
}
