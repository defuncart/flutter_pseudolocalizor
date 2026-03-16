import 'dart:convert';
import 'dart:io';

import 'package:test/test.dart';
import 'package:test_process/test_process.dart';

void main() {
  test('determine if package has warnings', () async {
    final process = await TestProcess.start(
      Platform.resolvedExecutable,
      ['pub', 'publish', '--dry-run'],
      workingDirectory: Directory.current.path,
    );

    final output = await process.stdoutStream().toList();
    await process.shouldExit(0);

    print(output.join('\n'));
  });

  test('determine package pub score', () async {
    // requires dart pub global activate pana
    final process = await TestProcess.start(
      Platform.resolvedExecutable,
      ['pub', 'global', 'run', 'pana', '--json'],
      workingDirectory: Directory.current.path,
    );

    final output = await process.stdoutStream().join('\n');
    await process.shouldExit(0);

    final result = jsonDecode(output);
    expect(result['scores']['grantedPoints'], 140);
  });
}
