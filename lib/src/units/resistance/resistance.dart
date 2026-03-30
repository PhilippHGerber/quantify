import 'package:meta/meta.dart';

import '../../core/linear_quantity.dart';
import '../../core/quantity_format.dart';
import '../../core/quantity_parse_exception.dart' show QuantityParseException;
import '../../core/quantity_parser.dart';
import '../current/current.dart';
import '../current/current_extensions.dart';
import '../current/current_unit.dart';
import '../power/power.dart';
import '../voltage/voltage.dart';
import '../voltage/voltage_extensions.dart';
import '../voltage/voltage_unit.dart';
import 'resistance_unit.dart';

/// Represents a quantity of electrical resistance.
///
/// Electrical resistance is a measure of the opposition to current flow in a
/// circuit. The SI derived unit for resistance is the Ohm (Ω), defined by
/// Ohm's law as the ratio of voltage to current (R = V / I).
///
/// This class provides a type-safe way to handle resistance values and
/// conversions between different units (e.g., ohms, kiloohms, megaohms).
@immutable
final class Resistance extends LinearQuantity<ResistanceUnit, Resistance> {
  /// Creates a new `Resistance` quantity with the given numerical [value] and [unit].
  ///
  /// Example:
  /// ```dart
  /// final resistor = Resistance(470, ResistanceUnit.ohm);
  /// final pullUp = Resistance(4.7, ResistanceUnit.kiloohm);
  /// final insulation = Resistance(10, ResistanceUnit.megaohm);
  /// ```
  const Resistance(super._value, super._unit);

  /// Creates a [Resistance] from [Voltage] and [Current] using Ohm's law (R = V / I).
  ///
  /// Both inputs are converted to SI base units (volts and amperes) before
  /// dividing. The result is returned in ohms.
  ///
  /// ```dart
  /// final voltage = 12.V;
  /// final current = 0.5.A;
  /// final resistance = Resistance.fromOhmsLaw(voltage, current); // 24.0 Ω
  /// ```
  factory Resistance.fromOhmsLaw(Voltage voltage, Current current) =>
      Resistance(voltage.inVolts / current.inAmperes, ResistanceUnit.ohm);

  @override
  @protected
  Resistance create(double value, ResistanceUnit unit) => Resistance(value, unit);

  /// The parser instance used to convert strings into [Resistance] objects.
  ///
  /// The parser supports both strict symbol aliases and case-insensitive name
  /// aliases configured in [ResistanceUnit].
  static final QuantityParser<ResistanceUnit, Resistance> parser =
      QuantityParser<ResistanceUnit, Resistance>(
    symbolAliases: ResistanceUnit.symbolAliases,
    nameAliases: ResistanceUnit.nameAliases,
    factory: Resistance.new,
  );

  /// Parses a string representation of resistance into a [Resistance] object.
  ///
  /// Throws [QuantityParseException] if parsing fails.
  ///
  /// Example:
  /// ```dart
  /// final r1 = Resistance.parse('470 Ω');   // 470 ohms
  /// final r2 = Resistance.parse('4.7 kΩ');  // 4.7 kiloohms
  /// final r3 = Resistance.parse('10 MΩ');   // 10 megaohms
  /// ```
  static Resistance parse(
    String input, {
    List<QuantityFormat> formats = const [QuantityFormat.invariant],
  }) {
    return parser.parse(input, formats: formats);
  }

  /// Attempts to parse a string representation of resistance.
  /// Returns `null` if parsing fails.
  ///
  /// Example:
  /// ```dart
  /// final valid = Resistance.tryParse('470 ohms');  // Resistance(470.0, ResistanceUnit.ohm)
  /// final invalid = Resistance.tryParse('invalid');  // null
  /// ```
  static Resistance? tryParse(
    String input, {
    List<QuantityFormat> formats = const [QuantityFormat.invariant],
  }) {
    return parser.tryParse(input, formats: formats);
  }

  /// Calculates the [Voltage] across this resistance for a given [Current]
  /// using Ohm's law (V = I × R).
  ///
  /// Both values are converted to SI base units (ohms and amperes) before
  /// multiplying. The result is returned in volts.
  ///
  /// ```dart
  /// final resistor = 100.ohms;
  /// final current = 0.5.A;
  /// final voltage = resistor.voltageAt(current); // 50.0 V
  /// ```
  Voltage voltageAt(Current current) => Voltage(
        getValue(ResistanceUnit.ohm) * current.inAmperes,
        VoltageUnit.volt,
      );

  /// Calculates the [Current] through this resistance for a given [Voltage]
  /// using Ohm's law (I = V / R).
  ///
  /// Both values are converted to SI base units (volts and ohms) before
  /// dividing. The result is returned in amperes.
  ///
  /// ```dart
  /// final resistor = 100.ohms;
  /// final voltage = 12.V;
  /// final current = resistor.currentAt(voltage); // 0.12 A
  /// ```
  Current currentAt(Voltage voltage) => Current(
        voltage.inVolts / getValue(ResistanceUnit.ohm),
        CurrentUnit.ampere,
      );

  /// Calculates the [Power] dissipated by this resistance for a given [Current]
  /// using Joule's law (P = I² × R).
  ///
  /// The result unit is determined by the [current] and resistance unit
  /// combination — see [Power.fromCurrentAndResistance] for the full mapping.
  ///
  /// ```dart
  /// 50.ohms.powerFrom(2.A);         // 200.0 W
  /// 10.kiloohms.powerFrom(100.mA);  // 100.0 mW
  /// ```
  Power powerFrom(Current current) => Power.fromCurrentAndResistance(current, this);

  /// Calculates the [Power] dissipated by this resistance for a given [Voltage]
  /// using the formula P = V² / R.
  ///
  /// The result unit is determined by the [voltage] and resistance unit
  /// combination — see [Power.fromVoltageAndResistance] for the full mapping.
  ///
  /// ```dart
  /// 50.ohms.powerAt(100.V);       // 200.0 W
  /// 1.kiloohms.powerAt(10.V);     // 100.0 mW
  /// ```
  Power powerAt(Voltage voltage) => Power.fromVoltageAndResistance(voltage, this);
}
