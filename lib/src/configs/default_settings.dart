import '../enums/text_expansion_format.dart';
import '../enums/unicode_block.dart';

/// A config of default settings for the package
abstract class DefaultSettings {
  /// The base language
  static const baseLanguage = 'en';

  /// Whether to replace the base language.
  static const replaceBase = false;

  /// A list of unicode blocks to use
  static const unicodeBlocks = UnicodeBlock.values;

  /// Whether the pseudo text should be wrapped in square brackets.
  static const useBrackets = true;

  /// Which text expansion format to use.
  static const textExpansionFormat = TextExpansionFormat.repeatVowels;
}
