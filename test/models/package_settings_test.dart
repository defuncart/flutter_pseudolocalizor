import 'package:flutter_pseudolocalizor/flutter_pseudolocalizor.dart';
import 'package:flutter_pseudolocalizor/src/configs/default_settings.dart';
import 'package:flutter_pseudolocalizor/src/enums/supported_language.dart';
import 'package:flutter_pseudolocalizor/src/enums/text_expansion_format.dart';
import 'package:flutter_pseudolocalizor/src/enums/unicode_block.dart';
import 'package:test/test.dart';

void main() {
  test('When nullable constructor params are null, expect defaults', () {
    final packageSettings = PackageSettings(
      inputFilepath: 'loca.csv',
      replaceBase: null,
      unicodeBlocks: null,
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
    expect(packageSettings.unicodeBlocks, isNull);
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
      unicodeBlocks: ['latinSupplement'],
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
    expect(packageSettings.unicodeBlocks, [UnicodeBlock.latinSupplement]);
    expect(packageSettings.languagesToGenerate, [SupportedLanguage.de]);
    expect(packageSettings.useBrackets, true);
    expect(packageSettings.textExpansionFormat, TextExpansionFormat.append);
    expect(packageSettings.textExpansionRatio, 1.5);
    expect(packageSettings.csvSettings, isNotNull);
    expect(packageSettings.patternToIgnore, RegExp(r'Flutter'));
    expect(packageSettings.keysToIgnore, ['myKey']);
  });

  group('replaceBase, unicodeBlocks', () {
    test('when replaceBase is false, expect unicodeBlocks is null', () {
      final packageSettings = PackageSettings(
        inputFilepath: 'loca.csv',
        replaceBase: false,
        unicodeBlocks: ['latinSupplement'],
        languagesToGenerate: null,
        useBrackets: null,
        textExpansionFormat: null,
        textExpansionRatio: null,
        csvSettings: null,
        patternsToIgnore: null,
        keysToIgnore: null,
      );
      expect(packageSettings.replaceBase, isFalse);
      expect(packageSettings.unicodeBlocks, isNull);
    });

    test(
        'when replaceBase is true and unicodeBlocks is null, '
        'expect unicodeBlocks is default', () {
      final packageSettings = PackageSettings(
        inputFilepath: 'loca.csv',
        replaceBase: true,
        unicodeBlocks: null,
        languagesToGenerate: null,
        useBrackets: null,
        textExpansionFormat: null,
        textExpansionRatio: null,
        csvSettings: null,
        patternsToIgnore: null,
        keysToIgnore: null,
      );
      expect(packageSettings.replaceBase, isTrue);
      expect(packageSettings.unicodeBlocks, DefaultSettings.unicodeBlocks);
    });

    test(
        'when replaceBase is true and unicodeBlocks is not null, '
        'expect unicodeBlocks is parsed', () {
      final packageSettings = PackageSettings(
        inputFilepath: 'loca.csv',
        replaceBase: true,
        unicodeBlocks: ['latinSupplement'],
        languagesToGenerate: null,
        useBrackets: null,
        textExpansionFormat: null,
        textExpansionRatio: null,
        csvSettings: null,
        patternsToIgnore: null,
        keysToIgnore: null,
      );
      expect(packageSettings.replaceBase, isTrue);
      expect(packageSettings.unicodeBlocks, [UnicodeBlock.latinSupplement]);
    });
  });

  test('Expect toString is overridden', () {
    final packageSettings = PackageSettings(
      inputFilepath: 'loca.csv',
      replaceBase: null,
      unicodeBlocks: null,
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
