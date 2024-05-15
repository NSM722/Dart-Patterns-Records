import 'dart:convert';

class Document {
  /// define and initialize JSON data
  final Map<String, Object?> _json;
  Document() : _json = jsonDecode(documentJson);

  /// create a getter that returns a record
  /// read JSON values using a map pattern
  (String, {DateTime modified}) get metadata {
    if (_json
        case {
          'metadata': {
            'title': String title,
            'modified': String localModified,
          }
        }) {
      return (title, modified: DateTime.parse(localModified));
    } else {
      throw const FormatException('Unexpected JSON');
    }
  }

  List<Block> getBlocks() {
    /// return a list of Block objects
    if (_json case {'blocks': List blocksJson}) {
      /// use a 'collection for' to create a list of Block objects
      /// without patterns, one would need the toList() method to cast
      return [for (final blockJson in blocksJson) Block.fromJson(blockJson)];
    } else {
      throw const FormatException('Unexpected JSON format');
    }
  }
}

/// 'sealed' keyword is a class modifier that restricts the
/// inheritance of a class to the same file i.e you can only
/// extend or implement this class in the same library
sealed class Block {
  Block();

  /// create instances of the Block class from JSON data
  /// by using the .fromJson() factory constructor without
  /// manually parsing the JSON data every time
  factory Block.fromJson(Map<String, Object?> json) {
    return switch (json) {
      {'type': 'h1', 'text': String text} => HeaderBlock(text),
      {'type': 'p', 'text': String text} => ParagraphBlock(text),
      {'type': 'checkbox', 'text': String text, 'checked': bool checked} =>
        CheckboxBlock(text, checked),
      _ => throw const FormatException('Unexpected JSON format'),
    };
  }
}

/// subclasses of Block to represent
///  different types of blocks
class HeaderBlock extends Block {
  final String text;
  HeaderBlock(this.text);
}

class ParagraphBlock extends Block {
  final String text;
  ParagraphBlock(this.text);
}

class CheckboxBlock extends Block {
  final String text;
  final bool isChecked;
  CheckboxBlock(this.text, this.isChecked);
}

/// mocking incoming JSON data
const documentJson = '''
{
  "metadata": {
    "title": "My Document",
    "modified": "2024-05-10"
  },
  "blocks": [
    {
      "type": "h1",
      "text": "Chapter 1"
    },
    {
      "type": "p",
      "text": "Lorem ipsum dolor sit amet, consectetur adipiscing elit."
    },
    {
      "type": "checkbox",
      "checked": true,
      "text": "Learn Dart 3"
    }
  ]
}
''';
