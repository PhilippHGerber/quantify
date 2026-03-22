import 'package:meta/meta.dart';

import '../../core/linear_quantity.dart';
import '../../core/quantity_format.dart';
import '../../core/quantity_parser.dart';
import 'current_unit.dart';

/// Represents a quantity of electric current.
///
/// Electric current is the rate of flow of electric charge. The SI base unit
/// for electric current is the Ampere (A). It is a fundamental quantity in
/// electrical engineering and physics.
///
/// This class provides a type-safe way to handle electric current values and
/// conversions between different units (e.g., amperes, milliamperes, kiloamperes).
@immutable
class Current extends LinearQuantity<CurrentUnit, Current> {
  /// Creates a new `Current` quantity with the given numerical [value] and [unit].
  ///
  /// Example:
  /// ```dart
  /// final circuitCurrent = Current(1.5, CurrentUnit.ampere);
  /// final sensorOutput = Current(20.0, CurrentUnit.milliampere);
  /// ```
  const Current(super._value, super._unit);

  @override
  @protected
  Current create(double value, CurrentUnit unit) => Current(value, unit);

  /// The parser instance used to convert strings into [Current] objects.
  ///
  /// The parser supports both strict symbol aliases and case-insensitive name
  /// aliases configured in [CurrentUnit].
  static final QuantityParser<CurrentUnit, Current> parser = QuantityParser<CurrentUnit, Current>(
    symbolAliases: CurrentUnit.symbolAliases,
    nameAliases: CurrentUnit.nameAliases,
    factory: Current.new,
  );

  /// Parses a string representation of electric current into a [Current]
  /// object.
  ///
  /// The [formats] list controls how the numeric portion is interpreted.
  static Current parse(
    String input, {
    List<QuantityFormat> formats = const [QuantityFormat.invariant],
  }) {
    return parser.parse(input, formats: formats);
  }

  /// Parses a string representation of electric current into a [Current]
  /// object, returning `null` when parsing fails.
  ///
  /// See [parse] for formatting and matching behavior.
  static Current? tryParse(
    String input, {
    List<QuantityFormat> formats = const [QuantityFormat.invariant],
  }) {
    return parser.tryParse(input, formats: formats);
  }

  // Potential future enhancements for Current:
  // - Current * Time = ElectricCharge (would require ElectricCharge type)
  // - ElectricPotential / Current = Resistance (would require ElectricPotential and Resistance types)
  // - Power / Current = ElectricPotential (would require Power and ElectricPotential types)
}
