<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Support\Facades\Mail;
use App\Mail\TwoFactorCodeMail;

class TwoFactorCode extends Model
{
    use HasFactory;

    protected $fillable = [
        'user_id',
        'code',
        'expires_at',
        'used_at',
    ];

    protected $casts = [
        'expires_at' => 'datetime',
        'used_at' => 'datetime',
    ];

    /**
     * Relationship to User
     */
    public function user()
    {
        return $this->belongsTo(User::class);
    }

    /**
     * Generate a new 2FA code for a user
     */
    public static function generateFor(User $user): self
    {
        // Invalidate any existing unused codes for this user
        static::where('user_id', $user->id)
            ->whereNull('used_at')
            ->delete();

        // Generate a new 6-digit code
        $code = str_pad(random_int(0, 999999), 6, '0', STR_PAD_LEFT);

        // Create the code record (expires in 10 minutes)
        $twoFactorCode = static::create([
            'user_id' => $user->id,
            'code' => $code,
            'expires_at' => now()->addMinutes(10),
        ]);

        // Send email with the code
        Mail::to($user->email)->send(new TwoFactorCodeMail($code, $user));

        return $twoFactorCode;
    }

    /**
     * Check if the code is still valid (not expired and not used)
     */
    public function isValid(): bool
    {
        return $this->expires_at->isFuture() && is_null($this->used_at);
    }

    /**
     * Mark the code as used
     */
    public function markAsUsed(): void
    {
        $this->update(['used_at' => now()]);
    }

    /**
     * Find a valid code for a user
     */
    public static function findValidCode(int $userId, string $code): ?self
    {
        return static::where('user_id', $userId)
            ->where('code', $code)
            ->whereNull('used_at')
            ->where('expires_at', '>', now())
            ->first();
    }
}
