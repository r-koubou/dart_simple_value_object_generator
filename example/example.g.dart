// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'example.dart';

// **************************************************************************
// ValueObjectGenerator
// **************************************************************************

extension type const _$Id._(int value) {
  // ignore: empty_constructor_bodies
  _$Id(this.value) {
    if (value < 0) {
      throw ArgumentError.value(value, 'value', 'must be >= 0');
    }

    if (value > 100) {
      throw ArgumentError.value(value, 'value', 'must be <= 100');
    }
  }

  bool operator <(_$Id other) {
    return value < other.value;
  }

  bool operator <=(_$Id other) {
    return value <= other.value;
  }

  bool operator >(_$Id other) {
    return value > other.value;
  }

  bool operator >=(_$Id other) {
    return value >= other.value;
  }
}

extension type const _$Email._(String value) {
  // ignore: empty_constructor_bodies
  _$Email(this.value) {
    if (value.isEmpty) {
      throw ArgumentError.value(value, 'value', 'must not be empty');
    }
  }
}
