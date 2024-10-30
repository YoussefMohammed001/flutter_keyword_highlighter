import 'package:flutter/material.dart';
import 'package:flutter_keyword_highlighter/flutter_keyword_highlighter.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Keyword Highlighter Example',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const HighlightExampleScreen(),
    );
  }
}

class HighlightExampleScreen extends StatelessWidget {
  const HighlightExampleScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Keyword Highlighter Example',
          style: TextStyle(fontSize: 18.0),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: HighlightedText(
          content:
              'Flutter is an open-source UI software development toolkit created by Google Googleee. It is used to develop cross-platform applications for Android, iOS, Linux, and more.',
          defaultTextStyle:
              const TextStyle(fontSize: 16.0, color: Colors.black),
          highlightedTextStyles: [
            HighlightedTextStyle(
              highlightedText: 'Flutter',
              customStyle: const TextStyle(
                  color: Colors.blue, fontWeight: FontWeight.bold),
              allowsPartialMatch:
                  true, // Highlights any occurrence of "Flutter"
            ),
            HighlightedTextStyle(
              highlightedText: 'Google',

              customStyle: const TextStyle(
                  color: Colors.green, fontStyle: FontStyle.italic),
              allowsPartialMatch:
                  false, // Highlights exact word match for "Google"
            ),
            HighlightedTextStyle(
              highlightedText: 'applications',
              customStyle: const TextStyle(
                  color: Colors.red, fontWeight: FontWeight.w600),
            ),
          ],
        ),
      ),
    );
  }
}
