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

### Text Format

There are many different ways to format the pseudo text, for instance:

- doubling the length of all vowels (i.e. `Heellöö Wöörld`).
- wrapping the text in square brackets and using the words *one*, *two*, *three* etc. as text expansion (i.e `[Hello World one]`).
- wrapping the text in square brackets and !!! (i.e. `[ !!! Hellö Wörld !!! ]`)
- wrapping the text in square brackets and prepending random special characters as text expansion (ie. `[ Hellö Wörld äßÜẞ ]`).

**Note:** The text expansion may also use punctuation of the target language (i.e. ¿ and ¡ in Spanish).

### Pseudo Translations

Putting this altogether, we could render our base string as follows:

| English | Hello World!           |
| ------- | ---------------------- |
| German  | [ Hellö Wörld! ÜüäßÖ ] |
| Polish  | [ Hęłłó Wórłd! ęśżĘŚ ] |
| Russian | [ Нёлло Шоялд! ОТЧжт ] |

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
  lines_to_ignore:
    - 2
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
| lines_to_ignore              | A list of line numbers which should be ignored.                                          |

`input_filepath` must be given, all other settings are optional. If Latin-1 Supplement and Latin Extended-A letters should be tested, set `replace_base` to true. To test specific languages, set `languages_to_generate` with an array of languages.

Ensure that your current working directory is the project root. Given the localization file `test.csv`, simply run the terminal command:

```
flutter pub run flutter_pseudolocalizor
```

to generate `test-PSEUDO.csv`. This generated file can then be incorporated into your dev build using a package like [flappy_translator](https://pub.dev/packages/flappy_translator).

Note that `patterns_to_ignore` is especially useful to avoid text replacement for certain know constructs, for instance a product name or a pattern ``%myVar$d` used to parse variables from text.

## Limitations

- Only CSV input files are supported.
- Supports Latin-1 Supplement and Latin Extended-A but not Latin Extended-B or Latin Extended-C.
- The following languages are supported: de, es, fr, it, pl, pt, ru and tr.
- Only text expansion is considered.
- Only one character replacement style.
- Except for Spanish, punctuation isn't considered for text expansion.
- No ability to ignore certain text constructs (i.e. `%myVar$d`) when replacing characters.

## Future Plans

- Although 8 languages are currently supported, some of the world's most spoken languages like Arabic, Chinese and Hindi are not supported. 
  - For languages with their own alphabets (like Arabic, Armenian, Georgian, Hindi, Korean etc.), one approach could be to append random letters from the alphabet onto the original English text.
  - For character based writing systems like Chinese, Japanese etc., maybe random characters could be appended to the original English text.
- Add support for Latin Extended-B and Latin Extended-C.
- Presently Latin-1 Supplement and Latin Extended-A letters can be tested using `replace_base` option. If there is demand for specific language implementations which use the extended-Latin alphabet (i.e. Romanian, Czech etc.), these could be added per request.
- If the Russian mapping is positively received, other languages which use the Cyrillic alphabet and Greek could be similarly implemented.

## Collaboration

Spotted any issues? Please open [an issue on GitHub](https://github.com/defuncart/flutter_pseudolocalizor/issues)! Would like to contribute a new language or feature? Fork the repo and submit a PR!
