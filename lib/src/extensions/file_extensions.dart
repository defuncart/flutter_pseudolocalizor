import 'dart:io';

extension FileExtensions on File {
  /// Convenience method which recursively creates a file if needed
  /// and then writes string contents to disk
  void createRecursivelyAndWriteContents(String contents) {
    if (!existsSync()) {
      createSync(recursive: true);
    }
    writeAsStringSync(contents);

    print('Wrote to $path');
  }
}
