import 'package:flutter/material.dart';
import 'package:flutter_keyword_highlighter/flutter_keyword_highlighter.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Keyword Highlighter Example',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: HighlighterExample(),
    );
  }
}

class HighlighterExample extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final String paragraph = "Flutter is an open-source UI software development toolkit created by Google.";

    // Define highlighted text styles
    final List<HighlightedTextStyle> highlights = [
      HighlightedTextStyle(
        "Flutter",
        const TextStyle(backgroundColor: Colors.green, color: Colors.white, fontWeight: FontWeight.bold),
        specificIndices: [0, 1], // Highlight specific indices (if needed)
        fontSize: 18.0,
      ),
      HighlightedTextStyle(
        "Google",
        const TextStyle(backgroundColor: Colors.blue, color: Colors.white, fontWeight: FontWeight.bold),
      ),
    ];

    return Scaffold(
      appBar: AppBar(title: const Text('Keyword Highlighter Example')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text("Highlighted Text:", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            const SizedBox(height: 10),
            HighlightedText(
              content: paragraph,
              highlightedTextStyles: highlights,
              defaultTextStyle: const TextStyle(fontSize: 16.0), // Default text style for the content
            ),
          ],
        ),
      ),
    );
  }
}