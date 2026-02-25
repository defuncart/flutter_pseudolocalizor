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
        'myKey': '[Ȟₑɇɇéⱹⱡⱺǫ ⱳðȍɍĺǆ¡]',
        '@myKey': {},
        'welcome': '[Ɯǝɇëēȇēⱸêłȼȯöȫôȣȭmȩę {firstName}¡]',
        '@welcome': {},
        'numberMessages':
            '{count, plural, zero{[¥ðǭŭµ ĥaaⱱėė ñðƣ ŋǝēŵ mĕȩśƨaaĝěƨ]} one{[Ƴºōùű ⱨaaⱽēǝ ¹ ȵēěŵ mȇǝƽȿaaǵĕ]} other{[Ȳœȍðȍűùǔ ƕaⱽɇ {count} ⁿêęₑȇŵ mĕⱸₔęșšaaağₔǝș]}}',
        '@numberMessages': {'description': 'An info message about new messages count'},
        'whoseBook': '{sex, select, male{[Ħïǁìȿ ƃõƣōǫⱪ]} female{[Ȟȩēêɍ ƅơȫȯȫķ]} other{[Ƭȟęęⱻǁǃɍ ƀơôŏðĸ]}}',
        '@whoseBook': {'description': 'A message determine whose book it is'},
        'unreadEmails':
            '{howMany, plural, zero{[Ʈħɇèęéɍȇēⱻè aaaa®ėₔēě ⁿₒǒȍó ŭůǚǜňŕⱸēaaď ȅëmaîǉș ſö® {userName}]} one{[Țĥƹéěȩřȩⱻĕȩ ǁìįⁱś ₁ ǔµưŭǹřȅⱻȩēaaaƌ ĕƹmaaȉƪ ſōŗ {userName}]} other{[Ʈƕȇĕèǝ®ⱸĕƹȇ aaŕè {howMany} ưüǘǚƞŕȩȅₑëaaaaƌ ƹⱻëmaaǁƪȿ ſǫȓ {userName}]}}',
        '@unreadEmails': {'description': 'How many unread emails for user'},
        'weatherReaction':
            '{weatherType, select, sunny{[Ⱳⱷơº°ⱨºŏǒ]} cloudy{[Ɱₑēⱸⱨ]} rainy{[Ⱳèëĕėȟ]} other{[ŌǾȪⱦⱨêëř]}}',
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
        "@@locale": "de",
        "myKey": "[Heeeellöö wöörld!]",
        "@myKey": {},
        "welcome": "[Weeeeeeeelcöööööömee {firstName}!]",
        "@welcome": {}
      },
      SupportedLanguage.es: {
        "@@locale": "es",
        "myKey": "[Hééééllóó wóórld!]",
        "@myKey": {},
        "welcome": "[Wéééééééélcóóóóóóméé {firstName}!]",
        "@welcome": {}
      },
      SupportedLanguage.pl: {
        "@@locale": "pl",
        "myKey": "[Hęęęęłłóó wóórłd!]",
        "@myKey": {},
        "welcome": "[Węęęęęęęęłćóóóóóómęę {firstName}!]",
        "@welcome": {}
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
}
