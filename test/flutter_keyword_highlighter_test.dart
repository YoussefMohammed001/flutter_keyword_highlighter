import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_keyword_highlighter/flutter_keyword_highlighter.dart';

void main() {
  testWidgets('HighlightedText highlights specified text', (WidgetTester tester) async {
    // Build the HighlightedText widget
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: HighlightedText(
            paragraph: 'This is an example paragraph for testing.',
            highlightTexts: [
              HighlightText(
                'example',
                const TextStyle(
                  color: Colors.red,
                  fontWeight: FontWeight.bold,
                ),
                fontSize: 18.0,
              ),
            ],
            defaultTextStyle: const TextStyle(fontSize: 14.0),
          ),
        ),
      ),
    );

    // Verify that the highlighted text is present
    expect(find.text('example'), findsOneWidget);

    // Verify the text is styled correctly

  });


}