library flutter_keyword_highlighter;

import 'package:flutter/material.dart';

/// A widget that highlights specified words or phrases in a text
/// with customizable text styles. Allows optional partial matching.
class HighlightedText extends StatelessWidget {
  /// The main content text where keywords will be highlighted.
  final String content;

  /// A list of styles for specific words or phrases to be highlighted
  /// in the content text.
  final List<HighlightedTextStyle> highlightedTextStyles;

  /// An optional default text style for the content text.
  /// If not provided, a default font size and black color will be used.
  final TextStyle? defaultTextStyle;

  const HighlightedText({
    super.key,
    required this.content,
    required this.highlightedTextStyles,
    this.defaultTextStyle,
  });

  @override
  Widget build(BuildContext context) {
    List<TextSpan> textSpans = []; // Holds styled text spans for RichText.
    int currentStartIndex = 0; // Tracks current index in content string.

    // Loop through each highlight style in the list to apply to content text.
    for (final highlightStyle in highlightedTextStyles) {
      // Escape special characters in highlight text for accurate matching.
      String escapedText = RegExp.escape(highlightStyle.highlightedText);

      // Create a regex based on `allowsPartialMatch` to control match type.
      RegExp regex = highlightStyle.allowsPartialMatch
          ? RegExp(escapedText, caseSensitive: false)
          : RegExp(r'\b' + escapedText + r'\b', caseSensitive: false);

      // Find all matches in content text, add surrounding and highlighted text.
      while (true) {
        final match = regex.firstMatch(content.substring(currentStartIndex));
        if (match == null) break; // Exit if no match found.

        // Add unhighlighted text span before the match.
        if (match.start > 0) {
          textSpans.add(TextSpan(
            text: content.substring(currentStartIndex, currentStartIndex + match.start),
            style: defaultTextStyle ??
                const TextStyle(fontSize: 14.0, color: Colors.black),
          ));
        }

        // Add highlighted text span with specified style.
        textSpans.add(
          TextSpan(
            text: match.group(0),
            style: highlightStyle.customStyle.copyWith(
              fontSize: highlightStyle.highlightFontSize,
            ),
          ),
        );

        currentStartIndex += match.end; // Move start to next unmatched section.
      }
    }

    // Add any remaining unhighlighted text after the last match.
    if (currentStartIndex < content.length) {
      textSpans.add(TextSpan(
        text: content.substring(currentStartIndex),
        style: defaultTextStyle ??
            const TextStyle(fontSize: 14.0, color: Colors.black),
      ));
    }

    // Use RichText to display the content with all specified highlights.
    return RichText(
      text: TextSpan(
        children: textSpans,
        style: defaultTextStyle ??
            const TextStyle(fontSize: 14.0, color: Colors.black),
      ),
    );
  }
}

/// Defines a style for specific text to be highlighted within the content.
class HighlightedTextStyle {
  /// Text to be highlighted in the main content.
  final String highlightedText;

  /// Custom style for the highlighted text, including color, font, etc.
  final TextStyle customStyle;

  /// Font size for the highlighted text. Defaults to 14.0 if not specified.
  final double highlightFontSize;

  /// Determines if this highlight should match any occurrence
  /// (substring match) or an exact match.
  final bool allowsPartialMatch;

  /// Creates an instance of [HighlightedTextStyle] with named parameters.
  HighlightedTextStyle({
    required this.highlightedText,
    required this.customStyle,
    this.highlightFontSize = 14.0,
    this.allowsPartialMatch = false,
  });
}