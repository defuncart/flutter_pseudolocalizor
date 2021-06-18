/// Settings for SupportedLanguage.es
abstract class ES {
  /// An array of special characters
  static const specialCharacters = [
    'á',
    'é',
    'í',
    'ó',
    'ú',
    'ü',
    'ñ',
    'Á',
    'É',
    'Í',
    'Ó',
    'Ú',
    'Ü',
    'Ñ',
    '¿',
    '¡',
  ];

  /// A dictionary of mapping characters
  static const mappingCharacters = {
    'a': ['á'],
    'A': ['Á'],
    'e': ['é'],
    'E': ['É'],
    'i': ['í'],
    'I': ['Í'],
    'o': ['ó'],
    'O': ['Ó'],
    'u': ['ú', 'ü'],
    'U': ['Ú', 'Ü'],
    'n': ['ñ'],
    'N': ['Ñ'],
  };
}
