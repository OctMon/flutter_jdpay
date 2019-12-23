import 'dart:async';

import 'package:flutter/services.dart';
final MethodChannel _channel = const MethodChannel('flutter_jdpay')
  ..setMethodCallHandler(_handler);

Future<dynamic> _handler(MethodCall methodCall) {
  if ("onPayResult" == methodCall.method) {
    print("onPayResult：" + methodCall.arguments);
  }
  return Future.value(true);
}

class FlutterJdPay {
//  static const MethodChannel _channel = const MethodChannel('flutter_jdpay');

  static Future<String> get getVersion async {
    final String version = await _channel.invokeMethod('getVersion');
    return version;
  }

  /// 京东支付注册服务
  /// appId       注册的appId
  /// merchantId  注册的商户号
  static registerService(String appId, String merchantId) {
    _channel.invokeMethod(
        'registerService', {'appId': appId, 'merchantId': merchantId});
  }

  /// 唤起京东支付
  /// orderId     订单号
  /// signData    验签数据
  /// extraInfo   扩展数据，非必传，业务无特殊要求则传nil
  ///             ps:extraInfo: @{@"bizTag":@"CPAY"} bizTag:支付标识，必传
  /// result      支付完成回调
  /// 支付完成回调
  /// 其中包含字段:
  ///            errorCode:错误码
  ///            payStatus:支付状态
  ///            extraData:成功返回数据 (NSDictionary对象)
  ///
  /// 错误码
  /// 支付返回码
  ///  0001  :订单不存在或者订单查询异常
  ///  0002  :订单已完成
  ///  0003  :订单已取消
  ///  0004  :商户信息不匹配
  ///  0005  :获取不到用户pin
  ///  0006  :参数异常
  ///  0007  :获取不到商户秘钥
  ///  0008  :验签失败
  ///  0009  :查询商户信息不存在
  ///  0010  :appKey无效
  ///
  /// 注册返回码
  ///  000001	订单不存在或者订单查询异常
  ///  000002	订单已完成
  ///  000003	订单已取消
  ///  000004	未登陆
  ///  000005	系统异常,令牌生成失败
  ///  000006	pin 入参为空
  ///  000007	非法参数
  ///  000008	 查询商户信息不存在
  ///  000009	appKey无效
  ///
  /// H5支付返回码
  ///  CASH000000  :商户收单异常
  ///  CASH000001  :系统请求失败
  ///  CASH000002  :支付异常
  ///  CASH000003  :登录超时
  ///  CASH000004  :支付验签失败
  ///  CASH000005  :支付金额异常
  ///  CASH000006  :商户解密异常
  ///  CASH000007  :校验商户签名异常
  ///  CASH000008  :获取短信验证码失败
  ///  CASH000009  :此卡不支持在线支付
  ///  CASH000010  :用户卡ID出错
  ///  CASH000011  :生日输入错误
  ///  CASH000012  :验证码校验失败
  ///  CASH000013  :生日校验次数超过6次
  ///  CASH000014  :商户提交参数异常
  ///  CASH000015  :扫码支付临时订单信息获取异常
  ///  CASH000018  :该商户信息不存在
  ///  CASH000019  :该商户DES秘钥不存在
  ///  CASH000024  :商户提交参数异常
  ///  1009        :网络不通
  ///  999999      :未安装京东APP
  ///
  /// 支付状态
  ///  #define JDP_PAY_AUTH_SUCCESS  @"JDP_PAY_SUCCESS"
  ///  #define JDP_PAY_AUTH_FAIL  @"JDP_PAY_FAIL"
  ///  #define JDP_PAY_AUTH_CANCEL  @"JDP_PAY_CANCEL"
  ///  #define JDP_PAY_AUTH_NONE  @"JDP_PAY_NONE"   //暂无使用
  static Future<Map> pay(String orderId, String signData, {Map extraInfo}) {
//    return _channel.invokeMethod('pay',
//        {'orderId': orderId, 'signData': signData, 'extraInfo': extraInfo});
    return _channel.invokeMethod('pay', {
      'appId': '7ad8a3d997994f6c26efee6cb2d27cdb',
      'merchantId': '22294531',
      'orderId': orderId,
      'signData': signData,
      'extraInfo': extraInfo
    });
  }
}
