import 'package:flutter_pseudolocalizor/src/extensions/string_extensions.dart';
import 'package:test/test.dart';

void main() {
  group('StringExtensions', () {
    group('isVowel', () {
      test('When a, e, i, o, u, expect true', () {
        final letters = ['a', 'e', 'i', 'o', 'u'];

        for (final letter in letters) {
          expect(letter.isVowel, isTrue);
          expect(letter.toUpperCase().isVowel, isTrue);
        }
      });

      test('When b, c, d etc, expect false', () {
        final letters = [
          'b',
          'c',
          'd',
          'f',
          'g',
          'h',
          'j',
          'k',
          'l',
          'm',
          'n',
          'p',
          'q',
          'r',
          's',
          't',
          'v',
          'w',
          'x',
          'y',
          'z',
        ];

        for (final letter in letters) {
          expect(letter.isVowel, isFalse);
          expect(letter.toUpperCase().isVowel, isFalse);
        }
      });

      test('when not a single character, expect argument error', () {
        expect(
          () => ''.isVowel,
          throwsArgumentError,
        );

        expect(
          () => 'aa'.isVowel,
          throwsArgumentError,
        );
      });
    });

    group('hasVowels', () {
      test('Text contains at least one vowel, expect true', () {
        expect('Vowel'.hasVowels, isTrue);
        expect('a'.hasVowels, isTrue);
      });

      test('Text contains no vowels, expect false', () {
        expect('N Vwl'.hasVowels, isFalse);
        expect('b'.hasVowels, isFalse);
      });
    });
  });
}
