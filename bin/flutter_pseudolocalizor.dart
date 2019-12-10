import 'dart:io';

import 'package:flutter_pseudolocalizor/flutter_pseudolocalizor.dart';

import 'utils/yaml_parser.dart';

void main(List<String> arguments) {
  final packageSettings = YamlParser.packageSettingsFromPubspec();

  if (packageSettings.inputFilepath == null) {
    print('Error! Input filepath not defined!');
    return;
  }

  // if the input file doesn't exist, quit
  final file = File(packageSettings.inputFilepath);
  if (!file.existsSync()) {
    print('Error! File ${packageSettings.inputFilepath} does not exist!');
    return;
  }

  if (packageSettings.replaceBase == true &&
      packageSettings.languagesToGenerate != null &&
      packageSettings.languagesToGenerate.isNotEmpty) {
    print('Warning! Ignoring ${YamlArguments.languagesToGenerate} as ${YamlArguments.replaceBase} is true!');
  }

  if (packageSettings.replaceBase == false &&
      (packageSettings.languagesToGenerate == null || packageSettings.languagesToGenerate.isEmpty)) {
    print('Error! No languages to generate specified!');
    return;
  }

  if (packageSettings.textExpansionRatio != null &&
      (packageSettings.textExpansionRatio < 1 || packageSettings.textExpansionRatio > 3)) {
    print('Error! Expected 1.0 <= ${YamlArguments.textExpansionRatio} <= 3!');
    return;
  }

  Pseudolocalizor.generate(file, packageSettings);
}
