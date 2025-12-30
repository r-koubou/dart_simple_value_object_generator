import 'code_generator.dart';
import 'value_object_generator_option.dart';

final class AllowEmptyValidationCodeGenerator implements CodeGenerator {
  final ValueObjectGeneratorOption option;

  AllowEmptyValidationCodeGenerator(this.option);

  @override
  void generate(StringBuffer buffer) {
    final allowEmpty = option.annotation.allowEmpty ?? true;

    if (allowEmpty) {
      return;
    }

    final valueName = option.valueName;

    final code = '''
if ($valueName.isEmpty) {
  throw ArgumentError.value($valueName, '$valueName', 'must not be empty');
}
''';

    buffer.writeln(code);
  }
}
