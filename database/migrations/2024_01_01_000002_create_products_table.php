<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration {
    /**
     * Run the migrations.
     */
    public function up(): void
    {
        Schema::create('products', function (Blueprint $table) {
            $table->id();
            $table->string('sku', 100)->nullable();
            $table->text('image')->nullable();
            $table->string('category', 100)->nullable();
            $table->string('sub_category', 100)->nullable();
            $table->string('brand', 100)->nullable();
            $table->string('title')->nullable();

            // Description
            $table->text('descriptions')->nullable();

            // Stock management
            $table->integer('stock')->default(0);
            $table->integer('minimum_stock')->default(0);

            // Metadata
            $table->timestamps();

            // Indexes
            $table->index('sku');
            $table->index('category');
            $table->index('sub_category');
            $table->index('brand');
            $table->index('stock');
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('products');
    }
};
