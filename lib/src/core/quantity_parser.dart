import 'package:intl/intl.dart';

import 'quantity.dart';
import 'quantity_format.dart';
import 'quantity_parse_exception.dart';
import 'unit.dart';

// --- Grouping size detection ---

/// The detected primary (rightmost) and secondary (intermediate) digit-group
/// sizes for a particular [NumberFormat].
///
/// Most Western locales use `(primary: 3, secondary: 3)` — the familiar
/// three-digit grouping.  Indian-script locales (hi_IN, bn_IN, …) use
/// `(primary: 3, secondary: 2)` — the 2-2-3 pattern where intermediate
/// groups are two digits wide.
typedef _GroupingSizes = ({int primary, int secondary});

/// Cache keyed by [NumberFormat] instance so that the probe is run at most
/// once per unique formatter object.  Uses [Expando] (weak-key semantics) to
/// avoid retaining formats that are no longer alive.
final _groupingSizesCache = Expando<_GroupingSizes>();

/// Detects the grouping sizes used by [nf] by formatting a probe integer.
///
/// `1234567` (seven digits) is chosen because it is large enough to generate
/// at least two group separators with any grouping scheme, which lets us
/// observe both the primary (final) and secondary (intermediate) sizes:
///
/// * en_US → `"1,234,567"` → primary = 3, secondary = 3
/// * hi_IN → `"12,34,567"` → primary = 3, secondary = 2
///
/// Falls back to `(primary: 3, secondary: 3)` when grouping is absent or
/// produces fewer than two separators.
_GroupingSizes _detectGroupingSizes(NumberFormat nf) {
  final groupSep = nf.symbols.GROUP_SEP;
  if (groupSep.isEmpty) return (primary: 3, secondary: 3);

  final formatted = nf.format(1234567);

  // Strip any fractional part (an integer probe should not produce one, but
  // be defensive in case a custom format has a minimum-fraction-digit setting).
  final decimalSep = nf.symbols.DECIMAL_SEP;
  final intPart = formatted.contains(decimalSep)
      ? formatted.substring(0, formatted.indexOf(decimalSep))
      : formatted;

  final segments = intPart.split(groupSep);

  // Need at least 3 segments (2 separators) to observe an intermediate group.
  if (segments.length < 2) return (primary: 3, secondary: 3);

  final primary = segments.last.length;
  // When there are only 2 segments (one separator) there is no intermediate
  // group — secondary defaults to primary.
  final secondary = segments.length >= 3 ? segments[segments.length - 2].length : primary;

  return (primary: primary, secondary: secondary);
}

// --- Character classes ---

/// Apostrophe variants used as thousands separators in locales like de_CH/de_LI:
/// straight apostrophe (U+0027),
/// left single quote (U+2018),
/// right single quote (U+2019).
const String _kApostrophes = "\u0027\u2018\u2019";

/// Standard separators that safely support variable digit grouping (e.g., hi_IN).
/// Includes whitespace, non-breaking space (\xA0), narrow no-break space (\u202F),
/// period, comma, and Arabic thousands separator (\u066C).
const String _kStandardSeps = r'\s\xA0\u202F\.,\u066C';

/// Characters representing safe visual separators that can be stripped globally
/// before validation, as they hold no mathematical decimal significance.
/// Includes spaces, non-breaking spaces, narrow no-break spaces, Arabic
/// thousands separators, and apostrophes.
const String _kVisualSeparators = r'\s\xA0\u202F\u0027\u2018\u2019\u066C';

/// Decimal digits supported by the parser.
/// Includes ASCII, Arabic-Indic, and Eastern Arabic-Indic digits.
const String _digit = r'[0-9\u0660-\u0669\u06F0-\u06F9]';

/// Optional fractional tail: a dot, comma, or Arabic decimal separator (\u066B)
/// followed by zero or more digits.
const String _optionalFraction = '[\\.,\\u066B]?$_digit*';

/// A number that starts with the decimal separator (e.g. `.5`, `,75`, `٫5`).
const String _leadingDecimal = '[\\.,\\u066B]$_digit+';

// --- Composed regex ---
//
// The quantity pattern is built from small, named pieces so that each part
// of the grammar is easy to read and maintain independently.

