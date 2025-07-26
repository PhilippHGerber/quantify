import 'package:meta/meta.dart';

import '../../core/unit.dart';
import 'power_factors.dart';

/// Represents units of power.
///
/// This enum implements the [Unit] interface to provide conversion capabilities
/// and a display [symbol] for each power unit. All conversion factors are
/// pre-calculated in the constructor relative to the Watt (W).
enum PowerUnit implements Unit<PowerUnit> {
  // --- SI Units ---
  /// Watt (W), the SI derived unit of power, equal to one Joule per second.
  watt(1, 'W'),

  /// Milliwatt (mW), a sub-multiple of the Watt, common in electronics.
  milliwatt(PowerFactors.wattsPerMilliwatt, 'mW'),

  /// Kilowatt (kW), a common multiple of the Watt.
  kilowatt(PowerFactors.wattsPerKilowatt, 'kW'),

  /// Megawatt (MW), a common multiple of the Watt, used for large-scale power.
  megawatt(PowerFactors.wattsPerMegawatt, 'MW'),

  /// Gigawatt (GW), a multiple of the Watt, used for large power plants.
  gigawatt(PowerFactors.wattsPerGigawatt, 'GW'),

  // --- Engineering / Common Units ---

  /// Mechanical Horsepower (hp), a common unit for engine and motor power.
  horsepower(PowerFactors.wattsPerHorsepower, 'hp'),

  /// Metric Horsepower (PS), used commonly in the automotive industry.
  metricHorsepower(PowerFactors.wattsPerMetricHorsepower, 'PS'),

  /// British Thermal Unit per hour (Btu/h), common in HVAC.
  btuPerHour(PowerFactors.wattsPerBtuPerHour, 'Btu/h'),

  // --- CGS Units ---

  /// Erg per second (erg/s), the power unit in the CGS system.
  ergPerSecond(PowerFactors.wattsPerErgPerSecond, 'erg/s');

  /// Constant constructor for enum members.
  const PowerUnit(double toWattFactor, this.symbol)
      : _toWattFactor = toWattFactor,
        _factorToWatt = toWattFactor / 1.0,
        _factorToMilliwatt = toWattFactor / PowerFactors.wattsPerMilliwatt,
        _factorToKilowatt = toWattFactor / PowerFactors.wattsPerKilowatt,
        _factorToMegawatt = toWattFactor / PowerFactors.wattsPerMegawatt,
        _factorToGigawatt = toWattFactor / PowerFactors.wattsPerGigawatt,
        _factorToHorsepower = toWattFactor / PowerFactors.wattsPerHorsepower,
        _factorToMetricHorsepower = toWattFactor / PowerFactors.wattsPerMetricHorsepower,
        _factorToBtuPerHour = toWattFactor / PowerFactors.wattsPerBtuPerHour,
        _factorToErgPerSecond = toWattFactor / PowerFactors.wattsPerErgPerSecond;

  /// The factor to convert a value from this unit to the base unit (Watt).
  // ignore: unused_field
  final double _toWattFactor;

  /// The human-readable symbol for this power unit (e.g., "W", "kW", "hp").
  @override
  final String symbol;

  // --- Pre-calculated direct conversion factors ---
  final double _factorToWatt;
  final double _factorToMilliwatt;
  final double _factorToKilowatt;
  final double _factorToMegawatt;
  final double _factorToGigawatt;
  final double _factorToHorsepower;
  final double _factorToMetricHorsepower;
  final double _factorToBtuPerHour;
  final double _factorToErgPerSecond;

  /// Returns the direct conversion factor to convert a value from this [PowerUnit]
  /// to the [targetUnit].
  @override
  @internal
  double factorTo(PowerUnit targetUnit) {
    switch (targetUnit) {
      case PowerUnit.watt:
        return _factorToWatt;
      case PowerUnit.milliwatt:
        return _factorToMilliwatt;
      case PowerUnit.kilowatt:
        return _factorToKilowatt;
      case PowerUnit.megawatt:
        return _factorToMegawatt;
      case PowerUnit.gigawatt:
        return _factorToGigawatt;
      case PowerUnit.horsepower:
        return _factorToHorsepower;
      case PowerUnit.metricHorsepower:
        return _factorToMetricHorsepower;
      case PowerUnit.btuPerHour:
        return _factorToBtuPerHour;
      case PowerUnit.ergPerSecond:
        return _factorToErgPerSecond;
    }
  }
}
