import 'package:flutter_pseudolocalizor/flutter_pseudolocalizor.dart';
import 'package:flutter_pseudolocalizor/src/enums/supported_language.dart';
import 'package:flutter_pseudolocalizor/src/enums/text_expansion_format.dart';
import 'package:test/test.dart';

void main() {
  test('When nullable constructor params are null, expect defaults', () {
    final packageSettings = PackageSettings(
      inputFilepath: 'loca.csv',
      replaceBase: null,
      languagesToGenerate: null,
      useBrackets: null,
      textExpansionFormat: null,
      textExpansionRatio: null,
      csvSettings: null,
      patternsToIgnore: null,
      keysToIgnore: null,
    );

    expect(packageSettings, isNotNull);
    expect(packageSettings.inputFilepath, 'loca.csv');
    expect(packageSettings.replaceBase, isNotNull);
    expect(packageSettings.languagesToGenerate, isNull);
    expect(packageSettings.useBrackets, isNotNull);
    expect(packageSettings.textExpansionFormat, isNotNull);
    expect(packageSettings.textExpansionRatio, isNull);
    expect(packageSettings.csvSettings, isNotNull);
    expect(packageSettings.patternToIgnore, isNull);
    expect(packageSettings.keysToIgnore, isNull);
  });

  test('When languagesToGenerate constructor param non-null, expect given', () {
    final packageSettings = PackageSettings(
      inputFilepath: 'loca.csv',
      replaceBase: true,
      languagesToGenerate: ['de'],
      useBrackets: true,
      textExpansionFormat: 'append',
      textExpansionRatio: 1.5,
      csvSettings: CSVSettings(),
      patternsToIgnore: ['Flutter'],
      keysToIgnore: ['myKey'],
    );

    expect(packageSettings.inputFilepath, 'loca.csv');
    expect(packageSettings.replaceBase, isTrue);
    expect(packageSettings.languagesToGenerate, [SupportedLanguage.de]);
    expect(packageSettings.useBrackets, true);
    expect(packageSettings.textExpansionFormat, TextExpansionFormat.append);
    expect(packageSettings.textExpansionRatio, 1.5);
    expect(packageSettings.csvSettings, isNotNull);
    expect(packageSettings.patternToIgnore, RegExp(r'Flutter'));
    expect(packageSettings.keysToIgnore, ['myKey']);
  });

  test('Expect toString is overridden', () {
    final packageSettings = PackageSettings(
      inputFilepath: 'loca.csv',
      replaceBase: null,
      languagesToGenerate: null,
      useBrackets: null,
      textExpansionFormat: null,
      textExpansionRatio: null,
      csvSettings: null,
      patternsToIgnore: null,
      keysToIgnore: null,
    );

    expect(packageSettings.toString(), isNot("Instance of 'PackageSettings'"));
  });
}
