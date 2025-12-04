import 'package:analyzer/dart/element/element.dart';
import 'package:analyzer/dart/element/type.dart';
import 'package:build/build.dart';
import 'package:simple_value_object_annotation/value_object_annotation.dart';
import 'package:source_gen/source_gen.dart';

import 'comparison_operators_code_generator.dart';
import 'equality_code_generator.dart';
import 'max_length_validation_code_generator.dart';
import 'max_validation_code_generator.dart';
import 'min_length_validation_code_generator.dart';
import 'min_validation_code_generator.dart';
import 'to_string_code_generator.dart';

/// Code generator for [ValueObject]
class ValueObjectGenerator extends GeneratorForAnnotation<ValueObject> {
  const ValueObjectGenerator();

  @override
  String generateForAnnotatedElement(
    Element element,
    ConstantReader annotation,
    BuildStep buildStep,
  ) {
    if (element is! ClassElement) {
      throw InvalidGenerationSourceError(
        '@ValueObject can only be applied to classes.',
        element: element,
      );
    }

    // Class name
    final className = '_\$${element.name}';

    // Retrieve the type name from the T in @ValueObject<T>
    final interfaceType = annotation.objectValue.type as InterfaceType;
    final type = interfaceType.typeArguments.first.getDisplayString();

    // Retrieve validation parameters
    num? min = _parseAnnotation(annotation, 'min');
    num? max = _parseAnnotation(annotation, 'max');
    int? minLength = _parseAnnotation(annotation, 'minLength');
    int? maxLength = _parseAnnotation(annotation, 'maxLength');

    final constructorCodes = [
      MinValidationCodeGenerator(min),
      MaxValidationCodeGenerator(max),
      MinLengthValidationCodeGenerator(minLength),
      MaxLengthValidationCodeGenerator(maxLength),
    ];

    final methodCoes = [
      ToStringCodeGenerator(),
      EqualityCodeGenerator(className),
      ComparisonOperatorsCodeGenerator(className, type),
    ];

    // Generate class code
    final buffer = StringBuffer();

    // BEGIN class
    buffer.writeln('class $className {');

    // Field
    buffer.writeln('final $type value;');
    buffer.writeln();

    // Constructor
    buffer.writeln('  // ignore: empty_constructor_bodies');
    buffer.writeln('$className(this.value) {');
    for (final generator in constructorCodes) {
      generator.generate(buffer);
    }
    buffer.writeln('}');

    // Methods
    for (final generator in methodCoes) {
      generator.generate(buffer);
    }

    // END class
    buffer.writeln('}');

    return buffer.toString();
  }

  T? _parseAnnotation<T>(ConstantReader reader, String fieldName) {
    final field = reader.peek(fieldName);
    if (field == null || field.isNull) {
      return null;
    }
    return field.literalValue as T;
  }
}
