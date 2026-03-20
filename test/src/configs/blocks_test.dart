import 'package:flutter_pseudolocalizor/src/configs/blocks/latin_extended_additional.dart';
import 'package:flutter_pseudolocalizor/src/enums/unicode_block.dart';
import 'package:test/test.dart';

void main() {
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
