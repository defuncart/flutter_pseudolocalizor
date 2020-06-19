import 'package:flutter_pseudolocalizor/src/utils/reg_exp_utils.dart';
import 'package:test/test.dart';

void main() {
  test('combinePatterns: patterns is null, expect null RegExp', () {
    final regExp = RegExpUtils.combinePatterns(null);
    expect(regExp, isNull);
  });

  test('combinePatterns: patterns is empty, expect null RegExp', () {
    final regExp = RegExpUtils.combinePatterns([]);
    expect(regExp, isNull);
  });

  test('combinePatterns: Valid patterns, valid regexp', () {
    final regExp = RegExpUtils.combinePatterns(['%(\S*?)\$[ds]', 'Flutter']);
    expect(regExp, isNotNull);
    expect(regExp.pattern, '%(\S*?)\$[ds]|Flutter');
  });
}
