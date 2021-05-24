import 'package:flutter_pseudolocalizor/flutter_pseudolocalizor.dart';
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
      replaceBase: null,
      languagesToGenerate: ['de'],
      useBrackets: null,
      textExpansionFormat: null,
      textExpansionRatio: null,
      csvSettings: null,
      patternsToIgnore: null,
      keysToIgnore: null,
    );

    expect(packageSettings.inputFilepath, isNotNull);
    expect(packageSettings.replaceBase, isNotNull);
    expect(packageSettings.languagesToGenerate, isNotNull);
    expect(packageSettings.useBrackets, isNotNull);
    expect(packageSettings.textExpansionFormat, isNotNull);
    expect(packageSettings.textExpansionRatio, isNull);
    expect(packageSettings.csvSettings, isNotNull);
    expect(packageSettings.patternToIgnore, isNull);
    expect(packageSettings.keysToIgnore, isNull);
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
