abstract interface class CodeGenerator {
  void generate(StringBuffer buffer);
}

bool isComparableType(String type) {
  return type == 'int' || type == 'double' || type == 'num';
}
