import 'code_generator.dart';
import 'value_object_generator_option.dart';

final class MinValidationCodeGenerator implements CodeGenerator {
  final ValueObjectGeneratorOption option;

  MinValidationCodeGenerator(this.option);

  @override
  void generate(StringBuffer buffer) {
    if (option.annotation.min == null) {
      return;
    }

    final valueName = option.valueName;
    final min = option.annotation.min!;

    final code = '''
if ($valueName < $min) {
  throw ArgumentError.value($valueName, '$valueName', 'must be >= $min');
}
''';
    buffer.writeln(code);
  }
}
