# Example

Firstly, add the package as a dev dependency:

```yaml
dev_dependencies: 
  flutter_pseudolocalizor: 
```

Next define settings in `pubspec.yaml` for the package:

```yaml
flutter_pseudolocalizor:
  input_filepath: "test.csv"
  replace_base: false
  use_brackets: true
  text_expansion_ratio: null
  languages_to_generate:
    - de
    - pl
    - ru
  csv_settings:
    delimiter: ";"
    column_index: 1
  patterns_to_ignore:
    - '%(\S*?)\$[ds]'
    - 'Flutter'
```

| Setting                    | Description                                                                              |
| -------------------------- | ---------------------------------------------------------------------------------------- |
| input_filepath             | A path to the input localization file.                                                   |
| output_filepath            | A path for the generated output file. Defaults to `<input_filename>-PSEUDO.<extension>`. |
| replace_base               | Whether the base language (en) should be replaced. Defaults to `false`.                  |
| text_expansion_ratio       | The ratio (between 1 and 3) of text expansion. If `null`, uses a linear function.        | 
| languages_to_generate      | An array of languages to generate. Ignored if `replace_base` is true.                    |
| csv_settings: delimiter    | A delimiter to separate columns in the input CSV file. Defaults to `,`.                  |
| csv_settings: column_index | The column index of the base language (en) in the input CSV file. Defaults to `1`.       |
| patterns_to_ignore         | A list of patterns to ignore during text replacement.                                    |

`input_filepath` must be given, all other settings are optional. If Latin-1 Supplement and Latin Extended-A letters should be tested, set `replace_base` to true. To test specific languages, set `languages_to_generate` with an array of languages.

Ensure that your current working directory is the project root. Given the localization file `test.csv`, simply run the terminal command:

```
flutter pub run flutter_pseudolocalizor
```

to generate `test-PSEUDO.csv`. This generated file can then be incorporated into your dev build using a package like [flappy_translator](https://pub.dev/packages/flappy_translator).

Note that `patterns_to_ignore` is especially useful to avoid text replacement for certain know constructs, for instance a product name or a pattern ``%myVar$d` used to parse variables from text.
