import 'dart:io';

import 'package:flutter_pseudolocalizor/flutter_pseudolocalizor.dart'
    show ARBSettings, CSVSettings, PackageSettings;
import 'package:yaml/yaml.dart';

/// A class of arguments which the user can specify in pubspec.yaml
class YamlArguments {
  static const inputFilepath = 'input_filepath';
  static const replaceBase = 'replace_base';
  static const unicodeBlocks = 'unicode_blocks';
  static const languagesToGenerate = 'languages_to_generate';
  static const seed = 'seed';
  static const useBrackets = 'use_brackets';
  static const textExpansionFormat = 'text_expansion_format';
  static const textExpansionRatio = 'text_expansion_ratio';
  static const patternsToIgnore = 'patterns_to_ignore';
  static const keysToIgnore = 'keys_to_ignore';
  static const arbSettings = 'arb_settings';
  static const csvSettings = 'csv_settings';
}

/// A class of arguments which the user can specify in pubspec.yaml for csv_settings object
class YamlARBArguments {
  static const outputDirectory = 'output_directory';
}

/// A class of arguments which the user can specify in pubspec.yaml for csv_settings object
class YamlCSVArguments {
  static const outputFilepath = 'output_filepath';
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
  static PackageSettings? packageSettingsFromPubspec() {
    final yamlMap = _packageSettingsAsYamlMap();
    if (yamlMap != null) {
      final inputFilepath = yamlMap[YamlArguments.inputFilepath];
      if (inputFilepath == null) {
        print('Error! Input filepath not defined!');
        exit(0);
      }

      return PackageSettings(
        inputFilepath: inputFilepath,
        replaceBase: yamlMap[YamlArguments.replaceBase],
        unicodeBlocks:
            _yamlListToStringList(yamlMap[YamlArguments.unicodeBlocks]),
        languagesToGenerate:
            _yamlListToStringList(yamlMap[YamlArguments.languagesToGenerate]),
        seed: yamlMap[YamlArguments.seed],
        useBrackets: yamlMap[YamlArguments.useBrackets],
        textExpansionFormat: yamlMap[YamlArguments.textExpansionFormat],
        textExpansionRatio:
            _dynamicToDouble(yamlMap[YamlArguments.textExpansionRatio]),
        patternsToIgnore:
            _yamlListToStringList(yamlMap[YamlArguments.patternsToIgnore]),
        keysToIgnore:
            _yamlListToStringList(yamlMap[YamlArguments.keysToIgnore]),
        arbSettings: _arbSettingsFromPubspec(yamlMap),
        csvSettings: _csvSettingsFromPubspec(yamlMap),
      );
    }

    return null;
  }

  /// Returns the csv settings from pubspec
  static ARBSettings? _arbSettingsFromPubspec(Map<dynamic, dynamic> yamlMap) {
    if (yamlMap.containsKey(YamlArguments.arbSettings)) {
      final arbSettingsAsYamlMap = yamlMap[YamlArguments.arbSettings];
      return ARBSettings(
        outputDirectory: arbSettingsAsYamlMap[YamlARBArguments.outputDirectory],
      );
    }

    return null;
  }

  /// Returns the csv settings from pubspec
  static CSVSettings? _csvSettingsFromPubspec(Map<dynamic, dynamic> yamlMap) {
    if (yamlMap.containsKey(YamlArguments.csvSettings)) {
      final csvSettingsAsYamlMap = yamlMap[YamlArguments.csvSettings];
      return CSVSettings(
        outputFilepath: csvSettingsAsYamlMap[YamlCSVArguments.outputFilepath],
        delimiter: csvSettingsAsYamlMap[YamlCSVArguments.delimiter],
        columnIndex: csvSettingsAsYamlMap[YamlCSVArguments.columnIndex],
      );
    }

    return null;
  }

  /// Returns the package settings from pubspec as a yaml map
  static Map<dynamic, dynamic>? _packageSettingsAsYamlMap() {
    final file = File(pubspecFilePath);
    final yamlString = file.readAsStringSync();
    final Map<dynamic, dynamic> yamlMap = loadYaml(yamlString);
    return yamlMap[yamlPackageSectionId];
  }

  /// Converts a YamlList? into a List<String>?
  static List<String>? _yamlListToStringList(YamlList? inputList) =>
      inputList?.map((item) => item.toString()).toList();

  /// Converts a dynamic to a double?
  static double? _dynamicToDouble(dynamic input) {
    if (input != null) {
      if (input.runtimeType == double) {
        return input;
      } else if (input.runtimeType == int) {
        return input.toDouble();
      }

      return double.tryParse(input);
    }

    return null;
  }
}
