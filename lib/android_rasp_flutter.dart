import 'package:flutter/services.dart';

enum SecurityStatus { secure, rooted, emulator, debugger, unknown }

class AndroidRasp {
  static const MethodChannel _channel = MethodChannel('android_rasp_plugin');
  static const EventChannel _eventChannel = EventChannel(
    'android_rasp_plugin/events',
  );

  // Helper method to parse the native strings into strict Enums
  static SecurityStatus _parseStatus(String? status) {
    switch (status) {
      case 'secure':
        return SecurityStatus.secure;
      case 'rooted':
        return SecurityStatus.rooted;
      case 'emulator':
        return SecurityStatus.emulator;
      case 'debugger':
        return SecurityStatus.debugger;
      default:
        return SecurityStatus.unknown;
    }
  }

  /// One-time check: Ideal for app startup (e.g., inside main() or splash screen)
  static Future<SecurityStatus?> get securityStatus async {
    try {
      final String? status = await _channel.invokeMethod('getSecurityStatus');
      return _parseStatus(status);
    } catch (e) {
      print(e);
      return null;
    }
  }

  /// Real-time subscription to android-rasp
  static Stream<SecurityStatus> get securityEvents {
    return _eventChannel.receiveBroadcastStream().map(
      (dynamic event) => _parseStatus(event as String?),
    );
  }
}
