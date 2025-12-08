import 'package:analyzer/dart/element/type.dart';
import 'package:simple_value_object_annotation/simple_value_object_annotation.dart';
import 'package:source_gen/source_gen.dart';

/// Options for generating value object code
final class ValueObjectGeneratorOption {
  /// The annotation instance that values are derived
  final ValueObject annotation;

  /// The name of the type name
  final String typeName;

  /// The name of the generated type name
  final String generateTypeName;

  /// The Dart type of the value
  final DartType valueType;

  /// The name of the value type
  final String valueTypeName;

  /// The name of the value variable
  final String valueName;

  /// The default value name (='value')
  static const String defaultValueName = 'value';

  ValueObjectGeneratorOption({
    required this.annotation,
    required this.typeName,
    required this.valueType,
    required this.valueTypeName,
    this.valueName = defaultValueName,
  }) : generateTypeName = '_\$$typeName';

  /// Checks if the value type name is numeric (int, double, num)
  bool isValueTypeNumeric() {
    return valueType.isDartCoreNum ||
        valueType.isDartCoreInt ||
        valueType.isDartCoreDouble;
  }

  /// Checks if the value type name is int
  bool isValueTypeInt() {
    return valueType.isDartCoreInt;
  }

  /// Checks if the value type name is double
  bool isValueTypeDouble() {
    return valueType.isDartCoreDouble;
  }

  /// Checks if the value type name is String
  bool isValueTypeString() {
    return valueType.isDartCoreString;
  }

  /// Creates an instance from [ConstantReader]
  factory ValueObjectGeneratorOption.from({
    required String name,
    required ConstantReader annotation,
    String valueName = defaultValueName,
  }) {
    final typeName = name;

    final interfaceType = annotation.objectValue.type as InterfaceType;
    final valueType = interfaceType.typeArguments.first;
    final valueTypeName = valueType.getDisplayString();

    final min = annotation.peek('min')?.literalValue as num?;
    final max = annotation.peek('max')?.literalValue as num?;
    final minLength = annotation.peek('minLength')?.literalValue as int?;
    final maxLength = annotation.peek('maxLength')?.literalValue as int?;
    final allowEmpty = annotation.peek('allowEmpty')?.literalValue as bool?;

    final annotationValue = ValueObject(
      min: min,
      max: max,
      minLength: minLength,
      maxLength: maxLength,
      allowEmpty: allowEmpty,
    );

    return ValueObjectGeneratorOption(
      annotation: annotationValue,
      typeName: typeName,
      valueType: valueType,
      valueTypeName: valueTypeName,
      valueName: valueName,
    );
  }
}
