import 'package:analyzer/dart/element/type.dart';
import 'package:simple_value_object_annotation/value_object_annotation.dart';
import 'package:source_gen/source_gen.dart';

/// Options for generating value object code
class ValueObjectGeneratorOption {
  /// The annotation instance that values are derived
  final ValueObject annotation;

  /// The name of the class name
  final String className;

  /// The name of the class name to be generated
  final String generateClassName;

  /// The name of the value type
  final String valueTypeName;

  /// The name of the value variable (default is 'value')
  final String valueName;

  ValueObjectGeneratorOption({
    required this.annotation,
    required this.className,
    required this.valueTypeName,
    this.valueName = 'value',
  }) : generateClassName = '_\$$className';

  /// Checks if the value type name is numeric (int, double, num)
  bool isValueTypeNumeric() {
    return valueTypeName == 'num' ||
        valueTypeName == 'int' ||
        valueTypeName == 'double';
  }

  /// Checks if the value type name is int
  bool isValueTypeInt() {
    return valueTypeName == 'int';
  }

  /// Checks if the value type name is double
  bool isValueTypeDouble() {
    return valueTypeName == 'double';
  }

  /// Checks if the value type name is String
  bool isValueTypeString() {
    return valueTypeName == 'String';
  }

  /// Creates an instance from [ConstantReader]
  factory ValueObjectGeneratorOption.from({
    required String name,
    required ConstantReader annotation,
    String valueName = 'value',
  }) {
    final className = name;

    final interfaceType = annotation.objectValue.type as InterfaceType;
    final valueTypeName = interfaceType.typeArguments.first.getDisplayString();

    final min = annotation.peek('min')?.literalValue as num?;
    final max = annotation.peek('max')?.literalValue as num?;
    final minLength = annotation.peek('minLength')?.literalValue as int?;
    final maxLength = annotation.peek('maxLength')?.literalValue as int?;
    final presets = annotation.peek('presets')?.mapValue;

    final annotationValue = ValueObject(
      min: min,
      max: max,
      minLength: minLength,
      maxLength: maxLength,
      presets: presets?.map((k, v) {
        return MapEntry(
          k?.toStringValue() ?? '',
          ConstantReader(v).literalValue,
        );
      }),
    );

    return ValueObjectGeneratorOption(
      annotation: annotationValue,
      className: className,
      valueTypeName: valueTypeName,
      valueName: valueName,
    );
  }
}
