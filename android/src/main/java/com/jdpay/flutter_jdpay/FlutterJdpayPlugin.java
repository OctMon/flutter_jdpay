package com.jdpay.flutter_jdpay;

import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugin.common.MethodChannel.MethodCallHandler;
import io.flutter.plugin.common.MethodChannel.Result;
import io.flutter.plugin.common.PluginRegistry.Registrar;

import com.jdpaysdk.author.Constants;
import com.jdpaysdk.author.JDPayAuthor;

/** FlutterJdpayPlugin */
public class FlutterJdpayPlugin implements MethodCallHandler {
  /** Plugin registration. */
  public static void registerWith(Registrar registrar) {
    final MethodChannel channel = new MethodChannel(registrar.messenger(), "flutter_jdpay");
    channel.setMethodCallHandler(new FlutterJdpayPlugin());
  }

  @Override
  public void onMethodCall(MethodCall call, Result result) {
        JDPayAuthor jdPayAuthor = new JDPayAuthor();
    switch (call.method) {
      case "getVersion":
//        result.success(jdPayAuthor.getVersionCode(this));
        break;
      case "registerService":
        break;
      case "pay":
        String appId = call.argument("appId");
        String merchantId = call.argument("merchantId");
        String orderId = call.argument("orderId");
        String signData = call.argument("signData");
//        jdPayAuthor.author(MainActivity.this, orderId, merchantId, appId, signData);
        result.success(JDPayAuthor.JDPAY_RESULT);
        break;
      default:
        result.notImplemented();
        break;
    }
  }
}
