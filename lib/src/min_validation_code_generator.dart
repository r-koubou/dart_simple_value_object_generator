import 'code_generator.dart';

final class MinValidationCodeGenerator implements CodeGenerator {
  final num? min;
  final String valueName;

  MinValidationCodeGenerator(this.min, {this.valueName = 'value'});

  @override
  void generate(StringBuffer buffer) {
    if (min == null) {
      return;
    }
    final code = '''
if ($valueName < $min) {
  throw ArgumentError.value($valueName, '$valueName', 'must be >= $min');
}
''';
    buffer.writeln(code);
  }
}
