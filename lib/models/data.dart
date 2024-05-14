import 'dart:convert';

class Document {
  /// define and initialize JSON data
  final Map<String, Object?> _json;
  Document() : _json = jsonDecode(documentJson);

  /// create a getter that returns a record
  (String, {DateTime modified}) get metadata {
    const title = 'My Document';
    final now = DateTime.now();

    /// this return type is a record with two fields
    /// the first field is a string, the second field is a DateTime
    /// the return statement constructs a new record by enclosing
    /// the two values in parentheses, the first field is positional
    /// & unnamed, the second field is named
    return (
      title,
      modified: now,
    );
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
