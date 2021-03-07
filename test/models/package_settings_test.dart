import 'package:flutter_pseudolocalizor/flutter_pseudolocalizor.dart';
import 'package:test/test.dart';

void main() {
  test('When nullable constructor params are null, expect defaults', () {
    final packageSettings = PackageSettings(
      inputFilepath: 'loca.csv',
      outputFilepath: null,
      replaceBase: null,
      languagesToGenerate: null,
      useBrackets: null,
      textExpansionRatio: null,
      csvSettings: null,
      patternsToIgnore: null,
      lineNumbersToIgnore: null,
    );

    expect(packageSettings, isNotNull);
    expect(packageSettings.inputFilepath, 'loca.csv');
    expect(packageSettings.outputFilepath, isNotNull);
    expect(packageSettings.replaceBase, isNotNull);
    expect(packageSettings.languagesToGenerate, isNull);
    expect(packageSettings.useBrackets, isNotNull);
    expect(packageSettings.textExpansionRatio, isNull);
    expect(packageSettings.csvSettings, isNotNull);
    expect(packageSettings.patternToIgnore, isNull);
    expect(packageSettings.lineNumbersToIgnore, isNull);
  });

  test('When languagesToGenerate constructor param non-null, expect given', () {
    final packageSettings = PackageSettings(
      inputFilepath: 'loca.csv',
      outputFilepath: null,
      replaceBase: null,
      languagesToGenerate: ['de'],
      useBrackets: null,
      textExpansionRatio: null,
      csvSettings: null,
      patternsToIgnore: null,
      lineNumbersToIgnore: null,
    );

    expect(packageSettings.inputFilepath, isNotNull);
    expect(packageSettings.outputFilepath, isNotNull);
    expect(packageSettings.replaceBase, isNotNull);
    expect(packageSettings.languagesToGenerate, isNotNull);
    expect(packageSettings.useBrackets, isNotNull);
    expect(packageSettings.textExpansionRatio, isNull);
    expect(packageSettings.csvSettings, isNotNull);
    expect(packageSettings.patternToIgnore, isNull);
    expect(packageSettings.lineNumbersToIgnore, isNull);
  });

  test('Expect toString is overridden', () {
    final packageSettings = PackageSettings(
      inputFilepath: 'loca.csv',
      outputFilepath: null,
      replaceBase: null,
      languagesToGenerate: null,
      useBrackets: null,
      textExpansionRatio: null,
      csvSettings: null,
      patternsToIgnore: null,
      lineNumbersToIgnore: null,
    );

    expect(packageSettings.toString(), isNot("Instance of 'PackageSettings'"));
  });
}
