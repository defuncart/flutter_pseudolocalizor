import 'dart:math';

import '../configs/language_settings.dart';
import '../enums/supported_language.dart';
import '../enums/text_expansion_format.dart';
import '../extensions/string_extensions.dart';

/// Base pseudolocalization generation logic which can be utilized by file generators
mixin PseudoGenerator {
  /// A random number generator
  static final _random = Random();

  static String generatePseudoTranslation(
    String baseText, {
    SupportedLanguage? languageToGenerate,
    required bool useBrackets,
    required TextExpansionFormat textExpansionFormat,
    double? textExpansionRate,
    RegExp? patternToIgnore,
  }) {
    final pseudoTextLength = textExpansionRate != null
        ? (baseText.length * textExpansionRate).ceil()
        : _pseudotranslationLengthForText(baseText);
    final numberOfExpansionCharactersToGenerate =
        pseudoTextLength - baseText.length;
    var _baseText = baseText;
    var textExpansion = '';

    if (numberOfExpansionCharactersToGenerate > 0) {
      switch (textExpansionFormat) {
        case TextExpansionFormat.append:
          textExpansion = generateRandomSpecialCharacters(
            numberOfExpansionCharactersToGenerate,
            language: languageToGenerate,
          );
          break;
        case TextExpansionFormat.repeatVowels:
          var count = 0;
          while (count < numberOfExpansionCharactersToGenerate) {
            _baseText = patternToIgnore != null
                ? _baseText.splitMapJoin(
                    patternToIgnore,
                    onNonMatch: (value) => repeatVowels(value,
                        count: (numberOfExpansionCharactersToGenerate *
                                (value.length / baseText.length))
                            .floor()),
                  )
                : repeatVowels(
                    _baseText,
                    count: numberOfExpansionCharactersToGenerate - count,
                  );
            count = _baseText.length - baseText.length;
          }
          break;
        case TextExpansionFormat.numberWords:
          textExpansion = generateNumberWords(
            expansionCount: numberOfExpansionCharactersToGenerate,
          );
          break;
        case TextExpansionFormat.exclamationMarks:
          // nothing to do
          break;
      }
    }

    // ignore any patterns during text replacement, if needed
    final characterReplacement = patternToIgnore != null
        ? _baseText.splitMapJoin(
            patternToIgnore,
            onNonMatch: (value) => _addSpecialCharactersToText(
              value,
              language: languageToGenerate,
            ),
          )
        : _addSpecialCharactersToText(baseText, language: languageToGenerate);

    final useExclamationMarks =
        textExpansionFormat == TextExpansionFormat.exclamationMarks;

    return (useBrackets ? '[' : '') +
        (useExclamationMarks ? '!!! ' : '') +
        characterReplacement +
        (textExpansion.isNotEmpty ? ' $textExpansion' : '') +
        (useExclamationMarks ? ' !!!' : '') +
        (useBrackets ? ']' : '');
  }

  /// Repeats [count] vowels in [text], i.e. Hello => Heelloo
  static String repeatVowels(
    String text, {
    required int count,
  }) {
    if (count < 1) {
      return text;
    }

    var elongatedText = text;
    var temp = <String>[];
    var vowelsRepeated = 0;
    while (vowelsRepeated < count) {
      for (var i = 0; i < elongatedText.length; i++) {
        if (elongatedText[i].isVowel) {
          temp.add(elongatedText[i]);
          vowelsRepeated++;
        }
        temp.add(elongatedText[i]);

        if (vowelsRepeated == count) {
          if (i < elongatedText.length) {
            temp.addAll(elongatedText.substring(i + 1).split(''));
          }
          break;
        }
      }

      elongatedText = temp.reduce((value, element) => value + element);
      temp.clear();
    }

    return temp.isNotEmpty
        ? temp.reduce((value, element) => value + element)
        : elongatedText;
  }

  /// Returns a string containing mapped special characters (a => ä) for the selected language.
  static String _addSpecialCharactersToText(
    String text, {
    required SupportedLanguage? language,
  }) {
    final sb = StringBuffer();
    final characters = text.split('');
    final mappingCharacters = mappingCharactersForSupportedLanguage(language);
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

  /// Returns a string containing [count] random special characters for the selected language.
  static String generateRandomSpecialCharacters(
    int count, {
    required SupportedLanguage? language,
  }) {
    if (count < 1) {
      return '';
    }

    final sb = StringBuffer();
    for (var i = 0; i < count; i++) {
      sb.write(randomSpecialCharacter(language: language));
    }
    return sb.toString();
  }

  /// Returns a random special character for [language].
  static String randomSpecialCharacter({
    required SupportedLanguage? language,
  }) {
    final specialCharacters = specialCharactersForSupportedLanguage(language);
    return specialCharacters[_random.nextInt(specialCharacters.length)];
  }

  /// Returns a list of special characters for [language].
  static List<String> specialCharactersForSupportedLanguage(
          SupportedLanguage? language) =>
      language == null
          ? LanguageSettings.fallbackSpecialCharacters
          : LanguageSettings.specialCharacters[language]!;

  /// Returns mapping characters for [language].
  static Map<String, List<String>> mappingCharactersForSupportedLanguage(
          SupportedLanguage? language) =>
      language == null
          ? LanguageSettings.fallbackMappingCharacters
          : LanguageSettings.mappingCharacters[language]!;

  static const _numberWords = [
    'one',
    'two',
    'three',
    'four',
    'five',
    'six',
    'seven',
    'eight',
    'nine',
  ];

  /// Generates the required words for [expansionCount], i.e. `one two`.
  static String generateNumberWords({required int expansionCount}) {
    if (expansionCount < 1) {
      return '';
    }

    var index = 0;
    final sb = StringBuffer();

    do {
      if (index != 0) {
        sb.write(' ');
      }
      sb.write(_numberWords[index]);
      index++;
    } while (index < _numberWords.length && sb.length < expansionCount);

    return sb.toString();
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
