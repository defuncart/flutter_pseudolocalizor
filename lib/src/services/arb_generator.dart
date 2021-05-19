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
      final shouldReplace =
          !(packageSettings.keysToIgnore?.contains(key) ?? false);
      if (shouldReplace) {
        final String value = arbContents[key];
        String pseudoText;

        if (_regExPluralSelect.hasMatch(value)) {
          pseudoText = value;

          // final matches = _regExFnComponent.allMatches(value);
          final matches = _matches(value);
          for (final match in matches) {
            final psuedoSelect = PseudoGenerator.generatePseudoTranslation(
              match.text,
              languageToGenerate: null,
              useBrackets: packageSettings.useBrackets,
              textExpansionFormat: packageSettings.textExpansionFormat,
              textExpansionRate: packageSettings.textExpansionRatio,
              // patternToIgnore: packageSettings.patternToIgnore,
              patternToIgnore: _regExVariableName,
            );

            pseudoText = pseudoText.replaceFirst(
              match.function,
              match.function.replaceAll(match.text, psuedoSelect),
            );
          }
        } else {
          pseudoText = PseudoGenerator.generatePseudoTranslation(
            value,
            languageToGenerate: null,
            useBrackets: packageSettings.useBrackets,
            textExpansionFormat: packageSettings.textExpansionFormat,
            textExpansionRate: packageSettings.textExpansionRatio,
            // patternToIgnore: packageSettings.patternToIgnore,
            patternToIgnore: _regExVariableName,
          );
        }

        arbContents[key] = pseudoText;
      }
    }

    final encoder = JsonEncoder.withIndent('  ');
    return encoder.convert(arbContents);
  }

  /// TODO determine matches basic on RegExp and funky logic
  /// only works when variable is at end of statement
  static Iterable<_Match> _matches(String value) {
    final returnValue = <_Match>[];

    final matchesWithoutVariables = _regExFnComponent.allMatches(value);
    for (final match in matchesWithoutVariables) {
      returnValue.add(
        _Match(function: match.group(1)!, text: match.group(2)!),
      );
    }

    final exps = <String>[];
    for (final match in matchesWithoutVariables) {
      if (match.groupCount > 0) {
        exps.add(match.group(1)!);
      }
    }

    final matchAllCasesExtraBracketEnd =
        RegExp(r'([a-z_]\w*\{.*\})').allMatches(value);
    if (matchAllCasesExtraBracketEnd.isNotEmpty) {
      for (final match in matchAllCasesExtraBracketEnd) {
        if (match.groupCount > 0) {
          var function = match.group(1)!;
          exps.forEach((exp) => function = function.replaceAll(exp, ''));
          function = function.substring(0, function.length - 1);
          function = function.trim();

          if (function.isNotEmpty) {
            returnValue.add(
              _Match(
                function: function,
                text: RegExp(r'\{(.*)\}').allMatches(function).first.group(1)!,
              ),
            );
          }
        }
      }
    }

    return returnValue;
  }
}

class _Match {
  const _Match({
    required this.function,
    required this.text,
  });

  final String function;
  final String text;
}
