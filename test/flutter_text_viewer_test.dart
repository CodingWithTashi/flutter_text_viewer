import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:flutter_text_viewer/flutter_text_viewer.dart';

void main() {
  test('adds one to input values', () {
    final calculator = TextViewerPage(
      textViewer: TextViewer.asset(''),
      showSearchAppBar: false,
    );
  });
}
