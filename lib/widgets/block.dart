import 'package:flutter/material.dart';
import 'package:patterns_codelabs/models/data.dart';

class BlockWidget extends StatelessWidget {
  final Block block;

  const BlockWidget({
    required this.block,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    TextStyle? textStyle;
    switch (block.type) {
      case 'h1':
        textStyle = Theme.of(context).textTheme.displayMedium;
      case 'p':
        textStyle = Theme.of(context).textTheme.bodyMedium;

      /// this wildcard pattern (_) is used to handle all other cases
      case _:
        textStyle = Theme.of(context).textTheme.bodySmall;
    }
    return Container(
      margin: const EdgeInsets.all(8),
      child: Text(
        block.text,
        style: textStyle,
      ),
    );
  }
}
