import 'package:analyzer/dart/analysis/results.dart';
import 'package:analyzer/dart/ast/ast.dart';
import 'package:analyzer/dart/element/element.dart';
import 'package:build/build.dart';
import 'package:simple_value_object_annotation/simple_value_object_annotation.dart';
import 'package:source_gen/source_gen.dart';

import 'allow_empty_validation_code_generator.dart';
import 'max_length_validation_code_generator.dart';
import 'max_validation_code_generator.dart';
import 'min_length_validation_code_generator.dart';
import 'min_validation_code_generator.dart';
import 'number_comparison_operator_code_generator.dart';
import 'value_object_generator_option.dart';

/// Code generator for [ValueObject]
final class ValueObjectGenerator extends GeneratorForAnnotation<ValueObject> {
  const ValueObjectGenerator();

  @override
  String generateForAnnotatedElement(
    Element element,
    ConstantReader annotation,
    BuildStep buildStep,
  ) {
    if (element is! TypeAliasElement) {
      throw InvalidGenerationSourceError(
        '@ValueObject can only be applied to typedef.',
        element: element,
      );
    }

    // typedef: right side type name
    String? generateTypeName;

    // Get the name of the right-hand side (e.g., _$Email) from the AST.
    final session = element.session;
    final parsedLibrary = session?.getParsedLibraryByElement(element.library);
    if (parsedLibrary is ParsedLibraryResult) {
      final node =
          parsedLibrary.getFragmentDeclaration(element.firstFragment)?.node;
      if (node is GenericTypeAlias) {
        generateTypeName = node.type.toSource();
      }
    }

    if (generateTypeName == null) {
      throw InvalidGenerationSourceError(
        'Could not determine the right-hand side type name of the typedef.',
        element: element,
      );
    }

    // Retrieve validation parameters
    final option = ValueObjectGeneratorOption.from(
      name: element.name!,
      generateTypeName: generateTypeName,
      annotation: annotation,
    );

    return _generate(option);
  }

  String _generate(ValueObjectGeneratorOption option) {
    // Type name
    final typeName = option.generateTypeName;

    // Value type
    final valueType = option.valueTypeName;

    final fieldDeclarations = [
      // Additional field declarations
    ];

    final constructorCodes = [
      MinValidationCodeGenerator(option),
      MaxValidationCodeGenerator(option),
      MinLengthValidationCodeGenerator(option),
      MaxLengthValidationCodeGenerator(option),
      AllowEmptyValidationCodeGenerator(option),
    ];

    final methodCodes = [
      // Additional method codes
      NumberComparisonOperatorCodeGenerator(option),
    ];

    // Generate extension type code
    final buffer = StringBuffer();

    // BEGIN extension type
    buffer.writeln('extension type const $typeName._($valueType value) {');

    // Field declarations
    for (final generator in fieldDeclarations) {
      generator.generate(buffer);
    }

    // Constructor
    buffer.writeln('  // ignore: empty_constructor_bodies');
    buffer.writeln('$typeName(this.value) {');
    for (final generator in constructorCodes) {
      generator.generate(buffer);
    }
    buffer.writeln('}');
    buffer.writeln();

    // Methods
    for (final generator in methodCodes) {
      generator.generate(buffer);
    }

    // END extension type
    buffer.writeln('}');

    return buffer.toString();
  }
}
