import 'package:flutter_pseudolocalizor/flutter_pseudolocalizor.dart';
import 'package:test/test.dart';

void main() {
  test('When constructor params are null, expect defaults', () {
    final csvSettings = CSVSettings(
      outputFilepath: null,
      delimiter: null,
      columnIndex: null,
    );

    expect(csvSettings.outputFilepath, isNull);
    expect(csvSettings.delimiter, isNotNull);
    expect(csvSettings.columnIndex, isNotNull);
  });

  test('When constructor params are non-null, expect given', () {
    final csvSettings = CSVSettings(
      outputFilepath: 'bla.csv',
      delimiter: ',',
      columnIndex: 1,
    );

    expect(csvSettings.outputFilepath, 'bla.csv');
    expect(csvSettings.delimiter, ',');
    expect(csvSettings.columnIndex, 1);
  });

  test('Expect toString is overridden', () {
    final csvSettings = CSVSettings();

    expect(csvSettings.toString(), isNot("Instance of 'CSVSettings'"));
  });
}
