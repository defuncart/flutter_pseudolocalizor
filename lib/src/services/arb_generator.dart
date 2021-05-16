import 'dart:convert';
import 'dart:io';

import '../models/package_settings.dart';
import 'pseudo_generator.dart';

final _regExVariableName = RegExp(r'\{[a-z_]\w*\}');
final _regExPluralSelect = RegExp(r'\{[a-z_]\w*, (plural|select){1}, .*\}');
final _regExFnComponent = RegExp(r'([a-z_]\w*\{([a-zA-Z0-9_ ]*)\})');

/// Generates pseudo localizations for an arb file
class ARBGenerator with PseudoGenerator {
  /// Generates pseudo localizations with a given [file] and [packageSettings]
  static String? generate(
    File file,
    PackageSettings packageSettings,
  ) {
    // decode arb into a map
    final stringContents = file.readAsStringSync();
    final arbContents = json.decode(stringContents);

    // determine keys
    final keys = arbContents.keys.where((key) => !key.startsWith('@')).toList()
      ..sort();
    if (keys.isEmpty) {
      print('Error! No keys found!');
      return null;
    }

    // TODO simply base replace for now

    for (final key in keys) {
      final String value = arbContents[key];
      String pseudoText;

      if (_regExPluralSelect.hasMatch(value)) {
        pseudoText = value;

        final matches = _regExFnComponent.allMatches(value);
        for (final match in matches) {
          final psuedoSelect = PseudoGenerator.generatePseudoTranslation(
            match.group(2)!,
            languageToGenerate: null,
            useBrackets: packageSettings.useBrackets,
            textExpansionRate: packageSettings.textExpansionRatio,
            // patternToIgnore: packageSettings.patternToIgnore,
            patternToIgnore: _regExVariableName,
          );

          pseudoText = pseudoText.replaceFirst(
            match.group(1)!,
            match.group(1)!.replaceAll(match.group(2)!, psuedoSelect),
          );
        }
      } else {
        pseudoText = PseudoGenerator.generatePseudoTranslation(
          value,
          languageToGenerate: null,
          useBrackets: packageSettings.useBrackets,
          textExpansionRate: packageSettings.textExpansionRatio,
          // patternToIgnore: packageSettings.patternToIgnore,
          patternToIgnore: _regExVariableName,
        );
      }

      arbContents[key] = pseudoText;
    }

    final encoder = JsonEncoder.withIndent('  ');
    return encoder.convert(arbContents);
  }
}
