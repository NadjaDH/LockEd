package com.example.yourappname

import android.content.*
import io.flutter.plugin.common.MethodChannel
import io.flutter.view.FlutterMain

class AlarmReceiver : BroadcastReceiver() {
    override fun onReceive(context: Context, intent: Intent) {
        FlutterMain.startInitialization(context)
        FlutterMain.ensureInitializationComplete(context, null)

        val engine = io.flutter.embedding.engine.FlutterEngine(context)
        engine.dartExecutor.binaryMessenger.let {
            MethodChannel(it, "com.example.alarm/navigation")
                .invokeMethod("navigateToHome", null)
        }
    }
}
