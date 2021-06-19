// import 'dart:io';

// import 'package:flutter_pseudolocalizor/src/extensions/file_extensions.dart';
// import 'package:test/test.dart';

// void main() {
//   group('FileExtensions', () {
//     late File file;
//     group('createRecursivelyAndWriteContents', () {
//       group('When current directory', () {
//         // create temp file
//         file = File('_.csv');
//         print('A');

//         test('expect file does not yet exist', () async {
//           print('B');
//           expect(await file.exists(), isFalse);
//         });

//         group('when method invoked', () {
//           file.createRecursivelyAndWriteContents('');
//           print('C');

//           test('expect that file exists', () {
//             print('D');
//             expect(file.existsSync(), isTrue);
//             expect(file.readAsStringSync(), isEmpty);
//           });
//         });

//         test('tidy up', () async {
//           // clear up and delete file
//           print('E');
//           await Future.delayed(Duration(seconds: 1));
//           print('F');
//           file.deleteSync();
//         });
//       });
//     });
//   });
// }

void main() {}
