Simple Value Object Generator
==============================

A Dart code generator that simplifies the creation of Value Objects using Dart's `extension type`.
It allows you to define wrapper types for primitives (like `int`, `String`) with built-in validation logic, ensuring type safety and data integrity with minimal boilerplate.

## Features

### Extension Types

Utilizes Dart's `extension type` for zero-cost abstractions (at runtime, they are the underlying type).

### Validation

Automatically generates validation logic in the constructor.

- `int`, `double`: `min`, `max`
- `String / Iterable<T>, Map<K,V>`: `minLength`, `maxLength` `allowEmpty`

### Simple Syntax

Define Value Objects using `typedef` and annotations.

## Getting started

Add the dependencies to your `pubspec.yaml`:

```yaml
dependencies:
  simple_value_object_annotation: ^1.0.0

dev_dependencies:
  simple_value_object_generator: ^1.0.2
```

## Usage

### 1. Define your Value Object

Create a file (e.g., `example.dart`), add the `part` directive, and define your type using `typedef` and the `@ValueObject` annotation.

```dart
import 'package:simple_value_object_annotation/simple_value_object_annotation.dart';

part 'example.g.dart';

@ValueObject<int>(min: 0, max: 100)
typedef Id = $Id;

@ValueObject<String>(allowEmpty: false, maxLength: 200)
typedef Email = $Email;
```

#### Supported ValueObject\<T\> annotation values

- Numbers (`int`, `double`)
    - `min`: Minimum value (inclusive).
    - `max`: Maximum value (inclusive).

- String, Collections (has `length`, `isEmpty` property )
    - `allowEmpty`: Whether to allow empty strings/collections (default: `true`).
    - `minLength`: Minimum character/element count (inclusive)
    - `maxLength`: Maximum character/element count (inclusive)


### 2. Run the Generator

Run `build_runner` to generate the implementation code.

```bash
dart run build_runner build
```

Following is genenerated code example:

```dart
// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'example.dart';

// **************************************************************************
// ValueObjectGenerator
// **************************************************************************

extension type const $Id._(int value) {
  // ignore: empty_constructor_bodies
  $Id(this.value) {
    if (value < 0) {
      throw ArgumentError.value(value, 'value', 'must be >= 0');
    }

    if (value > 100) {
      throw ArgumentError.value(value, 'value', 'must be <= 100');
    }
  }
}

extension type const $Email._(String value) {
  // ignore: empty_constructor_bodies
  $Email(this.value) {
    if (value.length > 200) {
      throw ArgumentError.value(value, 'value', 'length must be <= 200');
    }

    if (value.isEmpty) {
      throw ArgumentError.value(value, 'value', 'must not be empty');
    }
  }
}
```

### 3. Use it

```dart
void main() {
    // Valid creation
    final id = Id(42);
    final email = Email('test@example.com');

    print(id.value); // 42

    // Runtime behavior
    print(id is int); // true (Runtime type is the underlying type)

    // Validation errors
    try {
    final invalidId = Id(-1); // Throws ArgumentError
    } catch (e) {
    print(e);
    }
}
```