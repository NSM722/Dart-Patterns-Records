import 'package:flutter/material.dart';
import 'package:patterns_codelabs/models/data.dart';
import 'package:patterns_codelabs/screens/document_screen.dart';

void main() {
  runApp(const DocumentApp());
}

/// It represents the span of time between
/// today and the modified value from the JSON data
String formatDate(DateTime dateTime) {
  final today = DateTime.now();
  final difference = dateTime.difference(today);

  return switch (difference) {
    /// object pattern matching on the Duration class
    /// for the inDays and isNegative properties
    Duration(inDays: 0) => 'today',
    Duration(inDays: 1) => 'tomorrow',
    Duration(inDays: -1) => 'yesterday',

    /// a guard clause using the 'when' keyword
    Duration(inDays: final days) when days > 7 => '${days ~/ 7} weeks from now',
    Duration(inDays: final days) when days < -7 => '${days.abs() ~/ 7} weeks ago',
    Duration(inDays: final days, isNegative: true) => '${days.abs()} days ago',
    Duration(inDays: final days) => '$days days from now',
  };
}

class DocumentApp extends StatelessWidget {
  const DocumentApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        useMaterial3: true,
      ),
      home: DocumentScreen(
        document: Document(),
      ),
    );
  }
}
