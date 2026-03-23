import 'package:meta/meta.dart';

import '../../core/unit.dart';
import 'speed_factors.dart';

/// Represents units of speed.
///
/// This enum implements the [LinearUnit] interface to provide conversion capabilities
/// and a display [symbol] for each speed unit.
/// All conversion factors are pre-calculated in the constructor relative to
/// Meter per Second (m/s).
enum SpeedUnit implements LinearUnit<SpeedUnit> {
  /// Meter per second (m/s), the SI derived unit of speed.
  meterPerSecond(1, 'm/s'),

  /// Kilometer per second (km/s), a common unit in scientific contexts like astronomy.
  kilometerPerSecond(SpeedFactors.mpsPerKps, 'km/s'),

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
        _factorToKilometerPerSecond = toMpsFactor / SpeedFactors.mpsPerKps,
        _factorToKilometerPerHour = toMpsFactor / SpeedFactors.mpsPerKmh,
        _factorToMilePerHour = toMpsFactor / SpeedFactors.mpsPerMph,
        _factorToKnot = toMpsFactor / SpeedFactors.mpsPerKnot,
        _factorToFootPerSecond = toMpsFactor / SpeedFactors.mpsPerFps;

  // ignore: unused_field // Used to store the conversion factor to Meter per Second (m/s).
  final double _toMpsFactor;

  @override
  final String symbol;

  // --- Pre-calculated direct conversion factors from this unit to all others ---
  final double _factorToMeterPerSecond;
  final double _factorToKilometerPerSecond;
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
      case SpeedUnit.kilometerPerSecond:
        return _factorToKilometerPerSecond;
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

  /// Case-sensitive symbol aliases for parsing.
  ///
  /// Symbols with slashes (like `m/s`, `km/h`) are included alongside
  /// common abbreviations without slashes.
  static const symbolAliases = <String, SpeedUnit>{
    'm/s': SpeedUnit.meterPerSecond,
    'km/s': SpeedUnit.kilometerPerSecond,
    'km/h': SpeedUnit.kilometerPerHour,
    'kmh': SpeedUnit.kilometerPerHour,
    'mph': SpeedUnit.milePerHour,
    'kn': SpeedUnit.knot,
    'kt': SpeedUnit.knot,
    'ft/s': SpeedUnit.footPerSecond,
    'fps': SpeedUnit.footPerSecond,
  };

  /// Case-insensitive name aliases for parsing (all lowercase).
  ///
  /// Includes singular, plural, and regional spelling variants.
  static const nameAliases = <String, SpeedUnit>{
    'meter per second': SpeedUnit.meterPerSecond,
    'meters per second': SpeedUnit.meterPerSecond,
    'metre per second': SpeedUnit.meterPerSecond,
    'metres per second': SpeedUnit.meterPerSecond,
    'kilometer per second': SpeedUnit.kilometerPerSecond,
    'kilometers per second': SpeedUnit.kilometerPerSecond,
    'kilometre per second': SpeedUnit.kilometerPerSecond,
    'kilometres per second': SpeedUnit.kilometerPerSecond,
    'kilometer per hour': SpeedUnit.kilometerPerHour,
    'kilometers per hour': SpeedUnit.kilometerPerHour,
    'kilometre per hour': SpeedUnit.kilometerPerHour,
    'kilometres per hour': SpeedUnit.kilometerPerHour,
    'kmh': SpeedUnit.kilometerPerHour,
    'kph': SpeedUnit.kilometerPerHour,
    'mph': SpeedUnit.milePerHour,
    'mile per hour': SpeedUnit.milePerHour,
    'miles per hour': SpeedUnit.milePerHour,
    'kn': SpeedUnit.knot,
    'kt': SpeedUnit.knot,
    'knot': SpeedUnit.knot,
    'knots': SpeedUnit.knot,
    'fps': SpeedUnit.footPerSecond,
    'foot per second': SpeedUnit.footPerSecond,
    'feet per second': SpeedUnit.footPerSecond,
  };
}
