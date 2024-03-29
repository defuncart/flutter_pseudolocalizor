## [0.5.1] - 24/07/2021

* Fixes a bug where in the case of generating languages and not replacing base, when output directory did not exist, generation would fail.

## [0.5.0] - 29/06/2021

* Added ARB file support.
* Added repeated vowels, number words and exclamation marks as text expansion formats.
* Added ability to completely ignore certain keys during text replacement. This is a minor breaking change as previously line numbers were used.
* Added ability to use both replace_base and languages_to_generate together.
* Added Latin Extended B, Latin Extended C and Superscripts and Subscripts special characters.
* Moved outputFilepath setting to CSVSettings. This is a minor breaking change.

## [0.4.0] - 07/04/2021

* Aligns analysis options to pedantic used by Google instead of custom Effective Dart options.
* Null safety migration.

## [0.3.0] - 28/07/2020

* Added ability to completely ignore certain lines during text replacement.
* Removed dependency on Flutter, thus Dart-only projects can now avail of this package.
* Improved code coverage.

## [0.2.0] - 04/02/2020

* Added Setting to ignore certain expressions during text replacement, i.e. product name or regexp for variables.

## [0.1.0] - 10/12/2019

* Initial beta version.
* Generates pseudolocalizations with a selection of extended Latin characters for given localization strings.
* Pseudolocalizations can be also generated for specific languages (de, es, fr, it, pl, pt, ru and tr).
* Ability to wrap pseudo texts in square brackets.
* Ability to set text expansion ratio (from 1 to 3).
* Supports CSV localization files.
