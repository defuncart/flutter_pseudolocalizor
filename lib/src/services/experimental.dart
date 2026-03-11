import '../configs/default_settings.dart';
import '../enums/supported_language.dart';
import '../enums/text_expansion_format.dart';
import '../enums/unicode_block.dart';
import 'pseudo_generator.dart';

export '../enums/supported_language.dart';
export '../enums/text_expansion_format.dart';
export '../enums/unicode_block.dart';

extension StringPseudoExtensions on String {
  String pseudo() => StringGenerator.generate(this);
}

class StringGenerator with PseudoGenerator {
  static String generate(String baseText) {
    final settings = FlutterPseudolocalizor.settings;
    return PseudoGenerator.generatePseudoTranslation(
      baseText,
      languageToGenerate: settings.languageToGenerate,
      unicodeBlocks: settings.unicodeBlocks,
      useBrackets: settings.useBrackets,
      textExpansionFormat: settings.textExpansionFormat,
      textExpansionRate: settings.textExpansionRate,
      patternToIgnore: settings.patternToIgnore,
    );
  }
}

abstract class FlutterPseudolocalizor {
  const FlutterPseudolocalizor._();

  static FlutterPseudolocalizorSettings settings = const FlutterPseudolocalizorSettings();
}

class FlutterPseudolocalizorSettings {
  const FlutterPseudolocalizorSettings({
    this.languageToGenerate,
    this.unicodeBlocks = DefaultSettings.unicodeBlocks,
    this.useBrackets = DefaultSettings.useBrackets,
    this.textExpansionFormat = DefaultSettings.textExpansionFormat,
    this.textExpansionRate = 1.4,
    this.patternToIgnore,
  });

  /// An optional language to generate
  final SupportedLanguage? languageToGenerate;

  /// A list of unicode blocks to use
  final List<UnicodeBlock> unicodeBlocks;

  /// Whether the pseudo text should be wrapped in square brackets.
  final bool useBrackets;

  /// Which text expansion format to use.
  final TextExpansionFormat textExpansionFormat;

  final double textExpansionRate;

  final RegExp? patternToIgnore;
}
