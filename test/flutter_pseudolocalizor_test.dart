import 'dart:io';

import 'package:path/path.dart' as p;
import 'package:test/test.dart';
import 'package:test_descriptor/test_descriptor.dart' as d;
import 'package:test_process/test_process.dart';

void main() {
  test(
      'when no settings define in pubspec.yaml or flutter_pseudolocalizor.yaml, expect tool generates no output',
      () async {
    await createFlutterProject(
      hasPubspecSettings: false,
      hasYamlSettingsFile: false,
    );

    final output = await runDart(
      ['run', 'flutter_pseudolocalizor'],
    );

    expect(
      output,
      [
        'Error! Settings for flutter_pseudolocalizor not found in pubspec.yaml or flutter_pseudolocalizor.yaml.',
      ],
    );

    final file = getGeneratedFile();
    expect(file.existsSync(), isFalse);
  });

  test('when settings defined in pubspec.yaml, expect tool generates output',
      () async {
    await createFlutterProject(
      hasPubspecSettings: true,
      hasYamlSettingsFile: false,
    );

    final output = await runDart(
      ['run', 'flutter_pseudolocalizor'],
    );

    expect(
      output,
      [
        'Wrote to l10n_pseudo/intl_en.arb',
        'All Done!',
      ],
    );

    final file = getGeneratedFile();
    expect(file.existsSync(), isTrue);
    expect(file.readAsStringSync(), '''
{
  "@@locale": "en",
  "myKey": "[Ȟₑɇɇƪⱹöⱺǫ ⱳðȍɍĺǆ¡]"
}''');
  });

  test(
      'when settings defined in flutter_pseudolocalizor.yaml, expect tool generates output',
      () async {
    await createFlutterProject(
      hasPubspecSettings: false,
      hasYamlSettingsFile: true,
    );

    final output = await runDart(
      ['run', 'flutter_pseudolocalizor'],
    );

    expect(
      output,
      [
        'Wrote to l10n_pseudo/intl_en.arb',
        'All Done!',
      ],
    );

    final file = getGeneratedFile();
    expect(file.existsSync(), isTrue);
    expect(file.readAsStringSync(), '''
{
  "@@locale": "en",
  "myKey": "[Ȟₑɇɇƪⱹöⱺǫ ⱳðȍɍĺǆ¡]"
}''');
  });

  test(
      'when settings defined in both pubspec.yaml and flutter_pseudolocalizor.yaml, expect tool generates output',
      () async {
    await createFlutterProject(
      hasPubspecSettings: true,
      hasYamlSettingsFile: true,
    );

    final output = await runDart(
      ['run', 'flutter_pseudolocalizor'],
    );

    expect(
      output,
      [
        'Settings defined in both flutter_pseudolocalizor.yaml and pubspec.yaml. Defaulting to flutter_pseudolocalizor.yaml.',
        'Wrote to l10n_pseudo/intl_en.arb',
        'All Done!',
      ],
    );

    final file = getGeneratedFile();
    expect(file.existsSync(), isTrue);
    expect(file.readAsStringSync(), '''
{
  "@@locale": "en",
  "myKey": "[Ȟₑɇɇƪⱹöⱺǫ ⱳðȍɍĺǆ¡]"
}''');
  });
}

const tempDir = 'tempDir';

Future<void> createFlutterProject({
  bool hasYamlSettingsFile = false,
  bool hasPubspecSettings = false,
}) async {
  await d.dir(tempDir, [
    d.file('pubspec.yaml', '''
name: test_app
environment:
  sdk: '^3.0.0'

dev_dependencies:
  flutter_pseudolocalizor:
    path: ${Directory.current.path}

${hasPubspecSettings ? settings : ''}
'''),
    d.dir('lib', [
      d.file('main.dart', 'void main() {}'),
    ]),
    d.dir('assets_dev', [
      d.dir('l10n', [
        d.file('en.arb', '''{
  "@@locale": "en",
  "myKey": "Hello world!"
}'''),
      ]),
    ]),
    if (hasYamlSettingsFile) d.file('flutter_pseudolocalizor.yaml', settings),
  ]).create();

  await runDart(
    ['pub', 'get'],
  );
}

const settings = '''
flutter_pseudolocalizor:
  input_filepath: "assets_dev/l10n/en.arb"
  replace_base: true
''';

Future<List<String>> runDart(List<String> args) async {
  final process = await TestProcess.start(
    Platform.resolvedExecutable,
    args,
    workingDirectory: p.join(d.sandbox, tempDir),
  );

  final output = await process.stdoutStream().toList();

  await process.shouldExit(0);

  return output;
}

File getGeneratedFile() =>
    File(p.join(d.sandbox, tempDir, 'l10n_pseudo/intl_en.arb'));
