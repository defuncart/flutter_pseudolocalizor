import 'package:flutter_pseudolocalizor/src/configs/blocks/latin_extended_a.dart';
import 'package:flutter_pseudolocalizor/src/configs/blocks/latin_extended_b.dart';
import 'package:flutter_pseudolocalizor/src/configs/blocks/latin_extended_c.dart';
import 'package:flutter_pseudolocalizor/src/configs/blocks/latin_supplement.dart';
import 'package:flutter_pseudolocalizor/src/configs/blocks/superscripts_subscripts.dart';
import 'package:flutter_pseudolocalizor/src/enums/unicode_block.dart';
import 'package:flutter_pseudolocalizor/src/extensions/unicode_block_extensions.dart';
import 'package:test/test.dart';

void main() {
  group('UnicodeBlockExtensions', () {
    group('specialCharacters', () {
      test('Expect correct value for each SupportedLanguage', () {
        expect(
          UnicodeBlock.latinSupplement.specialCharacters,
          LatinSupplement.specialCharacters,
        );
        expect(
          UnicodeBlock.latinExtendedA.specialCharacters,
          LatinExtendedA.specialCharacters,
        );
        expect(
          UnicodeBlock.latinExtendedB.specialCharacters,
          LatinExtendedB.specialCharacters,
        );
        expect(
          UnicodeBlock.latinExtendedC.specialCharacters,
          LatinExtendedC.specialCharacters,
        );
        expect(
          UnicodeBlock.superscriptsSubscripts.specialCharacters,
          SuperscriptsSubscripts.specialCharacters,
        );
      });
    });

    group('mappingCharacters', () {
      test('Expect correct value for each SupportedLanguage', () {
        expect(
          UnicodeBlock.latinSupplement.mappingCharacters,
          LatinSupplement.mappingCharacters,
        );
        expect(
          UnicodeBlock.latinExtendedA.mappingCharacters,
          LatinExtendedA.mappingCharacters,
        );
        expect(
          UnicodeBlock.latinExtendedB.mappingCharacters,
          LatinExtendedB.mappingCharacters,
        );
        expect(
          UnicodeBlock.latinExtendedC.mappingCharacters,
          LatinExtendedC.mappingCharacters,
        );
        expect(
          UnicodeBlock.superscriptsSubscripts.mappingCharacters,
          SuperscriptsSubscripts.mappingCharacters,
        );
      });
    });
  });
}
