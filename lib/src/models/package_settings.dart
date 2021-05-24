import '../configs/default_settings.dart';
import '../enums/supported_language.dart';
import '../enums/text_expansion_format.dart';
import '../utils/reg_exp_utils.dart';
import '../utils/utils.dart';
import 'arb_settings.dart';
import 'csv_settings.dart';

/// A model representing package settings
class PackageSettings {
  /// The filepath for the input localization file. This must be supplied.
  final String inputFilepath;

  /// Whether to replace the base langauge. Defaults to `false`.
  final bool replaceBase;

  /// A list of languages to generate.
  final List<SupportedLanguage>? languagesToGenerate;

  /// Whether the pseudo text should be wrapped in square brackets. Defaults to `true`.
  final bool useBrackets;

  /// The format of the text expansion.
  final TextExpansionFormat textExpansionFormat;

  /// The ratio of text expansion for the pseudo text (compared to base text).
  final double? textExpansionRatio;

  /// A RegExp to ignore during text replacement.
  final RegExp? patternToIgnore;

  /// A list of keys which should be ignored.
  final List<String>? keysToIgnore;

  /// A model of arb settings.
  final ARBSettings arbSettings;

  /// A model of csv settings.
  final CSVSettings csvSettings;

  /// Constructs a new instance of [PackageSettings]
  PackageSettings({
    required this.inputFilepath,
    required bool? replaceBase,
    required List<String>? languagesToGenerate,
    required bool? useBrackets,
    required String? textExpansionFormat,
    required this.textExpansionRatio,
    required List<String>? patternsToIgnore,
    required this.keysToIgnore,
    ARBSettings? arbSettings,
    CSVSettings? csvSettings,
  })  : replaceBase = replaceBase ?? DefaultSettings.replaceBase,
        languagesToGenerate =
            Utils.covertSupportedLangugesFromListString(languagesToGenerate),
        useBrackets = useBrackets ?? DefaultSettings.useBrackets,
        textExpansionFormat =
            Utils.convertTextExpansionFormatFromString(textExpansionFormat) ??
                DefaultSettings.textExpansionFormat,
        patternToIgnore = RegExpUtils.combinePatterns(patternsToIgnore),
        arbSettings = arbSettings ?? ARBSettings(),
        csvSettings = csvSettings ?? CSVSettings();

  /// Returns a String representation of the model.
  @override
  String toString() =>
      '{inputFilepath: $inputFilepath, replaceBase: $replaceBase, languagesToGenerate: $languagesToGenerate, useBrackets: $useBrackets, textExpansionFormat: $textExpansionFormat, textExpansionRatio: $textExpansionRatio, patternToIgnore: $patternToIgnore, keysToIgnore: $keysToIgnore, arbSettings: $arbSettings, csvSettings: $csvSettings}';
}
