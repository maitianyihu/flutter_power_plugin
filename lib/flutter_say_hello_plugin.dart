import 'dart:async';

import 'package:flutter/services.dart';

class FlutterSayHelloPlugin {
  static const MethodChannel _channel =
      const MethodChannel('flutter_say_hello_plugin');

  //事件通道
  static const EventChannel _eventChannel =
      const EventChannel('flutter_say_hello_plugin_event');

  static StreamSubscription eventStreamSubscription(
      void onData(dynamic event), Function error) {
    return _eventChannel
        .receiveBroadcastStream()
        .listen(onData, onError: error);
  }

  static Future<String> get platformVersion async {
    final String version = await _channel.invokeMethod('getPlatformVersion');
    return version;
  }

  static sayHello() async {
    await _channel.invokeMethod('sayHello');
  }
}
