import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_jdpay/flutter_jdpay.dart' as JDPay;

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String _sdkVersion = 'Unknown';
  String _payResult = '待支付';

  @override
  void initState() {
    super.initState();

    JDPay.FlutterJdPay.registerService(
        '7ad8a3d997994f6c26efee6cb2d27cdb', '22294531');
    JDPay.responsePayResult.listen((result) {
      setState(() {
        _payResult = "$result";
      });
    });
    initPlatformState();
  }

  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> initPlatformState() async {
    String sdkVersion;
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      sdkVersion = await JDPay.FlutterJdPay.getVersion;
    } on PlatformException {
      sdkVersion = 'Failed to get platform version.';
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;

    setState(() {
      _sdkVersion = sdkVersion;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Container(
          margin: EdgeInsets.symmetric(horizontal: 15),
          child: ListView(
            children: <Widget>[
              Center(child: Text('京东支付SDK 版本: $_sdkVersion')),
              RaisedButton(
                child: Text('支付'),
                onPressed: () async {
                  Map result = await JDPay.FlutterJdPay.pay(
                      '1000148966268266494059',
                      'bb05ce87d5f4c9063eb007e2301c7a83');
                  print(result);
                },
              ),
              Center(child: Text('京东支付结果: $_payResult')),
            ],
          ),
        ),
      ),
    );
  }
}
