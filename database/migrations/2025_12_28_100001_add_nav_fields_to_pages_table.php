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
        Schema::table('pages', function (Blueprint $table) {
            $table->boolean('show_in_nav')->default(false)->after('is_published');
            $table->integer('nav_order')->default(0)->after('show_in_nav');
            $table->string('nav_parent')->nullable()->after('nav_order');
            $table->string('nav_label')->nullable()->after('nav_parent');
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::table('pages', function (Blueprint $table) {
            $table->dropColumn(['show_in_nav', 'nav_order', 'nav_parent', 'nav_label']);
        });
    }
};
