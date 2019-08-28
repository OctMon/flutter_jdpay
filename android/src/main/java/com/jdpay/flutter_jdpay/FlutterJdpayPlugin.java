package com.jdpay.flutter_jdpay;

import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugin.common.MethodChannel.MethodCallHandler;
import io.flutter.plugin.common.MethodChannel.Result;
import io.flutter.plugin.common.PluginRegistry.Registrar;

/** FlutterJdpayPlugin */
public class FlutterJdpayPlugin implements MethodCallHandler {
  /** Plugin registration. */
  public static void registerWith(Registrar registrar) {
    final MethodChannel channel = new MethodChannel(registrar.messenger(), "flutter_jdpay");
    channel.setMethodCallHandler(new FlutterJdpayPlugin());
  }

  @Override
  public void onMethodCall(MethodCall call, Result result) {
    switch (call.method) {
      case "getVersion":
        result.success("待实现");
        break;
      case "registerService":
        //TODO:待实现
        break;
      case "pay":
        //TODO:待实现
        break;
      default:
        result.notImplemented();
        break;
    }
  }
}
