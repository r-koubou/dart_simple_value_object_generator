import 'package:simple_value_object_annotation/value_object_annotation.dart';

part 'example.g.dart';

@ValueObject<int>()
final class Price extends _$Price {
  Price(super.value);
}

@ValueObject<String>(minLength: 1, maxLength: 80)
final class Name extends _$Name {
  Name(super.value);
}
