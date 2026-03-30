import 'package:meta/meta.dart';

import '../../../quantify.dart' show QuantityParseException;
import '../../core/linear_quantity.dart';
import '../../core/quantity_format.dart';
import '../../core/quantity_parse_exception.dart' show QuantityParseException;
import '../../core/quantity_parser.dart';
import '../force/force.dart';
import '../force/force_extensions.dart';
import '../force/force_unit.dart';
import '../length/length.dart';
import '../length/length_extensions.dart';
import '../length/length_unit.dart';
import '../power/power.dart';
import '../power/power_extensions.dart';
import '../power/power_unit.dart';
import '../time/time.dart';
import '../time/time_extensions.dart';
import '../time/time_unit.dart';
import 'energy_unit.dart';

/// Represents a quantity of energy.
///
/// Energy is a fundamental physical quantity representing the capacity to do work.
/// The SI derived unit for energy is the Joule (J). This class provides a
/// type-safe way to handle energy values and conversions between different units
/// (e.g., joules, calories, kilowatt-hours).
@immutable
final class Energy extends LinearQuantity<EnergyUnit, Energy> {
  /// Creates a new `Energy` quantity with the given numerical [value] and [unit].
  ///
  /// Example:
  /// ```dart
  /// final workDone = Energy(500.0, EnergyUnit.joule);
  /// final foodEnergy = Energy(250.0, EnergyUnit.kilocalorie);
  /// final electricityUsed = Energy(1.2, EnergyUnit.kilowattHour);
  /// ```
  const Energy(super._value, super._unit);

  /// Creates an [Energy] from [power] and [duration] (E = P × t).
  ///
  /// If the combination of [power]'s unit and [duration]'s unit matches a
  /// standard energy unit (W + s → J, W + h → Wh, kW + h → kWh, BTU/h + h → BTU), the
  /// result uses that unit. Otherwise the result is in [EnergyUnit.joule].
  ///
  /// ```dart
  /// Energy.from(100.W, 2.hours);     // 200.0 Wh
  /// Energy.from(1.kW, 1.hours);       // 1.0 kWh
  /// Energy.from(1000.btuPerHour, 2.h); // 2000.0 BTU
  /// Energy.from(100.W, 10.s);         // 1000.0 J
  /// ```
  factory Energy.from(Power power, Time duration) {
    final target = _correspondingEnergyUnit(power.unit, duration.unit);
    if (target != null) return Energy(power.value * duration.value, target);
    return Energy(power.inWatts * duration.inSeconds, EnergyUnit.joule);
  }

  /// Creates an [Energy] from [Force] and [Length] (W = F × d, the work–energy theorem).
  ///
  /// If the unit combination maps to a natural energy unit (e.g. N × m → J,
  /// kN × km → MJ), the result uses that unit. Imperial and CGS pairs (e.g.
  /// lbf × ft, dyn × cm) have no matching [EnergyUnit] and fall back to
  /// [EnergyUnit.joule].
  ///
  /// ```dart
  /// Energy.fromWork(10.N, 5.m);     // 50.0 J
  /// Energy.fromWork(2.kN, 3.km);    // 6.0 MJ
  /// Energy.fromWork(1.N, 500.mm);   // 500.0 mJ
  /// ```
  factory Energy.fromWork(Force force, Length distance) {
    final target = _correspondingEnergyUnitFromWork(force.unit, distance.unit);
    if (target != null) return Energy(force.value * distance.value, target);
    return Energy(force.inNewtons * distance.inM, EnergyUnit.joule);
  }

  /// Maps a [PowerUnit] × [TimeUnit] pair to its natural [EnergyUnit].
  static EnergyUnit? _correspondingEnergyUnit(PowerUnit p, TimeUnit t) => switch ((p, t)) {
        (PowerUnit.watt, TimeUnit.second) => EnergyUnit.joule,
        (PowerUnit.watt, TimeUnit.hour) => EnergyUnit.wattHour,
        (PowerUnit.kilowatt, TimeUnit.hour) => EnergyUnit.kilowattHour,
        (PowerUnit.btuPerHour, TimeUnit.hour) => EnergyUnit.btu,
        _ => null,
      };

  /// Maps a [ForceUnit] × [LengthUnit] pair to its natural [EnergyUnit].
  ///
  /// Rule: result prefix = prefix(F) × prefix(d).
  static EnergyUnit? _correspondingEnergyUnitFromWork(ForceUnit f, LengthUnit l) =>
      switch ((f, l)) {
        (ForceUnit.newton, LengthUnit.millimeter) => EnergyUnit.millijoule,
        (ForceUnit.newton, LengthUnit.meter) => EnergyUnit.joule,
        (ForceUnit.newton, LengthUnit.kilometer) => EnergyUnit.kilojoule,
        (ForceUnit.kilonewton, LengthUnit.meter) => EnergyUnit.kilojoule,
        (ForceUnit.kilonewton, LengthUnit.kilometer) => EnergyUnit.megajoule,
        (ForceUnit.meganewton, LengthUnit.meter) => EnergyUnit.megajoule,
        (ForceUnit.meganewton, LengthUnit.kilometer) => EnergyUnit.gigajoule,
        (ForceUnit.giganewton, LengthUnit.meter) => EnergyUnit.gigajoule,
        // lbf×ft (no ft·lbf EnergyUnit), dyn×cm (no erg EnergyUnit) → SI fallback
        _ => null,
      };

  @override
  @protected
  Energy create(double value, EnergyUnit unit) => Energy(value, unit);

  /// The parser instance used to convert strings into [Energy] objects.
  ///
  /// The parser supports all standard units including symbols and full names.
  static final QuantityParser<EnergyUnit, Energy> parser = QuantityParser<EnergyUnit, Energy>(
    symbolAliases: EnergyUnit.symbolAliases,
    nameAliases: EnergyUnit.nameAliases,
    factory: Energy.new,
  );

  /// Parses a string representation of energy into an [Energy] object.
  ///
  /// Throws [QuantityParseException] if parsing fails.
  ///
  /// Example:
  /// ```dart
  /// final e1 = Energy.parse('100 J');      // 100 joules
  /// final e2 = Energy.parse('500 kcal');   // 500 kilocalories
  /// final e3 = Energy.parse('1.5 kWh');    // 1.5 kilowatt-hours
  /// ```
  static Energy parse(
    String input, {
    List<QuantityFormat> formats = const [QuantityFormat.invariant],
  }) {
    return parser.parse(input, formats: formats);
  }

  /// Attempts to parse a string representation of energy. Returns `null` if parsing fails.
  ///
  /// Example:
  /// ```dart
  /// final valid = Energy.tryParse('100 joules');  // Energy(100.0, EnergyUnit.joule)
  /// final invalid = Energy.tryParse('invalid');   // null
  /// ```
  static Energy? tryParse(
    String input, {
    List<QuantityFormat> formats = const [QuantityFormat.invariant],
  }) {
    return parser.tryParse(input, formats: formats);
  }
}
