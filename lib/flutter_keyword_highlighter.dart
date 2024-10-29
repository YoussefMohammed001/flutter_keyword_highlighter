library flutter_keyword_highlighter;

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class HighlightedText extends StatelessWidget {
  final String content; // Renamed from 'paragraph' to 'content'
  final List<HighlightedTextStyle>
      highlightedTextStyles; // Renamed from 'highlightTexts' to 'highlightedTextStyles'
  final TextStyle?
      defaultTextStyle; // Custom default text style for the content

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

    // Iterate through the list of highlighted text styles
    for (final highlight in highlightedTextStyles) {
      String escapedText = RegExp.escape(highlight.text);
      RegExp regex = RegExp(escapedText, caseSensitive: false);

      // Add text before the highlight
      while (true) {
        final match = regex.firstMatch(content.substring(startIndex));
        if (match == null) break; // No more matches

        if (match.start > 0) {
          textSpans.add(TextSpan(
            text: content.substring(startIndex, startIndex + match.start),
            style: defaultTextStyle ??
                const TextStyle(
                    fontSize: 14.0), // Default font size if not provided
          ));
        }

        // Add highlighted text with its specific font size
        textSpans.add(
          TextSpan(
            text: match.group(0),
            style: highlight.style.copyWith(
                fontSize: highlight
                    .fontSize), // Use the specific style and font size for this highlight
          ),
        );

        startIndex += match.end; // Move the start to after the match
      }

      // Highlight specific indices if provided
      if (highlight.specificIndices != null) {
        for (int index in highlight.specificIndices!) {
          // Check if index is within bounds
          if (index >= 0 && index < content.length) {
            final char = content[index];
            textSpans.insert(
                index,
                TextSpan(
                  text: char,
                  style: const TextStyle(
                    backgroundColor:
                        Colors.yellow, // Default background for specific index
                    fontWeight: FontWeight.bold,
                  ),
                ));
          } else {
            // Log a warning for out-of-bounds index
            if (kDebugMode) {
              print(
                  'Warning: Specific index $index is out of bounds for the content.');
            }
          }
        }
      }
    }

    // Add remaining text after last highlight
    if (startIndex < content.length) {
      textSpans.add(TextSpan(
        text: content.substring(startIndex),
        style: defaultTextStyle ??
            const TextStyle(
                fontSize: 14.0), // Default font size if not provided
      ));
    }

    return RichText(
      text: TextSpan(
        children: textSpans,
        style: defaultTextStyle ??
            const TextStyle(
                fontSize: 14.0), // Default font size if not provided
      ),
    );
  }
}

// A class to hold text, its style, specific indices, and font size for highlighting
class HighlightedTextStyle {
  final String text; // Text to highlight
  final TextStyle style; // Style for the highlighted text
  final List<int>?
      specificIndices; // Optional list of specific indices for highlighting
  final double fontSize; // Font size for the highlighted text

  HighlightedTextStyle(this.text, this.style,
      {this.specificIndices,
      this.fontSize = 14.0}); // Default font size is 14.0
}
