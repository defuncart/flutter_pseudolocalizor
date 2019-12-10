import '../../enums/supported_language.dart';

/// Language settings for SupportedLanguage.fr
class FR {
  static const language = SupportedLanguage.fr;

  /// An array of special characters
  static const specialCharacters = [
    'à',
    'â',
    'æ',
    'é',
    'è',
    'ê',
    'ë',
    'î',
    'ï',
    'ô',
    'œ',
    'ù',
    'û',
    'ü',
    'ç',
    'À',
    'Â',
    'Æ',
    'É',
    'È',
    'Ê',
    'Ë',
    'Î',
    'Ï',
    'Ô',
    'Œ',
    'Ù',
    'Û',
    'Ü',
    'Ç',
  ];

  /// A dictionary of mapping characters
  static const mappingCharacters = {
    'a': ['à', 'â', 'æ'],
    'A': ['À', 'Â', 'Æ'],
    'e': ['é', 'è', 'ê', 'ë'],
    'E': ['É', 'È', 'Ê', 'Ë'],
    'i': ['î', 'ï'],
    'I': ['Î', 'Ï'],
    'o': ['ô', 'œ'],
    'O': ['Ô', 'Œ'],
    'u': ['ù', 'û', 'ü'],
    'U': ['Ù', 'Û', 'Ü'],
    'c': ['ç'],
    'C': ['Ç'],
  };
}
