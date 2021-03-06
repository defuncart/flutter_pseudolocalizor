import 'package:flutter_pseudolocalizor/src/enums/supported_input_file_type.dart';
import 'package:flutter_pseudolocalizor/src/enums/supported_language.dart';
import 'package:flutter_pseudolocalizor/src/utils/utils.dart';
import 'package:test/test.dart';

void main() {
  test('Convert string to supported language', () {
    final strings = SupportedLanguage.values.map(Utils.describeEnum).toList();

    // strings (lower case) should be correctly converted
    for (var i = 0; i < strings.length; i++) {
      final supportedLanguage =
          Utils.convertSupportedLangaugeFromString(strings[i]);
      expect(supportedLanguage, SupportedLanguage.values[i]);
    }

    // strings (upper case) should be correctly converted
    for (var i = 0; i < strings.length; i++) {
      final supportedLanguage =
          Utils.convertSupportedLangaugeFromString(strings[i].toUpperCase());
      expect(supportedLanguage, SupportedLanguage.values[i]);
    }

    // null input, expect null output
    var supportedLanguage = Utils.convertSupportedLangaugeFromString(null);
    expect(supportedLanguage, isNull);

    // incorrect input, expect null output
    supportedLanguage = Utils.convertSupportedLangaugeFromString('bla');
    expect(supportedLanguage, isNull);
  });

  test('Convert List<string> to List<SupportedLanguage>', () {
    final strings = SupportedLanguage.values.map(Utils.describeEnum).toList();

    // strings (lower case) should be correctly converted
    var supportedLanguages =
        Utils.covertSupportedLangugesFromListString(strings);
    expect(supportedLanguages, SupportedLanguage.values);

    // strings (upper case) should be correctly converted
    supportedLanguages = Utils.covertSupportedLangugesFromListString(
        strings.map((x) => x.toUpperCase()).toList());
    expect(supportedLanguages, SupportedLanguage.values);

    // null input should generate null output
    supportedLanguages = Utils.covertSupportedLangugesFromListString(null);
    expect(supportedLanguages, isNull);
  });

  test('Convert string to SupportedInputFileType', () {
    final strings =
        SupportedInputFileType.values.map(Utils.describeEnum).toList();

    // strings (lower case) should be correctly converted
    for (var i = 0; i < strings.length; i++) {
      final supportedInputFileTypes =
          Utils.convertSupportedInputFileTypeFromString(strings[i]);
      expect(supportedInputFileTypes, SupportedInputFileType.values[i]);
    }

    // strings (upper case) should be correctly converted
    for (var i = 0; i < strings.length; i++) {
      final supportedInputFileTypes =
          Utils.convertSupportedInputFileTypeFromString(
              strings[i].toUpperCase());
      expect(supportedInputFileTypes, SupportedInputFileType.values[i]);
    }

    // null input, expect null output
    var supportedInputFileTypes =
        Utils.convertSupportedInputFileTypeFromString(null);
    expect(supportedInputFileTypes, isNull);

    // incorrect input, expect null output
    supportedInputFileTypes =
        Utils.convertSupportedInputFileTypeFromString('bla');
    expect(supportedInputFileTypes, isNull);
  });

  test('Generate output file', () {
    // incorrect input, expect null output
    var outputFilepath = Utils.generateOutputFilePath(inputFilepath: 'bla');
    expect(outputFilepath, isNull);

    // correct input, expect generated output
    outputFilepath = Utils.generateOutputFilePath(inputFilepath: 'test.csv');
    expect(outputFilepath, 'test-PSEUDO.csv');

    // correct input (multiple fullspots), expect generated output
    outputFilepath = Utils.generateOutputFilePath(inputFilepath: 'my.test.csv');
    expect(outputFilepath, 'my.test-PSEUDO.csv');
  });
}
