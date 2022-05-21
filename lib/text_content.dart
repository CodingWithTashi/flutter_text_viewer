import 'package:flutter/material.dart';

class TextContent extends StatelessWidget {
  final String text;
  final String? highlightText;
  final TextStyle? style;
  final TextStyle highlightStyle;
  final TextStyle focusStyle;
  final Color? highlightColor;
  final bool ignoreCase;
  final Color focusColor;
  final List<GlobalKey> keys;
  final int focusKeyIndex;
  const TextContent({
    Key? key,
    required this.text,
    this.highlightText,
    this.style,
    this.highlightColor,
    required this.highlightStyle,
    required this.focusStyle,
    this.ignoreCase = true,
    required this.focusColor,
    required this.keys,
    required this.focusKeyIndex,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if ((highlightText == null || highlightText!.isEmpty) || text.isEmpty) {
      return Text(text, style: style);
    }

    var sourceText = ignoreCase ? text.toLowerCase() : text;
    var targetHighlight =
        ignoreCase ? highlightText?.toLowerCase() : highlightText;

    List<TextSpan> spans = [];
    int start = 0;
    int indexOfHighlight;
    keys.clear();
    do {
      indexOfHighlight = sourceText.indexOf(targetHighlight!, start);
      if (indexOfHighlight < 0) {
        // no highlight
        spans.add(_normalSpan(text.substring(start)));
        break;
      }
      if (indexOfHighlight > start) {
        // normal text before highlight
        spans.add(_normalSpan(text.substring(start, indexOfHighlight)));
      }
      start = indexOfHighlight + highlightText!.length;
      //focusNodeList.add(indexOfHighlight);
      /*    if (focusNodeList.length==1) {
        spans.add(_focusSpan(text.substring(indexOfHighlight, start)));
      } else {
        spans.add(_highlightSpan(text.substring(indexOfHighlight, start)));
      }*/
      spans.add(_highlightSpan(
          text.substring(indexOfHighlight, start), indexOfHighlight));
    } while (true);
    return Text.rich(TextSpan(children: spans));
  }

  TextSpan _highlightSpan(String content, int indexOfHighlight) {
    final spanKey = GlobalKey(debugLabel: indexOfHighlight.toString());
    keys.add(spanKey);
    return TextSpan(children: [
      WidgetSpan(
        child: SizedBox(
          key: spanKey,
        ),
      ),
      TextSpan(
          text: content,
          style: keys.indexOf(spanKey) == focusKeyIndex
              ? focusStyle
              : highlightStyle),
    ]);
  }

  TextSpan _normalSpan(String content) {
    return TextSpan(text: content, style: style);
  }

  TextSpan _focusSpan(String content) {
    return TextSpan(
      text: content,
      style: focusStyle,
    );
  }
}
