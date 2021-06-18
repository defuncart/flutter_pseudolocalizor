/// Settings for SupportedLanguage.tr
abstract class TR {
  /// An array of special characters
  static const specialCharacters = [
    'ç',
    'ş',
    'ğ',
    'i',
    'ı',
    'ö',
    'ü',
    'Ç',
    'Ş',
    'Ğ',
    'İ',
    'I',
    'Ö',
    'Ü',
  ];

  /// A dictionary of mapping characters
  static const mappingCharacters = {
    'c': ['ç'],
    'C': ['Ç'],
    's': ['ş'],
    'S': ['Ş'],
    'g': ['ğ'],
    'G': ['Ğ'],
    'i': ['i', 'ı'],
    'I': ['İ', 'I'],
    'o': ['ö'],
    'O': ['Ö'],
    'u': ['ü'],
    'U': ['Ü'],
  };
}
