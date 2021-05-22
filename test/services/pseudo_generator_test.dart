import 'package:flutter_pseudolocalizor/src/services/pseudo_generator.dart';
import 'package:test/test.dart';

void main() {
  group('$PseudoGenerator', () {
    group('elongateVowels', () {
      test('When hello count = 1, expect heello', () {
        expect(
          PseudoGenerator.repeatVowels(
            'hello',
            count: 1,
          ),
          'heello',
        );
      });

      test('When hello count = 2, expect heelloo', () {
        expect(
          PseudoGenerator.repeatVowels(
            'hello',
            count: 2,
          ),
          'heelloo',
        );
      });

      test('When hello count = 3, expect heeelloo', () {
        expect(
          PseudoGenerator.repeatVowels(
            'hello',
            count: 3,
          ),
          'heeelloo',
        );
      });

      test('When hello, goodbye count = 5, expect heelloo, goooodbyye', () {
        expect(
          PseudoGenerator.repeatVowels(
            'hello, goodbye',
            count: 5,
          ),
          'heelloo, goooodbyye',
        );
      });

      test('when count < 1, input', () {
        expect(
          PseudoGenerator.repeatVowels(
            'hello',
            count: 0,
          ),
          'hello',
        );
      });
    });
  });
}
