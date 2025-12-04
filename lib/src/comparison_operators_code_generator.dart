import 'code_generator.dart';

final class ComparisonOperatorsCodeGenerator implements CodeGenerator {
  final String className;
  final String valueName;
  final String valueType;

  ComparisonOperatorsCodeGenerator(this.className, this.valueType,
      {this.valueName = 'value'});

  @override
  void generate(StringBuffer buffer) {
    if (!isComparableType(valueType)) {
      return;
    }

    final operators = ['<', '<=', '>', '>='];
    for (final operator in operators) {
      final code = '''
bool operator $operator($className other) {
  return $valueName $operator other.$valueName;
}
''';
      buffer.writeln(code);
    }
  }
}
