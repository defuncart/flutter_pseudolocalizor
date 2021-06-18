/// Settings for SupportedLanguage.de
abstract class DE {
  /// An array of special characters
  static const specialCharacters = [
    'ä',
    'ö',
    'ü',
    'ß',
    'Ä',
    'Ö',
    'Ü',
    'ẞ',
  ];

  /// A dictionary of mapping characters
  static const mappingCharacters = {
    'a': ['ä'],
    'A': ['Ä'],
    'o': ['ö'],
    'O': ['Ö'],
    'u': ['ü'],
    'U': ['Ü'],
    'b': ['ß'],
    'B': ['ẞ'],
  };
}
