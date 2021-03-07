/// A class of utils for RegExp
abstract class RegExpUtils {
  /// Combines a list of string patterns into a RegExp
  static RegExp? combinePatterns(List<String?>? patterns) {
    if (patterns != null && patterns.isNotEmpty) {
      final filteredPatterns = patterns.where((element) => element != null);
      final concatPattern = filteredPatterns.isNotEmpty
          ? filteredPatterns.reduce((value, element) => '$value|$element')
          : null;
      if (concatPattern != null && concatPattern.isNotEmpty) {
        return RegExp(concatPattern);
      }
    }

    return null;
  }
}
