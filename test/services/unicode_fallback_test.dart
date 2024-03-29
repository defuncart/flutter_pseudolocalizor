import 'package:collection/collection.dart';
import 'package:flutter_pseudolocalizor/src/enums/unicode_block.dart';
import 'package:flutter_pseudolocalizor/src/extensions/unicode_block_extensions.dart';
import 'package:flutter_pseudolocalizor/src/services/unicode_fallback.dart';
import 'package:test/test.dart';

void main() {
  group('$UnicodeFallback', () {
    group('specialCharacters', () {
      test('When blocks is empty, expect argument error', () {
        expect(
          () => UnicodeFallback.specialCharacters(blocks: []),
          throwsArgumentError,
        );
      });

      test('For each block, expect their own chars', () {
        for (final block in UnicodeBlock.values) {
          final specialCharacters = UnicodeFallback.specialCharacters(blocks: [
            block,
          ]);

          expect(
            ListEquality().equals(
              specialCharacters,
              block.specialCharacters,
            ),
            isTrue,
          );
        }
      });

      test('', () {
        final specialCharacters = UnicodeFallback.specialCharacters(blocks: [
          UnicodeBlock.latinSupplement,
          UnicodeBlock.latinExtendedA,
        ]);

        expect(
          ListEquality().equals(
            specialCharacters,
            [
              '¡',
              '¢',
              '£',
              '¤',
              '¥',
              '¦',
              '§',
              '¨',
              '©',
              '«',
              '¬',
              '®',
              '¯',
              '±',
              '´',
              'µ',
              '¶',
              '·',
              '¸',
              '»',
              '¼',
              '½',
              '¾',
              '¿',
              'À',
              'Á',
              'Â',
              'Ã',
              'Ä',
              'Å',
              'Æ',
              'Ç',
              'È',
              'É',
              'Ê',
              'Ë',
              'Ì',
              'Í',
              'Î',
              'Ï',
              'Ð',
              'Ñ',
              'Ò',
              'Ó',
              'Ô',
              'Õ',
              'Ö',
              '×',
              'Ø',
              'Ù',
              'Ú',
              'Û',
              'Ü',
              'Ý',
              'Þ',
              'ß',
              'à',
              'á',
              'â',
              'ã',
              'ä',
              'å',
              'æ',
              'ç',
              'è',
              'é',
              'ê',
              'ë',
              'ì',
              'í',
              'î',
              'ï',
              'ð',
              'ñ',
              'ò',
              'ó',
              'ô',
              'õ',
              'ö',
              '÷',
              'ø',
              'ù',
              'ú',
              'û',
              'ü',
              'ý',
              'þ',
              'ÿ',
              'ā',
              'ă',
              'ą',
              'ć',
              'ĉ',
              'ċ',
              'č',
              'ď',
              'đ',
              'ē',
              'ĕ',
              'ė',
              'ę',
              'ě',
              'ĝ',
              'ğ',
              'ġ',
              'ģ',
              'ĥ',
              'ħ',
              'ĩ',
              'ī',
              'ĭ',
              'į',
              'ı',
              'ĳ',
              'ĵ',
              'ķ',
              'ĸ',
              'ĺ',
              'ļ',
              'ľ',
              'ŀ',
              'ł',
              'ń',
              'ņ',
              'ň',
              'ŋ',
              'ō',
              'ŏ',
              'ő',
              'œ',
              'ŕ',
              'ŗ',
              'ř',
              'ś',
              'ŝ',
              'ş',
              'š',
              'ţ',
              'ť',
              'ŧ',
              'ũ',
              'ū',
              'ŭ',
              'ů',
              'ű',
              'ų',
              'ŵ',
              'ŷ',
              'ź',
              'ż',
              'ž',
              'ſ',
              'Ā',
              'Ă',
              'Ą',
              'Ć',
              'Ĉ',
              'Ċ',
              'Č',
              'Ď',
              'Đ',
              'Ē',
              'Ĕ',
              'Ė',
              'Ę',
              'Ě',
              'Ĝ',
              'Ğ',
              'Ġ',
              'Ģ',
              'Ĥ',
              'Ħ',
              'Ĩ',
              'Ī',
              'Ĭ',
              'Į',
              'İ',
              'Ĳ',
              'Ĵ',
              'Ķ',
              'Ĺ',
              'Ļ',
              'Ľ',
              'Ŀ',
              'Ł',
              'Ń',
              'Ņ',
              'Ň',
              'Ŋ',
              'Ō',
              'Ŏ',
              'Ő',
              'Œ',
              'Ŕ',
              'Ŗ',
              'Ř',
              'Ś',
              'Ŝ',
              'Ş',
              'Š',
              'Ţ',
              'Ť',
              'Ŧ',
              'Ũ',
              'Ū',
              'Ŭ',
              'Ů',
              'Ű',
              'Ų',
              'Ŵ',
              'Ŷ',
              'Ÿ',
              'Ź',
              'Ż',
              'Ž',
            ],
          ),
          isTrue,
        );
      });
    });

    group('mappingCharacters', () {
      test('When blocks is empty, expect argument error', () {
        expect(
          () => UnicodeFallback.mappingCharacters(blocks: []),
          throwsArgumentError,
        );
      });

      test('For each block, expect their own mapping chars', () {
        for (final block in UnicodeBlock.values) {
          final mappingCharacters = UnicodeFallback.mappingCharacters(blocks: [
            block,
          ]);

          expect(
            DeepCollectionEquality().equals(
              mappingCharacters,
              block.mappingCharacters,
            ),
            isTrue,
          );
        }
      });

      test('', () {
        final mappingCharacters = UnicodeFallback.mappingCharacters(blocks: [
          UnicodeBlock.latinSupplement,
          UnicodeBlock.latinExtendedA,
        ]);

        expect(
          mappingCharacters,
          {
            'a': ['à', 'á', 'â', 'ã', 'ä', 'å', 'æ', 'ā', 'ă', 'ą'],
            'A': ['À', 'Á', 'Â', 'Ã', 'Ä', 'Å', 'Æ', 'Ā', 'Ă', 'Ą'],
            'b': ['ß'],
            'c': ['ç', '¢', '©', 'ć', 'ĉ', 'ċ', 'č'],
            'C': ['Ç', 'Ć', 'Ĉ', 'Ċ', 'Č'],
            'D': ['Ð', 'Ď', 'Đ'],
            'e': ['è', 'é', 'ê', 'ë', 'ē', 'ĕ', 'ė', 'ę', 'ě'],
            'E': ['È', 'É', 'Ê', 'Ë', 'Ē', 'Ĕ', 'Ė', 'Ę', 'Ě'],
            'i': ['ì', 'í', 'î', 'ï', 'ĩ', 'ī', 'ĭ', 'į', 'ı', 'ĳ'],
            'I': ['Ì', 'Í', 'Î', 'Ï', 'Ĩ', 'Ī', 'Ĭ', 'Į', 'İ', 'Ĳ'],
            'n': ['ñ', 'ń', 'ņ', 'ň', 'ŋ'],
            'N': ['Ñ', 'Ń', 'Ņ', 'Ň', 'Ŋ'],
            'o': ['ð', 'ò', 'ó', 'ô', 'õ', 'ö', 'ø', 'ō', 'ŏ', 'ő', 'œ'],
            'O': ['Ò', 'Ó', 'Ô', 'Õ', 'Ö', 'Ø', 'Ō', 'Ŏ', 'Ő', 'Œ'],
            'p': ['þ'],
            'P': ['Þ'],
            'u': ['ù', 'ú', 'û', 'ü', 'µ', 'ũ', 'ū', 'ŭ', 'ů', 'ű', 'ų'],
            'U': ['Ù', 'Ú', 'Û', 'Ü', 'Ũ', 'Ū', 'Ŭ', 'Ů', 'Ű', 'Ų'],
            'x': ['×'],
            'y': ['ý', 'ŷ'],
            'Y': ['Ý', '¥', 'Ŷ', 'Ÿ'],
            '!': ['¡'],
            '?': ['¿'],
            'd': ['ď', 'đ'],
            'f': ['ſ'],
            'g': ['ĝ', 'ğ', 'ġ', 'ģ'],
            'G': ['Ĝ', 'Ğ', 'Ġ', 'Ģ'],
            'h': ['ĥ', 'ħ'],
            'H': ['Ĥ', 'Ħ'],
            'j': ['ĵ'],
            'J': ['Ĵ'],
            'k': ['ķ', 'ĸ'],
            'K': ['Ķ'],
            'l': ['ĺ', 'ļ', 'ľ', 'ŀ', 'ł'],
            'L': ['Ĺ', 'Ļ', 'Ľ', 'Ŀ', 'Ł'],
            'r': ['®', 'ŕ', 'ŗ', 'ř'],
            'R': ['Ŕ', 'Ŗ', 'Ř'],
            's': ['ś', 'ŝ', 'ş', 'š'],
            'S': ['§', 'Ś', 'Ŝ', 'Ş', 'Š'],
            't': ['ţ', 'ť', 'ŧ'],
            'T': ['Ţ', 'Ť', 'Ŧ'],
            'w': ['ŵ'],
            'W': ['Ŵ'],
            'z': ['ź', 'ż', 'ž'],
            'Z': ['Ź', 'Ż', 'Ž']
          },
        );
      });
    });
  });
}
