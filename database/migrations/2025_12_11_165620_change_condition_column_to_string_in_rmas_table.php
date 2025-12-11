<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Support\Facades\DB;

return new class extends Migration
{
    /**
     * Run the migrations.
     */
    public function up(): void
    {
        // Drop and recreate the condition column as string
        DB::statement('ALTER TABLE rmas DROP COLUMN IF EXISTS `condition`');
        DB::statement('ALTER TABLE rmas ADD COLUMN `condition` VARCHAR(255) NULL AFTER `received_date`');
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        DB::statement('ALTER TABLE rmas DROP COLUMN IF EXISTS `condition`');
    }
};
