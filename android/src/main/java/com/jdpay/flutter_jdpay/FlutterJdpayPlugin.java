package com.jdpay.flutter_jdpay;

import android.app.Activity;
import android.content.Intent;
import android.widget.Toast;

import com.jdpaysdk.author.Constants;
import com.jdpaysdk.author.JDPayAuthor;

import io.flutter.Log;
import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugin.common.MethodChannel.MethodCallHandler;
import io.flutter.plugin.common.MethodChannel.Result;
import io.flutter.plugin.common.PluginRegistry;
import io.flutter.plugin.common.PluginRegistry.Registrar;

/**
 * FlutterJdpayPlugin
 */
public class FlutterJdpayPlugin implements MethodCallHandler, PluginRegistry.ActivityResultListener {
    private static Activity activity;
    private MethodChannel methodChannel;
//  private static String appId;
//  private static String merchantId;

    private FlutterJdpayPlugin(Activity activity, MethodChannel methodChannel) {
        this.activity = activity;
        this.methodChannel = methodChannel;
    }


    /**
     * Plugin registration.
     */
    public static void registerWith(Registrar registrar) {
        final MethodChannel channel = new MethodChannel(registrar.messenger(), "flutter_jdpay");
//    channel.setMethodCallHandler(new FlutterJdpayPlugin());
//    activity = registrar.activity();
        channel.setMethodCallHandler(new FlutterJdpayPlugin(registrar.activity(), channel));
        registrar.addActivityResultListener(new FlutterJdpayPlugin(registrar.activity(), channel));
    }

    @Override
    public void onMethodCall(MethodCall call, Result result) {
        JDPayAuthor jdPayAuthor = new JDPayAuthor();
        switch (call.method) {
            case "getVersion":
                result.success(jdPayAuthor.getVersionCode(activity));
                break;
            case "registerService":
//        appId = call.argument("appId");
//        merchantId = call.argument("merchantId");
                break;
            case "pay":
                String appId = call.argument("appId");
                String merchantId = call.argument("merchantId");
                String orderId = call.argument("orderId");
                String signData = call.argument("signData");
                jdPayAuthor.author(activity, orderId, merchantId, appId, signData, null);
//        result.success(JDPayAuthor.JDPAY_RESULT);
                break;
            default:
                result.notImplemented();
                break;
        }
    }

    @Override
    public boolean onActivityResult(int requestCode, int resultCode, Intent data) {
        if (data != null) {
            if (Constants.PAY_RESPONSE_CODE == resultCode) {//返回信息接收
                String result = data.getStringExtra(JDPayAuthor.JDPAY_RESULT);
                Log.e(activity.getLocalClassName(), "result:" + result);
                methodChannel.invokeMethod("onPayResult", result);
            }
        } else {
            Toast.makeText(activity, "返回为NULL", Toast.LENGTH_SHORT).show();
        }
        return false;
    }
}
