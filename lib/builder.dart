import 'package:build/build.dart';
import 'package:source_gen/source_gen.dart';

import 'generator.dart';


Builder valueObjectGenerator(BuilderOptions options) =>
    SharedPartBuilder(const [ValueObjectGenerator()], 'simple_value_object');
