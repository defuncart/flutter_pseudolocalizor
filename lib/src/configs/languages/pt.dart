import '../../enums/supported_language.dart';

/// Language settings for SupportedLanguage.pt
class PT {
  static const language = SupportedLanguage.pt;

  /// An array of special characters
  static const specialCharacters = [
    'à',
    'á',
    'â',
    'ã',
    'ç',
    'é',
    'ê',
    'í',
    'ó',
    'ô',
    'õ',
    'ú',
    'ü',
    'À',
    'Á',
    'Â',
    'Ã',
    'Ç',
    'É',
    'Ê',
    'Í',
    'Ó',
    'Ô',
    'Õ',
    'Ú',
    'Ü',
  ];

  /// A dictionary of mapping characters
  static const mappingCharacters = {
    'a': ['à', 'á', 'â', 'ã'],
    'A': ['À', 'Á', 'Â', 'Ã'],
    'e': ['é', 'ê'],
    'E': ['É', 'Ê'],
    'i': ['í'],
    'I': ['Í'],
    'o': ['ó', 'ô', 'õ'],
    'O': ['Ó', 'Ô', 'Õ'],
    'u': ['ú', 'ü'],
    'U': ['Ú', 'Ü'],
    'c': ['ç'],
    'C': ['Ç'],
  };
}
