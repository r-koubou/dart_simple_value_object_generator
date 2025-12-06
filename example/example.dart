import 'package:simple_value_object_annotation/value_object_annotation.dart';

part 'example.g.dart';

@ValueObject<int>(min: 0, max: 100)
typedef Id = _$Id;

extension type const X._(int value) {
  X(this.value) {
    if (value < 0) {
      throw ArgumentError('Value must be non-negative');
    }
  }
}

// @ValueObject<int>(comparable: true)
// final class Price extends _$Price {
//   Price(super.value);
// }

// @ValueObject<String>(minLength: 1, maxLength: 80)
// final class Name extends _$Name {
//   Name(super.value);
// }

// extension type const _$Id(int value) {
//   _$Id operator +(_$Id other) => _$Id(value + other.value);
// }

// typedef Id = _$Id;

void main() {
  final id1 = Id(1);
  final id2 = Id(1);
  final id3 = Id(2);

  print('runtimeType of id1: ${id1.runtimeType}');
  print('id1 is num: ${id1 is num}');
  print('id1 is int: ${id1 is int}');
  print('id1 is Id: ${id1 is Id}');
  print('id1: ${id1.value}, id2: ${id2.value}, id3: ${id3.value}');
  print('id1 == id2: ${id1 == id2}');
  print('id1 < id3: ${id1.value < id3.value}');

  try {
    final invalidId = Id(-1);
    print('invalidId: ${invalidId.value}');
  } catch (e) {
    print('Error creating invalidId: $e');
  }
}