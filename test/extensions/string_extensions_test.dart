import 'package:flutter_pseudolocalizor/src/extensions/string_extensions.dart';
import 'package:test/test.dart';

void main() {
  group('StringExtensions', () {
    group('isVowel', () {
      test('When a, e, i, o, u, y, expect true', () {
        final letters = ['a', 'e', 'i', 'o', 'u', 'y'];

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
  });
}
