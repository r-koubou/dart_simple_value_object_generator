import 'code_generator.dart';
import 'value_object_generator_option.dart';

final class ComparisonOperatorsCodeGenerator implements CodeGenerator {
  final ValueObjectGeneratorOption option;

  ComparisonOperatorsCodeGenerator(this.option);

  @override
  void generate(StringBuffer buffer) {
    if (!option.annotation.comparable) {
      return;
    }

    final className = option.generateClassName;
    final valueName = option.valueName;
    final operators = ['<', '<=', '>', '>='];

    for (final opr in operators) {
      final code = '''
bool operator $opr($className other) {
  return $valueName $opr other.$valueName;
}
''';
      buffer.writeln(code);
    }
  }
}
