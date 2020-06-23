import '../../enums/supported_language.dart';

/// Language settings for SupportedLanguage.es
class ES {
  /// The language
  static const language = SupportedLanguage.es;

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
