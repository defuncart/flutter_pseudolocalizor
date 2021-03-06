import '../configs/default_settings.dart';
import '../configs/language_settings.dart';
import '../enums/supported_input_file_type.dart';
import '../enums/supported_language.dart';

/// A class of utils used for the package
class Utils {
  /// Returns a list of special characters for a given [SupportLanguage]
  static List<String>? specialCharactersForSupportedLanguage(
          SupportedLanguage? language) =>
      language == null
          ? LanguageSettings.fallbackSpecialCharacters
          : LanguageSettings.specialCharacters[language];

  /// Returns mapping characters for a given [SupportLanguage]
  static Map<String, List<String>>? mappingCharactersForSupportedLanguage(
          SupportedLanguage? language) =>
      language == null
          ? LanguageSettings.fallbackMappingCharacters
          : LanguageSettings.mappingCharacters[language];

  /// Converts a list of strings ['de', 'pl] into [SupportedLanguage.de, SupportedLanguage.pl]
  static List<SupportedLanguage>? covertSupportedLangugesFromListString(
      List<String>? inputList) {
    if (inputList == null || inputList.isEmpty) {
      return null;
    }

    final returnArray = <SupportedLanguage>[];
    for (final language in inputList) {
      final temp = convertSupportedLangaugeFromString(language);
      if (temp != null) {
        returnArray.add(temp);
      }
    }

    return returnArray;
  }

  /// Converts a string into SupportedLanguage
  static SupportedLanguage? convertSupportedLangaugeFromString(
      String? language) {
    final values = SupportedLanguage.values.where(
        (item) => describeEnum(item).toString() == language?.toLowerCase());
    return values.isNotEmpty ? values.first : null;
  }

  /// Converts a string into SupportedInputFileType
  static SupportedInputFileType? convertSupportedInputFileTypeFromString(
      String? filetype) {
    final values = SupportedInputFileType.values.where(
        (item) => describeEnum(item).toString() == filetype?.toLowerCase());
    return values.isNotEmpty ? values.first : null;
  }

  /// Returns a generated output filepath for a given inputfiepath
  static String? generateOutputFilePath({required String inputFilepath}) {
    final index = inputFilepath.lastIndexOf('.');
    if (index != -1) {
      return '${inputFilepath.substring(0, index)}-${DefaultSettings.outputFilenamePrependText}${inputFilepath.substring(index, inputFilepath.length)}';
    }
    print(
        'ERROR! input filepath does not contain an extension! $inputFilepath');

    return null;
  }

  ///
  static String describeEnum(Object enumEntry) {
    final description = enumEntry.toString();
    final indexOfDot = description.indexOf('.');
    assert(indexOfDot != -1 && indexOfDot < description.length - 1);
    return description.substring(indexOfDot + 1);
  }
}
