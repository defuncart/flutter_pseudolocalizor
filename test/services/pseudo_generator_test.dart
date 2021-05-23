import 'package:flutter_pseudolocalizor/src/configs/language_settings.dart';
import 'package:flutter_pseudolocalizor/src/enums/supported_language.dart';
import 'package:flutter_pseudolocalizor/src/services/pseudo_generator.dart';
import 'package:test/test.dart';

void main() {
  group('$PseudoGenerator', () {
    group('elongateVowels', () {
      test('When hello count = 1, expect heello', () {
        expect(
          PseudoGenerator.repeatVowels(
            'hello',
            count: 1,
          ),
          'heello',
        );
      });

      test('When hello count = 2, expect heelloo', () {
        expect(
          PseudoGenerator.repeatVowels(
            'hello',
            count: 2,
          ),
          'heelloo',
        );
      });

      test('When hello count = 3, expect heeelloo', () {
        expect(
          PseudoGenerator.repeatVowels(
            'hello',
            count: 3,
          ),
          'heeelloo',
        );
      });

      test('When hello, goodbye count = 5, expect heelloo, goooodbyye', () {
        expect(
          PseudoGenerator.repeatVowels(
            'hello, goodbye',
            count: 5,
          ),
          'heelloo, goooodbyee',
        );
      });

      test('when count < 1, input', () {
        expect(
          PseudoGenerator.repeatVowels(
            'hello',
            count: 0,
          ),
          'hello',
        );
      });
    });

    group('generateNumberWords', () {
      test('when expansionCount = 0, expect empty', () {
        expect(
          PseudoGenerator.generateNumberWords(
            expansionCount: 0,
          ),
          isEmpty,
        );
      });

      test('when expansionCount < 4, expect one', () {
        expect(
          PseudoGenerator.generateNumberWords(
            expansionCount: 3,
          ),
          'one',
        );
      });

      test('when expansionCount < 8, expect one two', () {
        expect(
          PseudoGenerator.generateNumberWords(
            expansionCount: 7,
          ),
          'one two',
        );
      });

      test('when expansionCount < 13, expect one two three', () {
        expect(
          PseudoGenerator.generateNumberWords(
            expansionCount: 13,
          ),
          'one two three',
        );
      });
    });

    group('generateRandomSpecialCharacters', () {
      test('When count < 1, expect empty string', () {
        expect(
          PseudoGenerator.generateRandomSpecialCharacters(-1, language: null),
          isEmpty,
        );
      });

      test('When count > 0, expect correct string length', () {
        expect(
          PseudoGenerator.generateRandomSpecialCharacters(
            1,
            language: null,
          ).length,
          1,
        );
      });
    });

    group('specialCharactersForSupportedLanguage', () {
      test('when null is passed, expect default', () {
        expect(
          PseudoGenerator.specialCharactersForSupportedLanguage(null),
          isNotNull,
        );
        expect(
          PseudoGenerator.specialCharactersForSupportedLanguage(null),
          LanguageSettings.fallbackSpecialCharacters,
        );
      });

      test(
          'when language is passed, expect special characters '
          'for that language', () {
        for (final language in SupportedLanguage.values) {
          expect(
            PseudoGenerator.specialCharactersForSupportedLanguage(language),
            isNotNull,
          );
          expect(
            PseudoGenerator.specialCharactersForSupportedLanguage(language),
            LanguageSettings.specialCharacters[language]!,
          );
        }
      });
    });

    group('mappingCharactersForSupportedLanguage', () {
      test('when null is passed, expect default', () {
        expect(
          PseudoGenerator.mappingCharactersForSupportedLanguage(null),
          isNotNull,
        );
        expect(
          PseudoGenerator.mappingCharactersForSupportedLanguage(null),
          LanguageSettings.fallbackMappingCharacters,
        );
      });

      test(
          'when language is passed, expect special characters '
          'for that language', () {
        for (final language in SupportedLanguage.values) {
          expect(
            PseudoGenerator.mappingCharactersForSupportedLanguage(language),
            isNotNull,
          );
          expect(
            PseudoGenerator.mappingCharactersForSupportedLanguage(language),
            LanguageSettings.mappingCharacters[language]!,
          );
        }
      });
    });

    group('randomSpecialCharacter', () {
      test('Regardless of language, expect single character', () {
        expect(
          PseudoGenerator.randomSpecialCharacter(language: null).length,
          1,
        );

        for (final language in SupportedLanguage.values) {
          expect(
            PseudoGenerator.randomSpecialCharacter(language: language).length,
            1,
          );
        }
      });
    });
  });
}
