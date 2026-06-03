import 'package:simple_value_object_generator/src/code_generator.dart';
import 'package:simple_value_object_generator/src/value_object_generator_option.dart';

class EmptyStringCodeGenerator implements CodeGenerator {
  final ValueObjectGeneratorOption option;

  EmptyStringCodeGenerator(this.option);

  @override
  void generate(StringBuffer buffer) {
    final allowEmpty = option.annotation.allowEmpty ?? true;
    final minLength = option.annotation.minLength ?? 0;

    if (!option.isValueTypeString() || !allowEmpty || minLength > 0) {
      return;
    }

    final code = '''
static final ${option.typeName} empty = ${option.typeName}('');
''';
    buffer.writeln(code);
  }
}
