import 'package:meta/meta.dart';

import '../../core/unit.dart';
import 'speed_factors.dart';

/// Represents units of speed.
///
/// This enum implements the [Unit] interface to provide conversion capabilities
/// and a display [symbol] for each speed unit.
/// All conversion factors are pre-calculated in the constructor relative to
/// Meter per Second (m/s).
enum SpeedUnit implements Unit<SpeedUnit> {
  /// Meter per second (m/s), the SI derived unit of speed.
  meterPerSecond(1, 'm/s'),

  /// Kilometer per hour (km/h), a common unit for road vehicle speed.
  kilometerPerHour(SpeedFactors.mpsPerKmh, 'km/h'),

  /// Mile per hour (mph), a common unit for road vehicle speed in some countries.
  milePerHour(SpeedFactors.mpsPerMph, 'mph'),

  /// Knot (kn), a unit of speed equal to one nautical mile per hour.
  /// Commonly used in maritime and aviation contexts.
  knot(SpeedFactors.mpsPerKnot, 'kn'),

  /// Foot per second (ft/s), used in some engineering contexts.
  footPerSecond(SpeedFactors.mpsPerFps, 'ft/s');

  /// Constant constructor for enum members.
  ///
  /// [_toMpsFactor] is the factor to convert from this unit to the base unit (Meter per Second).
  /// [symbol] is the display symbol for the unit.
  ///
  /// The constructor pre-calculates all direct conversion factors
  /// from this unit to every other `SpeedUnit`.
  const SpeedUnit(double toMpsFactor, this.symbol)
      : _toMpsFactor = toMpsFactor,
        _factorToMeterPerSecond = toMpsFactor / 1.0,
        _factorToKilometerPerHour = toMpsFactor / SpeedFactors.mpsPerKmh,
        _factorToMilePerHour = toMpsFactor / SpeedFactors.mpsPerMph,
        _factorToKnot = toMpsFactor / SpeedFactors.mpsPerKnot,
        _factorToFootPerSecond = toMpsFactor / SpeedFactors.mpsPerFps;

  // ignore: unused_field
  final double _toMpsFactor;

  @override
  final String symbol;

  // --- Pre-calculated direct conversion factors from this unit to all others ---
  final double _factorToMeterPerSecond;
  final double _factorToKilometerPerHour;
  final double _factorToMilePerHour;
  final double _factorToKnot;
  final double _factorToFootPerSecond;

  /// Returns the direct conversion factor to convert a value from this [SpeedUnit]
  /// to the [targetUnit].
  @override
  @internal
  double factorTo(SpeedUnit targetUnit) {
    switch (targetUnit) {
      case SpeedUnit.meterPerSecond:
        return _factorToMeterPerSecond;
      case SpeedUnit.kilometerPerHour:
        return _factorToKilometerPerHour;
      case SpeedUnit.milePerHour:
        return _factorToMilePerHour;
      case SpeedUnit.knot:
        return _factorToKnot;
      case SpeedUnit.footPerSecond:
        return _factorToFootPerSecond;
    }
  }
}
