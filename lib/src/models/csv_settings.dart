import 'package:meta/meta.dart';

import '../configs/csv_default_settings.dart';

/// A model representing CSV File parsing settings
class CSVSettings {
  /// The delimiter to use. Defaults to `,`.
  final String delimiter;

  /// The base language's column index. Defaults to 1.
  final int columnIndex;

  const CSVSettings({
    @required String delimiter,
    @required int columnIndex,
  })  : this.delimiter = delimiter ?? CSVDefaultSettings.delimiter,
        this.columnIndex = columnIndex ?? CSVDefaultSettings.columnIndex;

  /// Consts a new instance of `CSVSettings` whose parameters are given default values.
  CSVSettings.withDefaultSettings() : this(delimiter: null, columnIndex: null);

  /// Returns a String representation of the model.
  @override
  String toString() => '{delimiter: $delimiter, columnIndex: $columnIndex}';
}
