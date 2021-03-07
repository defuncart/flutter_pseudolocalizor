import 'dart:math';

import '../configs/default_settings.dart';
import '../enums/supported_language.dart';
import '../utils/utils.dart';

/// Base pseudolocalization generation logic which can be utilized by file generators
mixin PseudoGenerator {
  /// A random number generator
  static final _random = Random();

  static String generatePseudoTranslation(
    String baseText, {
    SupportedLanguage? languageToGenerate,
    bool useBrackets = DefaultSettings.useBrackets,
    double? textExpansionRate,
    RegExp? patternToIgnore,
  }) {
    final pseudoTextLength = textExpansionRate != null
        ? (baseText.length * textExpansionRate).ceil()
        : _pseudotranslationLengthForText(baseText);
    final numberOfRandomSpecialCharactersToGenerate = pseudoTextLength - baseText.length;

    // ignore any patterns during text replacement, if needed
    final characterReplacement = patternToIgnore != null
        ? baseText.splitMapJoin(
            patternToIgnore,
            onNonMatch: (value) => _addSpecialCharactersToText(value, language: languageToGenerate),
          )
        : _addSpecialCharactersToText(baseText, language: languageToGenerate);

    final textExpansion = numberOfRandomSpecialCharactersToGenerate > 0
        ? _generateXRandomSpecialCharacters(numberOfRandomSpecialCharactersToGenerate, language: languageToGenerate)
        : '';

    return (useBrackets ? '[ ' : '') +
        characterReplacement +
        (textExpansion.isNotEmpty ? ' $textExpansion' : '') +
        (useBrackets ? ' ]' : '');
  }

  /// Returns a string containing mapped special characters (a => ä) for the selected language.
  static String _addSpecialCharactersToText(String text, {required SupportedLanguage? language}) {
    final sb = StringBuffer();
    final characters = text.split('');
    final mappingCharacters = Utils.mappingCharactersForSupportedLanguage(language)!;
    final keys = mappingCharacters.keys.toList();
    for (final character in characters) {
      final index = keys.indexOf(character);
      if (index > 0) {
        final possibleMappings = mappingCharacters[character]!;
        sb.write(possibleMappings[_random.nextInt(possibleMappings.length)]);
      } else {
        sb.write(character);
      }
    }

    return sb.toString();
  }

  /// Returns a string contain X random special characters for the selected language.
  static String _generateXRandomSpecialCharacters(int count, {required SupportedLanguage? language}) {
    final sb = StringBuffer();
    for (var i = 0; i < count; i++) {
      sb.write(_randomSpecialCharacter(language: language));
    }
    return sb.toString();
  }

  /// Returns a random special character for the selected language.
  static String _randomSpecialCharacter({required SupportedLanguage? language}) {
    final specialCharacters = Utils.specialCharactersForSupportedLanguage(language)!;
    return specialCharacters[_random.nextInt(specialCharacters.length)];
  }

  /// Determines the Pseudotranslation length for a given text string.
  ///
  /// As a quick rule of thumb, using [IGDA Localization SIG](https://www.gamasutra.com/blogs/IGDALocalizationSIG/20180504/317560/PseudoLocalization__A_Must_in_Video_Gaming.php)'s suggestion.
  static int _pseudotranslationLengthForText(String text) {
    if (text.length > 20) {
      return (text.length * 1.3).ceil();
    } else if (text.length > 10) {
      return (text.length * 1.4).ceil();
    } else {
      return (text.length * 1.5).ceil();
    }
  }
}
