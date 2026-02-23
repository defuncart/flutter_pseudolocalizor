import 'package:flutter_pseudolocalizor/src/configs/default_settings.dart';
import 'package:flutter_pseudolocalizor/src/enums/supported_language.dart';
import 'package:flutter_pseudolocalizor/src/enums/text_expansion_format.dart';
import 'package:flutter_pseudolocalizor/src/enums/unicode_block.dart';
import 'package:flutter_pseudolocalizor/src/extensions/supported_language_extensions.dart';
import 'package:flutter_pseudolocalizor/src/services/pseudo_generator.dart';
import 'package:flutter_pseudolocalizor/src/services/unicode_fallback.dart';
import 'package:test/test.dart';

void main() {
  group('$PseudoGenerator', () {
    late PseudoGenerator pseudoGenerator;

    setUp(() {
      pseudoGenerator = PseudoGenerator(seed: 0);
    });

    group('generatePseudoTranslation', () {
      test('When seed is given, expect same output', () {
        expect(
          pseudoGenerator.generatePseudoTranslation(
            'A beautiful oasis invites eager curious minds to imagine unique adventures.',
            languageToGenerate: SupportedLanguage.fr,
            useBrackets: false,
            textExpansionFormat: TextExpansionFormat.repeatVowels,
          ),
          'À bèaûtïfùl œasîs ïnvïtès ëagêr çùrïôûs mïnds tô ïmagïnë ùnïqùê advèntûrés.',
        );

        expect(
          pseudoGenerator.generatePseudoTranslation(
            'The quick brown fox jumps over the lazy dog.',
            unicodeBlocks: DefaultSettings.unicodeBlocks,
            useBrackets: false,
            textExpansionFormat: TextExpansionFormat.repeatVowels,
          ),
          'Ŧĥę ɋǖȉȼĸ ȸŕºⱳǌ ſô× ɉµmƥș øⱴěř ťƕę ŀaƶȳ ǳœǥ.',
        );
      });
    });

    group('addSpecialCharactersToText', () {
      test('Expect return length same as input length', () {
        expect(
          pseudoGenerator
              .addSpecialCharactersToText(
                'hello',
                language: null,
                blocks: UnicodeBlock.values,
              )
              .length,
          5,
        );
      });
    });

    group('elongateVowels', () {
      test('When hello count = 1, expect heello', () {
        expect(
          pseudoGenerator.repeatVowels(
            'hello',
            count: 1,
          ),
          'heello',
        );
      });

      test('When hello count = 2, expect heelloo', () {
        expect(
          pseudoGenerator.repeatVowels(
            'hello',
            count: 2,
          ),
          'heelloo',
        );
      });

      test('When hello count = 3, expect heeelloo', () {
        expect(
          pseudoGenerator.repeatVowels(
            'hello',
            count: 3,
          ),
          'heeelloo',
        );
      });

      test('When hello, goodbye count = 5, expect heelloo, goooodbyye', () {
        expect(
          pseudoGenerator.repeatVowels(
            'hello, goodbye',
            count: 5,
          ),
          'heelloo, goooodbyee',
        );
      });

      test('when count < 1, input', () {
        expect(
          pseudoGenerator.repeatVowels(
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
          pseudoGenerator.generateNumberWords(
            expansionCount: 0,
          ),
          isEmpty,
        );
      });

      test('when expansionCount < 4, expect one', () {
        expect(
          pseudoGenerator.generateNumberWords(
            expansionCount: 3,
          ),
          'one',
        );
      });

      test('when expansionCount < 8, expect one two', () {
        expect(
          pseudoGenerator.generateNumberWords(
            expansionCount: 7,
          ),
          'one two',
        );
      });

      test('when expansionCount < 13, expect one two three', () {
        expect(
          pseudoGenerator.generateNumberWords(
            expansionCount: 13,
          ),
          'one two three',
        );
      });
    });

    group('generateRandomSpecialCharacters', () {
      test('When count < 1, expect empty string', () {
        expect(
          pseudoGenerator.generateRandomSpecialCharacters(
            -1,
            language: null,
            blocks: UnicodeBlock.values,
          ),
          isEmpty,
        );
      });

      test('When count > 0, expect correct string length', () {
        expect(
          pseudoGenerator
              .generateRandomSpecialCharacters(
                1,
                language: null,
                blocks: UnicodeBlock.values,
              )
              .length,
          1,
        );
      });
    });

    group('specialCharactersForSupportedLanguage', () {
      test('when null is passed, expect default', () {
        expect(
          pseudoGenerator.specialCharactersForSupportedLanguage(
            null,
            blocks: UnicodeBlock.values,
          ),
          isNotNull,
        );
        expect(
          pseudoGenerator.specialCharactersForSupportedLanguage(
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
            pseudoGenerator.specialCharactersForSupportedLanguage(
              language,
              blocks: UnicodeBlock.values,
            ),
            isNotNull,
          );
          expect(
            pseudoGenerator.specialCharactersForSupportedLanguage(
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
          pseudoGenerator.mappingCharactersForSupportedLanguage(
            null,
            blocks: UnicodeBlock.values,
          ),
          isNotNull,
        );
        expect(
          pseudoGenerator.mappingCharactersForSupportedLanguage(
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
            pseudoGenerator.mappingCharactersForSupportedLanguage(
              language,
              blocks: UnicodeBlock.values,
            ),
            isNotNull,
          );
          expect(
            pseudoGenerator.mappingCharactersForSupportedLanguage(
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
          pseudoGenerator
              .randomSpecialCharacter(
                language: null,
                blocks: UnicodeBlock.values,
              )
              .length,
          1,
        );

        for (final language in SupportedLanguage.values) {
          expect(
            pseudoGenerator
                .randomSpecialCharacter(
                  language: language,
                  blocks: UnicodeBlock.values,
                )
                .length,
            1,
          );
        }
      });
    });

    group('pseudotranslationLengthForText', () {
      test('When count > 20, expect 1.3 times', () {
        expect(
          pseudoGenerator.pseudotranslationLengthForText(
            _generateStringWithLength(21),
          ),
          (21 * 1.3).ceil(),
        );
      });

      test('When count > 10, expect 1.4 times', () {
        expect(
          pseudoGenerator.pseudotranslationLengthForText(
            _generateStringWithLength(11),
          ),
          (11 * 1.4).ceil(),
        );
      });

      test('When count < 11, expect 1.5 times', () {
        expect(
          pseudoGenerator.pseudotranslationLengthForText(
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
