import 'dart:math';

import 'package:meta/meta.dart';

import '../configs/default_settings.dart';
import '../enums/supported_language.dart';
import '../enums/text_expansion_format.dart';
import '../enums/unicode_block.dart';
import '../extensions/string_extensions.dart';
import '../extensions/supported_language_extensions.dart';
import 'unicode_fallback.dart';

/// Base pseudolocalization generation logic which can be utilized by file generators
mixin PseudoGenerator {
  /// A random number generator
  static var _random = Random();

  static void setSeed(int? seed) {
    if (seed != null) {
      _random = Random(seed);
    }
  }

  static String generatePseudoTranslation(
    String baseText, {
    List<UnicodeBlock>? unicodeBlocks,
    SupportedLanguage? languageToGenerate,
    required bool useBrackets,
    required TextExpansionFormat textExpansionFormat,
    double? textExpansionRate,
    RegExp? patternToIgnore,
  }) {
    final blocks = unicodeBlocks ?? DefaultSettings.unicodeBlocks;
    final pseudoTextLength = textExpansionRate != null
        ? (baseText.length * textExpansionRate).ceil()
        : pseudotranslationLengthForText(baseText);
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
            blocks: blocks,
          );
          break;
        case TextExpansionFormat.repeatVowels:
          if (baseText.hasVowels) {
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
          } else {
            textExpansion = generateRandomSpecialCharacters(
              numberOfExpansionCharactersToGenerate,
              language: languageToGenerate,
              blocks: blocks,
            );
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
            onNonMatch: (value) => addSpecialCharactersToText(
              value,
              language: languageToGenerate,
              blocks: blocks,
            ),
          )
        : addSpecialCharactersToText(
            baseText,
            language: languageToGenerate,
            blocks: blocks,
          );

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
  @visibleForTesting
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
  @visibleForTesting
  static String addSpecialCharactersToText(
    String text, {
    required SupportedLanguage? language,
    required List<UnicodeBlock> blocks,
  }) {
    final sb = StringBuffer();
    final characters = text.split('');
    final mappingCharacters =
        mappingCharactersForSupportedLanguage(language, blocks: blocks);
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
  @visibleForTesting
  static String generateRandomSpecialCharacters(
    int count, {
    required SupportedLanguage? language,
    required List<UnicodeBlock> blocks,
  }) {
    if (count < 1) {
      return '';
    }

    final sb = StringBuffer();
    for (var i = 0; i < count; i++) {
      sb.write(randomSpecialCharacter(
        language: language,
        blocks: blocks,
      ));
    }
    return sb.toString();
  }

  /// Returns a random special character for [language] and [blocks].
  @visibleForTesting
  static String randomSpecialCharacter({
    required SupportedLanguage? language,
    required List<UnicodeBlock> blocks,
  }) {
    final specialCharacters = specialCharactersForSupportedLanguage(
      language,
      blocks: blocks,
    );
    return specialCharacters[_random.nextInt(specialCharacters.length)];
  }

  /// Returns a list of special characters for [language] and [blocks].
  @visibleForTesting
  static List<String> specialCharactersForSupportedLanguage(
    SupportedLanguage? language, {
    required List<UnicodeBlock> blocks,
  }) =>
      language != null
          ? language.specialCharacters
          : UnicodeFallback.specialCharacters(blocks: blocks);

  /// Returns mapping characters for [language] and [blocks].
  @visibleForTesting
  static Map<String, List<String>> mappingCharactersForSupportedLanguage(
    SupportedLanguage? language, {
    required List<UnicodeBlock> blocks,
  }) =>
      language != null
          ? language.mappingCharacters
          : UnicodeFallback.mappingCharacters(blocks: blocks);

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
  @visibleForTesting
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
  @visibleForTesting
  static int pseudotranslationLengthForText(String text) {
    if (text.length > 20) {
      return (text.length * 1.3).ceil();
    } else if (text.length > 10) {
      return (text.length * 1.4).ceil();
    } else {
      return (text.length * 1.5).ceil();
    }
  }
}
