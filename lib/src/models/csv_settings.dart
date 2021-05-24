import '../configs/csv_default_settings.dart';

/// A model representing CSV File parsing settings
class CSVSettings {
  /// A filepath for the output file. Defaults to `<input_filename>_PSEUDO.<extension>`.
  final String? outputFilepath;

  /// The delimiter to use. Defaults to `,`.
  final String delimiter;

  /// The base language's column index. Defaults to 1.
  final int columnIndex;

  /// Constructs a new instance of [CSVSettings]
  ///
  /// [outputFilepath] is required. If null, defaults to `CSVDefaultSettings.delimiter`.
  /// [delimiter] is required. If null, defaults to `CSVDefaultSettings.delimiter`.
  /// [columnIndex] is required. If null, defaults to `CSVDefaultSettings.columnIndex`.
  CSVSettings({
    this.outputFilepath,
    String? delimiter,
    int? columnIndex,
  })  : delimiter = delimiter ?? CSVDefaultSettings.delimiter,
        columnIndex = columnIndex ?? CSVDefaultSettings.columnIndex;

  /// Returns a String representation of the model.
  @override
  String toString() =>
      '{outputFilepath: $outputFilepath, delimiter: $delimiter, columnIndex: $columnIndex}';
}
