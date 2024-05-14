import 'dart:convert';

class Document {
  /// define and initialize JSON data
  final Map<String, Object?> _json;
  Document() : _json = jsonDecode(documentJson);

  /// create a getter that returns a record
  (String, {DateTime modified}) get metadata {
    /// read values from the _json map
    if (_json.containsKey('metadata')) {
      final metadataJson = _json['metadata'];
      if (metadataJson is Map) {
        final title = metadataJson['title'] as String;
        final localModified = DateTime.parse(metadataJson['modified'] as String);
        return (
          title,
          modified: localModified,
        );
      }
    }
    throw const FormatException('Unexpected JSON');
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
