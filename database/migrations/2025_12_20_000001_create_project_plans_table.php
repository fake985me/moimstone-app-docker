<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    public function up(): void
    {
        Schema::create('project_plans', function (Blueprint $table) {
            $table->id();
            $table->string('project_code')->unique();
            $table->string('title');
            $table->text('description')->nullable();
            $table->string('client_name')->nullable();
            $table->string('client_contact')->nullable();
            $table->date('start_date');
            $table->date('end_date')->nullable();
            $table->integer('estimated_duration_days')->default(0);
            $table->integer('actual_duration_days')->nullable();
            $table->enum('status', ['draft', 'planning', 'in_progress', 'on_hold', 'completed', 'cancelled'])->default('draft');
            $table->decimal('total_estimated_cost', 15, 2)->default(0);
            $table->decimal('total_actual_cost', 15, 2)->default(0);
            $table->decimal('progress_percentage', 5, 2)->default(0);
            $table->foreignId('user_id')->nullable()->constrained()->nullOnDelete();
            $table->text('notes')->nullable();
            $table->timestamps();
        });
    }

    public function down(): void
    {
        Schema::dropIfExists('project_plans');
    }
};
