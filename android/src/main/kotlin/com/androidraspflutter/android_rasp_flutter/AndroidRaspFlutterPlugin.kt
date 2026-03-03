package com.androidraspflutter.android_rasp_flutter

import android.content.Context
import android.os.Handler
import android.os.Looper
import androidx.annotation.NonNull
import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.plugin.common.EventChannel
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import io.flutter.plugin.common.MethodChannel.Result as FlutterResult

import com.securevale.rasp.android.SecureApp
import com.securevale.rasp.android.api.SecureAppChecker
import com.securevale.rasp.android.api.result.Result as RaspResult

class AndroidRaspFlutterPlugin : FlutterPlugin, MethodCallHandler, EventChannel.StreamHandler {

    private lateinit var methodChannel: MethodChannel
    private lateinit var eventChannel: EventChannel
    private lateinit var context: Context

    private var checker: SecureAppChecker? = null
    private var eventSink: EventChannel.EventSink? = null

    private val mainHandler = Handler(Looper.getMainLooper())

    override fun onAttachedToEngine(@NonNull flutterPluginBinding: FlutterPlugin.FlutterPluginBinding) {
        context = flutterPluginBinding.applicationContext

        SecureApp.init()

        checker = SecureAppChecker.Builder(
            context,
            checkEmulator = true,
            checkDebugger = true,
            checkRoot = true
        ).build()

        methodChannel = MethodChannel(flutterPluginBinding.binaryMessenger, "android_rasp_plugin")
        methodChannel.setMethodCallHandler(this)

        eventChannel = EventChannel(flutterPluginBinding.binaryMessenger, "android_rasp_plugin/events")
        eventChannel.setStreamHandler(this)
    }

    override fun onMethodCall(@NonNull call: MethodCall, @NonNull result: FlutterResult) {
        when (call.method) {
            "getPlatformVersion" -> {
                result.success("Android ${android.os.Build.VERSION.RELEASE}")
            }
            "getSecurityStatus" -> {
               
                val checkResult = checker?.check()
                result.success(mapResultToString(checkResult))
            }
            else -> result.notImplemented()
        }
    }

   
    override fun onListen(arguments: Any?, events: EventChannel.EventSink?) {
        eventSink = events
        Thread {
            try {
                val checkResult = checker?.check()
                val resultString = mapResultToString(checkResult)
                mainHandler.post { eventSink?.success(resultString) }
            } catch (e: Exception) {
                mainHandler.post { eventSink?.error("RASP_ERROR", e.message, null) }
            }
        }.start()
    }

    override fun onCancel(arguments: Any?) {
        eventSink = null
    }

    private fun mapResultToString(result: RaspResult?): String {
        return when (result) {
            is RaspResult.Secure -> "secure"
            is RaspResult.Rooted -> "rooted"
            is RaspResult.EmulatorFound -> "emulator"
            is RaspResult.DebuggerEnabled -> "debugger"
            else -> "unknown"
        }
    }

    override fun onDetachedFromEngine(@NonNull binding: FlutterPlugin.FlutterPluginBinding) {
        methodChannel.setMethodCallHandler(null)
        eventChannel.setStreamHandler(null)
    }
}