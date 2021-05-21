extension StringExtensions on String {
  static const _vowels = ['a', 'e', 'i', 'o', 'u', 'y'];

  /// Determines if a String is a vowel
  ///
  /// Assumes that the String has a single character
  ///
  /// Note that y is also considered a vowel
  bool get isVowel {
    if (length != 1) {
      throw ArgumentError('$this is invalid, expected single character');
    }

    return _vowels.contains(toLowerCase());
  }
}
