import 'code_generator.dart';

final class MinLengthValidationCodeGenerator implements CodeGenerator {
  final int? minLength;
  final String valueName;

  MinLengthValidationCodeGenerator(this.minLength, {this.valueName = 'value'});

  @override
  void generate(StringBuffer buffer) {
    if (minLength == null) {
      return;
    }
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
