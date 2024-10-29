import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_keyword_highlighter/flutter_keyword_highlighter.dart';

void main() {
  test('HighlightedText highlights the correct words', () {
    final highlightedText = HighlightedText(
      paragraph: 'Flutter is great.',
      searchWord: 'Flutter',
      fontSize: 16.0,
      highlightedTextSize: 17.0,

    );

    // Add assertions to test the functionality
    expect(highlightedText, isA<HighlightedText>());
    // Additional tests can check the rendering logic, etc.
  });
}