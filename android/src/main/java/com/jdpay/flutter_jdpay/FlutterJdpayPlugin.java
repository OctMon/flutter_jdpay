package com.jdpay.flutter_jdpay;

import android.app.Activity;

import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugin.common.MethodChannel.MethodCallHandler;
import io.flutter.plugin.common.MethodChannel.Result;
import io.flutter.plugin.common.PluginRegistry.Registrar;

import com.jdpaysdk.author.Constants;
import com.jdpaysdk.author.JDPayAuthor;

import java.util.Map;

/** FlutterJdpayPlugin */
public class FlutterJdpayPlugin implements MethodCallHandler {
  private static Activity activity;
  private static String appId;
  private static String merchantId;
  /** Plugin registration. */
  public static void registerWith(Registrar registrar) {
    final MethodChannel channel = new MethodChannel(registrar.messenger(), "flutter_jdpay");
    channel.setMethodCallHandler(new FlutterJdpayPlugin());
    activity = registrar.activity();
  }

  @Override
  public void onMethodCall(MethodCall call, Result result) {
        JDPayAuthor jdPayAuthor = new JDPayAuthor();
    switch (call.method) {
      case "getVersion":
        result.success(jdPayAuthor.getVersionCode(activity));
        break;
      case "registerService":
        appId = call.argument("appId");
        merchantId = call.argument("merchantId");
        break;
      case "pay":
        String orderId = call.argument("orderId");
        String signData = call.argument("signData");
        jdPayAuthor.author(activity, orderId, merchantId, appId, signData, null);
        result.success(JDPayAuthor.JDPAY_RESULT);
        break;
      default:
        result.notImplemented();
        break;
    }
  }
}
