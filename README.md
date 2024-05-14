# [Dive into Dart's patterns and records](https://codelabs.developers.google.com/codelabs/dart-patterns-records?hl=en#0 "follow tutorial")

[Dart Collections](https://dart.dev/language/collections#collection-operators "Read docs")

## Objectives

- How to create a record that stores multiple values with different types.
- How to return multiple values from a function using a record.
- How to use patterns to match, validate, and destructure data from records and other objects.
- How to bind pattern-matched values to new or existing variables.
- How to use new switch statement capabilities, switch expressions, and if-case statements.
- How to take advantage of exhaustiveness checking to ensure that every case is handled in a switch statement or switch expression.

## Create empty project

```dart
/// The --empty flag prevents the creation of the
/// standard counter app in the lib/main.dart file
flutter create --empty patterns_codelab
```

## Create a record

Records allow you to create a single object that stores multiple values with different types.

They are similar to classes, but they are more lightweight and are designed to store data rather than behavior.

Records can return the various types from a single function/method call.

They are comma-delimited field lists enclosed in parentheses.

To access the individual fields composed in that record, you can use records' built-in getter syntax.

```dart
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
```

### Access record fields

To get a positional field (a field without a name, **like title**), use the getter `$<num>` on the record. This returns only unnamed fields.

Named fields **like modified** don't have a positional getter, so you can use its name directly, `like metadataRecord.modified`.

To determine the name of a getter for a positional field, start at $1 and skip named fields. For example:

```dart
var record = (named: 'v', 'y', named2: 'x', 'z');
print(record.$1);                               // prints y
print(record.$2);                               // prints z
```

## Patterns

Patterns allow you to match, validate, and destructure data from records and other objects.

Destructuring lets you unpack values from an object to assign them to local variables, or perform further matching on them.

Patterns are used in switch statements, switch expressions, and if-case statements.

They compare against against actual values to determine if they **_match_**

```dart
/// destructure the record into local variables
/// this is a record pattern (title, modified: modified)
final (title, modified: modified) = document.metadata;
```

The record pattern `(title, modified: modified)` contains two variable **_patterns_** that match against the fields of the record returned by metadata

- The expression matches the subpattern because the result is a record with two fields, one of which is named `modified`.

- Because they match, the variable declaration pattern destructures the expression, accessing its values and binding them to new local variables of the same types and names, String title and DateTime modified.

'Refutable patterns' are used in control flow contexts:

- They expect that some values they compare against will not match.
- They are meant to influence the control flow, based on whether or not the value matches.
- They don't interrupt execution with an error if they don't match, they just move to the next statement.
- They can destructure and bind variables that are only usable when they match.

### Read JSON values without patterns

The following code validates that the data is structured correctly without using patterns.

It performs three checks before doing anything else:

- The JSON contains the data structure you expect: `if (_json.containsKey('metadata'))`
- The data has the type you expect: `if (metadataJson is Map)`
- That the data is not `null`, which is implicitly confirmed in the previous check.

```dart
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
```

### Read JSON values using a map pattern

With a `refutable pattern`, you can verify that the JSON has the expected structure using a `map pattern`.

Here, the case body only executes if the case pattern matches the data in `_json`.

This match accomplishes the same thing as the previous code example.

```dart
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
}
```

This code validates the following:

- \_json is a Map type.
- \_json contains a metadata key.
- \_json is not null.
- \_json['metadata'] is also a Map type.
- \_json['metadata'] contains the keys title and modified.
- title and localModified are strings and aren't null.

If the value doesn't match, the pattern `refutes` (refuses to continue execution) and proceeds to the **else** clause. If the match is successful, the pattern destructures the values of **title** and **modified **from the map and binds them to new local variables.

### switch expressions vs switch statements

Switch expressions are a more concise way to write switch statements.

They omit the `case` keyword and use the fat arrow `=>` to separate the pattern from the case body.

Unlike switch statements, switch expressions **return a value** and can be used anywhere an expression can be used.

```dart
/// switch statement
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

/// switch expression
textStyle = switch (block.type) {
  'h1' => Theme.of(context).textTheme.displayMedium,
  'p' || 'checkbox' => Theme.of(context).textTheme.bodyMedium,
  _ => Theme.of(context).textTheme.bodySmall,
};
```
