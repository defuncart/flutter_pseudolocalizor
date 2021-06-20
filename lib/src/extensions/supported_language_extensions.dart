import '../configs/languages/de.dart';
import '../configs/languages/es.dart';
import '../configs/languages/fr.dart';
import '../configs/languages/it.dart';
import '../configs/languages/pl.dart';
import '../configs/languages/pt.dart';
import '../configs/languages/ru.dart';
import '../configs/languages/tr.dart';
import '../enums/supported_language.dart';

extension SupportedLanguageExtensions on SupportedLanguage {
  /// An array of special characters
  List<String> get specialCharacters {
    switch (this) {
      case SupportedLanguage.de:
        return DE.specialCharacters;
      case SupportedLanguage.es:
        return ES.specialCharacters;
      case SupportedLanguage.fr:
        return FR.specialCharacters;
      case SupportedLanguage.it:
        return IT.specialCharacters;
      case SupportedLanguage.pl:
        return PL.specialCharacters;
      case SupportedLanguage.pt:
        return PT.specialCharacters;
      case SupportedLanguage.ru:
        return RU.specialCharacters;
      case SupportedLanguage.tr:
        return TR.specialCharacters;
    }
  }

  /// A dictionary of mapping characters
  Map<String, List<String>> get mappingCharacters {
    switch (this) {
      case SupportedLanguage.de:
        return DE.mappingCharacters;
      case SupportedLanguage.es:
        return ES.mappingCharacters;
      case SupportedLanguage.fr:
        return FR.mappingCharacters;
      case SupportedLanguage.it:
        return IT.mappingCharacters;
      case SupportedLanguage.pl:
        return PL.mappingCharacters;
      case SupportedLanguage.pt:
        return PT.mappingCharacters;
      case SupportedLanguage.ru:
        return RU.mappingCharacters;
      case SupportedLanguage.tr:
        return TR.mappingCharacters;
    }
  }
}
