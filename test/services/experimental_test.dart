import 'package:flutter_pseudolocalizor/src/services/experimental.dart';
import 'package:test/test.dart';

void main() {
  group('StringPseudoExtensions', () {
    test('Basic test', () async {
      expect('hello'.pseudo(), isA<String>());
    });

    group('when settings are given', () {
      setUp(() {
        FlutterPseudolocalizor.settings = FlutterPseudolocalizorSettings(
          languageToGenerate: SupportedLanguage.de,
          useBrackets: false,
          textExpansionRate: 1,
        );
      });

      test('expect correct value', () {
        expect('hello'.pseudo(), 'hellö');
      });
    });
  });
}
