import 'dart:io';

import 'package:flutter_pseudolocalizor/flutter_pseudolocalizor.dart';
import 'package:flutter_pseudolocalizor/src/services/csv_generator.dart';
import 'package:test/test.dart';

void main() {
  final csvFileContents = '''
key;en
title;My Title
subtitle;A subtitle
''';

  test('replaceBase', () {
    // create file
    final file = File('_.csv');
    file.writeAsStringSync(csvFileContents);

    // initialize settings
    final csvSettings = CSVSettings(
      delimiter: ';',
      columnIndex: 1,
    );
    final packageSettings = PackageSettings(
      inputFilepath: '../../example/test.csv',
      outputFilepath: null,
      replaceBase: true,
      languagesToGenerate: null,
      useBrackets: true,
      textExpansionRatio: null,
      csvSettings: csvSettings,
      patternsToIgnore: null,
      lineNumbersToIgnore: null,
    );

    final contents = CSVGenerator.generate(file, packageSettings)!;
    final rowCount = rowCountFromCSVContents(contents);
    final columnCount = columnCountFromCSVContents(contents);

    expect(rowCount, 3);
    expect(columnCount, 2);

    // clear up and delete file
    file.deleteSync();
  });

  test('languagesToGenerate', () {
    // create file
    final file = File('_.csv');
    file.writeAsStringSync(csvFileContents);

    // initialize settings
    final csvSettings = CSVSettings(
      delimiter: ';',
      columnIndex: 1,
    );
    final packageSettings = PackageSettings(
      inputFilepath: '../../example/test.csv',
      outputFilepath: null,
      replaceBase: false,
      languagesToGenerate: ['de', 'es', 'pl'],
      useBrackets: true,
      textExpansionRatio: null,
      csvSettings: csvSettings,
      patternsToIgnore: null,
      lineNumbersToIgnore: null,
    );

    final contents = CSVGenerator.generate(file, packageSettings)!;
    final rowCount = rowCountFromCSVContents(contents);
    final columnCount = columnCountFromCSVContents(contents);

    expect(rowCount, 3);
    expect(columnCount, 5);

    // clear up and delete file
    file.deleteSync();
  });
}

int rowCountFromCSVContents(String contents) => contents.split('\n').length;

int columnCountFromCSVContents(String contents) {
  final firstRow = contents.split('\n').first;
  return firstRow.split(';').length;
}
