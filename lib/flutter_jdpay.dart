import 'dart:async';

import 'package:flutter/services.dart';

class FlutterJdpay {
  static const MethodChannel _channel =
      const MethodChannel('flutter_jdpay');

  static Future<String> get platformVersion async {
    final String version = await _channel.invokeMethod('getPlatformVersion');
    return version;
  }
}
