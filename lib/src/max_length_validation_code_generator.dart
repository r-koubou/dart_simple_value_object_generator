import 'code_writer.dart';

final class MaxLengthValidationCodeGenerator implements CodeGenerator {
  final int? maxLength;
  final String valueName;

  MaxLengthValidationCodeGenerator(this.maxLength, {this.valueName = 'value'});

  @override
  void generate(StringBuffer buffer) {
    if (maxLength == null) {
      return;
    }
    final code = '''
if ($valueName.length > $maxLength) {
  throw ArgumentError.value($valueName, '$valueName', 'length must be <= $maxLength');
}
''';
    buffer.writeln(code);
  }
}
