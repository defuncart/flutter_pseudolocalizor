import '../configs/arb_default_settings.dart';
import '../configs/csv_default_settings.dart';
import '../enums/supported_input_file_type.dart';
import '../enums/supported_language.dart';
import '../enums/text_expansion_format.dart';
import '../enums/unicode_block.dart';

/// A class of utils used for the package
class Utils {
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

    return returnArray.isNotEmpty ? returnArray : null;
  }

  /// Converts a string into SupportedLanguage
  static SupportedLanguage? convertSupportedLangaugeFromString(
      String? language) {
    final values = SupportedLanguage.values
        .where((item) => describeEnum(item) == language?.toLowerCase());
    return values.isNotEmpty ? values.first : null;
  }

  /// Converts a list of strings ['latinSupplement', 'latinExtendedA'] into
  /// [UnicodeBlock.latinSupplement, UnicodeBlock.latinExtendedA]
  static List<UnicodeBlock>? covertUnicodeBlocksFromListString(
      List<String>? inputList) {
    if (inputList == null || inputList.isEmpty) {
      return null;
    }

    final returnArray = <UnicodeBlock>[];
    for (final block in inputList) {
      final temp = convertUnicodeBlockFromString(block);
      if (temp != null) {
        returnArray.add(temp);
      }
    }

    return returnArray.isNotEmpty ? returnArray : null;
  }

  /// Converts a string into UnicodeBlock
  static UnicodeBlock? convertUnicodeBlockFromString(String? block) {
    final values = UnicodeBlock.values.where(
        (item) => describeEnum(item).toLowerCase() == block?.toLowerCase());
    return values.isNotEmpty ? values.first : null;
  }

  /// Converts a string into SupportedInputFileType
  static SupportedInputFileType? convertSupportedInputFileTypeFromString(
      String? filetype) {
    final values = SupportedInputFileType.values
        .where((item) => describeEnum(item) == filetype?.toLowerCase());
    return values.isNotEmpty ? values.first : null;
  }

  /// Converts a string into TextExpansionType
  static TextExpansionFormat? convertTextExpansionFormatFromString(
      String? textExpansionType) {
    final values = TextExpansionFormat.values.where((item) =>
        describeEnum(item).toLowerCase() == textExpansionType?.toLowerCase());
    return values.isNotEmpty ? values.first : null;
  }

  /// Returns a generated arb output filepath for [outputDirectory] and [language]
  ///
  /// When [outputDirectory] is null, `ARBDefaultSettings.outputDirectory` is used
  /// Assumes that [language] is a well-formated locale
  static String generateARBOutputFilepath({
    required String? outputDirectory,
    required String language,
  }) =>
      '${outputDirectory ?? ARBDefaultSettings.outputDirectory}/intl_$language.arb';

  /// Returns a generated csv output filepath for [inputFilepath]
  static String generateCSVOutputFilePath({required String inputFilepath}) {
    final index = inputFilepath.lastIndexOf('.');

    if (index == -1) {
      throw ArgumentError(
          'inputFilepath $inputFilepath does not contain an extension!');
    }

    return '${inputFilepath.substring(0, index)}_${CSVDefaultSettings.outputFilenameAppendText}${inputFilepath.substring(index, inputFilepath.length)}';
  }

  /// Taken from flutter
  static String describeEnum(Object enumEntry) {
    final description = enumEntry.toString();
    final indexOfDot = description.indexOf('.');
    assert(indexOfDot != -1 && indexOfDot < description.length - 1);
    return description.substring(indexOfDot + 1);
  }
}
