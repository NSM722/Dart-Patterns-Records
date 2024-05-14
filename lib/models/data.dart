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

class Block {
  final String type;
  final String text;

  Block(this.type, this.text);

  /// create instances of the Block class from JSON data
  /// by using the .fromJson() factory constructor without
  /// manually parsing the JSON data every time
  factory Block.fromJson(Map<String, Object?> json) {
    if (json
        case {
          'type': String type,
          'text': String text,
        }) {
      return Block(type, text);
    } else {
      throw const FormatException('Unexpected JSON');
    }
  }
}

/// mocking incoming JSON data
const documentJson = '''
{
  "metadata": {
    "title": "My Document",
    "modified": "2023-05-10"
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
      "checked": false,
      "text": "Learn Dart 3"
    }
  ]
}
''';
