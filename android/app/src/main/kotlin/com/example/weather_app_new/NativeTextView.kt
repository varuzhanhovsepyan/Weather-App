package com.example.weather_app_new

import android.content.Context
import android.graphics.Color
import android.view.View
import android.widget.TextView
import io.flutter.plugin.platform.PlatformView

class NativeTextView(context: Context) : PlatformView {

    private val textView = TextView(context).apply {
        text = "Hello from Android!"
        textSize = 24f
        setTextColor(Color.BLACK)
        setBackgroundColor(Color.LTGRAY)
        gravity = android.view.Gravity.CENTER
    }

    override fun getView(): View {
        return textView
    }

    override fun dispose() {
    }
}