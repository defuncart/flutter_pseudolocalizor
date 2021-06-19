import 'dart:io';

import '../enums/supported_input_file_type.dart';
import '../extensions/file_extensions.dart';
import '../models/package_settings.dart';
import '../services/csv_generator.dart';
import '../utils/utils.dart';
import 'arb_generator.dart';

/// A service which generates pseudolocalization files
class Pseudolocalizor {
  /// Generates an output pseudolocalization file
  static void generate(
    PackageSettings packageSettings,
  ) {
    // check that the file exists
    final file = File(packageSettings.inputFilepath);
    if (!file.existsSync()) {
      print('Error! File ${packageSettings.inputFilepath} does not exist!');
      return;
    }

    // check that the file has an extension - this is needed to determine if the file is supported
    if (!file.path.contains('.')) {
      print('Error! No file extension specified!');
      return;
    }

    final fileExtension = file.path.split('.').last;
    final filetype =
        Utils.convertSupportedInputFileTypeFromString(fileExtension);
    if (filetype == null) {
      print(
          'Error! File ${packageSettings.inputFilepath} has extension $fileExtension which is not supported!');
      return;
    }

    // generate output
    if (filetype == SupportedInputFileType.csv) {
      final outputFile = File(
        packageSettings.csvSettings.outputFilepath ??
            Utils.generateCSVOutputFilePath(
                inputFilepath: packageSettings.inputFilepath),
      );
      final fileContents = CSVGenerator.generate(file, packageSettings);
      outputFile.createRecursivelyAndWriteContents(fileContents);
    } else if (filetype == SupportedInputFileType.arb) {
      // firstly deal with base
      var outputFile = File(
        Utils.generateARBOutputFilepath(
          outputDirectory: packageSettings.arbSettings.outputDirectory,
          language: 'en',
        ),
      );
      if (packageSettings.replaceBase) {
        final fileContents = ARBGenerator.generate(file, packageSettings);
        outputFile.createRecursivelyAndWriteContents(fileContents);
      } else {
        file.copySync(outputFile.path);
        print('Wrote to ${outputFile.path}');
      }

      // then generate any additional languages
      if (packageSettings.languagesToGenerate != null &&
          packageSettings.languagesToGenerate!.isNotEmpty) {
        for (final language in packageSettings.languagesToGenerate!) {
          final outputFile = File(
            Utils.generateARBOutputFilepath(
              outputDirectory: packageSettings.arbSettings.outputDirectory,
              language: Utils.describeEnum(language),
            ),
          );
          final fileContents = ARBGenerator.generate(
            file,
            packageSettings,
            supportedLanguage: language,
          );
          outputFile.createRecursivelyAndWriteContents(fileContents);
        }
      }
    }

    print('All Done!');
  }
}
