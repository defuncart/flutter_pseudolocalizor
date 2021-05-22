extension StringExtensions on String {
  static const _vowels = ['a', 'e', 'i', 'o', 'u'];

  /// Determines if a String is a vowel
  ///
  /// Throws [ArgumentError] when String is not a single character
  bool get isVowel {
    if (length != 1) {
      throw ArgumentError('$this is invalid, expected single character');
    }

    return _vowels.contains(toLowerCase());
  }
}
