import 'package:analyzer/dart/element/element.dart';
import 'package:build/build.dart';
import 'package:simple_value_object_annotation/value_object_annotation.dart';
import 'package:source_gen/source_gen.dart';


/// @ValueType が付いたクラスから値オブジェクトを生成するジェネレータ。
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
        '@ValueObject はクラスにのみ付与できます。',
        element: element,
      );
    }

    // 1. 生成するクラス名
    final className = '_\$${element.name}';

    // 2. @ValueObject の type 値から型名を取得
    final type = annotation.peek('type')!.typeValue.getDisplayString();

    // 3. min / max を取得
    num? min = _parseAnnotationField(annotation, 'min');
    num? max = _parseAnnotationField(annotation, 'max');
    int? minLength = _parseAnnotationField(annotation, 'minLength');
    int? maxLength = _parseAnnotationField(annotation, 'maxLength');

    // 4. 手動テンプレート（文字列）で Dart コードを組み立てる
    final buffer = StringBuffer();

    // BEGIN class
    buffer.writeln('class $className {');

    // Field
    buffer.writeln('final $type value;');
    buffer.writeln();

    // Constructor
    buffer.writeln('$className(this.value) {');
    _writeMinValidation(buffer, min);
    _writeMaxValidation(buffer, max);
    _writeLMinLengthValidation(buffer, minLength);
    _writeLMaxLengthValidation(buffer, maxLength);
    buffer.writeln('}');

    // BEGIN toString
    _writeToString(buffer);

    // hashCode and equals
    _writeEquality(buffer, className);

    // Binary Operators if type is int or double
    _writeConditionalBinaryOperator(buffer, className, type, '<');
    _writeConditionalBinaryOperator(buffer, className, type, '<=');
    _writeConditionalBinaryOperator(buffer, className, type, '>');
    _writeConditionalBinaryOperator(buffer, className, type, '>=');

    // END class
    buffer.writeln('}');

    return buffer.toString();
  }

  void _writeMinValidation(StringBuffer buffer, num? min) {
    if (min == null) {
      return;
    }
    final code = '''
if (value < $min) {
  throw ArgumentError.value(value, 'value', 'must be >= $min');
}
''';
    buffer.writeln(code);
  }

  void _writeMaxValidation(StringBuffer buffer, num? max) {
    if (max == null) {
      return;
    }
    final code = '''
if (value > $max) {
  throw ArgumentError.value(value, 'value', 'must be <= $max');
}
''';
    buffer.writeln(code);
  }

  void _writeLMinLengthValidation(StringBuffer buffer, int? minLength) {
    if (minLength == null) {
      return;
    }
    final code = minLength == 1
        ? '''
if (value.isEmpty) {
  throw ArgumentError.value(value, 'value', 'length must be >= $minLength');
}
'''
        : '''
if (value.length < $minLength) {
  throw ArgumentError.value(value, 'value', 'length must be >= $minLength');
}
''';
    buffer.writeln(code);
  }

  void _writeLMaxLengthValidation(StringBuffer buffer, int? maxLength) {
    if (maxLength == null) {
      return;
    }
    final code = '''
if (value.length > $maxLength) {
  throw ArgumentError.value(value, 'value', 'length must be <= $maxLength');
}
''';
    buffer.writeln(code);
  }

  void _writeToString(StringBuffer buffer) {
    final code = '''
@override
String toString() => value.toString();
''';
    buffer.writeln(code);
  }

  void _writeEquality(StringBuffer buffer, String className) {
    final code = '''
@override
int get hashCode => value.hashCode;

@override
bool operator ==(Object other) {
  if (identical(this, other)) return true;
  if (other is! $className) return false;
  return value == other.value;
}
''';

    buffer.writeln(code);
  }

  void _writeConditionalBinaryOperator(
      StringBuffer buffer, String className, String valueType, String op) {
    if (valueType != 'int' && valueType != 'double') {
      return;
    }
    final code = '''
bool operator $op($className other) {
  return this.value $op other.value;
}
''';
    buffer.writeln(code);
  }

  T? _parseAnnotationField<T>(ConstantReader reader, String fieldName) {
    final field = reader.peek(fieldName);
    if (field == null || field.isNull) {
      return null;
    }
    return field.literalValue as T;
  }
}
