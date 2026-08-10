package com.example.weather_app_new

import android.content.Context
import io.flutter.plugin.platform.PlatformView
import io.flutter.plugin.platform.PlatformViewFactory

class NativeTextViewFactory : PlatformViewFactory(null) {

    override fun create(
        context: Context,
        viewId: Int,
        args: Any?
    ): PlatformView {
        return NativeTextView(context)
    }
}