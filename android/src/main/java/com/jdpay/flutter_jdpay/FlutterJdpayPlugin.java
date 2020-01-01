package com.jdpay.flutter_jdpay;

import android.app.Activity;
import android.content.Intent;

import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugin.common.MethodChannel.MethodCallHandler;
import io.flutter.plugin.common.MethodChannel.Result;
import io.flutter.plugin.common.PluginRegistry;
import io.flutter.plugin.common.PluginRegistry.Registrar;

import com.jdpaysdk.author.Constants;
import com.jdpaysdk.author.JDPayAuthor;

/**
 * FlutterJdpayPlugin
 */
public class FlutterJdpayPlugin implements MethodCallHandler, PluginRegistry.ActivityResultListener {
    private static String appId;
    private static String merchantId;

    private Activity activity;
    private MethodChannel methodChannel;

    private FlutterJdpayPlugin(Activity activity, MethodChannel channel) {
        this.activity = activity;
        methodChannel = channel;
    }

    /**
     * Plugin registration.
     */
    public static void registerWith(Registrar registrar) {
        final MethodChannel channel = new MethodChannel(registrar.messenger(), "flutter_jdpay");
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
                appId = call.argument("appId");
                merchantId = call.argument("merchantId");
                break;
            case "pay":
                String orderId = call.argument("orderId");
                String signData = call.argument("signData");
                jdPayAuthor.author(activity, orderId, merchantId, appId, signData, null);
                break;
            default:
                result.notImplemented();
                break;
        }
    }

    @Override
    public boolean onActivityResult(int requestCode, int resultCode, Intent intent) {
        if (intent != null) {
            if (Constants.PAY_RESPONSE_CODE == resultCode) {
                String result = intent.getStringExtra(JDPayAuthor.JDPAY_RESULT);
                methodChannel.invokeMethod("onPayResult", result);
            }
        }
        return false;
    }
}
