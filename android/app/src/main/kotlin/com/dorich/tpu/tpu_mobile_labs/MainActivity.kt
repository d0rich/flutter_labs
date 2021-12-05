package com.dorich.tpu.tpu_mobile_labs

import android.app.Service
import android.content.Intent
import android.os.IBinder
import android.util.Log
import androidx.annotation.NonNull
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel
import kotlinx.coroutines.GlobalScope
import kotlinx.coroutines.Job
import kotlinx.coroutines.delay
import kotlinx.coroutines.launch


class MainActivity: FlutterActivity() {
    private val CHANNEL = "tpu_labs/service"

    override fun configureFlutterEngine(@NonNull flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)
        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, CHANNEL).setMethodCallHandler {
            call, result ->
            when (call.method){
                "startService" -> {
                    startService(Intent(this, TimeService::class.java))
                    result.success(null);
                }
                "stopService" -> {
                    stopService(Intent(this, TimeService::class.java))
                    result.success(null);
                }
                else -> {
                    result.notImplemented()
                }
            }
        }
    }
}

class TimeService : Service() {
    private var counter = 0
    private lateinit var job: Job

    override fun onBind(intent: Intent?): IBinder? {
        return null
    }
    override fun onStartCommand(intent: Intent?, flags: Int, startId: Int): Int {
        job = GlobalScope.launch {
            while (true) {
                delay(1000)
                Log.d("SERVICE", "Timer Is Ticking: " + counter)
                counter++
            }
        }
        return super.onStartCommand(intent, flags, startId)
    }
    override fun onDestroy() {
        Log.d("SERVICE", "onDestroy")
        job.cancel()
        super.onDestroy()
    }
}