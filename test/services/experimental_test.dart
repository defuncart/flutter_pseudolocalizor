import 'package:flutter_pseudolocalizor/src/services/experimental.dart';
import 'package:test/test.dart';

void main() {
  group('StringPseudoExtensions', () {
    test('Expect ', () async {
      print('hello'.pseudo());
      expect('hello'.pseudo(), isA<String>());
    });
  });
}
