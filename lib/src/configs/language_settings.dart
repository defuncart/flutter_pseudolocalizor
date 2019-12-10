import 'languages/de.dart';
import 'languages/es.dart';
import 'languages/fr.dart';
import 'languages/it.dart';
import 'languages/pl.dart';
import 'languages/pt.dart';
import 'languages/ru.dart';
import 'languages/tr.dart';
import 'languages/latin_extended.dart';
import '../enums/supported_language.dart';

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
