package com.yun.score_app;

import com.tencent.bugly.Bugly;

import io.flutter.app.FlutterApplication;

public class Application extends FlutterApplication {

    @Override
    public void onCreate() {
        super.onCreate();
        Bugly.init(getApplicationContext(), "3e7e403241", false);
    }
}
