import 'code_generator.dart';
import 'value_object_generator_option.dart';

final class NumberComparisonOperatorCodeGenerator implements CodeGenerator {
  final ValueObjectGeneratorOption option;

  NumberComparisonOperatorCodeGenerator(this.option);

  @override
  void generate(StringBuffer buffer) {
    if (!option.isValueTypeNumeric()) {
      return;
    }

    final operators = [
      '<',
      '<=',
      '>',
      '>=',
    ];

    for (final opr in operators) {
      final code = '''
bool operator $opr(${option.generateTypeName} other) {
  return ${option.valueName} $opr other.${option.valueName};
  }
''';
      buffer.writeln(code);
    }
  }
}
