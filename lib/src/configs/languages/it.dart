/// Settings for SupportedLanguage.it
abstract class IT {
  /// An array of special characters
  static const specialCharacters = [
    'à',
    'è',
    'é',
    'ì',
    'ò',
    'ù',
    'À',
    'È',
    'É',
    'Ì',
    'Ò',
    'Ù',
  ];

  /// A dictionary of mapping characters
  static const mappingCharacters = {
    'a': ['à'],
    'A': ['À'],
    'e': ['è', 'é'],
    'E': ['È', 'É'],
    'i': ['ì'],
    'I': ['Ì'],
    'o': ['ò'],
    'O': ['Ò'],
    'u': ['ù'],
    'U': ['Ù'],
  };
}
