package com.garibook.navtest.location

import android.annotation.SuppressLint
import android.os.Looper
import com.google.android.gms.location.LocationAvailability
import com.google.android.gms.location.LocationCallback
import com.google.android.gms.location.LocationRequest
import com.google.android.gms.location.LocationResult
import io.flutter.plugin.common.EventChannel
import com.garibook.navtest.location.LocationChannelContract as C

/**
 * Continuous updates over an EventChannel.
 *
 * Lifecycle guarantee: native updates exist only between onListen and
 * onCancel (Dart cancelled its subscription) or [stop] (activity/engine
 * detached). Nothing keeps running in the background after that.
 */
class LocationStreamHandler(
    private val provider: LocationProvider,
) : EventChannel.StreamHandler {

    private var sink: EventChannel.EventSink? = null
    private var callback: LocationCallback? = null

    @SuppressLint("MissingPermission") // checked in ensureReady()
    override fun onListen(arguments: Any?, events: EventChannel.EventSink) {
        stop() // defensive: never stack two native listeners
        sink = events

        try {
            provider.ensureReady()
        } catch (e: LocationError) {
            events.error(e.code, e.message, null)
            return
        }

        val args = arguments as? Map<*, *> ?: emptyMap<String, Any>()
        val highAccuracy = args[C.ARG_HIGH_ACCURACY] as? Boolean ?: true
        val intervalMs = (args[C.ARG_INTERVAL_MS] as? Number)?.toLong() ?: DEFAULT_INTERVAL_MS
        val minDistance = (args[C.ARG_MIN_DISTANCE_M] as? Number)?.toFloat() ?: 0f

        val request = LocationRequest.Builder(LocationProvider.priorityOf(highAccuracy), intervalMs)
            .setMinUpdateIntervalMillis(intervalMs / 2)
            .setMinUpdateDistanceMeters(minDistance)
            .build()

        val cb = object : LocationCallback() {
            override fun onLocationResult(result: LocationResult) {
                result.lastLocation?.let { sink?.success(it.toChannelMap()) }
            }

            override fun onLocationAvailability(availability: LocationAvailability) {
                // Services switched off while streaming: report it, typed.
                if (!availability.isLocationAvailable && !provider.isServiceEnabled()) {
                    sink?.error(C.ERR_SERVICES_DISABLED, "Location services were turned off", null)
                }
            }
        }
        callback = cb

        try {
            provider.client.requestLocationUpdates(request, cb, Looper.getMainLooper())
        } catch (e: SecurityException) {
            callback = null
            events.error(C.ERR_PERMISSION_DENIED, "Location permission revoked", null)
        }
    }

    override fun onCancel(arguments: Any?) = stop()

    fun stop() {
        callback?.let { provider.client.removeLocationUpdates(it) }
        callback = null
        sink = null
    }

    private companion object {
        const val DEFAULT_INTERVAL_MS = 1_000L
    }
}
