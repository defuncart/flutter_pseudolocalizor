import 'dart:io';

import 'package:flutter_pseudolocalizor/flutter_pseudolocalizor.dart';

import 'utils/yaml_parser.dart';

void main() {
  final packageSettings = YamlParser.packageSettingsFromPubspec();
  if (packageSettings == null) {
    print('Error! Settings for flutter_pseudolocalizor not found in pubspec.');
    exit(0);
  }

  // if the input file doesn't exist, quit
  final file = File(packageSettings.inputFilepath);
  if (!file.existsSync()) {
    print('Error! File ${packageSettings.inputFilepath} does not exist!');
    exit(0);
  }

  if (packageSettings.replaceBase == true &&
      packageSettings.languagesToGenerate != null &&
      packageSettings.languagesToGenerate!.isNotEmpty) {
    print(
        'Warning! Ignoring ${YamlArguments.languagesToGenerate} as ${YamlArguments.replaceBase} is true!');
  }

  if (packageSettings.replaceBase == false &&
      (packageSettings.languagesToGenerate == null ||
          packageSettings.languagesToGenerate!.isEmpty)) {
    print('Error! No languages to generate specified!');
    exit(0);
  }

  if (packageSettings.textExpansionRatio != null &&
      (packageSettings.textExpansionRatio! < 1 ||
          packageSettings.textExpansionRatio! > 3)) {
    print('Error! Expected 1.0 <= ${YamlArguments.textExpansionRatio} <= 3!');
    exit(0);
  }

  Pseudolocalizor.generate(file, packageSettings);
}
