import 'dart:io';

import '../enums/supported_input_file_type.dart';
import '../models/package_settings.dart';
import '../services/csv_generator.dart';
import '../utils/utils.dart';

/// A service which generates pseudolocalization files
class Pseudolocalizor {
  /// Generates an output pseudolocalization file
  static void generate(
    File file,
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
    final filetype = Utils.convertSupportedInputFileTypeFromString(fileExtension);
    if (filetype == null) {
      print('Error! File ${packageSettings.inputFilepath} has extension $fileExtension which is not supported!');
      return;
    }

    // generate output
    final outputFile = File(packageSettings.outputFilepath);
    if (filetype == SupportedInputFileType.csv) {
      final fileContents = CSVGenerator.generate(file, packageSettings);
      if (fileContents != null) {
        outputFile.writeAsStringSync(fileContents);

        print('All done! Wrote to ${packageSettings.outputFilepath}');
      }
    }
  }
}
