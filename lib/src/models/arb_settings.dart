/// A model representing ARB File parsing settings
class ARBSettings {
  /// An optional directory for generated files.
  final String? outputDirectory;

  /// Constructs a new instance of [ARBSettings]
  ARBSettings({
    this.outputDirectory,
  });

  /// Returns a String representation of the model.
  @override
  String toString() => '{outputFilepath: $outputDirectory}';
}
