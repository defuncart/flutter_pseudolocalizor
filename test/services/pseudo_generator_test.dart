import 'package:flutter_pseudolocalizor/src/enums/supported_language.dart';
import 'package:flutter_pseudolocalizor/src/enums/unicode_block.dart';
import 'package:flutter_pseudolocalizor/src/extensions/supported_language_extensions.dart';
import 'package:flutter_pseudolocalizor/src/services/pseudo_generator.dart';
import 'package:flutter_pseudolocalizor/src/services/unicode_fallback.dart';
import 'package:test/test.dart';

void main() {
  group('$PseudoGenerator', () {
    group('addSpecialCharactersToText', () {
      test('Expect return length same as input length', () {
        expect(
          PseudoGenerator.addSpecialCharactersToText(
            'hello',
            language: null,
            blocks: UnicodeBlock.values,
          ).length,
          5,
        );
      });
    });

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
          PseudoGenerator.generateRandomSpecialCharacters(
            -1,
            language: null,
            blocks: UnicodeBlock.values,
          ),
          isEmpty,
        );
      });

      test('When count > 0, expect correct string length', () {
        expect(
          PseudoGenerator.generateRandomSpecialCharacters(
            1,
            language: null,
            blocks: UnicodeBlock.values,
          ).length,
          1,
        );
      });
    });

    group('specialCharactersForSupportedLanguage', () {
      test('when null is passed, expect default', () {
        expect(
          PseudoGenerator.specialCharactersForSupportedLanguage(
            null,
            blocks: UnicodeBlock.values,
          ),
          isNotNull,
        );
        expect(
          PseudoGenerator.specialCharactersForSupportedLanguage(
            null,
            blocks: UnicodeBlock.values,
          ),
          UnicodeFallback.specialCharacters(blocks: UnicodeBlock.values),
        );
      });

      test(
          'when language is passed, expect special characters '
          'for that language', () {
        for (final language in SupportedLanguage.values) {
          expect(
            PseudoGenerator.specialCharactersForSupportedLanguage(
              language,
              blocks: UnicodeBlock.values,
            ),
            isNotNull,
          );
          expect(
            PseudoGenerator.specialCharactersForSupportedLanguage(
              language,
              blocks: UnicodeBlock.values,
            ),
            language.specialCharacters,
          );
        }
      });
    });

    group('mappingCharactersForSupportedLanguage', () {
      test('when null is passed, expect default', () {
        expect(
          PseudoGenerator.mappingCharactersForSupportedLanguage(
            null,
            blocks: UnicodeBlock.values,
          ),
          isNotNull,
        );
        expect(
          PseudoGenerator.mappingCharactersForSupportedLanguage(
            null,
            blocks: UnicodeBlock.values,
          ),
          UnicodeFallback.mappingCharacters(
            blocks: UnicodeBlock.values,
          ),
        );
      });

      test(
          'when language is passed, expect special characters '
          'for that language', () {
        for (final language in SupportedLanguage.values) {
          expect(
            PseudoGenerator.mappingCharactersForSupportedLanguage(
              language,
              blocks: UnicodeBlock.values,
            ),
            isNotNull,
          );
          expect(
            PseudoGenerator.mappingCharactersForSupportedLanguage(
              language,
              blocks: UnicodeBlock.values,
            ),
            language.mappingCharacters,
          );
        }
      });
    });

    group('randomSpecialCharacter', () {
      test('Regardless of language, expect single character', () {
        expect(
          PseudoGenerator.randomSpecialCharacter(
            language: null,
            blocks: UnicodeBlock.values,
          ).length,
          1,
        );

        for (final language in SupportedLanguage.values) {
          expect(
            PseudoGenerator.randomSpecialCharacter(
              language: language,
              blocks: UnicodeBlock.values,
            ).length,
            1,
          );
        }
      });
    });

    group('pseudotranslationLengthForText', () {
      test('When count > 20, expect 1.3 times', () {
        expect(
          PseudoGenerator.pseudotranslationLengthForText(
            _generateStringWithLength(21),
          ),
          (21 * 1.3).ceil(),
        );
      });

      test('When count > 10, expect 1.4 times', () {
        expect(
          PseudoGenerator.pseudotranslationLengthForText(
            _generateStringWithLength(11),
          ),
          (11 * 1.4).ceil(),
        );
      });

      test('When count < 11, expect 1.5 times', () {
        expect(
          PseudoGenerator.pseudotranslationLengthForText(
            _generateStringWithLength(10),
          ),
          (10 * 1.5).ceil(),
        );
      });
    });
  });
}

String _generateStringWithLength(int length) =>
    String.fromCharCodes(List.generate(length, (_) => 89));
