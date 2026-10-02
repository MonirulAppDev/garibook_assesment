package com.garibook.navtest.location

import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.embedding.engine.plugins.activity.ActivityAware
import io.flutter.embedding.engine.plugins.activity.ActivityPluginBinding
import io.flutter.plugin.common.EventChannel
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import com.garibook.navtest.location.LocationChannelContract as C

/**
 * Entry point of the native location layer. Registered from MainActivity.
 *
 * Owns the channels and wires them to small single-purpose collaborators:
 * [PermissionManager], [LocationProvider], [LocationStreamHandler],
 * [SettingsLauncher].
 */
class LocationPlugin : FlutterPlugin, ActivityAware, MethodChannel.MethodCallHandler {

    private var methodChannel: MethodChannel? = null
    private var eventChannel: EventChannel? = null

    private var permissions: PermissionManager? = null
    private var provider: LocationProvider? = null
    private var streamHandler: LocationStreamHandler? = null
    private var settings: SettingsLauncher? = null
    private var activityBinding: ActivityPluginBinding? = null

    // region FlutterPlugin

    override fun onAttachedToEngine(binding: FlutterPlugin.FlutterPluginBinding) {
        val context = binding.applicationContext
        val permissionManager = PermissionManager(context)
        val locationProvider = LocationProvider(context, permissionManager)
        val handler = LocationStreamHandler(locationProvider)

        permissions = permissionManager
        provider = locationProvider
        streamHandler = handler
        settings = SettingsLauncher(context)

        methodChannel = MethodChannel(binding.binaryMessenger, C.METHOD_CHANNEL).also {
            it.setMethodCallHandler(this)
        }
        eventChannel = EventChannel(binding.binaryMessenger, C.EVENT_CHANNEL).also {
            it.setStreamHandler(handler)
        }
    }

    override fun onDetachedFromEngine(binding: FlutterPlugin.FlutterPluginBinding) {
        streamHandler?.stop()
        provider?.cancelAll()
        methodChannel?.setMethodCallHandler(null)
        eventChannel?.setStreamHandler(null)
        methodChannel = null
        eventChannel = null
        streamHandler = null
        provider = null
        permissions = null
        settings = null
    }

    // endregion

    // region ActivityAware

    override fun onAttachedToActivity(binding: ActivityPluginBinding) {
        activityBinding = binding
        permissions?.let {
            it.activity = binding.activity
            binding.addRequestPermissionsResultListener(it)
        }
    }

    override fun onDetachedFromActivityForConfigChanges() = detachActivity()

    override fun onReattachedToActivityForConfigChanges(binding: ActivityPluginBinding) =
        onAttachedToActivity(binding)

    override fun onDetachedFromActivity() {
        detachActivity()
        // Screen is gone for good: stop all location work.
        streamHandler?.stop()
        provider?.cancelAll()
    }

    private fun detachActivity() {
        permissions?.let { pm ->
            activityBinding?.removeRequestPermissionsResultListener(pm)
            pm.cancelPending()
            pm.activity = null
        }
        activityBinding = null
    }

    // endregion

    override fun onMethodCall(call: MethodCall, result: MethodChannel.Result) {
        val permissions = permissions
        val provider = provider
        val settings = settings
        if (permissions == null || provider == null || settings == null) {
            result.error(C.ERR_UNKNOWN, "Plugin detached", null)
            return
        }

        when (call.method) {
            C.CHECK_PERMISSION -> result.success(permissions.currentStatus())

            C.REQUEST_PERMISSION -> permissions.request { outcome ->
                outcome.fold(
                    onSuccess = { result.success(it) },
                    onFailure = { result.fail(it) },
                )
            }

            C.IS_SERVICE_ENABLED -> result.success(provider.isServiceEnabled())

            C.GET_CURRENT_LOCATION -> {
                val highAccuracy = call.argument<Boolean>(C.ARG_HIGH_ACCURACY) ?: true
                val timeoutMs = call.argument<Number>(C.ARG_TIMEOUT_MS)?.toLong() ?: DEFAULT_TIMEOUT_MS
                provider.getCurrentLocation(highAccuracy, timeoutMs) { outcome ->
                    outcome.fold(
                        onSuccess = { result.success(it) },
                        onFailure = { result.fail(it) },
                    )
                }
            }

            C.OPEN_APP_SETTINGS -> result.success(settings.openAppSettings(activityBinding?.activity))

            C.OPEN_LOCATION_SETTINGS -> result.success(settings.openLocationSettings(activityBinding?.activity))

            else -> result.notImplemented()
        }
    }

    private fun MethodChannel.Result.fail(error: Throwable) {
        if (error is LocationError) {
            error(error.code, error.message, null)
        } else {
            error(C.ERR_UNKNOWN, error.message ?: error.toString(), null)
        }
    }

    private companion object {
        const val DEFAULT_TIMEOUT_MS = 15_000L
    }
}
