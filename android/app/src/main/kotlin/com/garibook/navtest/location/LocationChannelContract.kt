package com.garibook.navtest.location

/**
 * Wire contract shared with Dart
 * (lib/features/location/data/datasources/location_channel_contract.dart).
 * Keep both files in sync.
 */
object LocationChannelContract {
    const val METHOD_CHANNEL = "navtest/location"
    const val EVENT_CHANNEL = "navtest/location/updates"

    // Methods
    const val CHECK_PERMISSION = "checkPermission"
    const val REQUEST_PERMISSION = "requestPermission"
    const val IS_SERVICE_ENABLED = "isLocationServiceEnabled"
    const val GET_CURRENT_LOCATION = "getCurrentLocation"
    const val OPEN_APP_SETTINGS = "openAppSettings"
    const val OPEN_LOCATION_SETTINGS = "openLocationSettings"

    // Argument keys
    const val ARG_HIGH_ACCURACY = "highAccuracy"
    const val ARG_TIMEOUT_MS = "timeoutMs"
    const val ARG_INTERVAL_MS = "intervalMs"
    const val ARG_MIN_DISTANCE_M = "minDistanceM"

    // Permission values
    const val PERMISSION_GRANTED = "granted"
    const val PERMISSION_GRANTED_APPROXIMATE = "grantedApproximate"
    const val PERMISSION_DENIED = "denied"
    const val PERMISSION_DENIED_FOREVER = "deniedForever"

    // Error codes
    const val ERR_PERMISSION_DENIED = "PERMISSION_DENIED"
    const val ERR_PERMISSION_DENIED_FOREVER = "PERMISSION_DENIED_FOREVER"
    const val ERR_SERVICES_DISABLED = "SERVICES_DISABLED"
    const val ERR_TIMEOUT = "TIMEOUT"
    const val ERR_REQUEST_IN_PROGRESS = "PERMISSION_REQUEST_IN_PROGRESS"
    const val ERR_NO_ACTIVITY = "NO_ACTIVITY"
    const val ERR_PLAY_SERVICES_UNAVAILABLE = "PLAY_SERVICES_UNAVAILABLE"
    const val ERR_UNKNOWN = "UNKNOWN"

    // Fix map keys
    const val KEY_LATITUDE = "latitude"
    const val KEY_LONGITUDE = "longitude"
    const val KEY_ACCURACY = "accuracy"
    const val KEY_BEARING = "bearing"
    const val KEY_SPEED = "speed"
    const val KEY_TIMESTAMP_MS = "timestampMs"
    const val KEY_IS_MOCK = "isMock"
}

/** Typed failure carried across the channel as (code, message). */
class LocationError(val code: String, override val message: String) : Exception(message)
