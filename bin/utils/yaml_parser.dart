import 'dart:io';

import 'package:flutter_pseudolocalizor/flutter_pseudolocalizor.dart' show CSVSettings, PackageSettings;
import 'package:yaml/yaml.dart';

/// A class of arguments which the user can specify in pubspec.yaml
class YamlArguments {
  static const inputFilepath = 'input_filepath';
  static const outputFilepath = 'output_filepath';
  static const replaceBase = 'replace_base';
  static const languagesToGenerate = 'languages_to_generate';
  static const useBrackets = 'use_brackets';
  static const textExpansionRatio = 'text_expansion_ratio';
  static const csvSettings = 'csv_settings';
  static const patternsToIgnore = 'patterns_to_ignore';
  static const lineNumbersToIgnore = 'line_numbers_to_ignore';
}

/// A class of arguments which the user can specify in pubspec.yaml for csv_settings object
class YamlCSVArguments {
  static const delimiter = 'delimiter';
  static const columnIndex = 'column_index';
}

/// A class which parses yaml
class YamlParser {
  /// The path to the pubspec file path
  static const pubspecFilePath = 'pubspec.yaml';

  /// The section id for package settings in the yaml file
  static const yamlPackageSectionId = 'flutter_pseudolocalizor';

  /// Returns the package settings from pubspec
  static PackageSettings packageSettingsFromPubspec() {
    final yamlMap = _packageSettingsAsYamlMap();
    return yamlMap != null
        ? PackageSettings(
            inputFilepath: yamlMap[YamlArguments.inputFilepath],
            outputFilepath: yamlMap[YamlArguments.outputFilepath],
            replaceBase: yamlMap[YamlArguments.replaceBase],
            languagesToGenerate: _yamlListToStringList(yamlMap[YamlArguments.languagesToGenerate]),
            useBrackets: yamlMap[YamlArguments.useBrackets],
            textExpansionRatio: _dynamicToDouble(yamlMap[YamlArguments.textExpansionRatio]),
            csvSettings: _csvSettingsFromPubspec(yamlMap),
            patternsToIgnore: _yamlListToStringList(yamlMap[YamlArguments.patternsToIgnore]),
            lineNumbersToIgnore: _yamlListToIntList(yamlMap[YamlArguments.lineNumbersToIgnore]),
          )
        : null;
  }

  /// Returns the csv settings from pubspec
  static CSVSettings _csvSettingsFromPubspec(Map<dynamic, dynamic> yamlMap) {
    if (yamlMap.containsKey(YamlArguments.csvSettings)) {
      final csvSettingsAsYamlMap = yamlMap[YamlArguments.csvSettings];
      return CSVSettings(
        delimiter: csvSettingsAsYamlMap[YamlCSVArguments.delimiter],
        columnIndex: csvSettingsAsYamlMap[YamlCSVArguments.columnIndex],
      );
    }

    return null;
  }

  /// Returns the package settings from pubspec as a yaml map
  static Map<dynamic, dynamic> _packageSettingsAsYamlMap() {
    final file = File(pubspecFilePath);
    final yamlString = file.readAsStringSync();
    final Map<dynamic, dynamic> yamlMap = loadYaml(yamlString);
    return yamlMap[yamlPackageSectionId];
  }

  /// Converts a YamlList into a List<String>
  static List<String> _yamlListToStringList(YamlList inputList) =>
      inputList != null ? inputList.map((item) => item.toString()).toList() : null;

  /// Converts a YamlList into a List<String>
  static List<int> _yamlListToIntList<T>(YamlList inputList) =>
      inputList != null ? inputList.map<int>((item) => item).toList() : null;

  /// Converts a dynamic to a double
  static double _dynamicToDouble(dynamic input) {
    if (input != null) {
      if (input.runtimeType == double) {
        return input;
      } else if (input.runtimeType == int) {
        return input.toDouble();
      }

      return double.tryParse(input);
    }

    // ignore: avoid_returning_null
    return null;
  }
}
