library utils;

import 'package:flutter_test/flutter_test.dart';

import '../../lib/src/enums/supported_input_file_type.dart';
import '../../lib/src/enums/supported_language.dart';
import '../../lib/src/utils/utils.dart';

void main() {
  test('Convert string to supported language', () {
    final strings = SupportedLanguage.values.map((x) => Utils.describeEnum(x)).toList();

    // strings (lower case) should be correctly converted
    for (int i = 0; i < strings.length; i++) {
      final supportedLanguage = Utils.convertSupportedLangaugeFromString(strings[i]);
      expect(supportedLanguage, SupportedLanguage.values[i]);
    }

    // strings (upper case) should be correctly converted
    for (int i = 0; i < strings.length; i++) {
      final supportedLanguage = Utils.convertSupportedLangaugeFromString(strings[i].toUpperCase());
      expect(supportedLanguage, SupportedLanguage.values[i]);
    }

    // null input, expect null output
    var supportedLanguage = Utils.convertSupportedLangaugeFromString(null);
    expect(supportedLanguage, null);

    // incorrect input, expect null output
    supportedLanguage = Utils.convertSupportedLangaugeFromString('bla');
    expect(supportedLanguage, null);
  });

  test('Convert List<string> to List<SupportedLanguage>', () {
    final strings = SupportedLanguage.values.map((x) => Utils.describeEnum(x)).toList();

    // strings (lower case) should be correctly converted
    var supportedLanguages = Utils.covertSupportedLangugesFromListString(strings);
    expect(supportedLanguages, SupportedLanguage.values);

    // strings (upper case) should be correctly converted
    supportedLanguages = Utils.covertSupportedLangugesFromListString(strings.map((x) => x.toUpperCase()).toList());
    expect(supportedLanguages, SupportedLanguage.values);

    // null input should generate null output
    supportedLanguages = Utils.covertSupportedLangugesFromListString(null);
    expect(supportedLanguages, null);
  });

  test('Convert string to SupportedInputFileType', () {
    final strings = SupportedInputFileType.values.map((x) => Utils.describeEnum(x)).toList();

    // strings (lower case) should be correctly converted
    for (int i = 0; i < strings.length; i++) {
      final supportedInputFileTypes = Utils.convertSupportedInputFileTypeFromString(strings[i]);
      expect(supportedInputFileTypes, SupportedInputFileType.values[i]);
    }

    // strings (upper case) should be correctly converted
    for (int i = 0; i < strings.length; i++) {
      final supportedInputFileTypes = Utils.convertSupportedInputFileTypeFromString(strings[i].toUpperCase());
      expect(supportedInputFileTypes, SupportedInputFileType.values[i]);
    }

    // null input, expect null output
    var supportedInputFileTypes = Utils.convertSupportedInputFileTypeFromString(null);
    expect(supportedInputFileTypes, null);

    // incorrect input, expect null output
    supportedInputFileTypes = Utils.convertSupportedInputFileTypeFromString('bla');
    expect(supportedInputFileTypes, null);
  });

  test('Generate output file', () {
    // null input, expect null output
    var outputFilepath = Utils.generateOutputFilePath(inputFilepath: null);
    expect(outputFilepath, null);

    // incorrect input, expect null output
    outputFilepath = Utils.generateOutputFilePath(inputFilepath: 'bla');
    expect(outputFilepath, null);

    // correct input, expect generated output
    outputFilepath = Utils.generateOutputFilePath(inputFilepath: 'test.csv');
    expect(outputFilepath, 'test-PSEUDO.csv');

    // correct input (multiple fullspots), expect generated output
    outputFilepath = Utils.generateOutputFilePath(inputFilepath: 'my.test.csv');
    expect(outputFilepath, 'my.test-PSEUDO.csv');
  });
}
