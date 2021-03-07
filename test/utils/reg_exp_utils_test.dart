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

  test('combinePatterns: patterns contains null values, expect null RegExp',
      () {
    final regExp = RegExpUtils.combinePatterns([null, null]);
    expect(regExp, isNull);
  });

  test('combinePatterns: Valid patterns, valid regexp', () {
    final regExp = RegExpUtils.combinePatterns(['%(\S*?)\$[ds]', 'Flutter']);
    expect(regExp, isNotNull);
    expect(regExp!.pattern, '%(\S*?)\$[ds]|Flutter');
  });

  test('combinePatterns: 2 patterns, one null, expect RegExp single pattern',
      () {
    final regExp = RegExpUtils.combinePatterns(['Flutter', null]);
    expect(regExp, isNotNull);
    expect(regExp!.pattern, 'Flutter');
  });

  test('combinePatterns: 3 patterns, one null, expect RegExp two patterns', () {
    final regExp =
        RegExpUtils.combinePatterns(['%(\S*?)\$[ds]', null, 'Flutter']);
    expect(regExp, isNotNull);
    expect(regExp!.pattern, '%(\S*?)\$[ds]|Flutter');
  });
}
