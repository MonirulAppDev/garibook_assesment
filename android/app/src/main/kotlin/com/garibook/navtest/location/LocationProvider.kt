package com.garibook.navtest.location

import android.annotation.SuppressLint
import android.content.Context
import android.location.Location
import android.location.LocationManager
import android.os.Build
import android.os.Handler
import android.os.Looper
import android.os.SystemClock
import androidx.core.location.LocationManagerCompat
import com.google.android.gms.common.ConnectionResult
import com.google.android.gms.common.GoogleApiAvailability
import com.google.android.gms.location.CurrentLocationRequest
import com.google.android.gms.location.FusedLocationProviderClient
import com.google.android.gms.location.LocationServices
import com.google.android.gms.location.Priority
import com.google.android.gms.tasks.CancellationTokenSource
import com.garibook.navtest.location.LocationChannelContract as C

/**
 * One-shot location via [FusedLocationProviderClient] plus shared
 * precondition checks used by the stream handler.
 */
class LocationProvider(
    private val context: Context,
    private val permissions: PermissionManager,
) {
    val client: FusedLocationProviderClient =
        LocationServices.getFusedLocationProviderClient(context)

    private val mainHandler = Handler(Looper.getMainLooper())
    private val pendingRequests = mutableSetOf<CancellationTokenSource>()

    fun isServiceEnabled(): Boolean {
        val lm = context.getSystemService(Context.LOCATION_SERVICE) as LocationManager
        return LocationManagerCompat.isLocationEnabled(lm)
    }

    /** Throws [LocationError] if location can't be requested right now. */
    fun ensureReady() {
        if (!permissions.hasAny()) throw permissions.missingPermissionError()
        if (!isServiceEnabled()) {
            throw LocationError(C.ERR_SERVICES_DISABLED, "Location services are turned off")
        }
        val playServices = GoogleApiAvailability.getInstance()
            .isGooglePlayServicesAvailable(context)
        if (playServices != ConnectionResult.SUCCESS) {
            throw LocationError(
                C.ERR_PLAY_SERVICES_UNAVAILABLE,
                "Google Play services unavailable (code $playServices)",
            )
        }
    }

    @SuppressLint("MissingPermission") // checked in ensureReady()
    fun getCurrentLocation(
        highAccuracy: Boolean,
        timeoutMs: Long,
        callback: (Result<Map<String, Any?>>) -> Unit,
    ) {
        try {
            ensureReady()
        } catch (e: LocationError) {
            callback(Result.failure(e))
            return
        }

        val cts = CancellationTokenSource()
        pendingRequests += cts
        var replied = false
        fun reply(result: Result<Map<String, Any?>>) {
            if (replied) return
            replied = true
            pendingRequests -= cts
            mainHandler.removeCallbacksAndMessages(cts)
            callback(result)
        }

        // Our own hard timeout, independent of Play Services behaviour.
        mainHandler.postAtTime(
            {
                cts.cancel()
                reply(Result.failure(LocationError(C.ERR_TIMEOUT, "No location fix within ${timeoutMs}ms")))
            },
            cts,
            SystemClock.uptimeMillis() + timeoutMs,
        )

        val request = CurrentLocationRequest.Builder()
            .setPriority(priorityOf(highAccuracy))
            .setDurationMillis(timeoutMs)
            .setMaxUpdateAgeMillis(MAX_CACHED_AGE_MS)
            .build()

        try {
            client.getCurrentLocation(request, cts.token)
                .addOnSuccessListener { location ->
                    if (location != null) {
                        reply(Result.success(location.toChannelMap()))
                    } else {
                        fallbackToLastLocation(::reply)
                    }
                }
                .addOnFailureListener { e ->
                    reply(Result.failure(LocationError(C.ERR_UNKNOWN, e.message ?: "Location request failed")))
                }
        } catch (e: SecurityException) {
            reply(Result.failure(permissions.missingPermissionError()))
        }
    }

    @SuppressLint("MissingPermission")
    private fun fallbackToLastLocation(reply: (Result<Map<String, Any?>>) -> Unit) {
        try {
            client.lastLocation
                .addOnSuccessListener { last ->
                    if (last != null && last.ageMillis() <= MAX_FALLBACK_AGE_MS) {
                        reply(Result.success(last.toChannelMap()))
                    } else {
                        reply(Result.failure(LocationError(C.ERR_TIMEOUT, "No location fix available")))
                    }
                }
                .addOnFailureListener {
                    reply(Result.failure(LocationError(C.ERR_TIMEOUT, "No location fix available")))
                }
        } catch (e: SecurityException) {
            reply(Result.failure(permissions.missingPermissionError()))
        }
    }

    /** Cancel any in-flight one-shot requests (engine/activity teardown). */
    fun cancelAll() {
        pendingRequests.forEach {
            it.cancel()
            mainHandler.removeCallbacksAndMessages(it)
        }
        pendingRequests.clear()
    }

    companion object {
        private const val MAX_CACHED_AGE_MS = 10_000L
        private const val MAX_FALLBACK_AGE_MS = 2 * 60_000L

        fun priorityOf(highAccuracy: Boolean): Int =
            if (highAccuracy) Priority.PRIORITY_HIGH_ACCURACY else Priority.PRIORITY_BALANCED_POWER_ACCURACY
    }
}

private fun Location.ageMillis(): Long =
    (SystemClock.elapsedRealtimeNanos() - elapsedRealtimeNanos) / 1_000_000

internal fun Location.toChannelMap(): Map<String, Any?> = mapOf(
    C.KEY_LATITUDE to latitude,
    C.KEY_LONGITUDE to longitude,
    C.KEY_ACCURACY to if (hasAccuracy()) accuracy.toDouble() else null,
    C.KEY_BEARING to if (hasBearing()) bearing.toDouble() else null,
    C.KEY_SPEED to if (hasSpeed()) speed.toDouble() else null,
    C.KEY_TIMESTAMP_MS to time,
    C.KEY_IS_MOCK to if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.S) {
        isMock
    } else {
        @Suppress("DEPRECATION")
        isFromMockProvider
    },
)
