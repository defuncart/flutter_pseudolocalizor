import '../configs/default_settings.dart';
import '../enums/supported_language.dart';
import '../utils/reg_exp_utils.dart';
import '../utils/utils.dart';
import 'csv_settings.dart';

/// A model representing package settings
class PackageSettings {
  /// The filepath for the input localization file. This must be supplied.
  final String inputFilepath;

  /// A filepath for the output file. Defaults to `<input_filename>-PSEUDO.<extension>`.
  final String outputFilepath;

  /// Whether to replace the base langauge. Defaults to `false`.
  final bool replaceBase;

  /// A list of languages to generate.
  final List<SupportedLanguage>? languagesToGenerate;

  /// Whether the pseudo text should be wrapped in square brackets. Defaults to `true`.
  final bool useBrackets;

  /// The ratio of text expansion for the pseudo text (compared to base text).
  final double? textExpansionRatio;

  /// A model of csv settings.
  final CSVSettings csvSettings;

  /// A RegExp to ignore during text replacement.
  final RegExp? patternToIgnore;

  /// A list of line numbers which should be ignored.
  final List<int> lineNumbersToIgnore;

  /// Constructs a new instance of [PackageSettings]
  PackageSettings({
    required this.inputFilepath,
    required String? outputFilepath,
    required bool? replaceBase,
    required List<String>? languagesToGenerate,
    required bool? useBrackets,
    required this.textExpansionRatio,
    required List<String>? patternsToIgnore,
    required List<int>? lineNumbersToIgnore,
    CSVSettings? csvSettings,
  })  : outputFilepath = outputFilepath ??
            Utils.generateOutputFilePath(inputFilepath: inputFilepath)!,
        replaceBase = replaceBase ?? DefaultSettings.replaceBase,
        languagesToGenerate =
            Utils.covertSupportedLangugesFromListString(languagesToGenerate),
        useBrackets = useBrackets ?? DefaultSettings.useBrackets,
        csvSettings = csvSettings ?? CSVSettings.withDefaultSettings(),
        patternToIgnore = RegExpUtils.combinePatterns(patternsToIgnore),
        lineNumbersToIgnore = lineNumbersToIgnore ?? [];

  /// Returns a String representation of the model.
  @override
  String toString() =>
      '{inputFilepath: $inputFilepath, outputFilepath: $outputFilepath, replaceBase: $replaceBase, languagesToGenerate: $languagesToGenerate, useBrackets: $useBrackets, textExpansionRatio: $textExpansionRatio, patternToIgnore: $patternToIgnore, lineNumbersToIgnore: $lineNumbersToIgnore}';
}
