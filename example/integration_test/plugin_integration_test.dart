import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:android_rasp_flutter/android_rasp_flutter.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('verify rasp check returns a valid status', (
    WidgetTester tester,
  ) async {
    //  call the Kotlin code
    final SecurityStatus? status = await AndroidRasp.securityStatus;

    // On a real, non-rooted device, this should be SecurityStatus.secure
    // On an emulator, it should be SecurityStatus.emulator
    print('Detected Security Status: $status');
    expect(status, isNotNull);
  });
}
