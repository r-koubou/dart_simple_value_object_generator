import 'code_writer.dart';

final class EqualityCodeGenerator implements CodeGenerator {
  final String className;
  final String valueName;

  EqualityCodeGenerator(this.className, {this.valueName = 'value'});

  @override
  void generate(StringBuffer buffer) {
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
