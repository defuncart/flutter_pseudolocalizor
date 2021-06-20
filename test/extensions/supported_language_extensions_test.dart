import 'package:flutter_pseudolocalizor/src/configs/languages/de.dart';
import 'package:flutter_pseudolocalizor/src/configs/languages/es.dart';
import 'package:flutter_pseudolocalizor/src/configs/languages/fr.dart';
import 'package:flutter_pseudolocalizor/src/configs/languages/it.dart';
import 'package:flutter_pseudolocalizor/src/configs/languages/pl.dart';
import 'package:flutter_pseudolocalizor/src/configs/languages/pt.dart';
import 'package:flutter_pseudolocalizor/src/configs/languages/ru.dart';
import 'package:flutter_pseudolocalizor/src/configs/languages/tr.dart';
import 'package:flutter_pseudolocalizor/src/enums/supported_language.dart';
import 'package:flutter_pseudolocalizor/src/extensions/supported_language_extensions.dart';
import 'package:test/test.dart';

void main() {
  group('SupportedLanguageExtensions', () {
    group('specialCharacters', () {
      test('Expect correct value for each SupportedLanguage', () {
        expect(SupportedLanguage.de.specialCharacters, DE.specialCharacters);
        expect(SupportedLanguage.es.specialCharacters, ES.specialCharacters);
        expect(SupportedLanguage.fr.specialCharacters, FR.specialCharacters);
        expect(SupportedLanguage.it.specialCharacters, IT.specialCharacters);
        expect(SupportedLanguage.pl.specialCharacters, PL.specialCharacters);
        expect(SupportedLanguage.pt.specialCharacters, PT.specialCharacters);
        expect(SupportedLanguage.ru.specialCharacters, RU.specialCharacters);
        expect(SupportedLanguage.tr.specialCharacters, TR.specialCharacters);
      });
    });

    group('mappingCharacters', () {
      test('Expect correct value for each SupportedLanguage', () {
        expect(SupportedLanguage.de.mappingCharacters, DE.mappingCharacters);
        expect(SupportedLanguage.es.mappingCharacters, ES.mappingCharacters);
        expect(SupportedLanguage.fr.mappingCharacters, FR.mappingCharacters);
        expect(SupportedLanguage.it.mappingCharacters, IT.mappingCharacters);
        expect(SupportedLanguage.pl.mappingCharacters, PL.mappingCharacters);
        expect(SupportedLanguage.pt.mappingCharacters, PT.mappingCharacters);
        expect(SupportedLanguage.ru.mappingCharacters, RU.mappingCharacters);
        expect(SupportedLanguage.tr.mappingCharacters, TR.mappingCharacters);
      });
    });
  });
}
