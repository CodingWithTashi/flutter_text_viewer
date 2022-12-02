import 'package:flutter/material.dart';

typedef OnErrorCallback = void Function(String error);

class TextViewer {
  /// Provide the path of the file that need to load
  /// In this case you need to pass .txt file
  /// Provide asset path
  final String? assetPath;

  ///Provide file path of i/o device
  ///Note: filePath doesn't support in flutter web since dart io is not support
  ///directly in web.For more read
  ///https://api.flutter.dev/flutter/dart-io/dart-io-library.html
  ///https://stackoverflow.com/questions/57182634/to-read-and-write-file-in-flutter-web
  final String? filePath;

  ///Provide string content
  final String? textContent;

  ///Style the text value of the file
  final TextStyle textStyle;

  ///Provide the style of character/word after search is found
  ///Default colors is Colors.blue
  final TextStyle highLightTextStyle;

  ///Provide Focus TextStyle when you navigate from one search to another search text
  ///Default colors is Colors.yellow
  final TextStyle focusTextStyle;

  ///Provide just the color of found character / word
  final Color highLightColor;

  ///Provide color of focus character / word
  final Color focusColor;

  ///Search text case is sensitive or not
  final bool ignoreCase;

  ///Search on error Callback
  final OnErrorCallback? onErrorCallback;

  const TextViewer._({
    this.assetPath,
    this.filePath,
    this.textContent,
    this.onErrorCallback,
    required this.textStyle,
    required this.focusTextStyle,
    required this.highLightTextStyle,
    required this.highLightColor,
    required this.focusColor,
    required this.ignoreCase,
  });

  factory TextViewer.asset(
    String assetPath, {
    TextStyle textStyle = const TextStyle(),
    TextStyle? highLightTextStyle,
    TextStyle? focusTextStyle,
    Color highLightColor = Colors.yellow,
    Color focusColor = Colors.amber,
    bool ignoreCase = true,
    OnErrorCallback? onErrorCallback,
  }) {
    return TextViewer._(
        assetPath: assetPath,
        textStyle: textStyle,
        highLightTextStyle: highLightTextStyle ??
            textStyle.copyWith(background: Paint()..color = highLightColor),
        focusTextStyle: focusTextStyle ??
            textStyle.copyWith(background: Paint()..color = focusColor),
        highLightColor: highLightColor,
        focusColor: focusColor,
        ignoreCase: ignoreCase,
        onErrorCallback: onErrorCallback);
  }

  factory TextViewer.file(
    String filePath, {
    TextStyle textStyle = const TextStyle(),
    TextStyle? highLightTextStyle,
    TextStyle? focusTextStyle,
    Color highLightColor = Colors.yellow,
    Color focusColor = Colors.amber,
    bool ignoreCase = true,
    OnErrorCallback? onErrorCallback,
  }) {
    return TextViewer._(
      filePath: filePath,
      textStyle: textStyle,
      highLightTextStyle: highLightTextStyle ??
          textStyle.copyWith(background: Paint()..color = highLightColor),
      focusTextStyle: focusTextStyle ??
          textStyle.copyWith(background: Paint()..color = focusColor),
      highLightColor: highLightColor,
      focusColor: focusColor,
      ignoreCase: ignoreCase,
      onErrorCallback: onErrorCallback,
    );
  }

  factory TextViewer.textValue(
    String textContent, {
    TextStyle textStyle = const TextStyle(),
    TextStyle? highLightTextStyle,
    TextStyle? focusTextStyle,
    Color highLightColor = Colors.yellow,
    Color focusColor = Colors.amber,
    bool ignoreCase = true,
    OnErrorCallback? onErrorCallback,
  }) {
    return TextViewer._(
        textContent: textContent,
        textStyle: textStyle,
        highLightTextStyle: highLightTextStyle ??
            textStyle.copyWith(background: Paint()..color = highLightColor),
        focusTextStyle: focusTextStyle ??
            textStyle.copyWith(background: Paint()..color = focusColor),
        highLightColor: highLightColor,
        focusColor: focusColor,
        ignoreCase: ignoreCase,
        onErrorCallback: onErrorCallback);
  }
}
