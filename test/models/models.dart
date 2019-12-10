library models;

import 'package:flutter_test/flutter_test.dart';

import '../../lib/src/models/csv_settings.dart';
import '../../lib/src/models/package_settings.dart';

void main() {
  test('PackageSettings', () {
    /// give null for all values
    var packageSettings = PackageSettings(
      inputFilepath: null,
      outputFilepath: null,
      replaceBase: null,
      languagesToGenerate: null,
      useBrackets: null,
      textExpansionRatio: null,
      csvSettings: null,
    );

    expect(packageSettings.inputFilepath, null);
    expect(packageSettings.outputFilepath, null);
    expect(packageSettings.replaceBase, isNotNull);
    expect(packageSettings.languagesToGenerate, null);
    expect(packageSettings.useBrackets, isNotNull);
    expect(packageSettings.textExpansionRatio, null);
    expect(packageSettings.csvSettings, isNotNull);

    /// give non-null for inputFilepath
    packageSettings = PackageSettings(
      inputFilepath: 'test.csv',
      outputFilepath: null,
      replaceBase: null,
      languagesToGenerate: null,
      useBrackets: null,
      textExpansionRatio: null,
      csvSettings: null,
    );

    expect(packageSettings.inputFilepath, isNotNull);
    expect(packageSettings.outputFilepath, isNotNull);
    expect(packageSettings.replaceBase, isNotNull);
    expect(packageSettings.languagesToGenerate, null);
    expect(packageSettings.useBrackets, isNotNull);
    expect(packageSettings.textExpansionRatio, null);
    expect(packageSettings.csvSettings, isNotNull);

    /// give non-null for languagesToGenerate
    packageSettings = PackageSettings(
      inputFilepath: null,
      outputFilepath: null,
      replaceBase: null,
      languagesToGenerate: ['de'],
      useBrackets: null,
      textExpansionRatio: null,
      csvSettings: null,
    );

    expect(packageSettings.inputFilepath, null);
    expect(packageSettings.outputFilepath, null);
    expect(packageSettings.replaceBase, isNotNull);
    expect(packageSettings.languagesToGenerate, isNotNull);
    expect(packageSettings.useBrackets, isNotNull);
    expect(packageSettings.textExpansionRatio, null);
    expect(packageSettings.csvSettings, isNotNull);
  });

  test('CSVSettings', () {
    /// give null for all values
    var csvSettings = CSVSettings(
      delimiter: null,
      columnIndex: null,
    );

    expect(csvSettings.delimiter, isNotNull);
    expect(csvSettings.columnIndex, isNotNull);

    /// give non-null for all values
    csvSettings = CSVSettings(
      delimiter: ',',
      columnIndex: 1,
    );

    expect(csvSettings.delimiter, isNotNull);
    expect(csvSettings.columnIndex, isNotNull);
  });
}
