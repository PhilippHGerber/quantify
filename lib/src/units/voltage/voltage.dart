import 'package:meta/meta.dart';

import '../../core/linear_quantity.dart';
import '../../core/quantity_format.dart';
import '../../core/quantity_parse_exception.dart' show QuantityParseException;
import '../../core/quantity_parser.dart';
import '../current/current.dart';
import '../current/current_extensions.dart';
import '../current/current_unit.dart';
import '../electric_charge/electric_charge.dart';
import '../electric_charge/electric_charge_unit.dart';
import '../energy/energy.dart';
import '../energy/energy_extensions.dart';
import '../power/power.dart';
import '../power/power_unit.dart';
import '../resistance/resistance.dart';
import '../resistance/resistance_unit.dart';
import 'voltage_unit.dart';

/// Represents a quantity of electric potential (voltage).
///
/// Electric potential, commonly called voltage, is the difference in electric
/// potential energy per unit of electric charge between two points.
/// The SI derived unit for voltage is the Volt (V), defined as one watt per
/// ampere (W/A) or one joule per coulomb (J/C).
///
/// This class provides a type-safe way to handle voltage values and conversions
/// between different units (e.g., volts, millivolts, kilovolts).
@immutable
class Voltage extends LinearQuantity<VoltageUnit, Voltage> {
  /// Creates a new `Voltage` quantity with the given numerical [value] and [unit].
  ///
  /// Example:
  /// ```dart
  /// final batteryVoltage = Voltage(12.0, VoltageUnit.volt);
  /// final sensorOutput = Voltage(3.3, VoltageUnit.volt);
  /// final gridVoltage = Voltage(230, VoltageUnit.kilovolt);
  /// ```
  const Voltage(super._value, super._unit);

  /// Creates a [Voltage] from [Power] and [Current] (V = P / I).
  ///
  /// Both inputs are converted to SI base units (watts and amperes) before
  /// dividing. The result is returned in volts.
  ///
  /// ```dart
  /// final power   = 100.W;
  /// final current = 2.A;
  /// final voltage = Voltage.fromPowerAndCurrent(power, current); // 50.0 V
  /// ```
  factory Voltage.fromPowerAndCurrent(Power power, Current current) =>
      Voltage(power.getValue(PowerUnit.watt) / current.inAmperes, VoltageUnit.volt);

  /// Creates a [Voltage] from [Energy] and [ElectricCharge] (V = E / Q).
  ///
  /// Both inputs are converted to SI base units (joules and coulombs) before
  /// dividing. The result is returned in volts.
  ///
  /// ```dart
  /// final energy = 100.J;
  /// final charge = 10.C;
  /// final voltage = Voltage.fromEnergyAndCharge(energy, charge); // 10.0 V
  /// ```
  factory Voltage.fromEnergyAndCharge(Energy energy, ElectricCharge charge) => Voltage(
        energy.inJoules / charge.getValue(ElectricChargeUnit.coulomb),
        VoltageUnit.volt,
      );

  @override
  @protected
  Voltage create(double value, VoltageUnit unit) => Voltage(value, unit);

  /// The parser instance used to convert strings into [Voltage] objects.
  ///
  /// The parser supports both strict symbol aliases and case-insensitive name
  /// aliases configured in [VoltageUnit].
  static final QuantityParser<VoltageUnit, Voltage> parser = QuantityParser<VoltageUnit, Voltage>(
    symbolAliases: VoltageUnit.symbolAliases,
    nameAliases: VoltageUnit.nameAliases,
    factory: Voltage.new,
  );

  /// Parses a string representation of voltage into a [Voltage] object.
  ///
  /// Throws [QuantityParseException] if parsing fails.
  ///
  /// Example:
  /// ```dart
  /// final v1 = Voltage.parse('12 V');    // 12 volts
  /// final v2 = Voltage.parse('3.3 kV');  // 3.3 kilovolts
  /// ```
  static Voltage parse(
    String input, {
    List<QuantityFormat> formats = const [QuantityFormat.invariant],
  }) {
    return parser.parse(input, formats: formats);
  }

  /// Attempts to parse a string representation of voltage.
  /// Returns `null` if parsing fails.
  ///
  /// Example:
  /// ```dart
  /// final valid = Voltage.tryParse('12 volts');  // Voltage(12.0, VoltageUnit.volt)
  /// final invalid = Voltage.tryParse('invalid');  // null
  /// ```
  static Voltage? tryParse(
    String input, {
    List<QuantityFormat> formats = const [QuantityFormat.invariant],
  }) {
    return parser.tryParse(input, formats: formats);
  }

  /// Calculates the [Current] through a given [Resistance] using Ohm's law
  /// (I = V / R).
  ///
  /// Both values are converted to SI base units (volts and ohms) before
  /// dividing. The result is returned in amperes.
  ///
  /// ```dart
  /// final voltage = 12.V;
  /// final resistor = 100.ohms;
  /// final current = voltage.currentThrough(resistor); // 0.12 A
  /// ```
  Current currentThrough(Resistance resistance) => Current(
        getValue(VoltageUnit.volt) / resistance.getValue(ResistanceUnit.ohm),
        CurrentUnit.ampere,
      );
}

/// Type alias for formal contexts where "Electric Potential" is preferred
/// over "Voltage".
typedef ElectricPotential = Voltage;
