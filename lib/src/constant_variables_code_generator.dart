import 'code_generator.dart';
import 'value_object_generator_option.dart';

final class ConstantVariablesCodeGenerator implements CodeGenerator {
  final ValueObjectGeneratorOption option;

  ConstantVariablesCodeGenerator(this.option);

  @override
  void generate(StringBuffer buffer) {
    if (option.annotation.presets == null) {
      return;
    }

    final className = option.generateClassName;
    final constants = option.annotation.presets!;

    constants.forEach((name, value) {
      buffer.writeln('  // ignore: unused_field');
      buffer.writeln('  static const $className $name = $className._($value);');
    });
  }
}
