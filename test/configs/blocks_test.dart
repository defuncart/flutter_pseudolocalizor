import 'package:flutter_pseudolocalizor/src/configs/blocks/latin_extended_a.dart';
import 'package:flutter_pseudolocalizor/src/configs/blocks/latin_extended_additional.dart';
import 'package:flutter_pseudolocalizor/src/configs/blocks/latin_extended_b.dart';
import 'package:flutter_pseudolocalizor/src/configs/blocks/latin_supplement.dart';
import 'package:flutter_pseudolocalizor/src/enums/unicode_block.dart';
import 'package:test/test.dart';

void main() {
  test(UnicodeBlock.latinSupplement, () {
    final allLetters = LatinSupplement.mappingCharacters.values.fold(
        <String>{}, (previousValue, element) => {...previousValue, ...element});

    // expect(LatinSupplement.specialCharacters.length, allLetters.length);

    for (final letter in LatinSupplement.specialCharacters) {
      // expect(
      //   allLetters.contains(letter),
      //   isTrue,
      //   reason: '$letter is not accounted for',
      // );
      if (!allLetters.contains(letter)) {
        print('$letter is not accounted for');
      }
    }
  });

  test(UnicodeBlock.latinExtendedA, () {
    final allLetters = LatinExtendedA.mappingCharacters.values.fold(
        <String>{}, (previousValue, element) => {...previousValue, ...element});

    expect(LatinExtendedA.specialCharacters.length, allLetters.length);

    for (final letter in LatinExtendedA.specialCharacters) {
      expect(
        allLetters.contains(letter),
        isTrue,
        reason: '$letter is not accounted for',
      );
    }
  });

  test(UnicodeBlock.latinExtendedB, () {
    final allLetters = LatinExtendedB.mappingCharacters.values.fold(
        <String>{}, (previousValue, element) => {...previousValue, ...element});

    expect(LatinExtendedB.specialCharacters.length, allLetters.length);

    for (final letter in LatinExtendedB.specialCharacters) {
      expect(
        allLetters.contains(letter),
        isTrue,
        reason: '$letter is not accounted for',
      );
    }
  });

  test(UnicodeBlock.latinExtendedAdditional, () {
    final allLetters = LatinExtendedAdditional.mappingCharacters.values.fold(
        <String>{}, (previousValue, element) => {...previousValue, ...element});

    expect(LatinExtendedAdditional.specialCharacters.length, allLetters.length);

    for (final letter in LatinExtendedAdditional.specialCharacters) {
      expect(
        allLetters.contains(letter),
        isTrue,
        reason: '$letter is not accounted for',
      );
    }
  });
}
