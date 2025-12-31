package com.example.demo_alarm_app

import android.os.Bundle
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel

class MainActivity : FlutterActivity() {

    private val CHANNEL = "alarm_channel"

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)

        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, CHANNEL)
            .setMethodCallHandler { call, result ->
                when (call.method) {
                    "scheduleAlarm" -> {
                        AlarmScheduler.scheduleAlarm(this)
                        result.success(true)
                    }
                    "stopAlarm" -> {
                        stopService(android.content.Intent(this, AlarmService::class.java))
                        result.success(true)
                    }
                    else -> result.notImplemented()
                }
            }
    }
}
