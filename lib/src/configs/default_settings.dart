import '../enums/text_expansion_format.dart';

/// A config of default settings for the package
abstract class DefaultSettings {
  /// Prepend text when autogenerating output filename.
  static const outputFilenamePrependText = 'PSEUDO';

  /// The base language
  static const baseLanguage = 'en';

  /// Whether to replace the base langauge.
  static const replaceBase = false;

  /// Whether the pseudo text should be wrapped in square brackets.
  static const useBrackets = true;

  /// Which text expansion format to use.
  static const textExpansionFormat = TextExpansionFormat.repeatVowels;
}
