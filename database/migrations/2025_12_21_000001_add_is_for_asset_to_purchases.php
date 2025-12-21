<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    /**
     * Run the migrations.
     */
    public function up(): void
    {
        Schema::table('purchases', function (Blueprint $table) {
            $table->boolean('is_for_asset')->default(false)->after('status');
        });

        Schema::table('purchase_items', function (Blueprint $table) {
            $table->boolean('is_for_asset')->default(false)->after('subtotal');
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::table('purchases', function (Blueprint $table) {
            $table->dropColumn('is_for_asset');
        });

        Schema::table('purchase_items', function (Blueprint $table) {
            $table->dropColumn('is_for_asset');
        });
    }
};
