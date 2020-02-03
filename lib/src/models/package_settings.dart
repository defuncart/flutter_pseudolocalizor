import 'package:meta/meta.dart';

import '../configs/default_settings.dart';
import 'csv_settings.dart';
import '../enums/supported_language.dart';
import '../utils/utils.dart';

/// A model representing package settings
class PackageSettings {
  /// The filepath for the input localization file. This must be supplied.
  final String inputFilepath;

  /// A filepath for the output file. Defaults to `<input_filename>-PSEUDO.<extension>`.
  final String outputFilepath;

  /// Whether to replace the base langauge. Defaults to `false`.
  final bool replaceBase;

  /// A list of languages to generate.
  final List<SupportedLanguage> languagesToGenerate;

  /// Whether the pseudo text should be wrapped in square brackets. Defaults to `true`.
  final bool useBrackets;

  /// The ratio of text expansion for the pseudo text (compared to base text).
  final double textExpansionRatio;

  /// A model of csv settings.
  final CSVSettings csvSettings;

  /// A RegExp to ignore during text replacement.
  final RegExp patternToIgnore;

  PackageSettings({
    @required this.inputFilepath,
    @required bool outputFilepath,
    @required bool replaceBase,
    @required List<String> languagesToGenerate,
    @required bool useBrackets,
    @required this.textExpansionRatio,
    @required List<String> patternsToIgnore,
    CSVSettings csvSettings,
  })  : this.outputFilepath = outputFilepath ?? Utils.generateOutputFilePath(inputFilepath: inputFilepath),
        this.replaceBase = replaceBase ?? DefaultSettings.replaceBase,
        this.languagesToGenerate = Utils.covertSupportedLangugesFromListString(languagesToGenerate),
        this.useBrackets = useBrackets ?? DefaultSettings.useBrackets,
        this.csvSettings = csvSettings ?? CSVSettings.withDefaultSettings(),
        this.patternToIgnore = _combinePatterns(patternsToIgnore);

  static RegExp _combinePatterns(List<String> patterns) {
    if (patterns != null && patterns.length > 0) {
      String combinedPattern = '';
      for (int i = 0; i < patterns.length; i++) {
        if (i != 0) {
          combinedPattern += "|";
        }
        combinedPattern += patterns[i];
      }

      return RegExp(combinedPattern);
    }

    return null;
  }

  /// Returns a String representation of the model.
  @override
  String toString() =>
      '{inputFilepath: $inputFilepath, outputFilepath: $outputFilepath, replaceBase: $replaceBase, languagesToGenerate: $languagesToGenerate, useBrackets: $useBrackets, textExpansionRatio: $textExpansionRatio, expressionsToIgnore: $patternToIgnore}';
}
