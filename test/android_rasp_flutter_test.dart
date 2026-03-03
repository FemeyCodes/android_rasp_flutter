import 'package:flutter_test/flutter_test.dart';
import 'package:android_rasp_flutter/android_rasp_flutter.dart';
import 'package:android_rasp_flutter/android_rasp_flutter_platform_interface.dart';
import 'package:android_rasp_flutter/android_rasp_flutter_method_channel.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

class MockAndroidRaspFlutterPlatform
    with MockPlatformInterfaceMixin
    implements AndroidRaspFlutterPlatform {

  @override
  Future<String?> getPlatformVersion() => Future.value('42');
}

void main() {
  final AndroidRaspFlutterPlatform initialPlatform = AndroidRaspFlutterPlatform.instance;

  test('$MethodChannelAndroidRaspFlutter is the default instance', () {
    expect(initialPlatform, isInstanceOf<MethodChannelAndroidRaspFlutter>());
  });

  test('getPlatformVersion', () async {
    AndroidRaspFlutter androidRaspFlutterPlugin = AndroidRaspFlutter();
    MockAndroidRaspFlutterPlatform fakePlatform = MockAndroidRaspFlutterPlatform();
    AndroidRaspFlutterPlatform.instance = fakePlatform;

    expect(await androidRaspFlutterPlugin.getPlatformVersion(), '42');
  });
}
