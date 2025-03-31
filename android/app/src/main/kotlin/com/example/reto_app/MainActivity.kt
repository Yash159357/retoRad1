//package com.example.reto_radiance
//
//import io.flutter.embedding.android.FlutterActivity
//
//class MainActivity : FlutterActivity()

package com.reto.reto_radiance

import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugins.GeneratedPluginRegistrant

class MainActivity: FlutterActivity() {
    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        GeneratedPluginRegistrant.registerWith(flutterEngine)
    }
}
