import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'android_rasp_flutter_platform_interface.dart';

/// An implementation of [AndroidRaspFlutterPlatform] that uses method channels.
class MethodChannelAndroidRaspFlutter extends AndroidRaspFlutterPlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('android_rasp_plugin');

  @override
  Future<String?> getPlatformVersion() async {
    final version = await methodChannel.invokeMethod<String>(
      'getPlatformVersion',
    );
    return version;
  }
}
