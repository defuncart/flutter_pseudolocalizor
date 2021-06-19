import 'dart:convert';
import 'dart:io';

import '../enums/supported_language.dart';
import '../models/package_settings.dart';
import '../utils/utils.dart';
import 'pseudo_generator.dart';

final _regExVariableName = RegExp(r'\{[a-z_]\w*\}');
final _regExPluralSelect = RegExp(r'\{[a-z_]\w*, (plural|select){1}, .*\}');
final _regExFnComponent = RegExp(r'([a-z_]\w*\{([a-zA-Z0-9_ ]*)\})');

/// Generates pseudo localizations for an arb file
class ARBGenerator with PseudoGenerator {
  /// Generates pseudo localizations with a given [file] and [packageSettings]
  static String generate(
    File file,
    PackageSettings packageSettings, {
    SupportedLanguage? supportedLanguage,
  }) {
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
      arbContents['@@locale'] = Utils.describeEnum(supportedLanguage);
    }

    for (final key in keys) {
      final shouldReplace =
          !(packageSettings.keysToIgnore?.contains(key) ?? false);
      if (shouldReplace) {
        final String value = arbContents[key];
        String pseudoText;

        if (_regExPluralSelect.hasMatch(value)) {
          pseudoText = value;

          final matches = _matches(value);
          for (final match in matches) {
            final psuedoSelect = PseudoGenerator.generatePseudoTranslation(
              match.text,
              languageToGenerate: supportedLanguage,
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
            languageToGenerate: supportedLanguage,
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

    final matchAllCases =
        RegExp(r'\{[a-z_]\w*, (plural|select){1}, (.*)\}').allMatches(value);
    var matchesWithVariables = matchAllCases.first.group(2)!;
    exps.forEach((exp) =>
        matchesWithVariables = matchesWithVariables.replaceAll(exp, ''));
    matchesWithVariables = matchesWithVariables.trim();

    if (matchesWithVariables.isNotEmpty) {
      final components = matchesWithVariables.split(RegExp(r'(?<=\}\s)'));

      var function = '';
      for (final component in components) {
        function += component;
        if (function.countCurlyOpenBrackets ==
            function.countCurlyClosedBrackets) {
          returnValue.add(
            _Match(
              function: function,
              text: RegExp(r'\{(.*)\}').allMatches(function).first.group(1)!,
            ),
          );
          function = '';
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

extension on String {
  int get countCurlyOpenBrackets {
    var count = 0;
    for (var i = 0; i < length; i++) {
      if (this[i] == '{') {
        count++;
      }
    }
    return count;
  }

  int get countCurlyClosedBrackets {
    var count = 0;
    for (var i = 0; i < length; i++) {
      if (this[i] == '}') {
        count++;
      }
    }
    return count;
  }
}
