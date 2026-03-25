import 'package:meta/meta.dart';

import '../../../quantify.dart' show QuantityParseException;
import '../../core/linear_quantity.dart';
import '../../core/quantity_format.dart';
import '../../core/quantity_parse_exception.dart' show QuantityParseException;
import '../../core/quantity_parser.dart';
import '../current/current.dart';
import '../current/current_extensions.dart';
import '../current/current_unit.dart';
import '../energy/energy.dart';
import '../energy/energy_extensions.dart';
import '../energy/energy_unit.dart';
import '../resistance/resistance.dart';
import '../resistance/resistance_unit.dart';
import '../time/time.dart';
import '../time/time_extensions.dart';
import '../time/time_unit.dart';
import '../voltage/voltage.dart';
import '../voltage/voltage_unit.dart';
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

  /// Creates a [Power] from [energy] and [duration] (P = E / t).
  ///
  /// If the combination of [energy]'s unit and [duration]'s unit matches a
  /// standard power unit (J + s → W, kJ + s → kW, kWh + h → kW,
  /// BTU + h → BTU/h), the result uses that unit. Otherwise the result is in
  /// [PowerUnit.watt].
  ///
  /// ```dart
  /// Power.from(3600.kJ, 1.hours);  // 1000.0 kW
  /// Power.from(1.kWh, 1.hours);    // 1.0 kW
  /// Power.from(100.btu, 1.hours);  // 100.0 BTU/h
  /// ```
  factory Power.from(Energy energy, Time duration) {
    final target = _correspondingPowerUnit(energy.unit, duration.unit);
    if (target != null) return Power(energy.value / duration.value, target);
    return Power(energy.inJoules / duration.inSeconds, PowerUnit.watt);
  }

  /// Creates a [Power] from [Voltage] and [Current] (P = V × I).
  ///
  /// If the unit combination maps to a natural power unit (e.g. V × A → W,
  /// kV × A → kW, V × mA → mW), the result uses that unit. Otherwise falls
  /// back to [PowerUnit.watt].
  ///
  /// ```dart
  /// Power.fromVoltageAndCurrent(12.V, 2.A);      // 24.0 W
  /// Power.fromVoltageAndCurrent(230.V, 10.A);    // 2300.0 W
  /// Power.fromVoltageAndCurrent(5.V, 200.mA);    // 1000.0 mW
  /// ```
  factory Power.fromVoltageAndCurrent(Voltage voltage, Current current) {
    final target = _correspondingPowerUnitFromVI(voltage.unit, current.unit);
    if (target != null) return Power(voltage.value * current.value, target);
    return Power(voltage.getValue(VoltageUnit.volt) * current.inAmperes, PowerUnit.watt);
  }

  /// Creates a [Power] from [Current] and [Resistance] using Joule's law (P = I² × R).
  ///
  /// If the unit combination maps to a natural power unit (e.g. A × Ω → W,
  /// mA × kΩ → mW, kA × Ω → MW), the result uses that unit. Otherwise falls
  /// back to [PowerUnit.watt].
  ///
  /// ```dart
  /// Power.fromCurrentAndResistance(2.A, 50.ohms);      // 200.0 W
  /// Power.fromCurrentAndResistance(100.mA, 10.kiloohms); // 100.0 mW
  /// ```
  factory Power.fromCurrentAndResistance(Current current, Resistance resistance) {
    final target = _correspondingPowerUnitFromIR(current.unit, resistance.unit);
    if (target != null) return Power(current.value * current.value * resistance.value, target);
    return Power(
      current.inAmperes * current.inAmperes * resistance.getValue(ResistanceUnit.ohm),
      PowerUnit.watt,
    );
  }

  /// Creates a [Power] from [Voltage] and [Resistance] (P = V² / R).
  ///
  /// If the unit combination maps to a natural power unit (e.g. V × Ω → W,
  /// V × kΩ → mW, kV × Ω → MW), the result uses that unit. Otherwise falls
  /// back to [PowerUnit.watt].
  ///
  /// ```dart
  /// Power.fromVoltageAndResistance(10.V, 50.ohms);     // 2.0 W
  /// Power.fromVoltageAndResistance(230.V, 1.kiloohms); // 52.9 mW
  /// ```
  factory Power.fromVoltageAndResistance(Voltage voltage, Resistance resistance) {
    final target = _correspondingPowerUnitFromVR(voltage.unit, resistance.unit);
    if (target != null) return Power(voltage.value * voltage.value / resistance.value, target);
    return Power(
      voltage.getValue(VoltageUnit.volt) *
          voltage.getValue(VoltageUnit.volt) /
          resistance.getValue(ResistanceUnit.ohm),
      PowerUnit.watt,
    );
  }

  /// Maps an [EnergyUnit] × [TimeUnit] pair to its natural [PowerUnit].
  static PowerUnit? _correspondingPowerUnit(EnergyUnit e, TimeUnit t) => switch ((e, t)) {
        (EnergyUnit.joule, TimeUnit.second) => PowerUnit.watt,
        (EnergyUnit.kilojoule, TimeUnit.second) => PowerUnit.kilowatt,
        (EnergyUnit.kilowattHour, TimeUnit.hour) => PowerUnit.kilowatt,
        (EnergyUnit.btu, TimeUnit.hour) => PowerUnit.btuPerHour,
        _ => null,
      };

  /// Maps a [VoltageUnit] × [CurrentUnit] pair to its natural [PowerUnit].
  ///
  /// Rule: result prefix = prefix(V) × prefix(I).
  static PowerUnit? _correspondingPowerUnitFromVI(VoltageUnit v, CurrentUnit i) => switch ((v, i)) {
        (VoltageUnit.volt, CurrentUnit.ampere) => PowerUnit.watt,
        (VoltageUnit.volt, CurrentUnit.milliampere) => PowerUnit.milliwatt,
        (VoltageUnit.volt, CurrentUnit.microampere) => PowerUnit.microwatt,
        (VoltageUnit.volt, CurrentUnit.kiloampere) => PowerUnit.kilowatt,
        (VoltageUnit.volt, CurrentUnit.megaampere) => PowerUnit.megawatt,
        (VoltageUnit.millivolt, CurrentUnit.ampere) => PowerUnit.milliwatt,
        (VoltageUnit.millivolt, CurrentUnit.kiloampere) => PowerUnit.watt,
        (VoltageUnit.microvolt, CurrentUnit.ampere) => PowerUnit.microwatt,
        (VoltageUnit.kilovolt, CurrentUnit.ampere) => PowerUnit.kilowatt,
        (VoltageUnit.kilovolt, CurrentUnit.milliampere) => PowerUnit.watt,
        (VoltageUnit.kilovolt, CurrentUnit.kiloampere) => PowerUnit.megawatt,
        (VoltageUnit.megavolt, CurrentUnit.ampere) => PowerUnit.megawatt,
        (VoltageUnit.megavolt, CurrentUnit.kiloampere) => PowerUnit.gigawatt,
        (VoltageUnit.gigavolt, CurrentUnit.ampere) => PowerUnit.gigawatt,
        _ => null,
      };

  /// Maps a [CurrentUnit] × [ResistanceUnit] pair to its natural [PowerUnit].
  ///
  /// Rule: result prefix = prefix(I)² × prefix(R).
  static PowerUnit? _correspondingPowerUnitFromIR(CurrentUnit i, ResistanceUnit r) =>
      switch ((i, r)) {
        (CurrentUnit.ampere, ResistanceUnit.ohm) => PowerUnit.watt,
        (CurrentUnit.ampere, ResistanceUnit.milliohm) => PowerUnit.milliwatt,
        (CurrentUnit.ampere, ResistanceUnit.kiloohm) => PowerUnit.kilowatt,
        (CurrentUnit.ampere, ResistanceUnit.megaohm) => PowerUnit.megawatt,
        (CurrentUnit.milliampere, ResistanceUnit.ohm) => PowerUnit.microwatt,
        (CurrentUnit.milliampere, ResistanceUnit.kiloohm) => PowerUnit.milliwatt,
        (CurrentUnit.milliampere, ResistanceUnit.megaohm) => PowerUnit.watt,
        (CurrentUnit.microampere, ResistanceUnit.kiloohm) => PowerUnit.nanowatt,
        (CurrentUnit.microampere, ResistanceUnit.megaohm) => PowerUnit.microwatt,
        (CurrentUnit.microampere, ResistanceUnit.gigaohm) => PowerUnit.milliwatt,
        (CurrentUnit.kiloampere, ResistanceUnit.milliohm) => PowerUnit.kilowatt,
        (CurrentUnit.kiloampere, ResistanceUnit.ohm) => PowerUnit.megawatt,
        _ => null,
      };

  /// Maps a [VoltageUnit] × [ResistanceUnit] pair to its natural [PowerUnit].
  ///
  /// Rule: result prefix = prefix(V)² / prefix(R).
  static PowerUnit? _correspondingPowerUnitFromVR(VoltageUnit v, ResistanceUnit r) =>
      switch ((v, r)) {
        (VoltageUnit.volt, ResistanceUnit.ohm) => PowerUnit.watt,
        (VoltageUnit.volt, ResistanceUnit.milliohm) => PowerUnit.kilowatt,
        (VoltageUnit.volt, ResistanceUnit.kiloohm) => PowerUnit.milliwatt,
        (VoltageUnit.volt, ResistanceUnit.megaohm) => PowerUnit.microwatt,
        (VoltageUnit.millivolt, ResistanceUnit.ohm) => PowerUnit.microwatt,
        (VoltageUnit.millivolt, ResistanceUnit.milliohm) => PowerUnit.milliwatt,
        (VoltageUnit.millivolt, ResistanceUnit.kiloohm) => PowerUnit.nanowatt,
        (VoltageUnit.kilovolt, ResistanceUnit.ohm) => PowerUnit.megawatt,
        (VoltageUnit.kilovolt, ResistanceUnit.kiloohm) => PowerUnit.kilowatt,
        (VoltageUnit.kilovolt, ResistanceUnit.megaohm) => PowerUnit.watt,
        (VoltageUnit.kilovolt, ResistanceUnit.gigaohm) => PowerUnit.milliwatt,
        (VoltageUnit.megavolt, ResistanceUnit.ohm) => PowerUnit.terawatt,
        _ => null,
      };

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

  /// Calculates the [Time] required to transfer or work a given [Energy].
  ///
  /// This method performs the dimensional calculation `Time = Energy / Power`.
  /// The result's unit matches the time component of this power's unit:
  /// watts → seconds, BTU/h → hours. Computation is in SI base units for
  /// correctness. If the power is zero, the result follows IEEE 754 semantics.
  ///
  /// ```dart
  /// final heater = 2000.W;
  /// heater.timeFor(7200.kJ); // 3600.0 s
  ///
  /// final furnace = 10000.btuPerHour;
  /// furnace.timeFor(50000.btu); // 5.0 h
  /// ```
  Time timeFor(Energy energy) {
    final energyInJoules = energy.inJoules;
    final powerInWatts = getValue(PowerUnit.watt);
    final timeInSeconds = energyInJoules / powerInWatts;
    final timeUnit = _correspondingTimeUnit(unit);
    return Time(Time(timeInSeconds, TimeUnit.second).getValue(timeUnit), timeUnit);
  }

  /// Maps a [PowerUnit] to the [TimeUnit] component of its definition.
  static TimeUnit _correspondingTimeUnit(PowerUnit u) => switch (u) {
        PowerUnit.btuPerHour => TimeUnit.hour,
        PowerUnit.ergPerSecond => TimeUnit.second,
        _ => TimeUnit.second, // W, kW, MW, etc. are all J/s
      };
}
