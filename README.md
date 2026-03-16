# flutter_pseudolocalizor

A pseudolocalization tool for Flutter that generates pseudo-translated strings from English source strings.

## Pseudolocalization

Pseudolocalization is a testing technique that generates pseudo-translated strings to simulate localization and verify that an application correctly handles different languages, character sets and text expansion/contraction.

```
Hello World!  -> [Hellö Wörld! ÜüäßÖ]
```

<details>
<summary>Learn more about pseudolocalization</summary>

### What is pseudolocalization?

- *Internationalization* is the process of designing a software application so that it can easily be adapted to various other languages and regions without any programming changes. 
- *Localization* is the process of adapting internationalized software for a specific region or language by adding locale-specific components (€2.99 => 2,99€) and translating text (Hello World! => Hallo Welt!). 
- *Pseudolocalization* is a software testing method used before the localization process in which fake (pseudo) translations (with the region and language specific characters) are generated: `Hello World!` => `[Hellö Wörld! ÜüäßÖ]`.

### Why use pseudolocalization?

The benefits of pseudolocalization are threefold:

1. To test that all (special) characters of the target locale (i.e. German) are displayed correctly.
2. To test that text boxes can accommodate longer translations. If a pseudo-translation is cutoff or visually looks ugly on the screen, then there's a good chance that the real translation will too.
3. To flag hardcoded strings or text images.

### Character Replacement

Generally pseudo-translations will replace characters in the English string (i.e. `Hello World`) with special (i.e. accented) characters from the target language. For German, the special characters `ä ö ü ß Ä Ö Ü ẞ` are mapped to vowels a, o and u, with ß mapped to b. Although ß is not linguistically related to b in German, visually similar characters are used to keep pseudo-translated strings readable for developers. Pseudo-translations may include accented letters as well as other visually distinct symbols, such as ¿.

### Text Expansion

When English is used as the base language, after translation many languages will exhibit *text expansion* and have longer text. Generally German extends by 10-35%, Polish 20-30% and Russian by 15%. Moreover, short English strings often expand proportionally more than longer strings during localization. Thus one approach to text expansion is to use a constant (say 40%), while another is to use a function of input text length returning values from 30-50%. Note that some languages (i.e. Japanese, Korean) generally contract and can actually have shorter text than their English counterparts.

### Text Expansion Format

There are multiple ways to format the text expansion, for instance:

- appending random special characters: `Hellö Wörld äßÜẞ`.
- repeating all vowels multiple times: `Heellöö Wöörld`.
- appending number words: `Hellö Wörld one two`.
- wrapping the base text with exclamation marks:  `!!! Hellö Wörld !!!`

Moreover, the text expansion is often wrapped in square brackets to easily determine UI clipping, while it may also use punctuation of the target language (i.e. ¿ and ¡ in Spanish).

### Pseudo-translations

Putting this altogether, the base string can be rendered as follows:

| English | Hello World!           |
| ------- | ---------------------- |
| German  | [Hellö Wörld! ÜüäßÖ]   |
| Polish  | [Hęęęłłóóó Wóórłd!]    |
| Russian | [!!! Нёлло Шоялд! !!!] |
| Spanish | [Hélló Wórld! one two] |

These pseudo-translations are intentionally nonsensical and do not represent real translations. They are used to verify that the application is ready for localization.
</details>

## Getting Started

Firstly, add the package as a dev dependency:

```yaml
dev_dependencies: 
  flutter_pseudolocalizor: 
```

Next define configuration settings in your project's `pubspec.yaml`:

```yaml
flutter_pseudolocalizor:
  input_filepath: "test.arb"
  replace_base: true
  unicode_blocks:
    - latinSupplement
    - latinExtendedA
  seed: 0
  use_brackets: true
  text_expansion_format: 'repeatVowels'
  text_expansion_ratio: null
  languages_to_generate:
    - de
    - pl
    - ru
  patterns_to_ignore:
    - '%(\S*?)\$[ds]'
    - 'Flutter'
  keys_to_ignore:
    - 'title'
  arb_settings:
    output_directory: 'l10n_pseudo'
  csv_settings:
    output_filepath: 'test_PSEUDO.csv'
    delimiter: ";"
    column_index: 1
```

| Setting                    | Description                                                                                                             |
| -------------------------- | ----------------------------------------------------------------------------------------------------------------------- |
| input_filepath             | A path to the input localization file.                                                                                  |
| replace_base               | Whether the base language (en) should be replaced. Defaults to `false`.                                                 |
| unicode_blocks             | When replace_base is true, a list of unicode blocks to use. Defaults to all.                                            |
| seed                       | A seed for random generators. Ensures pseudo strings are generated deterministically across runs.                       |
| text_expansion_format      | The format of the text expansion. Defaults to `repeatVowels`, alternatives `append`, `numberWords`, `exclamationMarks`. |
| text_expansion_ratio       | The ratio (between 1 and 3) of text expansion. If `null`, uses a linear function.                                       |
| languages_to_generate      | A list of languages to generate. Defaults to empty.                                                                     |
| patterns_to_ignore         | A list of patterns to ignore during text replacement.                                                                   |
| keys_to_ignore             | A list of keys that should not be pseudo-translated.                                                                    |
| arb_settings               | Optional settings when the input file is an arb, please see below for more info.                                        |
| csv_settings               | Optional settings when the input file is a csv file, please see below for more info.                                    |

`input_filepath` must be given, all other settings are optional. 

`replace_base` replaces the base language (en) with characters from `unicode_blocks`. To test specific languages, set `languages_to_generate` with a list of languages. `patterns_to_ignore` prevents pseudolocalization for specific patterns such as variables or product names.

| ARB Setting                | Description                                                                                                             |
| -------------------------- | ----------------------------------------------------------------------------------------------------------------------- |
| output_directory           | An optional directory for generated files. Defaults to `l10n_pseudo`.                                                   |

| CSV Setting                | Description                                                                                                             |
| -------------------------- | ----------------------------------------------------------------------------------------------------------------------- |
| output_filepath            | A path for the generated output file. Defaults to `<input_filename>_PSEUDO.csv`.                                        |
| delimiter                  | A delimiter to separate columns in the input CSV file. Defaults to `,`.                                                 |
| column_index               | The column index of the base language (en) in the input CSV file. Defaults to `1`.                                      |

Alternatively, these settings can be defined in `flutter_pseudolocalizor.yaml`

Ensure that your current working directory is the project root, then run the terminal command:

```sh
dart run flutter_pseudolocalizor
```

to generate output files.

## Future Plans

- Currently, Latin-1 Supplement and Latin Extended A, B and C are supported, covering most Latin-script languages.
- Add Latin Extended Additional to fully support Vietnamese.
- Support additional non-Latin scripts, including Arabic, Hindi, Korean, and other character-based writing systems such as Chinese and Japanese.
- Migrate from using plain String operations to Dart’s Characters Class for proper handling of multi-byte and combined Unicode characters.

## Collaboration

Spotted any issues? Please open [an issue on GitHub](https://github.com/defuncart/flutter_pseudolocalizor/issues)! Would like to contribute a new feature? Fork the repo and submit a PR!
