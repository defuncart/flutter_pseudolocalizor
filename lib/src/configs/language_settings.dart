import 'package:meta/meta.dart';

import '../enums/unicode_block.dart';
import 'blocks/latin_extended_a.dart';
import 'blocks/latin_supplement.dart';
import 'blocks/superscripts_subscripts.dart';
import 'languages/latin_extended.dart';

/// A config of language settings for the package
class LanguageSettings {
  /// A fallback value for special characters
  static List<String> get fallbackSpecialCharacters =>
      LatinExtended.specialCharacters;

  /// A fallback value for mapping characters
  static Map<String, List<String>> get fallbackMappingCharacters =>
      LatinExtended.mappingCharacters;
}

abstract class Fallback {
  /// A map of special characters to supported language
  @visibleForTesting
  static const mapSpecialCharacters = {
    UnicodeBlock.latinSupplement: LatinSupplement.specialCharacters,
    UnicodeBlock.latinExtendedA: LatinExtendedA.specialCharacters,
    UnicodeBlock.latinExtendedB: <String>[],
    UnicodeBlock.superscriptsSubscripts:
        SuperscriptsSubscripts.specialCharacters,
  };

  /// A map of mapping characters to supported language
  @visibleForTesting
  static const mapMappingCharacters = {
    UnicodeBlock.latinSupplement: LatinSupplement.mappingCharacters,
    UnicodeBlock.latinExtendedA: LatinExtendedA.mappingCharacters,
    UnicodeBlock.latinExtendedB: <String, List<String>>{},
    UnicodeBlock.superscriptsSubscripts:
        SuperscriptsSubscripts.mappingCharacters,
  };

  static List<String> specialCharacters({
    List<UnicodeBlock> blocks = UnicodeBlock.values,
  }) {
    if (blocks.isEmpty) {
      throw ArgumentError('Expected blocks to be non-empty');
    }

    return blocks
        .map((block) => mapSpecialCharacters[block]!)
        .expand((element) => element)
        .toList(growable: false);
  }

  static Map<String, List<String>> mappingCharacters({
    List<UnicodeBlock> blocks = UnicodeBlock.values,
  }) {
    if (blocks.isEmpty) {
      throw ArgumentError('Expected blocks to be non-empty');
    }

    var returnMap = <String, List<String>>{};
    for (final block in blocks) {
      for (final kvp in mapMappingCharacters[block]!.entries) {
        returnMap[kvp.key] = [
          if (returnMap.containsKey(kvp.key)) ...returnMap[kvp.key]!,
          ...kvp.value,
        ];
      }
    }

    return returnMap;
  }
}
