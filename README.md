# flutter_pseudolocalizor

A Pseudolocalization tool for Flutter which generates pseudo, nonsensical translations for multiple languages from a given English source.

## Pseudolocalization

- *Internationalization* is the process of designing a software application so that it can easily be adapted to various other languages and regions without any programming changes. 
- *Localization* is the process of adapting internationalized software for a specific region or language by adding locale-specific components (€2.99 => 2,99€) and translating text (Hello World! => Hallo Welt!). 
- *Pseudolocalization* is a software testing method used before the localization process in which a fake (or pseudo) translations (with the region and language specific characters) are generated: `Hello World!` => `[ Hellö Wörld! ÜüäßÖ ]`.

The benefits of pseudolocalization are three fold:

1. To test that all (special) characters of the target locale (i.e. German) are displayed correctly.
2. To test that text boxes can accommodate longer translations. If a pseduotranslation is cutoff or visually looks ugly on the screen, then there's a good chance that the real translation will too.
3. To flag hardcoded strings or text images.

### Character Replacement

Generally psuedo translations will replace characters in the English string (i.e. `Hello World`) with special (i.e. accented) characters from the target language. Considering German, the special characters `ä ö ü ß Ä Ö Ü ẞ` could be mapped to vowels a, o and u, with ß mapped to b. Although the letter ß has no relationship to b in German, what is important here is that the text is as readable as possible for the developer. The pseudo translation may also use a mixture of all UTF-8 special characters.

### Text Expansion

Considering English as the base language, after translation many languages will exhibit *text expansion* and have longer text strings. Generally German extends by 10-35%, Polish 20-30% and Russian by 15%. Moreover, shorter English text strings tends to expanded even more than larger strings. Thus one approach to text expansion is to use a constant (say 40%), while another is to use a function of input text length returning values from 30-50%. Note that some languages (i.e. Japanese, Korean) generally contract and can actually have shorter text strings than their English counterparts.

### Text Expansion Format

There are multiple ways to format the text expansion, for instance:

- appending random special characters: `Hellö Wörld äßÜẞ`.
- repeating all vowels multiple times: `Heellöö Wöörld`.
- appending number words: `Hellö Wörld one two`.
- wrapping the base text with exclamation marks:  `!!! Hellö Wörld !!!`)

Moreover, the text expansion is often wrapped in square brackets to easily determine UI clipping, while it may also use punctuation of the target language (i.e. ¿ and ¡ in Spanish).

### Pseudo Translations

Putting this altogether, the base string can be rendered as follows:

| English | Hello World!           |
| ------- | ---------------------- |
| German  | [Hellö Wörld! ÜüäßÖ]   |
| Polish  | [Hęęęłłóóó Wóórłd!]    |
| Russian | [!!! Нёлло Шоялд! !!!] |
| Spanish | [Hélló Wórld! one two] |

It is important to remember that these pseduotranslations are nonsensical: they are not real translations, instead merely a way to test that the app is ready for the translation stage.

## Getting Started

Firstly, add the package as a dev dependency:

```yaml
dev_dependencies: 
  flutter_pseudolocalizor: 
```

Next define settings in `pubspec.yaml` for the package:

```yaml
flutter_pseudolocalizor:
  input_filepath: "test.arb"
  replace_base: true
  unicode_blocks:
    - latinSupplement
    - latinExtendedA
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
| text_expansion_format      | The format of the text expansion. Defaults to `repeatVowels`, alternatives `append`, `numberWords`, `exclamationMarks`. |
| text_expansion_ratio       | The ratio (between 1 and 3) of text expansion. If `null`, uses a linear function.                                       |
| languages_to_generate      | A list of languages to generate. Defaults to empty.                                                                     |
| patterns_to_ignore         | A list of patterns to ignore during text replacement.                                                                   |
| keys_to_ignore             | A list of keys which should be ignored.                                                                                 |
| arb_settings               | Optional settings when the input file is an arb, please see below for more info.                                        |
| csv_settings               | Optional settings when the input file is a csv file, please see below for more info.                                    |

`input_filepath` must be given, all other settings are optional. 

`replace_base` replaces the base language (en) with characters from `unicode_blocks`. To test specific languages, set `languages_to_generate` with a list of languages. `patterns_to_ignore` is especially useful to avoid text replacement for certain know constructs, for instance a product name or a pattern `%myVar$d` used to parse variables from text.

| ARB Setting                | Description                                                                                                             |
| -------------------------- | ----------------------------------------------------------------------------------------------------------------------- |
| output_directory           | An optional directory for generated files. Defaults to `l10n_pseudo`.                                                   |

| CSV Setting                | Description                                                                                                             |
| -------------------------- | ----------------------------------------------------------------------------------------------------------------------- |
| output_filepath            | A path for the generated output file. Defaults to `<input_filename>_PSEUDO.csv`.                                        |
| delimiter                  | A delimiter to separate columns in the input CSV file. Defaults to `,`.                                                 |
| column_index               | The column index of the base language (en) in the input CSV file. Defaults to `1`.                                      |

Ensure that your current working directory is the project root, then run the terminal command:

```sh
dart run flutter_pseudolocalizor
```

or

```sh
flutter pub run flutter_pseudolocalizor
```

to generate output files.

## Future Plans

- Presently 500 non-basic latin characters are available. 
  - IPA Extensions, Phonetic Extensions, Latin Extended Additional, Latin Extended Additional, Letterlike symbols will be considered in future versions.
- Although 8 languages are currently supported, some of the world's most spoken languages like Arabic, Chinese and Hindi are not supported. 
  - For languages with their own alphabets (like Arabic, Armenian, Georgian, Hindi, Korean etc.), one approach could be to append random letters from the alphabet onto the original English text.
  - For character based writing systems like Chinese, Japanese etc., maybe random characters could be appended to the original English text.
- If the Russian mapping is positively received, other languages which use the Cyrillic alphabet and Greek could be similarly implemented.
- Migrate to use Characters class over Strings.

## Collaboration

Spotted any issues? Please open [an issue on GitHub](https://github.com/defuncart/flutter_pseudolocalizor/issues)! Would like to contribute a new language or feature? Fork the repo and submit a PR!
