import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:android_rasp_flutter/android_rasp_flutter.dart';

void main() {
  const MethodChannel channel = MethodChannel('android_rasp_plugin');

  TestWidgetsFlutterBinding.ensureInitialized();

  tearDown(() {
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
        .setMockMethodCallHandler(channel, null);
  });

  test(
    'getSecurityStatus returns rooted enum when native returns "rooted"',
    () async {
      TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
          .setMockMethodCallHandler(channel, (MethodCall methodCall) async {
            return 'rooted';
          });

      expect(await AndroidRasp.securityStatus, SecurityStatus.rooted);
    },
  );
}
