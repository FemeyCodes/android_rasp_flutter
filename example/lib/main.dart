import 'package:flutter/material.dart';
import 'dart:async';

import 'package:flutter/services.dart';
import 'package:android_rasp_flutter/android_rasp_flutter.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String _securityState = 'Unknown';
  final _androidRaspFlutterPlugin = AndroidRasp.securityStatus;

  @override
  void initState() {
    super.initState();
    initPlatformState();
  }

  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> initPlatformState() async {
    SecurityStatus? status;
    // Platform messages may fail, so we use a try/catch PlatformException.
    // We also handle the message potentially returning null.
    try {
      status = await _androidRaspFlutterPlugin;
    } on PlatformException {
      status = null;
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;

    switch (status) {
      case SecurityStatus.secure:
        setState(() {
          _securityState = "Secure";
        });
        break;
      case SecurityStatus.rooted:
        setState(() {
          _securityState = "Rooted";
        });
      case SecurityStatus.emulator:
        setState(() {
          _securityState = "Emulator";
        });
      case SecurityStatus.debugger:
        setState(() {
          _securityState = "Debugger";
        });
      default:
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: const Text('Plugin example app')),
        body: Center(child: Text('Security State is on: $_securityState\n')),
      ),
    );
  }
}