/// Optional leading `+` or `-`.
const String _sign = '[+-]?';

/// Contextual grouping match:
/// - Standard separators allow 1 or more digits (supports variable grouping like hi_IN: 12,34,567).
/// - Apostrophe/quote separators require EXACTLY 3 digits (supports de_CH/de_LI: 1'000,
///   while naturally rejecting composite imperial notation like 6'2").
const String _integerWithSeps = '$_digit+(?:[$_kStandardSeps]$_digit+|[$_kApostrophes]$_digit{3})*';

/// Optional scientific-notation suffix: `e`/`E`, optional sign, digits.
const String _optionalExponent = r'(?:[eE][+-]?\d+)?';

/// Special floating-point literals supported by Dart.
const String _specialNumbers = '(?:NaN|[+-]?Infinity)';

/// Matches a numeric value (group 1) followed by a unit suffix (group 2).
///
/// Supports integers, decimals, scientific notation, and a wide range of
/// international thousands separators so that locale-formatted strings can be
/// matched before being handed to the normaliser and validation engine.
final RegExp _quantityPattern = RegExp(
  '^'
  '($_specialNumbers|$_sign(?:$_integerWithSeps$_optionalFraction|$_leadingDecimal)$_optionalExponent)'
  r'\s*'
  r'(.+)$',
  unicode: true,
);

/// Matches one or more whitespace characters.
final RegExp _whitespacePattern = RegExp(r'\s+');

/// Parses Dart special floating-point literals when present.
double? _tryParseSpecialNumber(String numericPart) {
  switch (numericPart) {
    case 'NaN':
      return double.nan;
    case 'Infinity':
    case '+Infinity':
      return double.infinity;
    case '-Infinity':
      return double.negativeInfinity;
    default:
      return null;
  }
}

/// Counts non-overlapping occurrences of a substring within a string.
int _countOccurrences(String text, String needle) {
  if (needle.isEmpty) return 0;

  var count = 0;
  var start = 0;

  while (true) {
    final idx = text.indexOf(needle, start);
    if (idx == -1) return count;
    count++;
    start = idx + needle.length;
  }
}

/// Ensures the string is strictly valid for the given [NumberFormat] to prevent
/// the `intl` package from silently truncating unrecognised strings.
///
/// Accepts pre-computed string statistics ([hasDot], [hasComma], [dotCount],
/// [commaCount], [lastDotIndex], [lastCommaIndex]) so that when multiple formats
/// are tried for the same input, the string is scanned only once.
bool _isStrictlyValidForNumberFormat(
  String normalizedNumeric,
  NumberFormat nf, {
  required bool hasDot,
  required bool hasComma,
  required int dotCount,
  required int commaCount,
  required int lastDotIndex,
  required int lastCommaIndex,
  required _GroupingSizes groupingSizes,
}) {
  final decimalSep = nf.symbols.DECIMAL_SEP;
  final groupSep = nf.symbols.GROUP_SEP;

  // 1. ALIEN CHARACTER CHECK (Prevents intl silent truncation bug)
  // If the string contains a dot, comma, or Arabic decimal that the current locale
  // does not recognize as either a decimal or group separator, reject it immediately.
  if (hasDot && decimalSep != '.' && groupSep != '.') return false;
  if (hasComma && decimalSep != ',' && groupSep != ',') return false;
  if (normalizedNumeric.contains('\u066B') && decimalSep != '\u066B' && groupSep != '\u066B') {
    return false;
  }

  // 2. Prevent multiple decimal separators
  // Use pre-computed counts for the common separators; fall back to a scan for exotic ones.
  final decimalCount = decimalSep == '.'
      ? dotCount
      : decimalSep == ','
          ? commaCount
          : _countOccurrences(normalizedNumeric, decimalSep);
  if (decimalCount > 1) return false;

  // 3. Prevent grouping separators appearing after the decimal separator
  if (decimalCount == 1 && groupSep.isNotEmpty) {
    final decimalIndex = normalizedNumeric.indexOf(decimalSep);
    final groupAfterDecimal = normalizedNumeric.indexOf(
      groupSep,
      decimalIndex + decimalSep.length,
    );
    if (groupAfterDecimal != -1) return false;
  }

  // 4. Reject ambiguous mixed dot/comma placements under the current format.
  if (hasDot && hasComma) {
    if (decimalSep == '.' && groupSep == ',') {
      if (lastDotIndex < lastCommaIndex) {
        return false; // e.g. "1.234,56" under en_US is structurally invalid
      }
    } else if (decimalSep == ',' && groupSep == '.') {
      if (lastCommaIndex < lastDotIndex) {
        return false; // e.g. "1,234.56" under de_DE is structurally invalid
      }
    } else {
      return false; // Neither dot nor comma are the expected separators
    }
  }

  // 5. Validate grouping separator placement and digit counts (locale-aware).
  // Uses the sizes detected by _detectGroupingSizes so that variable-grouping
  // locales like hi_IN (2-2-3: "12,34,567") are accepted, while genuinely
  // malformed strings like "1,23,45" under en_US are still rejected.
  if (groupSep.isNotEmpty && groupSep != decimalSep && normalizedNumeric.contains(groupSep)) {
    final intPart = (decimalCount == 1)
        ? normalizedNumeric.substring(0, normalizedNumeric.indexOf(decimalSep))
        : normalizedNumeric;

    final segments = intPart.split(groupSep);

    if (segments.length > 1) {
      // Rightmost group must match the locale's primary (final) group size.
      if (segments.last.length != groupingSizes.primary) return false;

      // Every intermediate group must match the locale's secondary group size.
      // en_US: secondary = 3  →  "1,234,567"  ✓   "1,23,567"  ✗
      // hi_IN: secondary = 2  →  "12,34,567"  ✓   "1,234,567" ✗
      for (var i = 1; i < segments.length - 1; i++) {
        if (segments[i].length != groupingSizes.secondary) return false;
      }

      // The leading segment may be shorter (e.g. "1" in "1,234,567") but
      // must not be empty.
      if (segments.first.isEmpty) return false;
    }
  }

  return true;
}

