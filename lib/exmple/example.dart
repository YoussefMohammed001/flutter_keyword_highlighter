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
      title: 'Highlighted Text Example',
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Highlighted Text Example'),
        ),
        body: const Center(
          child: ExampleHighlightedText(),
        ),
      ),
    );
  }
}

class ExampleHighlightedText extends StatelessWidget {
  const ExampleHighlightedText({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: HighlightedText(
        content: "Flutter makes it easy to build beautiful apps. "
            "Flutter's hot reload helps you quickly build UIs.",
        highlightedTextStyles: [
          HighlightedTextStyle(
            'Flutter',
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.blue,
            ),
          ),
          HighlightedTextStyle(
            'UI',
            style: const TextStyle(
              fontStyle: FontStyle.italic,
              color: Colors.green,
            ),
          ),
        ],
        defaultTextStyle: const TextStyle(fontSize: 16.0, color: Colors.black),
      ),
    );
  }
}