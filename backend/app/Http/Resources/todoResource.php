<?php

namespace App\Http\Resources;

use Illuminate\Http\Request;
use Illuminate\Http\Resources\Json\JsonResource;

class todoResource extends JsonResource
{
    /**
     * Transform the resource into an array.
     *
     * @return array<string, mixed>
     */
    public function toArray(Request $request = null): array
    {
        return [
            'id' => $this->id,
            'name' => $this->name,
            'due' => $this->due,
            'countTask' => $this->tasks->count(),
            'countDone' => $this->tasks()->where('done', true)->count(),
        ];
    }
}
