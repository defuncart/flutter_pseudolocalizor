import 'dart:io';

import 'package:flutter_pseudolocalizor/src/extensions/file_extensions.dart';
import 'package:test/test.dart';

void main() {
  group('FileExtensions', () {
    late File file;
    group('createRecursivelyAndWriteContents', () {
      test(
          'When file to create is in current directory, '
          'and file does not initially exist, '
          'when method invoked, expect that file exists', () {
        // create temp file
        file = File('_.csv');

        expect(file.existsSync(), isFalse);

        file.createRecursivelyAndWriteContents('');
        expect(file.existsSync(), isTrue);
        expect(file.readAsStringSync(), isEmpty);

        // clear up and delete file
        file.deleteSync();
      });

      test(
          'When file to create is not in current directory, '
          'and file does not initially exist, '
          'when method invoked, expect that file exists', () {
        // create temp file
        file = File('_/_.csv');

        expect(file.existsSync(), isFalse);

        file.createRecursivelyAndWriteContents('');
        expect(file.existsSync(), isTrue);
        expect(file.readAsStringSync(), isEmpty);

        // clear up and delete file
        file.deleteSync(recursive: true);
      });
    });
  });
}

// void main() {}