/// An immutable, bulletproof parser for physical quantities.
///
/// Handles string parsing by extracting the numeric value and the unit symbol/name.
/// Uses a two-pass lookup strategy to safely distinguish case-sensitive SI prefixes
/// (like `Mm` vs `mm`) while providing a case-insensitive fallback for full unit
/// names and non-colliding units.
///
/// Instances are fully immutable. To parse with custom aliases, use [copyWithAliases]
/// to derive a new parser without affecting the original.
class QuantityParser<T extends Unit<T>, Q extends Quantity<T>> {
  /// Creates a new immutable parser with the given alias maps.
  QuantityParser({
    required Map<String, T> symbolAliases,
    required Map<String, T> nameAliases,
    required this.factory,
  })  : _symbolAliases = Map<String, T>.unmodifiable(symbolAliases),
        _nameAliases = Map<String, T>.unmodifiable({
          for (final entry in nameAliases.entries)
            entry.key.trim().replaceAll(_whitespacePattern, ' ').toLowerCase(): entry.value,
        });

  /// Factory used to create concrete quantities from parsed number+unit values.
  final Q Function(double, T) factory;

  final Map<String, T> _symbolAliases;
  final Map<String, T> _nameAliases;

  /// Returns a new parser that inherits all aliases from this instance plus
  /// any additional aliases provided.
  ///
  /// The original parser is not modified. Use this to create context-specific
  /// parsers without affecting the global [Quantity] parser.
  ///
  /// Example:
  /// ```dart
  /// final spanishParser = Length.parser.copyWithAliases(
  ///   extraNameAliases: {'pulgada': LengthUnit.inch},
  /// );
  /// final length = spanishParser.parse('55 pulgada');
  /// ```
  QuantityParser<T, Q> copyWithAliases({
    Map<String, T>? extraSymbolAliases,
    Map<String, T>? extraNameAliases,
  }) {
    return QuantityParser<T, Q>(
      symbolAliases: {
        ..._symbolAliases,
        if (extraSymbolAliases != null)
          for (final e in extraSymbolAliases.entries) e.key.trim(): e.value,
      },
      // Pass already-normalized keys through; constructor will re-normalize
      // (idempotent) so extra aliases are also normalized consistently.
      nameAliases: {
        ..._nameAliases,
        if (extraNameAliases != null) ...extraNameAliases,
      },
      factory: factory,
    );
  }

