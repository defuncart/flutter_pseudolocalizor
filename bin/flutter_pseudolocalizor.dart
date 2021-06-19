import 'dart:io';

import 'package:flutter_pseudolocalizor/flutter_pseudolocalizor.dart';

import 'utils/yaml_parser.dart';

void main() {
  final packageSettings = YamlParser.packageSettingsFromPubspec();
  if (packageSettings == null) {
    print('Error! Settings for flutter_pseudolocalizor not found in pubspec.');
    exit(0);
  }

  if (packageSettings.replaceBase == false &&
      (packageSettings.languagesToGenerate == null ||
          packageSettings.languagesToGenerate!.isEmpty)) {
    print('Error! Nothing to do! Please specify languages in pubspec.');
    exit(0);
  }

  if (packageSettings.textExpansionRatio != null &&
      (packageSettings.textExpansionRatio! < 1 ||
          packageSettings.textExpansionRatio! > 3)) {
    print('Error! Expected 1.0 <= ${YamlArguments.textExpansionRatio} <= 3!');
    exit(0);
  }

  Pseudolocalizor.generate(packageSettings);
}
