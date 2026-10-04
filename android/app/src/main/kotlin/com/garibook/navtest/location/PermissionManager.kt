package com.garibook.navtest.location

import android.Manifest
import android.app.Activity
import android.content.Context
import android.content.pm.PackageManager
import androidx.core.app.ActivityCompat
import androidx.core.content.ContextCompat
import io.flutter.plugin.common.PluginRegistry
import com.garibook.navtest.location.LocationChannelContract as C

class PermissionManager(private val context: Context) :
    PluginRegistry.RequestPermissionsResultListener {

    var activity: Activity? = null

    private var pendingCallback: ((Result<String>) -> Unit)? = null

    private val prefs by lazy {
        context.getSharedPreferences(PREFS_NAME, Context.MODE_PRIVATE)
    }

    fun hasFine(): Boolean = isGranted(Manifest.permission.ACCESS_FINE_LOCATION)

    fun hasAny(): Boolean = hasFine() || isGranted(Manifest.permission.ACCESS_COARSE_LOCATION)

    fun currentStatus(): String = when {
        hasFine() -> C.PERMISSION_GRANTED
        hasAny() -> C.PERMISSION_GRANTED_APPROXIMATE
        isPermanentlyDenied() -> C.PERMISSION_DENIED_FOREVER
        else -> C.PERMISSION_DENIED
    }

    fun missingPermissionError(): LocationError =
        if (currentStatus() == C.PERMISSION_DENIED_FOREVER) {
            LocationError(C.ERR_PERMISSION_DENIED_FOREVER, "Location permission permanently denied")
        } else {
            LocationError(C.ERR_PERMISSION_DENIED, "Location permission not granted")
        }

    fun request(callback: (Result<String>) -> Unit) {
        if (hasAny()) {
            callback(Result.success(currentStatus()))
            return
        }
        val host = activity ?: run {
            callback(Result.failure(LocationError(C.ERR_NO_ACTIVITY, "No foreground activity")))
            return
        }
        if (pendingCallback != null) {
            callback(
                Result.failure(
                    LocationError(C.ERR_REQUEST_IN_PROGRESS, "A permission request is already running"),
                ),
            )
            return
        }
        pendingCallback = callback
        prefs.edit().putBoolean(KEY_ASKED_BEFORE, true).apply()
        ActivityCompat.requestPermissions(
            host,
            arrayOf(
                Manifest.permission.ACCESS_FINE_LOCATION,
                Manifest.permission.ACCESS_COARSE_LOCATION,
            ),
            REQUEST_CODE,
        )
    }

    override fun onRequestPermissionsResult(
        requestCode: Int,
        permissions: Array<out String>,
        grantResults: IntArray,
    ): Boolean {
        if (requestCode != REQUEST_CODE) return false
        val callback = pendingCallback ?: return true
        pendingCallback = null
        callback(Result.success(currentStatus()))
        return true
    }

    fun cancelPending() {
        pendingCallback?.invoke(
            Result.failure(LocationError(C.ERR_NO_ACTIVITY, "Activity detached during permission request")),
        )
        pendingCallback = null
    }

    private fun isPermanentlyDenied(): Boolean {
        val host = activity ?: return false
        val askedBefore = prefs.getBoolean(KEY_ASKED_BEFORE, false)
        return askedBefore &&
            !ActivityCompat.shouldShowRequestPermissionRationale(
                host,
                Manifest.permission.ACCESS_FINE_LOCATION,
            )
    }

    private fun isGranted(permission: String): Boolean =
        ContextCompat.checkSelfPermission(context, permission) == PackageManager.PERMISSION_GRANTED

    private companion object {
        const val REQUEST_CODE = 0x4C4F
        const val PREFS_NAME = "navtest_location_permission"
        const val KEY_ASKED_BEFORE = "asked_before"
    }
}
