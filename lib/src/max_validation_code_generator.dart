import 'code_writer.dart';

final class MaxValidationCodeGenerator implements CodeGenerator {
  final num? max;
  final String valueName;

  MaxValidationCodeGenerator(this.max, {this.valueName = 'value'});

  @override
  void generate(StringBuffer buffer) {
    if (max == null) {
      return;
    }
    final code = '''if ($valueName > $max) {
  throw ArgumentError.value($valueName, '$valueName', 'must be <= $max');
}
''';
    buffer.writeln(code);
  }
}
