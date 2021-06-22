import 'package:flutter_pseudolocalizor/src/extensions/reg_exp_extensions.dart';
import 'package:test/test.dart';

void main() {
  group('RegExpExtensions', () {
    group('combine', () {
      test('Expect correct value', () {
        final regExp1 = RegExp('dart');
        final regExp2 = RegExp('flutter');
        expect(
          regExp1.combine(regExp2),
          RegExp('dart|flutter'),
        );
      });
    });
  });
}
