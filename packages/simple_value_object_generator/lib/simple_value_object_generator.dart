import 'package:build/build.dart';
import 'package:source_gen/source_gen.dart';

import 'src/value_object_generator.dart';

/// Builder for generating value object code
Builder valueObjectGenerator(BuilderOptions options) =>
    SharedPartBuilder(const [ValueObjectGenerator()], 'simple_value_object');
