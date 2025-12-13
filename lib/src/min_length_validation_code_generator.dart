import 'code_generator.dart';
import 'value_object_generator_option.dart';

final class MinLengthValidationCodeGenerator implements CodeGenerator {
  final ValueObjectGeneratorOption option;

  MinLengthValidationCodeGenerator(this.option);

  @override
  void generate(StringBuffer buffer) {
    if (option.annotation.minLength == null) {
      return;
    }

    final minLength = option.annotation.minLength!;
    final valueName = option.valueName;

    final code = minLength == 1
        ? '''
if ($valueName.isEmpty) {
  throw ArgumentError.value($valueName, '$valueName', 'length must be >= $minLength');
}
'''
        : '''
if ($valueName.length < $minLength) {
  throw ArgumentError.value($valueName, '$valueName', 'length must be >= $minLength');
}
''';
    buffer.writeln(code);
  }
}
