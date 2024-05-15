import 'package:flutter/material.dart';
import 'package:patterns_codelabs/main.dart';
import 'package:patterns_codelabs/models/data.dart';
import 'package:patterns_codelabs/widgets/block.dart';

class DocumentScreen extends StatelessWidget {
  final Document document;

  const DocumentScreen({
    required this.document,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    /// access the metadata record values
    /// final metadataRecord = document.metadata;

    /// destructure the record into local variables
    /// this is a record pattern (title, modified: modified)
    /// final (title, modified: modified) = document.metadata;

    /// refactor the above pattern
    /// this is a variable declaration pattern(irrefutable pattern)
    final (title, :modified) = document.metadata;

    /// contains the list of Block objects
    final blocks = document.getBlocks();

    final formattedDate = formatDate(modified);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          title,
        ),
      ),
      body: Column(
        children: [
          Text(
            'Last modified: $formattedDate',
          ),
          Expanded(
            child: ListView.builder(
              itemCount: blocks.length,
              itemBuilder: (context, index) {
                return BlockWidget(
                  block: blocks[index],
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