  /// Parses a string into a concrete quantity, throwing on failure.
  Q parse(
    String input, {
    List<QuantityFormat> formats = const [QuantityFormat.invariant],
  }) {
    final formatsToTry = formats.isEmpty ? const [QuantityFormat.invariant] : formats;
    final result = tryParse(input, formats: formatsToTry);
    if (result != null) return result;

    throw QuantityParseException(
      input: input,
      targetType: Q.toString(),
      formatsAttempted: formatsToTry.length,
    );
  }

  /// Attempts to parse a string into a numeric value and its unit.
  /// Returns `null` if the input cannot be parsed.
  Q? tryParse(
    String input, {
    List<QuantityFormat> formats = const [QuantityFormat.invariant],
  }) {
    final formatsToTry = formats.isEmpty ? const [QuantityFormat.invariant] : formats;

    final trimmed = input.trim();
    if (trimmed.isEmpty) return null;

    final match = _quantityPattern.firstMatch(trimmed);
    if (match == null) return null;

    final numericPart = match.group(1)!;
    final unitPart = match.group(2)!.trim();

    // Resolve the unit FIRST — fail fast if the unit is unknown.
    // 1. Strict symbol match (case-sensitive)
    var unit = _symbolAliases[unitPart];

    // 2. Normalized name match (case-insensitive)
    if (unit == null) {
      final normalizedUnit = unitPart.replaceAll(_whitespacePattern, ' ').toLowerCase();
      unit = _nameAliases[normalizedUnit];
    }

    if (unit == null) return null;

    final specialValue = _tryParseSpecialNumber(numericPart);
    if (specialValue != null) {
      return factory(specialValue, unit);
    }

    // NORMALIZE: Strip harmless visual grouping separators.
    // We remove spaces, narrow no-break spaces, and apostrophes globally.
    // We do NOT strip '.' or ',' here as they could be decimal markers.
    // This makes the string safe for 'double.tryParse' if it was SI-spaced (e.g. "1 000.5")
    // and eliminates 'intl' truncation vectors caused by unexpected visual spacing.
    final normalizedNumeric = numericPart.replaceAll(
      RegExp('[$_kVisualSeparators]'),
      '',
    );

    // Pre-compute string statistics once to avoid redundant scans per format.
    final hasDot = normalizedNumeric.contains('.');
    final hasComma = normalizedNumeric.contains(',');
    final dotCount = hasDot ? _countOccurrences(normalizedNumeric, '.') : 0;
    final commaCount = hasComma ? _countOccurrences(normalizedNumeric, ',') : 0;
    final lastDotIndex = hasDot ? normalizedNumeric.lastIndexOf('.') : -1;
    final lastCommaIndex = hasComma ? normalizedNumeric.lastIndexOf(',') : -1;

    // Try formats in order to parse the number.
    for (final format in formatsToTry) {
      final nf = format.effectiveNumberFormat;
      if (nf != null) {
        // Detect (and cache) the locale's grouping sizes once per NumberFormat
        // instance — the probe runs only on the first call for each formatter.
        var groupingSizes = _groupingSizesCache[nf];
        if (groupingSizes == null) {
          groupingSizes = _detectGroupingSizes(nf);
          _groupingSizesCache[nf] = groupingSizes;
        }

        if (!_isStrictlyValidForNumberFormat(
          normalizedNumeric,
          nf,
          hasDot: hasDot,
          hasComma: hasComma,
          dotCount: dotCount,
          commaCount: commaCount,
          lastDotIndex: lastDotIndex,
          lastCommaIndex: lastCommaIndex,
          groupingSizes: groupingSizes,
        )) {
          continue;
        }

        final value = nf.tryParse(normalizedNumeric)?.toDouble();
        if (value != null) return factory(value, unit);
      } else {
        // Invariant mode: strict Dart-native parsing (dot decimal, no comma separators).
        // Since we stripped spaces in the normalization step, SI-spaced values like "10 000.5"
        // will safely parse as 10000.5 here.
        final value = double.tryParse(normalizedNumeric);
        if (value != null) return factory(value, unit);
      }
    }

    return null;
  }
}
