library flutter_keyword_highlighter;

import 'package:flutter/material.dart';

/// A widget that highlights specific keywords or phrases within a given content.
///
/// The `HighlightedText` widget takes a [content] string, a list of [highlightedTextStyles],
/// and an optional [defaultTextStyle] for unhighlighted text. Each keyword or phrase in
/// `highlightedTextStyles` will appear with its specified color and font style.
class HighlightedText extends StatelessWidget {
  final String content; // The main content to be displayed
  final List<HighlightedTextStyle> highlightedTextStyles; // List of highlighted text styles
  final TextStyle? defaultTextStyle; // Custom default text style for content

  const HighlightedText({
    super.key,
    required this.content,
    required this.highlightedTextStyles,
    this.defaultTextStyle, // Optional default text style for content
  });

  @override
  Widget build(BuildContext context) {
    List<TextSpan> textSpans = [];
    int startIndex = 0;

    // Iterate through each highlighted text style
    for (final highlight in highlightedTextStyles) {
      String escapedText = RegExp.escape(highlight.text);
      RegExp regex = RegExp(escapedText, caseSensitive: false);

      // Process each occurrence of the text to be highlighted
      while (true) {
        final match = regex.firstMatch(content.substring(startIndex));
        if (match == null) break; // Exit loop if no more matches

        // Add non-highlighted text before the matched highlighted text
        if (match.start > 0) {
          textSpans.add(TextSpan(
            text: content.substring(startIndex, startIndex + match.start),
            style: defaultTextStyle ??
                const TextStyle(fontSize: 14.0, color: Colors.black),
          ));
        }

        // Add highlighted text
        textSpans.add(TextSpan(
          text: match.group(0),
          style: highlight.style.copyWith(
              fontSize: highlight.fontSize, color: highlight.color),
        ));

        startIndex += match.end; // Move startIndex past the matched text
      }
    }

    // Add remaining unhighlighted text after the last match
    if (startIndex < content.length) {
      textSpans.add(TextSpan(
        text: content.substring(startIndex),
        style: defaultTextStyle ??
            const TextStyle(fontSize: 14.0, color: Colors.black),
      ));
    }

    return RichText(
      text: TextSpan(
        children: textSpans,
        style: defaultTextStyle ??
            const TextStyle(fontSize: 14.0, color: Colors.black),
      ),
    );
  }
}

/// A class that represents a segment of text to be highlighted, with customizable
/// color, font style, and font size.
class HighlightedTextStyle {
  final String text; // Text to highlight
  final TextStyle style; // Text style for the highlighted text
  final double fontSize; // Font size for the highlighted text
  final Color color; // Color for the highlighted text

  HighlightedTextStyle(
      this.text, {
        required this.style,
        this.fontSize = 14.0,
        this.color = Colors.black, // Default color for highlighted text
      });
}