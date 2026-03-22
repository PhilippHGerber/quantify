import 'package:meta/meta.dart';

import '../../core/linear_quantity.dart';
import '../../core/quantity_format.dart';
import '../../core/quantity_parser.dart';
import 'information_unit.dart';

/// Represents a physical quantity of digital information.
///
/// Supports both SI/decimal units (`kB`, `MB`, `GB`, …) and IEC/binary units
/// (`KiB`, `MiB`, `GiB`, …). The base unit for internal storage is the Bit.
///
/// ```dart
/// final total = 500.MB + 1.GB;  // Information
/// print(total.inMB);             // 1500.0
/// print(total.inGiB);            // ~1.3969838619232178
/// ```
@immutable
class Information extends LinearQuantity<InformationUnit, Information> {
  /// Creates a new [Information] quantity with the given numerical [value] and [unit].
  ///
  /// Example:
  /// ```dart
  /// final size = Information(1.5, InformationUnit.gigabyte);
  /// final capacity = Information(512, InformationUnit.kibibyte);
  /// ```
  const Information(super._value, super._unit);

  @override
  @protected
  Information create(double value, InformationUnit unit) => Information(value, unit);

  /// The parser instance used to convert strings into [Information] objects.
  ///
  /// Symbol parsing is strictly case-sensitive: `'b'` → bit, `'B'` → byte,
  /// `'kB'` → kilobyte (SI), `'KiB'` → kibibyte (IEC).
  ///
  /// Create isolated parser variants to support custom or localized aliases:
  /// ```dart
  /// final customParser = Information.parser.copyWithAliases(
  ///   extraNameAliases: {'octet': InformationUnit.byte},
  /// );
  /// final custom = customParser.parse('8 octet');
  /// ```
  static final QuantityParser<InformationUnit, Information> parser =
      QuantityParser<InformationUnit, Information>(
    symbolAliases: InformationUnit.symbolAliases,
    nameAliases: InformationUnit.nameAliases,
    factory: Information.new,
  );

  /// Parses a string representation of an information quantity into an [Information] object.
  ///
  /// The [input] string should follow the format `"<number> <unit>"`.
  ///
  /// Symbol parsing is **strictly case-sensitive**:
  /// - `'1 b'` → 1 bit
  /// - `'1 B'` → 1 byte
  /// - `'1 kB'` → 1 kilobyte (SI, 1 000 bytes)
  /// - `'1 KiB'` → 1 kibibyte (IEC, 1 024 bytes)
  ///
  /// The [formats] list controls how the numeric portion is interpreted. Formats
  /// are tried in order; the first that successfully parses the number wins.
  /// Defaults to [QuantityFormat.invariant] (Dart-native dot-decimal parsing).
  ///
  /// Throws a [FormatException] if no format can parse the input.
  ///
  /// Example:
  /// ```dart
  /// final size = Information.parse('1.5 GiB');
  /// final de = Information.parse('1,5 GB', formats: [QuantityFormat.de]);
  /// ```
  static Information parse(
    String input, {
    List<QuantityFormat> formats = const [QuantityFormat.invariant],
  }) =>
      parser.parse(input, formats: formats);

  /// Parses a string representation of an information quantity into an [Information] object,
  /// returning `null` if the string cannot be parsed.
  ///
  /// See [parse] for details on [formats] and symbol case sensitivity.
  ///
  /// Example:
  /// ```dart
  /// final size = Information.tryParse('1.5 GiB'); // Information(1.5, ...)
  /// final bad  = Information.tryParse('not info'); // null
  /// ```
  static Information? tryParse(
    String input, {
    List<QuantityFormat> formats = const [QuantityFormat.invariant],
  }) =>
      parser.tryParse(input, formats: formats);
}
