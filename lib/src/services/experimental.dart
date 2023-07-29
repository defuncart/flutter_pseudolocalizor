import '../configs/default_settings.dart';
import '../enums/supported_language.dart';
import 'pseudo_generator.dart';

extension StringPseudoExtensions on String {
  String pseudo() => StringGenerator.generate(this);
}

class StringGenerator with PseudoGenerator {
  static String generate(String baseText) {
    return PseudoGenerator.generatePseudoTranslation(
      baseText,
      // languageToGenerate: supportedLanguage,
      languageToGenerate: SupportedLanguage.de,
      unicodeBlocks: DefaultSettings.unicodeBlocks,
      useBrackets: DefaultSettings.useBrackets,
      textExpansionFormat: DefaultSettings.textExpansionFormat,
      textExpansionRate: 1.4,
      patternToIgnore: null,
    );
  }
}
