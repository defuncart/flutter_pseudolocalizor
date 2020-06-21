/// A class of utils for RegExp
abstract class RegExpUtils {
  /// Combines a list of string patterns into a RegExp
  static RegExp combinePatterns(List<String> patterns) {
    if (patterns != null && patterns.length > 0) {
      final sb = StringBuffer();
      for (final pattern in patterns) {
        if (pattern != null) {
          if (sb.isNotEmpty) {
            sb.write('|');
          }
          sb.write(pattern);
        }
      }

      if (sb.isNotEmpty) {
        return RegExp(sb.toString());
      }
    }

    return null;
  }
}
