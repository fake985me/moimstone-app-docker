<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    public function up(): void
    {
        Schema::table('sales', function (Blueprint $table) {
            $table->decimal('subtotal', 15, 2)->default(0)->after('total_amount');
            $table->string('tax_type')->nullable()->after('subtotal'); // ppn, pph23, etc.
            $table->decimal('tax_rate', 5, 2)->default(0)->after('tax_type');
            $table->decimal('tax_amount', 15, 2)->default(0)->after('tax_rate');
            $table->decimal('discount_amount', 15, 2)->default(0)->after('tax_amount');
            $table->decimal('grand_total', 15, 2)->default(0)->after('discount_amount');
        });
    }

    public function down(): void
    {
        Schema::table('sales', function (Blueprint $table) {
            $table->dropColumn(['subtotal', 'tax_type', 'tax_rate', 'tax_amount', 'discount_amount', 'grand_total']);
        });
    }
};
