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

  bool operator <($Id other) {
    return value < other.value;
  }

  bool operator <=($Id other) {
    return value <= other.value;
  }

  bool operator >($Id other) {
    return value > other.value;
  }

  bool operator >=($Id other) {
    return value >= other.value;
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
