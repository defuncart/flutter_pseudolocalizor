import 'dart:convert';
import 'dart:io';

import '../enums/supported_language.dart';
import '../extensions/reg_exp_extensions.dart';
import '../models/package_settings.dart';
import 'pseudo_generator.dart';

final _regExVariableName = RegExp(r'\{[a-z_]\w*\}');

/// Generates pseudo localizations for an arb file
class ARBGenerator {
  /// Generates pseudo localizations with a given [file] and [packageSettings]
  static String generate(
    File file,
    PackageSettings packageSettings, {
    SupportedLanguage? supportedLanguage,
  }) {
    final pseudoGenerator = PseudoGenerator(seed: packageSettings.seed);

    // decode arb into a map
    final stringContents = file.readAsStringSync();
    final arbContents = json.decode(stringContents);

    // determine keys
    final keys = arbContents.keys.where((key) => !key.startsWith('@')).toList()
      ..sort();
    if (keys.isEmpty) {
      print('Error! No keys found!');
      exit(0);
    }

    if (supportedLanguage != null) {
      arbContents['@@locale'] = supportedLanguage.name;
    }

    for (final key in keys) {
      final shouldReplace =
          !(packageSettings.keysToIgnore?.contains(key) ?? false);
      if (shouldReplace) {
        final String value = arbContents[key];

        final patternToIgnore = packageSettings.patternToIgnore != null
            ? _regExVariableName.combine(packageSettings.patternToIgnore!)
            : _regExVariableName;

        final pseudoText = _isSelectOrPlural(value)
            ? _parseSelectPluralIcuString(
                value,
                (text) => pseudoGenerator.generatePseudoTranslation(
                  text,
                  languageToGenerate: supportedLanguage,
                  unicodeBlocks: packageSettings.unicodeBlocks,
                  useBrackets: packageSettings.useBrackets,
                  textExpansionFormat: packageSettings.textExpansionFormat,
                  textExpansionRate: packageSettings.textExpansionRatio,
                  patternToIgnore: patternToIgnore,
                ),
              )
            : pseudoGenerator.generatePseudoTranslation(
                value,
                languageToGenerate: supportedLanguage,
                unicodeBlocks: packageSettings.unicodeBlocks,
                useBrackets: packageSettings.useBrackets,
                textExpansionFormat: packageSettings.textExpansionFormat,
                textExpansionRate: packageSettings.textExpansionRatio,
                patternToIgnore: patternToIgnore,
              );

        arbContents[key] = pseudoText;
      }
    }

    final encoder = JsonEncoder.withIndent('  ');
    return encoder.convert(arbContents);
  }

  // Previously a regex was used to parse plural, select ICU strings
  // This results in some issues with nested variables
  // Manually parsing the string leads to more predictable results
  static String _parseSelectPluralIcuString(
    String input,
    String Function(String) onGenerate,
  ) {
    final buffer = StringBuffer();
    int i = 0;

    while (i < input.length) {
      if (input[i] != '{') {
        int start = i;
        while (i < input.length && input[i] != '{') {
          i++;
        }
        buffer.write(onGenerate(input.substring(start, i)));
        continue;
      }

      int start = i;
      int depth = 0;
      while (i < input.length) {
        if (input[i] == '{') {
          depth++;
        } else if (input[i] == '}') {
          depth--;
        }
        i++;
        if (depth == 0) {
          break;
        }
      }

      final block = input.substring(start, i);
      if (_isSelectOrPlural(block)) {
        buffer.write(
          _generatePseudoTranslationForPluralOrSelect(block, onGenerate),
        );
      } else {
        buffer.write(onGenerate(block));
      }
    }

    return buffer.toString();
  }

  static bool _isSelectOrPlural(String block) =>
      block.contains(', select,') || block.contains(', plural,');

  static String _generatePseudoTranslationForPluralOrSelect(
    String block,
    String Function(String) onGenerate,
  ) {
    final firstComma = block.indexOf(',');
    if (firstComma == -1) {
      return onGenerate(block);
    }

    final variable = block.substring(0, firstComma + 1);
    final rest = block.substring(firstComma + 1);

    final buffer = StringBuffer();
    buffer.write(variable);

    int i = 0;
    while (i < rest.length) {
      // copy everything until next '{'
      while (i < rest.length && rest[i] != '{') {
        buffer.write(rest[i]);
        i++;
      }
      if (i >= rest.length) break;

      // at '{', find matching '}'
      int depth = 1;
      i++; // skip opening '{'

      int valueStart = i;
      while (i < rest.length && depth > 0) {
        if (rest[i] == '{') {
          depth++;
        } else if (rest[i] == '}') {
          depth--;
        }
        i++;
      }
      int valueEnd = i - 1;

      final innerText = rest.substring(valueStart, valueEnd);
      final pseudoValue = onGenerate(innerText);

      buffer.write('{');
      buffer.write(pseudoValue);
      buffer.write('}');
    }

    return buffer.toString();
  }
}
