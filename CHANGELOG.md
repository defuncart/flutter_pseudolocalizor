## [0.5.0] - XX/XX/2021

* Added repeated vowels, number words and exclamation marks as text expansion formats.
* Added ability to completely ignore certain keys during text replacement. This is a breaking change as previously line numbers were used.
* Moved outputFilepath setting to CSVSettings. This is a minor breaking change.
* Improved code coverage.

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
