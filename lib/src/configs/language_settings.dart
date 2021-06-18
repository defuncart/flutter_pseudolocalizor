import 'package:meta/meta.dart';

import '../enums/latin_extended_block.dart';
import '../enums/supported_language.dart';
import 'languages/de.dart';
import 'languages/es.dart';
import 'languages/fr.dart';
import 'languages/it.dart';
import 'languages/latin_extended.dart';
import 'languages/pl.dart';
import 'languages/pt.dart';
import 'languages/ru.dart';
import 'languages/tr.dart';
import 'latin_extended/extended_a.dart';
import 'latin_extended/supplement.dart';

/// A config of language settings for the package
class LanguageSettings {
  /// A map of special characters to supported language
  static const specialCharacters = {
    SupportedLanguage.de: DE.specialCharacters,
    SupportedLanguage.es: ES.specialCharacters,
    SupportedLanguage.fr: FR.specialCharacters,
    SupportedLanguage.it: IT.specialCharacters,
    SupportedLanguage.pl: PL.specialCharacters,
    SupportedLanguage.pt: PT.specialCharacters,
    SupportedLanguage.ru: RU.specialCharacters,
    SupportedLanguage.tr: TR.specialCharacters,
  };

  /// A map of mapping characters to supported language
  static const mappingCharacters = {
    SupportedLanguage.de: DE.mappingCharacters,
    SupportedLanguage.es: ES.mappingCharacters,
    SupportedLanguage.fr: FR.mappingCharacters,
    SupportedLanguage.it: IT.mappingCharacters,
    SupportedLanguage.pl: PL.mappingCharacters,
    SupportedLanguage.pt: PT.mappingCharacters,
    SupportedLanguage.ru: RU.mappingCharacters,
    SupportedLanguage.tr: TR.mappingCharacters,
  };

  /// A fallback value for special characters
  static List<String> get fallbackSpecialCharacters => LatinExtended.specialCharacters;

  /// A fallback value for mapping characters
  static Map<String, List<String>> get fallbackMappingCharacters => LatinExtended.mappingCharacters;
}

abstract class Fallback {
  /// A map of special characters to supported language
  @visibleForTesting
  static const mapSpecialCharacters = {
    LatinExtendedBlock.supplement: Supplement.specialCharacters,
    LatinExtendedBlock.extendedA: ExtendedA.specialCharacters,
    LatinExtendedBlock.extendedB: <String>[],
  };

  /// A map of mapping characters to supported language
  @visibleForTesting
  static const mapMappingCharacters = {
    LatinExtendedBlock.supplement: Supplement.mappingCharacters,
    LatinExtendedBlock.extendedA: ExtendedA.mappingCharacters,
    LatinExtendedBlock.extendedB: <String, List<String>>{},
  };

  static List<String> specialCharacters({
    List<LatinExtendedBlock> blocks = LatinExtendedBlock.values,
  }) {
    if (blocks.isEmpty) {
      throw ArgumentError('Expected blocks to be non-empty');
    }

    return blocks.map((block) => mapSpecialCharacters[block]!).expand((element) => element).toList(growable: false);
  }

  static Map<String, List<String>> mappingCharacters({
    List<LatinExtendedBlock> blocks = LatinExtendedBlock.values,
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
