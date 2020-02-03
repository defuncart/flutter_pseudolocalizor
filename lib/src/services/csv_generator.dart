import 'dart:io';

import '../configs/default_settings.dart';
import '../models/package_settings.dart';
import 'pseudo_generator.dart';
import '../utils/utils.dart';

/// Generates pseudo localizations for a csv file
class CSVGenerator with PseudoGenerator {
  static String generate(
    File file,
    PackageSettings packageSettings,
  ) {
    if (file == null || packageSettings == null || packageSettings.csvSettings == null) {
      print('Error! Null data passed to CSVGenerator.generate().');
      return null;
    }

    // read all lines into a list
    final lines = file.readAsLinesSync();

    // ensure that the column index is valid
    final firstLineElements = lines.first.split(packageSettings.csvSettings.delimiter);
    if (packageSettings.csvSettings.columnIndex < 0 ||
        packageSettings.csvSettings.columnIndex >= firstLineElements.length) {
      print(
          'Error! Column index ${packageSettings.csvSettings.columnIndex} in ${packageSettings.inputFilepath} doesn\'t exist.');
      return null;
    }

    // ensure that the column `DefaultSettings.baseLanguage` is as specified in settings
    if (firstLineElements[packageSettings.csvSettings.columnIndex] != DefaultSettings.baseLanguage) {
      print(
          'Error! Langauge ${DefaultSettings.baseLanguage} not found at column ${packageSettings.csvSettings.columnIndex} in ${packageSettings.inputFilepath}');
      return null;
    }

    final locaBase = <String>[];
    for (int i = packageSettings.csvSettings.columnIndex; i < lines.length; i++) {
      locaBase.add(lines[i].split(packageSettings.csvSettings.delimiter)[packageSettings.csvSettings.columnIndex]);
    }

    final outputLines = List<String>.from(lines);
    if (packageSettings.replaceBase) {
      for (int i = 1; i < outputLines.length; i++) {
        final pseudoText = PseudoGenerator.generatePseudoTranslation(
          locaBase[i - 1],
          languageToGenerate: null,
          useBrackets: packageSettings.useBrackets,
          textExpansionRate: packageSettings.textExpansionRatio,
        );
        outputLines[i] = outputLines[i].replaceFirst(locaBase[i - 1], pseudoText);
      }
    } else {
      List<List<String>> generatedAll = [];
      generatedAll.add(packageSettings.languagesToGenerate.map((x) => Utils.describeEnum(x)).toList());
      for (final baseText in locaBase) {
        List<String> generated = [];

        for (final languageToGenerate in packageSettings.languagesToGenerate) {
          final pseudoTranslation = PseudoGenerator.generatePseudoTranslation(
            baseText,
            languageToGenerate: languageToGenerate,
            useBrackets: packageSettings.useBrackets,
            textExpansionRate: packageSettings.textExpansionRatio,
            expressionsToIgnore: packageSettings.expressionsToIgnore,
          );

          generated.add(pseudoTranslation);
        }

        generatedAll.add(List.from(generated));
        generated.clear();
      }

      for (int i = 0; i < outputLines.length; i++) {
        for (int j = 0; j < generatedAll[i].length; j++) {
          outputLines[i] += '${packageSettings.csvSettings.delimiter}${generatedAll[i][j]}';
        }
      }
    }

    return outputLines.join('\n');
  }
}
