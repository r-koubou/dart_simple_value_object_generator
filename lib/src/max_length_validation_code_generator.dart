import 'code_generator.dart';
import 'value_object_generator_option.dart';

final class MaxLengthValidationCodeGenerator implements CodeGenerator {
  final ValueObjectGeneratorOption option;

  MaxLengthValidationCodeGenerator(this.option);

  @override
  void generate(StringBuffer buffer) {
    if (option.annotation.maxLength == null) {
      return;
    }

    final maxLength = option.annotation.maxLength!;
    final valueName = option.valueName;

    final code = '''
if ($valueName.length > $maxLength) {
  throw ArgumentError.value($valueName, '$valueName', 'length must be <= $maxLength');
}
''';
    buffer.writeln(code);
  }
}
