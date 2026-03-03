
import 'android_rasp_flutter_platform_interface.dart';

class AndroidRaspFlutter {
  Future<String?> getPlatformVersion() {
    return AndroidRaspFlutterPlatform.instance.getPlatformVersion();
  }
}
