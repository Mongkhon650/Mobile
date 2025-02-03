import 'dart:io';

class AppConfig {
  static String get baseUrl {
    if (Platform.isAndroid) {
      return "http://10.1.15.113:3000"; // สำหรับ Emulator Android
    } else if (Platform.isIOS) {
      return "http://10.1.15.113:3000"; // สำหรับ iOS Simulator
    } else {
      return "http://10.1.15.113:3000"; // ใช้ IP ของเครื่องโฮสต์
    }
  }
}
