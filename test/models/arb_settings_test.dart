import 'package:flutter_pseudolocalizor/flutter_pseudolocalizor.dart';
import 'package:test/test.dart';

void main() {
  test('When constructor params are null, expect defaults', () {
    final csvSettings = ARBSettings(
      outputDirectory: null,
    );

    expect(csvSettings.outputDirectory, isNull);
  });

  test('Expect toString is overridden', () {
    final csvSettings = ARBSettings();

    expect(csvSettings.toString(), isNot("Instance of 'ARBSettings'"));
  });
}
