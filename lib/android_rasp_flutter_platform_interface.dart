import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'android_rasp_flutter_method_channel.dart';

abstract class AndroidRaspFlutterPlatform extends PlatformInterface {
  /// Constructs a AndroidRaspFlutterPlatform.
  AndroidRaspFlutterPlatform() : super(token: _token);

  static final Object _token = Object();

  static AndroidRaspFlutterPlatform _instance = MethodChannelAndroidRaspFlutter();

  /// The default instance of [AndroidRaspFlutterPlatform] to use.
  ///
  /// Defaults to [MethodChannelAndroidRaspFlutter].
  static AndroidRaspFlutterPlatform get instance => _instance;

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [AndroidRaspFlutterPlatform] when
  /// they register themselves.
  static set instance(AndroidRaspFlutterPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<String?> getPlatformVersion() {
    throw UnimplementedError('platformVersion() has not been implemented.');
  }
}
