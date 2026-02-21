import '../configs/blocks/latin_extended_a.dart';
import '../configs/blocks/latin_extended_b.dart';
import '../configs/blocks/latin_extended_c.dart';
import '../configs/blocks/latin_supplement.dart';
import '../configs/blocks/superscripts_subscripts.dart';
import '../enums/unicode_block.dart';

extension UnicodeBlockExtensions on UnicodeBlock {
  /// An array of special characters
  List<String> get specialCharacters => switch (this) {
        UnicodeBlock.latinSupplement => LatinSupplement.specialCharacters,
        UnicodeBlock.latinExtendedA => LatinExtendedA.specialCharacters,
        UnicodeBlock.latinExtendedB => LatinExtendedB.specialCharacters,
        UnicodeBlock.latinExtendedC => LatinExtendedC.specialCharacters,
        UnicodeBlock.superscriptsSubscripts =>
          SuperscriptsSubscripts.specialCharacters,
      };

  /// A dictionary of mapping characters
  Map<String, List<String>> get mappingCharacters => switch (this) {
        UnicodeBlock.latinSupplement => LatinSupplement.mappingCharacters,
        UnicodeBlock.latinExtendedA => LatinExtendedA.mappingCharacters,
        UnicodeBlock.latinExtendedB => LatinExtendedB.mappingCharacters,
        UnicodeBlock.latinExtendedC => LatinExtendedC.mappingCharacters,
        UnicodeBlock.superscriptsSubscripts =>
          SuperscriptsSubscripts.mappingCharacters,
      };
}
