import 'package:meta/meta.dart';

import '../../core/quantity.dart';
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
class Information extends Quantity<InformationUnit> {
  /// Creates a new [Information] quantity with the given numerical [value] and [unit].
  ///
  /// Example:
  /// ```dart
  /// final size = Information(1.5, InformationUnit.gigabyte);
  /// final capacity = Information(512, InformationUnit.kibibyte);
  /// ```
  const Information(super._value, super._unit);

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

  /// Converts this information quantity's value to the specified [targetUnit].
  ///
  /// Example:
  /// ```dart
  /// final size = Information(1, InformationUnit.gigabyte);
  /// final inMB = size.getValue(InformationUnit.megabyte); // 1000.0
  /// final inGiB = size.getValue(InformationUnit.gibibyte); // ~0.9313225746154785
  /// ```
  @override
  double getValue(InformationUnit targetUnit) {
    if (targetUnit == unit) return value;
    return value * unit.factorTo(targetUnit);
  }

  /// Creates a new [Information] instance with the value converted to the [targetUnit].
  ///
  /// Example:
  /// ```dart
  /// final oneGB = Information(1, InformationUnit.gigabyte);
  /// final inMB = oneGB.convertTo(InformationUnit.megabyte); // Information(1000.0, ...)
  /// ```
  @override
  Information convertTo(InformationUnit targetUnit) {
    if (targetUnit == unit) return this;
    return Information(getValue(targetUnit), targetUnit);
  }

  /// Compares this [Information] object to another [Quantity<InformationUnit>].
  ///
  /// Comparison is based on the true physical magnitude, automatically handling
  /// unit conversions (e.g., comparing SI gigabytes to IEC gibibytes).
  @override
  int compareTo(Quantity<InformationUnit> other) {
    final thisValueInOtherUnit = getValue(other.unit);
    return thisValueInOtherUnit.compareTo(other.value);
  }

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

  // --- Arithmetic Operators ---

  /// Adds this information quantity to another.
  ///
  /// [other] is converted to the unit of this quantity before addition.
  Information operator +(Information other) =>
      Information(value + other.getValue(unit), unit);

  /// Subtracts another information quantity from this one.
  ///
  /// [other] is converted to the unit of this quantity before subtraction.
  Information operator -(Information other) =>
      Information(value - other.getValue(unit), unit);

  /// Multiplies this information quantity by a dimensionless scalar.
  Information operator *(double scalar) => Information(value * scalar, unit);

  /// Divides this information quantity by a dimensionless scalar.
  ///
  /// Throws an [ArgumentError] if [scalar] is zero.
  Information operator /(double scalar) {
    if (scalar == 0) throw ArgumentError('Cannot divide by zero.');
    return Information(value / scalar, unit);
  }
}
