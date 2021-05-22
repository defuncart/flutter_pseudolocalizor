/// An enum which describes the different text expansion options
enum TextExpansionFormat {
  /// appends text at the end of the string, i.e. `Hello World abd`
  append,

  /// repeats vowels, i.e. `Heelloo Woorld`
  repeatVowels,

  /// appends numbers as words, i.e. `Hello World one`
  oneTwo,

  /// wraps text in exclamation marks, i.e. `!!! Hello World !!!`
  exclamationMarks
}
