import 'dart:io';

import '../configs/default_settings.dart';
import '../models/package_settings.dart';
import '../utils/utils.dart';
import 'pseudo_generator.dart';

/// Generates pseudo localizations for a csv file
class CSVGenerator with PseudoGenerator {
  /// Generates pseudo localizations with a given [file] and [packageSettings]
  static String generate(
    File file,
    PackageSettings packageSettings,
  ) {
    // read all lines into a list
    final lines = file.readAsLinesSync();

    // ensure that the column index is valid
    final firstLineElements =
        lines.first.split(packageSettings.csvSettings.delimiter);
    if (packageSettings.csvSettings.columnIndex < 0 ||
        packageSettings.csvSettings.columnIndex >= firstLineElements.length) {
      print(
          "Error! Column index ${packageSettings.csvSettings.columnIndex} in ${packageSettings.inputFilepath} doesn't exist.");
      exit(0);
    }

    // ensure that the column `DefaultSettings.baseLanguage` is as specified in settings
    if (firstLineElements[packageSettings.csvSettings.columnIndex] !=
        DefaultSettings.baseLanguage) {
      print(
          'Error! Langauge ${DefaultSettings.baseLanguage} not found at column ${packageSettings.csvSettings.columnIndex} in ${packageSettings.inputFilepath}');
      exit(0);
    }

    final locaBase = <String>[];
    for (var i = packageSettings.csvSettings.columnIndex;
        i < lines.length;
        i++) {
      locaBase.add(lines[i].split(packageSettings.csvSettings.delimiter)[
          packageSettings.csvSettings.columnIndex]);
    }

    final locaKeys = lines
        .map((line) => line.split(packageSettings.csvSettings.delimiter).first)
        .toList();

    final outputLines = List<String>.from(lines);
    if (packageSettings.replaceBase) {
      for (var i = 1; i < outputLines.length; i++) {
        final shouldReplace =
            !(packageSettings.keysToIgnore?.contains(locaKeys[i]) ?? false);
        if (shouldReplace) {
          final pseudoText = PseudoGenerator.generatePseudoTranslation(
            locaBase[i - 1],
            languageToGenerate: null,
            unicodeBlocks: packageSettings.unicodeBlocks,
            useBrackets: packageSettings.useBrackets,
            textExpansionFormat: packageSettings.textExpansionFormat,
            textExpansionRate: packageSettings.textExpansionRatio,
            patternToIgnore: packageSettings.patternToIgnore,
          );
          outputLines[i] =
              outputLines[i].replaceFirst(locaBase[i - 1], pseudoText);
        }
      }
    }
    if (packageSettings.languagesToGenerate != null &&
        packageSettings.languagesToGenerate!.isNotEmpty) {
      final generatedAll = <List<String>>[];
      generatedAll.add(packageSettings.languagesToGenerate!
          .map(Utils.describeEnum)
          .toList());
      for (var i = 0; i < locaBase.length; i++) {
        final baseText = locaBase[i];
        final generated = <String>[];
        final shouldReplace =
            !(packageSettings.keysToIgnore?.contains(locaKeys[i + 1]) ?? false);

        for (final languageToGenerate in packageSettings.languagesToGenerate!) {
          final pseudoTranslation = shouldReplace
              ? PseudoGenerator.generatePseudoTranslation(
                  baseText,
                  languageToGenerate: languageToGenerate,
                  unicodeBlocks: packageSettings.unicodeBlocks,
                  useBrackets: packageSettings.useBrackets,
                  textExpansionFormat: packageSettings.textExpansionFormat,
                  textExpansionRate: packageSettings.textExpansionRatio,
                  patternToIgnore: packageSettings.patternToIgnore,
                )
              : baseText;

          generated.add(pseudoTranslation);
        }

        generatedAll.add(List.from(generated));
        generated.clear();
      }

      for (var i = 0; i < outputLines.length; i++) {
        for (var j = 0; j < generatedAll[i].length; j++) {
          outputLines[i] +=
              '${packageSettings.csvSettings.delimiter}${generatedAll[i][j]}';
        }
      }
    }

    return outputLines.join('\n');
  }
}
