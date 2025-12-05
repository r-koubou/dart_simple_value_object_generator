import 'package:analyzer/dart/element/element.dart';
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
import 'value_object_generator_option.dart';

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

    // Retrieve validation parameters
    final option = ValueObjectGeneratorOption.from(
      element: element,
      annotation: annotation,
    );

    return _generate(option);
  }

  String _generate(ValueObjectGeneratorOption option) {
    // Class name
    final className = option.generateClassName;

    // Value type
    final valueType = option.valueTypeName;

    final constructorCodes = [
      MinValidationCodeGenerator(option),
      MaxValidationCodeGenerator(option),
      MinLengthValidationCodeGenerator(option),
      MaxLengthValidationCodeGenerator(option),
    ];

    final methodCoes = [
      ToStringCodeGenerator(),
      EqualityCodeGenerator(option),
      ComparisonOperatorsCodeGenerator(option),
    ];

    // Generate class code
    final buffer = StringBuffer();

    // BEGIN class
    buffer.writeln('class $className {');

    // Field
    buffer.writeln('final $valueType value;');
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
}
