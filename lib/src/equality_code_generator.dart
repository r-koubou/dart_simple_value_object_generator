import 'code_generator.dart';
import 'value_object_generator_option.dart';

final class EqualityCodeGenerator implements CodeGenerator {
  final ValueObjectGeneratorOption option;

  EqualityCodeGenerator(this.option);

  @override
  void generate(StringBuffer buffer) {
    final className = option.generateClassName;
    final valueName = option.valueName;

    final code = '''
@override
int get hashCode => $valueName.hashCode;
''';
    buffer.writeln(code);

    final equalityCode = '''@override
bool operator ==(Object other) {
  if (identical(this, other)) return true;
  if (other is! $className) return false;
  return $valueName == other.$valueName;
}
''';
    buffer.writeln(equalityCode);
  }
}
