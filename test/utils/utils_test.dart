import 'package:flutter_pseudolocalizor/src/enums/supported_input_file_type.dart';
import 'package:flutter_pseudolocalizor/src/enums/supported_language.dart';
import 'package:flutter_pseudolocalizor/src/enums/text_expansion_format.dart';
import 'package:flutter_pseudolocalizor/src/enums/unicode_block.dart';
import 'package:flutter_pseudolocalizor/src/utils/utils.dart';
import 'package:test/test.dart';

void main() {
  test('covertSupportedLangugesFromListString', () {
    expect(Utils.covertSupportedLangugesFromListString(null), isNull);
    expect(Utils.covertSupportedLangugesFromListString(<String>[]), isNull);

    expect(
      Utils.covertSupportedLangugesFromListString(['de', 'pl']),
      [SupportedLanguage.de, SupportedLanguage.pl],
    );

    expect(
      Utils.covertSupportedLangugesFromListString(['de', 'bla']),
      [SupportedLanguage.de],
    );

    expect(
      Utils.covertSupportedLangugesFromListString(['bla']),
      isNull,
    );
  });

  test('Convert string to $SupportedLanguage', () {
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

  test('Convert List<string> to List<$SupportedLanguage>', () {
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

  group('covertUnicodeBlocksFromListString', () {
    test('covertUnicodeBlocksFromListString', () {
      expect(Utils.covertUnicodeBlocksFromListString(null), isNull);
      expect(Utils.covertUnicodeBlocksFromListString(<String>[]), isNull);

      expect(
        Utils.covertUnicodeBlocksFromListString(
            ['latinSupplement', 'latinExtendedA']),
        [UnicodeBlock.latinSupplement, UnicodeBlock.latinExtendedA],
      );

      expect(
        Utils.covertUnicodeBlocksFromListString(['latinSupplement', 'bla']),
        [UnicodeBlock.latinSupplement],
      );

      expect(
        Utils.covertUnicodeBlocksFromListString(['bla']),
        isNull,
      );
    });

    test('Convert List<string> to List<$UnicodeBlock>', () {
      final strings = UnicodeBlock.values.map(Utils.describeEnum).toList();

      // strings (lower case) should be correctly converted
      var blocks = Utils.covertUnicodeBlocksFromListString(strings);
      expect(blocks, UnicodeBlock.values);

      // strings (upper case) should be correctly converted
      blocks = Utils.covertUnicodeBlocksFromListString(
          strings.map((x) => x.toUpperCase()).toList());
      expect(blocks, UnicodeBlock.values);

      // null input should generate null output
      blocks = Utils.covertUnicodeBlocksFromListString(null);
      expect(blocks, isNull);
    });
  });

  test('Convert string to $UnicodeBlock', () {
    final strings = UnicodeBlock.values.map(Utils.describeEnum).toList();

    // strings (lower case) should be correctly converted
    for (var i = 0; i < strings.length; i++) {
      final blocks = Utils.convertUnicodeBlockFromString(strings[i]);
      expect(blocks, UnicodeBlock.values[i]);
    }

    // strings (upper case) should be correctly converted
    for (var i = 0; i < strings.length; i++) {
      final blocks =
          Utils.convertUnicodeBlockFromString(strings[i].toUpperCase());
      expect(blocks, UnicodeBlock.values[i]);
    }

    // null input, expect null output
    var supportedLanguage = Utils.convertUnicodeBlockFromString(null);
    expect(supportedLanguage, isNull);

    // incorrect input, expect null output
    supportedLanguage = Utils.convertUnicodeBlockFromString('bla');
    expect(supportedLanguage, isNull);
  });

  test('Convert string to $SupportedInputFileType', () {
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

  test('Convert string to $TextExpansionFormat', () {
    final strings = TextExpansionFormat.values.map(Utils.describeEnum).toList();

    // strings (lower case) should be correctly converted
    for (var i = 0; i < strings.length; i++) {
      final supportedInputFileTypes =
          Utils.convertTextExpansionFormatFromString(strings[i]);
      expect(supportedInputFileTypes, TextExpansionFormat.values[i]);
    }

    // strings (upper case) should be correctly converted
    for (var i = 0; i < strings.length; i++) {
      final supportedInputFileTypes =
          Utils.convertTextExpansionFormatFromString(strings[i].toUpperCase());
      expect(supportedInputFileTypes, TextExpansionFormat.values[i]);
    }

    // null input, expect null output
    var supportedInputFileTypes =
        Utils.convertTextExpansionFormatFromString(null);
    expect(supportedInputFileTypes, isNull);

    // incorrect input, expect null output
    supportedInputFileTypes = Utils.convertTextExpansionFormatFromString('bla');
    expect(supportedInputFileTypes, isNull);
  });

  group('generateARBOutputFilepath', () {
    test('Given valid input, expect generated output', () {
      expect(
        Utils.generateARBOutputFilepath(
          outputDirectory: 'pseudo',
          language: 'en',
        ),
        'pseudo/intl_en.arb',
      );
    });

    test('Given valid input, expect generated output', () {
      expect(
        Utils.generateARBOutputFilepath(
          outputDirectory: null,
          language: 'en',
        ),
        'l10n_pseudo/intl_en.arb',
      );
    });
  });

  group('generateCSVOutputFilePath', () {
    test('Given invalid filepath, expect argument error', () {
      expect(
        () => Utils.generateCSVOutputFilePath(inputFilepath: 'bla'),
        throwsArgumentError,
      );
    });

    test('Given valid filepath, expect generated output', () {
      expect(
        Utils.generateCSVOutputFilePath(inputFilepath: 'test.csv'),
        'test_PSEUDO.csv',
      );
    });

    test(
        'Given valid filepath with multiple fullstops, expect generated output',
        () {
      expect(
        Utils.generateCSVOutputFilePath(inputFilepath: 'my.test.csv'),
        'my.test_PSEUDO.csv',
      );
    });
  });
}
