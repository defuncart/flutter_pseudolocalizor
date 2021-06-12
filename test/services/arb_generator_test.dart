import 'dart:convert';
import 'dart:io';

import 'package:flutter_pseudolocalizor/flutter_pseudolocalizor.dart';
import 'package:flutter_pseudolocalizor/src/services/arb_generator.dart';
import 'package:flutter_pseudolocalizor/src/utils/utils.dart';
import 'package:test/test.dart';

void main() {
  final fileContents = '''
{
  "@@locale": "en",
  "myKey": "Hello world!",
  "@myKey": {},
  "welcome": "Welcome {firstName}!",
  "@welcome": {}
}
''';

  test('replaceBase', () {
    // create file
    final file = File('_.arb');
    file.writeAsStringSync(fileContents);

    // initialize settings
    final packageSettings = PackageSettings(
      inputFilepath: '_.arb',
      replaceBase: true,
      languagesToGenerate: null,
      useBrackets: true,
      textExpansionFormat: null,
      textExpansionRatio: null,
      arbSettings: null,
      patternsToIgnore: null,
      keysToIgnore: null,
    );

    final contents = ARBGenerator.generate(file, packageSettings);
    expect(contents, isNotNull);
    final decodedContents = jsonDecode(contents!);
    expect(decodedContents['@@locale'], 'en');
    expect(decodedContents['myKey'], isNotNull);
    expect(decodedContents['myKey'], isNot('Hello world!'));
    expect(decodedContents['welcome'], isNotNull);
    expect(decodedContents['welcome'], isNot('Welcome {firstName}!'));

    // clear up and delete file
    file.deleteSync();
  });

  test('languagesToGenerate', () {
    // create file
    final file = File('_.arb');
    file.writeAsStringSync(fileContents);

    // initialize settings
    final packageSettings = PackageSettings(
      inputFilepath: '_.arb',
      replaceBase: false,
      languagesToGenerate: ['de', 'es', 'pl'],
      useBrackets: true,
      textExpansionFormat: null,
      textExpansionRatio: null,
      arbSettings: null,
      patternsToIgnore: null,
      keysToIgnore: null,
    );

    for (final language in packageSettings.languagesToGenerate!) {
      final contents = ARBGenerator.generate(
        file,
        packageSettings,
        supportedLanguage: language,
      );
      expect(contents, isNotNull);
      final decodedContents = jsonDecode(contents!);
      expect(decodedContents['@@locale'], isNot('en'));
      expect(decodedContents['@@locale'], Utils.describeEnum(language));
      expect(decodedContents['myKey'], isNotNull);
      expect(decodedContents['myKey'], isNot('Hello world!'));
      expect(decodedContents['welcome'], isNotNull);
      expect(decodedContents['welcome'], isNot('Welcome {firstName}!'));
    }

    // clear up and delete file
    file.deleteSync();
  });
}
