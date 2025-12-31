package com.example.demo_alarm_app

import android.app.Activity
import android.content.Intent
import android.os.Build
import android.os.Bundle
import android.view.WindowManager
import android.widget.Button

class AlarmActivity : Activity() {

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)

        // Show over lock screen & turn screen ON
        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.O_MR1) {
            setShowWhenLocked(true)
            setTurnScreenOn(true)
        } else {
            window.addFlags(
                WindowManager.LayoutParams.FLAG_SHOW_WHEN_LOCKED or
                        WindowManager.LayoutParams.FLAG_TURN_SCREEN_ON
            )
        }

        setContentView(R.layout.activity_alarm)

        val stopButton = findViewById<Button>(R.id.btnStop)
        stopButton.setOnClickListener {
            stopService(Intent(this, AlarmService::class.java))
            finish()
        }
    }
}
