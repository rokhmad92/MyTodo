<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Builder;
use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Title extends Model
{
    use HasFactory;

    protected $table = 'titles';
    protected $guarded = ['id'];

    // scope
    public function scopeUser(Builder $query): void
    {
        $query->where('user_id', auth()->user()->id);
    }

    // relasi
    public function tasks()
    {
        return $this->hasMany(Task::class, 'title_id', 'id');
    }
}
