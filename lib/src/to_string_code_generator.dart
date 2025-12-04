import 'code_writer.dart';

final class ToStringCodeGenerator implements CodeGenerator {
  final String valueName;
  ToStringCodeGenerator({this.valueName = 'value'});
  @override
  void generate(StringBuffer buffer) {
    final code = '''
@override
String toString() => $valueName.toString();
''';
    buffer.writeln(code);
  }
}
