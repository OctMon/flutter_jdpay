import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_jdpay/flutter_jdpay.dart';

void main() {
  const MethodChannel channel = MethodChannel('flutter_jdpay');

  setUp(() {
    channel.setMockMethodCallHandler((MethodCall methodCall) async {
      return '2.4.1';
    });
  });

  tearDown(() {
    channel.setMockMethodCallHandler(null);
  });

  test('getVersion', () async {
    expect(await FlutterJdPay().getVersion, '2.4.1');
  });
}
