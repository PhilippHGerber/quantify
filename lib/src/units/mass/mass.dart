import 'package:meta/meta.dart';

import '../../core/linear_quantity.dart';
import '../../core/quantity_format.dart';
import '../../core/quantity_parser.dart';
import 'mass_unit.dart';

/// Represents a physical quantity of mass.
///
/// Mass is a fundamental physical property of matter, measuring an object's
/// resistance to acceleration when a net force is applied. The SI base unit
/// is the Kilogram (kg).
///
/// This class provides a type-safe way to handle mass values, convert between
/// different units (e.g., kilograms, grams, pounds, ounces), and perform
/// arithmetic operations.
@immutable
final class Mass extends LinearQuantity<MassUnit, Mass> {
  /// Creates a new [Mass] quantity with the given numerical [value] and [unit].
  ///
  /// Example:
  /// ```dart
  /// final personWeightKg = Mass(70.0, MassUnit.kilogram);
  /// final sugarAmountGrams = Mass(500.0, MassUnit.gram);
  /// final packageWeightLbs = Mass(5.0, MassUnit.pound);
  /// ```
  const Mass(super._value, super._unit);

  @override
  @protected
  Mass create(double value, MassUnit unit) => Mass(value, unit);

  /// The parser instance used to convert strings into [Mass] objects.
  ///
  /// The parser supports all standard units and handles both case-sensitive SI
  /// symbols (like `Mg` vs `mg`) and case-insensitive unit names.
  ///
  /// Create isolated parser variants to support custom or localized aliases:
  /// ```dart
  /// final customParser = Mass.parser.copyWithAliases(
  ///   extraNameAliases: {'libra': MassUnit.pound},
  /// );
  /// final custom = customParser.parse('50 libra');
  /// ```
  static final QuantityParser<MassUnit, Mass> parser = QuantityParser<MassUnit, Mass>(
    symbolAliases: MassUnit.symbolAliases,
    nameAliases: MassUnit.nameAliases,
    factory: Mass.new,
  );

  /// Parses a string representation of a mass into a [Mass] object.
  ///
  /// The [input] string should follow the format `"<number> <unit>"`, where the
  /// space between the number and unit is optional.
  ///
  /// - **SI Prefixes**: Strictly case-sensitive (`10 mg` is milligrams,
  ///   `10 Mg` is megagrams).
  /// - **Imperial/US Units**: Case-insensitive (`180 lbs`, `180 LBS`, and
  ///   `180 Lbs` all parse correctly).
  ///
  /// The [formats] list controls how the numeric portion is interpreted. Formats
  /// are tried in order; the first that successfully parses the number wins.
  /// Defaults to [QuantityFormat.invariant] (Dart-native dot-decimal parsing).
  ///
  /// Throws a [FormatException] if no format can parse the input.
  ///
  /// Example:
  /// ```dart
  /// final weight = Mass.parse('180 lbs');
  /// final de = Mass.parse('1.234,56 kg', formats: [QuantityFormat.de]);
  /// ```
  static Mass parse(
    String input, {
    List<QuantityFormat> formats = const [QuantityFormat.invariant],
  }) =>
      parser.parse(input, formats: formats);

  /// Parses a string representation of a mass into a [Mass] object,
  /// returning `null` if the string cannot be parsed.
  ///
  /// The [input] string should follow the format `"<number> <unit>"`.
  /// See [parse] for details on [formats].
  ///
  /// Example:
  /// ```dart
  /// final weight = Mass.tryParse('180 lbs'); // Mass(180.0, ...)
  /// final bad = Mass.tryParse('not a mass'); // null
  /// ```
  static Mass? tryParse(
    String input, {
    List<QuantityFormat> formats = const [QuantityFormat.invariant],
  }) =>
      parser.tryParse(input, formats: formats);
}
