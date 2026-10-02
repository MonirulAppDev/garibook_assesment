package com.garibook.navtest.location

import android.app.Activity
import android.content.Context
import android.content.Intent
import android.net.Uri
import android.provider.Settings

/** Opens system settings screens natively. */
class SettingsLauncher(private val context: Context) {

    fun openAppSettings(activity: Activity?): Boolean = launch(
        activity,
        Intent(
            Settings.ACTION_APPLICATION_DETAILS_SETTINGS,
            Uri.fromParts("package", context.packageName, null),
        ),
    )

    fun openLocationSettings(activity: Activity?): Boolean =
        launch(activity, Intent(Settings.ACTION_LOCATION_SOURCE_SETTINGS))

    private fun launch(activity: Activity?, intent: Intent): Boolean = try {
        if (activity != null) {
            activity.startActivity(intent)
        } else {
            context.startActivity(intent.addFlags(Intent.FLAG_ACTIVITY_NEW_TASK))
        }
        true
    } catch (e: Exception) {
        false
    }
}
