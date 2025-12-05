// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'example.dart';

// **************************************************************************
// ValueObjectGenerator
// **************************************************************************

class _$Price {
  final int value;

  // ignore: empty_constructor_bodies
  _$Price(this.value) {}
  @override
  String toString() => value.toString();

  @override
  int get hashCode => value.hashCode;

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! _$Price) return false;
    return value == other.value;
  }
}

class _$Name {
  final String value;

  // ignore: empty_constructor_bodies
  _$Name(this.value) {
    if (value.isEmpty) {
      throw ArgumentError.value(value, 'value', 'length must be >= 1');
    }

    if (value.length > 80) {
      throw ArgumentError.value(value, 'value', 'length must be <= 80');
    }
  }
  @override
  String toString() => value.toString();

  @override
  int get hashCode => value.hashCode;

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! _$Name) return false;
    return value == other.value;
  }
}
