extension RegExpExtensions on RegExp {
  /// Combines current pattern and [other] pattern into a new [RegExp]
  RegExp combine(RegExp other) => RegExp('$pattern|${other.pattern}');
}
