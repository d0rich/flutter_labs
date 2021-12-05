package com.dorich.tpu.tpu_mobile_labs

import android.app.Service
import android.content.*
import android.os.Binder
import android.os.IBinder
import android.util.Log
import android.widget.TextView
import androidx.annotation.NonNull
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.EventChannel
import io.flutter.plugin.common.MethodChannel
import kotlinx.coroutines.GlobalScope
import kotlinx.coroutines.Job
import kotlinx.coroutines.delay
import kotlinx.coroutines.launch

const val BROADCAST_TIME_EVENT = "com.example.lab09.timeevent"

class MainActivity: FlutterActivity() {

    var myService: TimeService? = null
    var isBound = false
    private val myConnection = object : ServiceConnection {
        override fun onServiceConnected(className: ComponentName, service: IBinder) {
            val binder = service as TimeService.MyBinder
            myService = binder.getService()
            isBound = true
        }
        override fun onServiceDisconnected(name: ComponentName) {
            isBound = false
        }
    }

    override fun configureFlutterEngine(@NonNull flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)
        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, "tpu_labs/methods").setMethodCallHandler {
            call, result ->
            when (call.method){
                "startService" -> {
                    startService(Intent(this, TimeService::class.java))
                    bindService(Intent(this, TimeService::class.java),
                            myConnection, Context.BIND_AUTO_CREATE)
                    result.success(null)
                }
                "stopService" -> {
                    stopService(Intent(this, TimeService::class.java))
                    unbindService(myConnection)
                    result.success(null)
                }
                "getCounter" -> {
                    result.success(myService!!.getCounter())
                }
                "setDelay" -> {
                    myService!!.setDelay(call.arguments as Int)
                    result.success(call.arguments)
                }
                "restart" -> {
                    myService!!.restart()
                    result.success(null)
                }
                "setStartValue" -> {
                    myService!!.setStartValue(call.arguments as Int)
                    result.success(call.arguments)
                }
                else -> {
                    result.notImplemented()
                }
            }
        }

        EventChannel(flutterEngine.dartExecutor.binaryMessenger, "tpu_labs/stream").setStreamHandler(
                object: EventChannel.StreamHandler {

                    override fun onListen(arguments: Any?, events: EventChannel.EventSink?) {
                        val receiver: BroadcastReceiver? = object : BroadcastReceiver() {
                            // Получено широковещательное сообщение
                            override fun onReceive(context: Context?, intent: Intent) {
                                events?.success(intent.getIntExtra("counter", 0))
                            }
                        }
                        // Фильтр для ресивера
                        val filter = IntentFilter(BROADCAST_TIME_EVENT)
                        // Регистрация ресивера и фильтра
                        registerReceiver(receiver, filter)
                    }

                    override fun onCancel(p0: Any) {

                    }

                }
        )
    }
}

class TimeService : Service() {
    private var counter = 0
    private lateinit var job: Job
    private val myBinder = MyBinder()
    private var countDelay = 1000
    private var startValue = 0


    override fun onBind(intent: Intent?): IBinder? {
        return myBinder
    }
    override fun onStartCommand(intent: Intent?, flags: Int, startId: Int): Int {
        restart()
        job = GlobalScope.launch {
            while (true) {
                delay(countDelay.toLong())
                Log.d("SERVICE", "Timer Is Ticking: " + counter)
                counter++
                val intent = Intent(BROADCAST_TIME_EVENT);
                intent.putExtra("counter", counter);
                sendBroadcast(intent);
            }
        }
        return super.onStartCommand(intent, flags, startId)
    }
    override fun onDestroy() {
        Log.d("SERVICE", "onDestroy")
        job.cancel()
        super.onDestroy()
    }

    inner class MyBinder : Binder() {
        fun getService() : TimeService {
            return this@TimeService
        }
    }

    fun getCounter(): Int {
        return counter
    }

    fun setDelay(newDelay: Int){
        val isRunning = job.isActive
        if (isRunning) job.cancel()
        this.countDelay = newDelay
        if (isRunning) job = GlobalScope.launch {
            while (true) {
                delay(countDelay.toLong())
                Log.d("SERVICE", "Timer Is Ticking: " + counter)
                counter++
                val intent = Intent(BROADCAST_TIME_EVENT);
                intent.putExtra("counter", counter);
                sendBroadcast(intent);
            }
        }
    }

    fun restart(){
        this.counter = this.startValue
    }

    fun setStartValue(newStartValue: Int){
        this.startValue = newStartValue
    }

}