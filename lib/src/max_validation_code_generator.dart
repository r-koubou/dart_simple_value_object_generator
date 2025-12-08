import 'code_generator.dart';
import 'value_object_generator_option.dart';

final class MaxValidationCodeGenerator implements CodeGenerator {
  final ValueObjectGeneratorOption option;

  MaxValidationCodeGenerator(this.option);

  @override
  void generate(StringBuffer buffer) {
    if (option.annotation.max == null) {
      return;
    }

    final valueName = option.valueName;
    final max = option.annotation.max!;

    final code = '''
if ($valueName > $max) {
  throw ArgumentError.value($valueName, '$valueName', 'must be <= $max');
}
''';
    buffer.writeln(code);
  }
}
