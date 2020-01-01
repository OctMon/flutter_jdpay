#import "FlutterJdpayPlugin.h"
#import "JDPAuthSDK.h"

FlutterMethodChannel* channel;

@implementation FlutterJdpayPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
    channel = [FlutterMethodChannel
                                     methodChannelWithName:@"flutter_jdpay"
                                     binaryMessenger:[registrar messenger]];
    FlutterJdpayPlugin* instance = [[FlutterJdpayPlugin alloc] init];
    [registrar addMethodCallDelegate:instance channel:channel];
    [registrar addApplicationDelegate:instance];
}

- (void)handleMethodCall:(FlutterMethodCall*)call result:(FlutterResult)result {
    if ([@"getVersion" isEqualToString:call.method]) {
        result([[JDPAuthSDK sharedJDPay] version]);
    } else if ([@"registerService" isEqualToString:call.method]) {
        NSString *appId = call.arguments[@"appId"];
        NSString *merchantId = call.arguments[@"merchantId"];
        [[JDPAuthSDK sharedJDPay] registServiceWithAppID:appId merchantID:merchantId];
    } else if ([@"pay" isEqualToString:call.method]) {
        UIViewController *controller = [UIApplication sharedApplication].keyWindow.rootViewController;
        NSString *orderId = call.arguments[@"orderId"];
        NSString *signData = call.arguments[@"signData"];
        NSDictionary *extraInfo = call.arguments[@"extraInfo"];
        [[JDPAuthSDK sharedJDPay] payWithViewController:controller orderId:orderId signData:signData extraInfo:[extraInfo isKindOfClass:NSNull.self] ? nil : extraInfo completion:^(NSDictionary *resultDict) {
            [channel invokeMethod:@"onPayResult" arguments:resultDict];
        }];
    } else {
        result(FlutterMethodNotImplemented);
    }
}

- (BOOL)application:(UIApplication *)app openURL:(NSURL *)url options:(NSDictionary<UIApplicationOpenURLOptionsKey,id> *)options {
    return [self handleOpenURL:url];
}

- (BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url {
    return [self handleOpenURL:url];
}

- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation {
    return [self handleOpenURL:url];
}

-(BOOL)handleOpenURL:(NSURL*)url{
    if ([url.scheme hasPrefix:@"jdpauth"]) {
        return [[JDPAuthSDK sharedJDPay] handleOpenURL:url];
    }
    return NO;
}

@end
