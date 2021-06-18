/// Settings for SupportedLanguage.pl
abstract class PL {
  /// An array of special characters
  static const specialCharacters = [
    'ą',
    'ć',
    'ę',
    'ł',
    'ń',
    'ó',
    'ś',
    'ż',
    'ź',
    'Ą',
    'Ć',
    'Ę',
    'Ł',
    'Ń',
    'Ó',
    'Ś',
    'Ż',
    'Ź',
  ];

  /// A dictionary of mapping characters
  static const mappingCharacters = {
    'a': ['ą'],
    'A': ['Ą'],
    'c': ['ć'],
    'C': ['Ć'],
    'e': ['ę'],
    'E': ['Ę'],
    'l': ['ł'],
    'L': ['Ł'],
    'n': ['ń'],
    'N': ['Ń'],
    'o': ['ó'],
    'O': ['Ó'],
    's': ['ś'],
    'S': ['Ś'],
    'z': ['ż', 'ź'],
    'Z': ['Ż', 'Ź']
  };
}
