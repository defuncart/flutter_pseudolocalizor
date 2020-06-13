/// A class of utils for RegExp
abstract class RegExpUtils {
  /// Combines a list of string patterns into a RegExp
  static RegExp combinePatterns(List<String> patterns) {
    if (patterns != null && patterns.length > 0) {
      String combinedPattern = '';
      for (int i = 0; i < patterns.length; i++) {
        if (i != 0) {
          combinedPattern += "|";
        }
        combinedPattern += patterns[i];
      }

      return RegExp(combinedPattern);
    }

    return null;
  }
}
