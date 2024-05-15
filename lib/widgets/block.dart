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
    // TextStyle? textStyle;

    /// use a switch expression to determine the text style
    // textStyle = switch (block.type) {
    //   'h1' => Theme.of(context).textTheme.displayMedium,
    //   'p' || 'checkbox' => Theme.of(context).textTheme.bodyMedium,
    //   _ => Theme.of(context).textTheme.bodySmall,
    // };

    /// use a switch expression that uses object patterns for each case

    return Container(
      margin: const EdgeInsets.all(8),
      // child: Text(
      //   block.text,
      //   style: textStyle,
      // ),

      /// switch an instance of the Block class
      /// and match against object patterns that
      /// represent its subclasses extracting the
      /// values of the fields/properties in the process
      child: switch (block) {
        HeaderBlock(:final text) => Text(
            text,
            style: Theme.of(context).textTheme.displayMedium,
          ),
        ParagraphBlock(:final text) => Text(text),
        CheckboxBlock(:final text, :final isChecked) => Row(
            children: [
              Checkbox(value: isChecked, onChanged: (_) {}),
              Text(text),
            ],
          ),
      },
    );
  }
}
