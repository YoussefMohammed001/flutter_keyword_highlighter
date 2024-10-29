library flutter_keyword_highlighter;

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class HighlightedText extends StatelessWidget {
  final String paragraph;
  final List<HighlightText> highlightTexts; // List of highlighted texts with styles
  final TextStyle? defaultTextStyle; // Custom default text style for the paragraph

  const HighlightedText({super.key,
    required this.paragraph,
    required this.highlightTexts,
    this.defaultTextStyle, // Optional default text style for paragraph
  });

  @override
  Widget build(BuildContext context) {
    List<TextSpan> spans = [];
    int start = 0;

    // Iterate through the list of highlight texts
    for (final highlight in highlightTexts) {
      String pattern = RegExp.escape(highlight.text);
      RegExp regExp = RegExp(pattern, caseSensitive: false);

      // Add text before the highlight
      while (true) {
        final match = regExp.firstMatch(paragraph.substring(start));
        if (match == null) break; // No more matches

        if (match.start > 0) {
          spans.add(TextSpan(
            text: paragraph.substring(start, start + match.start),
            style: defaultTextStyle ?? const TextStyle(fontSize: 14.0), // Default font size if not provided
          ));
        }

        // Add highlighted text with its specific font size
        spans.add(
          TextSpan(
            text: match.group(0),
            style: highlight.style.copyWith(fontSize: highlight.fontSize), // Use the specific style and font size for this highlight
          ),
        );

        start += match.end; // Move the start to after the match
      }

      // Highlight specific indices if provided
      if (highlight.specificIndices != null) {
        for (int index in highlight.specificIndices!) {
          // Check if index is within bounds
          if (index >= 0 && index < paragraph.length) {
            final char = paragraph[index];
            spans.insert(index, TextSpan(
              text: char,
              style: const TextStyle(
                backgroundColor: Colors.yellow, // Default background for specific index
                fontWeight: FontWeight.bold,
              ),
            ));
          } else {
            // Log a warning for out-of-bounds index
            if (kDebugMode) {
              print('Warning: Specific index $index is out of bounds for the paragraph.');
            }
          }
        }
      }
    }

    // Add remaining text after last highlight
    if (start < paragraph.length) {
      spans.add(TextSpan(
        text: paragraph.substring(start),
        style: defaultTextStyle ?? const TextStyle(fontSize: 14.0), // Default font size if not provided
      ));
    }

    return RichText(
      text: TextSpan(
        children: spans,
        style: defaultTextStyle ?? const TextStyle(fontSize: 14.0), // Default font size if not provided
      ),
    );
  }
}

// A class to hold text, its style, specific indices, and font size for highlighting
class HighlightText {
  final String text;
  final TextStyle style;
  final List<int>? specificIndices; // Optional list of specific indices for highlighting
  final double fontSize; // Font size for the highlighted text

  HighlightText(this.text, this.style, {this.specificIndices, this.fontSize = 14.0}); // Default font size is 14.0
}