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
  List<String> get specialCharacters => switch (this) {
        SupportedLanguage.de => DE.specialCharacters,
        SupportedLanguage.es => ES.specialCharacters,
        SupportedLanguage.fr => FR.specialCharacters,
        SupportedLanguage.it => IT.specialCharacters,
        SupportedLanguage.pl => PL.specialCharacters,
        SupportedLanguage.pt => PT.specialCharacters,
        SupportedLanguage.ru => RU.specialCharacters,
        SupportedLanguage.tr => TR.specialCharacters,
        SupportedLanguage.zh =>
          throw StateError('$this does not use character replacement'),
      };

  /// A dictionary of mapping characters
  Map<String, List<String>> get mappingCharacters => switch (this) {
        SupportedLanguage.de => DE.mappingCharacters,
        SupportedLanguage.es => ES.mappingCharacters,
        SupportedLanguage.fr => FR.mappingCharacters,
        SupportedLanguage.it => IT.mappingCharacters,
        SupportedLanguage.pl => PL.mappingCharacters,
        SupportedLanguage.pt => PT.mappingCharacters,
        SupportedLanguage.ru => RU.mappingCharacters,
        SupportedLanguage.tr => TR.mappingCharacters,
        SupportedLanguage.zh =>
          throw StateError('$this does not use character replacement'),
      };
}
