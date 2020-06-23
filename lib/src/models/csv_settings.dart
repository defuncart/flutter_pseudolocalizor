import 'package:meta/meta.dart';

import '../configs/csv_default_settings.dart';

/// A model representing CSV File parsing settings
class CSVSettings {
  /// The delimiter to use. Defaults to `,`.
  final String delimiter;

  /// The base language's column index. Defaults to 1.
  final int columnIndex;

  /// Constructs a new instance of [CSVSettings]
  ///
  /// The parameter `delimiter` is required. If null, defaults to `CSVDefaultSettings.delimiter`.
  /// The parameter `columnIndex` is required. If null, defaults to `CSVDefaultSettings.columnIndex`.
  const CSVSettings({
    @required String delimiter,
    @required int columnIndex,
  })  : delimiter = delimiter ?? CSVDefaultSettings.delimiter,
        columnIndex = columnIndex ?? CSVDefaultSettings.columnIndex;

  /// Consts a new instance of `CSVSettings` whose parameters are given default values.
  CSVSettings.withDefaultSettings() : this(delimiter: null, columnIndex: null);

  /// Returns a String representation of the model.
  @override
  String toString() => '{delimiter: $delimiter, columnIndex: $columnIndex}';
}
