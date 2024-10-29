library flutter_keyword_highlighter;
import 'package:flutter/material.dart';

class HighlightedText extends StatelessWidget {
  final String paragraph;
  final String searchWord;
  final double fontSize;
  final Color highlightColor;      // Default highlight color
  final Color highlightTextColor;  // Default highlighted text color
  final double highlightedTextSize; // Specific size for the highlighted text

  const HighlightedText({super.key,
    required this.paragraph,
    required this.searchWord,
    required this.fontSize,
    this.highlightColor = Colors.yellow,       // Default highlight color is yellow
    this.highlightTextColor = Colors.black,    // Default text color is black
    this.highlightedTextSize = 16.0,           // Default size for highlighted text
  });

  @override
  Widget build(BuildContext context) {
    List<TextSpan> spans = [];
    String pattern = RegExp.escape(searchWord);
    RegExp regExp = RegExp(pattern, caseSensitive: false);

    int start = 0;
    for (final match in regExp.allMatches(paragraph)) {
      if (match.start > start) {
        spans.add(TextSpan(
          text: paragraph.substring(start, match.start),
          style: TextStyle(fontSize: fontSize),
        ));
      }

      spans.add(
        TextSpan(
          text: paragraph.substring(match.start, match.end),
          style: TextStyle(
            fontSize: highlightedTextSize,
            color: highlightTextColor,
            backgroundColor: highlightColor,
            fontWeight: FontWeight.bold,
          ),
        ),
      );

      start = match.end;
    }

    if (start < paragraph.length) {
      spans.add(TextSpan(
        text: paragraph.substring(start),
        style: TextStyle(fontSize: fontSize),
      ));
    }

    return RichText(
      text: TextSpan(
        children: spans,
        style: TextStyle(fontSize: fontSize),
      ),
    );
  }
}