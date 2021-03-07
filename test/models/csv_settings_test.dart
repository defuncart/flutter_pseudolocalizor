import 'package:flutter_pseudolocalizor/flutter_pseudolocalizor.dart';
import 'package:test/test.dart';

void main() {
  test('When constructor params are null, expect defaults', () {
    final csvSettings = CSVSettings(
      delimiter: null,
      columnIndex: null,
    );

    expect(csvSettings.delimiter, isNotNull);
    expect(csvSettings.columnIndex, isNotNull);
  });

  test('When constructor params are non-null, expect given', () {
    final csvSettings = CSVSettings(
      delimiter: ',',
      columnIndex: 1,
    );

    expect(csvSettings.delimiter, isNotNull);
    expect(csvSettings.columnIndex, isNotNull);
  });

  test('Expect toString is overridden', () {
    final csvSettings = CSVSettings(
      delimiter: null,
      columnIndex: null,
    );

    expect(csvSettings.toString(), isNot("Instance of 'CSVSettings'"));
  });
}
