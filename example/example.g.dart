// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'example.dart';

// **************************************************************************
// ValueObjectGenerator
// **************************************************************************

class _$Price {
  final int value;

  _$Price(this.value) {
    if (value < 0) {
      throw ArgumentError.value(value, 'value', 'must be >= 0');
    }

    if (value > 10000) {
      throw ArgumentError.value(value, 'value', 'must be <= 10000');
    }
  }
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

  bool operator <(_$Price other) {
    return this.value < other.value;
  }

  bool operator <=(_$Price other) {
    return this.value <= other.value;
  }

  bool operator >(_$Price other) {
    return this.value > other.value;
  }

  bool operator >=(_$Price other) {
    return this.value >= other.value;
  }
}

class _$Name {
  final String value;

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
