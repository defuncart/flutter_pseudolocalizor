import '../enums/unicode_block.dart';
import '../extensions/unicode_block_extensions.dart';

abstract class UnicodeFallback {
  static List<String> specialCharacters({
    List<UnicodeBlock> blocks = UnicodeBlock.values,
  }) {
    if (blocks.isEmpty) {
      throw ArgumentError('Expected blocks to be non-empty');
    }

    return blocks
        .map((block) => block.specialCharacters)
        .expand((element) => element)
        .toList(growable: false);
  }

  static Map<String, List<String>> mappingCharacters({
    List<UnicodeBlock> blocks = UnicodeBlock.values,
  }) {
    if (blocks.isEmpty) {
      throw ArgumentError('Expected blocks to be non-empty');
    }

    var returnMap = <String, List<String>>{};
    for (final block in blocks) {
      for (final kvp in block.mappingCharacters.entries) {
        returnMap[kvp.key] = [
          if (returnMap.containsKey(kvp.key)) ...returnMap[kvp.key]!,
          ...kvp.value,
        ];
      }
    }

    return returnMap;
  }
}
