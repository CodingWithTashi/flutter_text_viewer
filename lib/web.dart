import 'package:flutter/services.dart';

class File {
  final String path;
  File(this.path) {
    throw PlatformException(
      code: 'Platform Exception',
      message: 'TextViewer.file does not support in web',
    );
  }
  String readAsStringSync() {
    throw PlatformException(
        code: 'Platform Exception',
        message: 'TextViewer.file does not support in web');
  }
}
