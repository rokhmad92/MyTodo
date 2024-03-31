<?php

namespace Database\Seeders;

// use Illuminate\Database\Console\Seeds\WithoutModelEvents;

use Carbon\Carbon;
use Illuminate\Database\Seeder;

class DatabaseSeeder extends Seeder
{
    /**
     * Seed the application's database.
     */
    public function run(): void
    {
        // user
        \App\Models\User::insert([
            'name' => 'User',
            'email' => 'user@gmail.com',
            'password' => bcrypt('password'),
        ]);

        // data
        $a = \App\Models\Title::create([
            'name' => 'Belajar Flutter',
            'due' => Carbon::now()->addDay(2),
        ]);
        \App\Models\Task::insert([
            'title_id' => $a->id,
            'name' => 'Create',
            'done' => false,
            'created_at' => $a->created_at
        ]);
        \App\Models\Task::insert([
            'title_id' => $a->id,
            'name' => 'Read',
            'done' => True,
            'created_at' => $a->created_at
        ]);

        $b = \App\Models\Title::create([
            'name' => 'Belajar Laravel',
            'due' => Carbon::now()->addDay(10),
        ]);
        \App\Models\Task::insert([
            'title_id' => $b->id,
            'name' => 'Create',
            'done' => True,
            'created_at' => $b->created_at
        ]);
        \App\Models\Task::insert([
            'title_id' => $b->id,
            'name' => 'Update',
            'done' => false,
            'created_at' => $b->created_at
        ]);
    }
}
