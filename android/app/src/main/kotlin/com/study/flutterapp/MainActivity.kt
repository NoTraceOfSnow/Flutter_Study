package com.study.flutterapp

import android.os.Bundle
import android.widget.Toast

import io.flutter.app.FlutterActivity
import io.flutter.plugins.GeneratedPluginRegistrant

class MainActivity: FlutterActivity() {
  override fun onCreate(savedInstanceState: Bundle?) {
    super.onCreate(savedInstanceState)
    Toast.makeText(this,"ssss",Toast.LENGTH_SHORT).show()
    GeneratedPluginRegistrant.registerWith(this)
  }
}
