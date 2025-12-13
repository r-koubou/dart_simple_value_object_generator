// ignore_for_file: unnecessary_type_check

import 'package:simple_value_object_annotation/simple_value_object_annotation.dart';

part 'example.g.dart';

@ValueObject<int>(min: 0, max: 100)
typedef Id = _$Id;

@ValueObject<String>(allowEmpty: false, maxLength: 200)
typedef Email = _$Email;

void main() {
  final id1 = Id(1);
  final id2 = Id(1);
  final id3 = Id(2);

  // => runtimeType of id1: int
  print('runtimeType of id1: ${id1.runtimeType}');

  // => id1 is num: true
  print('id1 is num: ${id1 is num}');

  // => id1 is int: true
  print('id1 is int: ${id1 is int}');

  // => id1 is Id: true
  print('id1 is Id: ${id1 is Id}');

  // => id1: 1, id2: 1, id3: 2
  print('id1: ${id1.value}, id2: ${id2.value}, id3: ${id3.value}');

  // => id1 == id2: true
  print('id1 == id2: ${id1 == id2}');

  // => id1 < id3: true
  print('id1 < id3: ${id1 < id3}');

  try {
    // Should throw an Exception
    // Initialize with less than min value
    final _ = Id(-1);
  } catch (e) {
    print('Error creating invalidId: $e');
  }

  final email1 = Email('example@example.com');
  final email2 = Email('example@example.com');
  final email3 = Email('another@example.com');

  // => email1 is String: true
  print('email1 is String: ${email1 is String}');

  // => email1 == email2: true
  print('email1 == email2: ${email1 == email2}');

  // => email1 != email3: true
  print('email1 != email3: ${email1 != email3}');

  try {
    // Should throw an Exception
    // Initialize with empty string
    final _ = Email('');
  } catch (e) {
    print('Error creating emptyEmail: $e');
  }
}
