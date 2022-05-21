import 'package:flutter/material.dart';

class TextViewer {
  /// Provide the path of the file that need to load
  /// In this case you need to pass .txt file
  /// Provide asset path
  final String? assetPath;

  ///Provide file path
  final String? filePath;

  ///Provide string content
  final String? textContent;

  ///Style the text value of the file
  final TextStyle textStyle;

  ///Provide the style of character/word after search is found
  ///Default colors is Colors.blue
  final TextStyle highLightTextStyle;

  ///Provide Focus TextStyle when you navigate from one seach to another search text
  ///Default colors is Colors.yellow
  final TextStyle focusTextStyle;

  ///Provide just the color of found character / word
  final Color highLightColor;

  ///Search text case is sensitive or not
  final bool ignoreCase;

  const TextViewer._({
    this.assetPath,
    this.filePath,
    this.textContent,
    required this.textStyle,
    required this.focusTextStyle,
    required this.highLightTextStyle,
    required this.highLightColor,
    required this.ignoreCase,
  });

  factory TextViewer.asset(
    String assetPath, {
    TextStyle? textStyle,
    TextStyle? highLightTextStyle,
    TextStyle? focusTextStyle,
    Color? highLightColor,
    bool? ignoreCase,
  }) {
    return TextViewer._(
      assetPath: assetPath,
      textStyle: textStyle ?? const TextStyle(),
      highLightTextStyle: highLightTextStyle ??
          textStyle?.copyWith(background: Paint()..color = highLightColor!) ??
          TextStyle(background: Paint()..color = Colors.blue),
      focusTextStyle: focusTextStyle ??
          textStyle?.copyWith(background: Paint()..color = Colors.yellow) ??
          TextStyle(background: Paint()..color = Colors.yellow),
      highLightColor: highLightColor ?? Colors.blue,
      ignoreCase: ignoreCase ?? true,
    );
  }

  factory TextViewer.file(
    String filePath, {
    TextStyle? textStyle,
    TextStyle? highLightTextStyle,
    TextStyle? focusTextStyle,
    Color? highLightColor,
    bool? ignoreCase,
  }) {
    return TextViewer._(
      filePath: filePath,
      textStyle: textStyle ?? const TextStyle(),
      highLightTextStyle: highLightTextStyle ??
          textStyle?.copyWith(background: Paint()..color = highLightColor!) ??
          TextStyle(background: Paint()..color = Colors.blue),
      focusTextStyle: focusTextStyle ??
          textStyle?.copyWith(background: Paint()..color = highLightColor!) ??
          TextStyle(background: Paint()..color = Colors.yellow),
      highLightColor: highLightColor ?? Colors.blue,
      ignoreCase: ignoreCase ?? true,
    );
  }

  factory TextViewer.textValue(
    String textContent, {
    TextStyle? textStyle,
    TextStyle? highLightTextStyle,
    TextStyle? focusTextStyle,
    Color? highLightColor,
    bool? ignoreCase,
  }) {
    return TextViewer._(
      textContent: textContent,
      textStyle: textStyle ?? const TextStyle(),
      highLightTextStyle: highLightTextStyle ??
          textStyle?.copyWith(background: Paint()..color = highLightColor!) ??
          TextStyle(background: Paint()..color = Colors.blue),
      focusTextStyle: focusTextStyle ??
          textStyle?.copyWith(background: Paint()..color = highLightColor!) ??
          TextStyle(background: Paint()..color = Colors.yellow),
      highLightColor: highLightColor ?? Colors.blue,
      ignoreCase: ignoreCase ?? true,
    );
  }
}
