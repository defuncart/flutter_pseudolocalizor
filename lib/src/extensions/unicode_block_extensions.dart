import '../configs/blocks/latin_extended_a.dart';
import '../configs/blocks/latin_extended_b.dart';
import '../configs/blocks/latin_supplement.dart';
import '../configs/blocks/superscripts_subscripts.dart';
import '../enums/unicode_block.dart';

extension UnicodeBlockExtensions on UnicodeBlock {
  /// An array of special characters
  List<String> get specialCharacters {
    switch (this) {
      case UnicodeBlock.latinSupplement:
        return LatinSupplement.specialCharacters;
      case UnicodeBlock.latinExtendedA:
        return LatinExtendedA.specialCharacters;
      case UnicodeBlock.latinExtendedB:
        return LatinExtendedB.specialCharacters;
      case UnicodeBlock.superscriptsSubscripts:
        return SuperscriptsSubscripts.specialCharacters;
    }
  }

  /// A dictionary of mapping characters
  Map<String, List<String>> get mappingCharacters {
    switch (this) {
      case UnicodeBlock.latinSupplement:
        return LatinSupplement.mappingCharacters;
      case UnicodeBlock.latinExtendedA:
        return LatinExtendedA.mappingCharacters;
      case UnicodeBlock.latinExtendedB:
        return LatinExtendedB.mappingCharacters;
      case UnicodeBlock.superscriptsSubscripts:
        return SuperscriptsSubscripts.mappingCharacters;
    }
  }
}
