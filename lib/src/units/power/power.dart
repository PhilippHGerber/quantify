import 'package:meta/meta.dart';

import '../../../quantify.dart' show QuantityParseException;
import '../../core/linear_quantity.dart';
import '../../core/quantity_format.dart';
import '../../core/quantity_parse_exception.dart' show QuantityParseException;
import '../../core/quantity_parser.dart';
import 'power_unit.dart';

/// Represents a quantity of power.
///
/// Power is the rate at which energy is transferred or work is done.
/// The SI derived unit for power is the Watt (W), defined as one Joule per second.
/// This class provides a type-safe way to handle power values and conversions
/// between different units (e.g., watts, horsepower, Btu/h).
@immutable
class Power extends LinearQuantity<PowerUnit, Power> {
  /// Creates a new `Power` quantity with the given numerical [value] and [unit].
  ///
  /// Example:
  /// ```dart
  /// final lightBulbPower = Power(60.0, PowerUnit.watt);
  /// final carEnginePower = Power(150.0, PowerUnit.horsepower);
  /// final nuclearPlantOutput = Power(1.2, PowerUnit.gigawatt);
  /// ```
  const Power(super._value, super._unit);

  @override
  @protected
  Power create(double value, PowerUnit unit) => Power(value, unit);

  /// The parser instance used to convert strings into [Power] objects.
  ///
  /// The parser supports all standard units including symbols and full names.
  static final QuantityParser<PowerUnit, Power> parser = QuantityParser<PowerUnit, Power>(
    symbolAliases: PowerUnit.symbolAliases,
    nameAliases: PowerUnit.nameAliases,
    factory: Power.new,
  );

  /// Parses a string representation of power into a [Power] object.
  ///
  /// Throws [QuantityParseException] if parsing fails.
  ///
  /// Example:
  /// ```dart
  /// final p1 = Power.parse('100 W');   // 100 watts
  /// final p2 = Power.parse('5 kW');    // 5 kilowatts
  /// final p3 = Power.parse('150 hp');  // 150 horsepower
  /// ```
  static Power parse(
    String input, {
    List<QuantityFormat> formats = const [QuantityFormat.invariant],
  }) {
    return parser.parse(input, formats: formats);
  }

  /// Attempts to parse a string representation of power. Returns `null` if parsing fails.
  ///
  /// Example:
  /// ```dart
  /// final valid = Power.tryParse('100 watts');  // Power(100.0, PowerUnit.watt)
  /// final invalid = Power.tryParse('invalid');  // null
  /// ```
  static Power? tryParse(
    String input, {
    List<QuantityFormat> formats = const [QuantityFormat.invariant],
  }) {
    return parser.tryParse(input, formats: formats);
  }
}
