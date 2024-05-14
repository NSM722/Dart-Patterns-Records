import 'package:flutter/material.dart';
import 'package:patterns_codelabs/models/data.dart';

class DocumentScreen extends StatelessWidget {
  final Document document;

  const DocumentScreen({
    required this.document,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    /// access the metadata record values
    final metadataRecord = document.metadata;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          metadataRecord.$1,
        ),
      ),
      body: Column(
        children: [
          Center(
            child: Text(
              'Last modified: ${metadataRecord.modified}',
            ),
          ),
        ],
      ),
    );
  }
}
