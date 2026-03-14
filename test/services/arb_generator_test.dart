import 'dart:convert';
import 'dart:io';

import 'package:flutter_pseudolocalizor/flutter_pseudolocalizor.dart';
import 'package:flutter_pseudolocalizor/src/enums/supported_language.dart';
import 'package:flutter_pseudolocalizor/src/services/arb_generator.dart';
import 'package:test/test.dart';

void main() {
  final fileContents = '''
{
  "@@locale": "en",
  "myKey": "Hello world!",
  "@myKey": {},
  "welcome": "Welcome {firstName}!",
  "@welcome": {},
  "numberMessages": "{count, plural, zero{You have no new messages} one{You have 1 new message} other{You have {count} new messages}}",
  "@numberMessages": {
    "description": "An info message about new messages count"
  },
  "whoseBook": "{sex, select, male{His book} female{Her book} other{Their book}}",
  "@whoseBook": {
    "description": "A message determine whose book it is"
  },
  "unreadEmails": "{howMany, plural, zero{There are no unread emails for {userName}} one{There is 1 unread email for {userName}} other{There are {howMany} unread emails for {userName}}}",
  "@unreadEmails": {
    "description": "How many unread emails for user"
  },
  "weatherReaction": "{weatherType, select, sunny{Woohoo} cloudy{Meh} rainy{Weeh} other{Other}}",
  "@weatherReaction": {
    "description": "Reaction to types of weather"
  }
}
''';

  final fileContentsShort = '''
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
      unicodeBlocks: null,
      languagesToGenerate: null,
      seed: null,
      useBrackets: true,
      textExpansionFormat: null,
      textExpansionRatio: null,
      arbSettings: null,
      patternsToIgnore: null,
      keysToIgnore: null,
    );

    final contents = ARBGenerator.generate(file, packageSettings);
    expect(contents, isNotNull);

    final decodedContents = jsonDecode(contents);
    expect(
      decodedContents,
      {
        '@@locale': 'en',
        'myKey': '[Ȟₑɇɇƪⱹöⱺǫ ⱳðȍɍĺǆ¡]',
        '@myKey': {},
        'welcome': '[Ɯₑėȅȴćº°mₔₑ {firstName}¡]',
        '@welcome': {},
        'numberMessages':
            '{count, plural, zero{[¥ðǭŭµ ĥaaⱱėė ñðƣ ŋǝēŵ mĕȩśƨaaĝěƨ]} one{[Ƴºōùű ⱨaaⱽēǝ ¹ ȵēěŵ mȇǝƽȿaaǵĕ]} other{[Ȳœȍµù ħaaⱱȇ {count} ǹɇɇéŵ męₑšȿaaģⱸₔš]}}',
        '@numberMessages': {
          'description': 'An info message about new messages count'
        },
        'whoseBook':
            '{sex, select, male{[Ⱶĩȋǀŝ ßøⱷøŏƙ]} female{[Ⱶéēₑř ßøǭœºĸ]} other{[Ťħëēȇıȋ® ßⱺȯöȫķ]}}',
        '@whoseBook': {'description': 'A message determine whose book it is'},
        'unreadEmails':
            '{howMany, plural, zero{[Ƭȟĕₔȑëƹ aaŗɇè ŋºȱ ǔµƞɍₑėaađ ēěmaaïⱡś ſó® {userName}]} one{[Ŧħⱻǝŕⱸē ĭĳś ¹ µũǌŕƹëaaƌ ƹémaaⁱĳƚ ſó® {userName}]} other{[Ťƕéęřéě aaȓēȅ {howMany} ŭµńřⱻȩaađ ĕĕmaaǀȉƪș ƒȍȑ {userName}]}}',
        '@unreadEmails': {'description': 'How many unread emails for user'},
        'weatherReaction':
            '{weatherType, select, sunny{[Ŵȯⱺȣöȟₒǒ°]} cloudy{[Ɱēèȅƕ]} rainy{[Ⱳⱸₑëȩħ]} other{[ȌÓÔťⱨëēŗ]}}',
        '@weatherReaction': {'description': 'Reaction to types of weather'}
      },
    );

    // clear up and delete file
    file.deleteSync();
  });

  test('languagesToGenerate', () {
    // create file
    final file = File('_.arb');
    file.writeAsStringSync(fileContentsShort);

    // initialize settings
    final packageSettings = PackageSettings(
      inputFilepath: '_.arb',
      replaceBase: false,
      unicodeBlocks: null,
      languagesToGenerate: ['de', 'es', 'pl'],
      seed: null,
      useBrackets: true,
      textExpansionFormat: null,
      textExpansionRatio: null,
      arbSettings: null,
      patternsToIgnore: null,
      keysToIgnore: null,
    );

    final expectedValues = {
      SupportedLanguage.de: {
        '@@locale': 'de',
        'myKey': '[Heeellööö wöörld!]',
        '@myKey': {},
        'welcome': '[Weeelcöömee {firstName}!]',
        '@welcome': {}
      },
      SupportedLanguage.es: {
        '@@locale': 'es',
        'myKey': '[Héééllóóó wóórld!]',
        '@myKey': {},
        'welcome': '[Wééélcóóméé {firstName}!]',
        '@welcome': {}
      },
      SupportedLanguage.pl: {
        '@@locale': 'pl',
        'myKey': '[Hęęęłłóóó wóórłd!]',
        '@myKey': {},
        'welcome': '[Węęęłćóómęę {firstName}!]',
        '@welcome': {}
      }
    };

    for (final language in packageSettings.languagesToGenerate!) {
      final contents = ARBGenerator.generate(
        file,
        packageSettings,
        supportedLanguage: language,
      );
      expect(contents, isNotNull);

      final decodedContents = jsonDecode(contents);
      expect(decodedContents, expectedValues[language]);
    }

    // clear up and delete file
    file.deleteSync();
  });

  test('test potential edge cases', () {
    // create file
    final file = File('_.arb');
    file.writeAsStringSync('''{
  "@@locale": "en",
  "key1": "{value}%",
  "key2": "Error: {error}",
  "key3": "{value}{unit, select, seconds{sec} minutes{min} hours{h} other{}}"
}''');

    // initialize settings
    final packageSettings = PackageSettings(
      inputFilepath: '_.arb',
      replaceBase: false,
      unicodeBlocks: null,
      languagesToGenerate: null,
      seed: null,
      useBrackets: true,
      textExpansionFormat: null,
      textExpansionRatio: null,
      arbSettings: null,
      patternsToIgnore: null,
      keysToIgnore: null,
    );

    final contents = ARBGenerator.generate(
      file,
      packageSettings,
      supportedLanguage: SupportedLanguage.zh,
    );
    expect(contents, isNotNull);

    final decodedContents = jsonDecode(contents);
    expect(
      decodedContents,
      {
        '@@locale': 'zh',
        'key1': '{value}文件',
        'key2': '管理数据{error}',
        'key3':
            '{value}{unit, select, seconds{数据} minutes{错误} hours{错误} other{}}'
      },
    );

    // clear up and delete file
    file.deleteSync();
  });
}
