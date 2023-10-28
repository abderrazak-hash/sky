import 'dart:io';

enum PlatformType {
  mobile,
  desktop,
}

PlatformType getCurrentPlatform() {
  if (Platform.isAndroid || Platform.isIOS) {
    return PlatformType.mobile;
  } else {
    return PlatformType.desktop;
  }
}
