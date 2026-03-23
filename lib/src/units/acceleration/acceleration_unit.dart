import 'package:meta/meta.dart';

import '../../core/unit.dart';
import 'acceleration_factors.dart';

/// Represents units of acceleration.
///
/// This enum implements the [LinearUnit] interface to provide conversion capabilities
/// and a display [symbol] for each acceleration unit.
/// All conversion factors are pre-calculated in the constructor relative to
/// Meter per Second Squared (m/s²).
enum AccelerationUnit implements LinearUnit<AccelerationUnit> {
  /// Meter per second squared (m/s²), the SI derived unit of acceleration.
  meterPerSecondSquared(1, 'm/s²'),

  /// Standard Gravity (g), a unit of acceleration equal to the conventional standard
  /// acceleration of an object in a vacuum near the surface of the Earth.
  standardGravity(AccelerationFactors.mpssPerStandardGravity, 'g'),

  /// Kilometer per hour per second ((km/h)/s), a unit often used to describe
  /// automotive performance (e.g., 0 to 100 km/h in x seconds).
  kilometerPerHourPerSecond(AccelerationFactors.mpssPerKmhPerSec, 'km/h/s'),

  /// Mile per hour per second ((mph)/s), another unit for automotive performance.
  milePerHourPerSecond(AccelerationFactors.mpssPerMphPerSec, 'mph/s'),

  /// Knot per second ((kn)/s), used in maritime and aviation contexts.
  knotPerSecond(AccelerationFactors.mpssPerKnotPerSec, 'kn/s'),

  /// Foot per second squared (ft/s²), an imperial/US customary unit.
  footPerSecondSquared(AccelerationFactors.mpssPerFpsSquared, 'ft/s²'),

  /// Centimeter per second squared (cm/s²), also known as the Galileo (Gal).
  /// The CGS unit of acceleration.
  centimeterPerSecondSquared(AccelerationFactors.mpssPerCmpss, 'cm/s²');

  /// Constant constructor for enum members.
  const AccelerationUnit(double toMpssFactor, this.symbol)
      : _toMpssFactor = toMpssFactor,
        _factorToMeterPerSecondSquared = toMpssFactor / 1.0,
        _factorToStandardGravity = toMpssFactor / AccelerationFactors.mpssPerStandardGravity,
        _factorToKilometerPerHourPerSecond = toMpssFactor / AccelerationFactors.mpssPerKmhPerSec,
        _factorToMilePerHourPerSecond = toMpssFactor / AccelerationFactors.mpssPerMphPerSec,
        _factorToKnotPerSecond = toMpssFactor / AccelerationFactors.mpssPerKnotPerSec,
        _factorToFootPerSecondSquared = toMpssFactor / AccelerationFactors.mpssPerFpsSquared,
        _factorToCentimeterPerSecondSquared = toMpssFactor / AccelerationFactors.mpssPerCmpss;

  /// SI and unit symbols matched **strictly case-sensitive**.
  static const Map<String, AccelerationUnit> symbolAliases = {
    'm/s²': meterPerSecondSquared,
    'g': standardGravity,
    'km/h/s': kilometerPerHourPerSecond,
    'mph/s': milePerHourPerSecond,
    'kn/s': knotPerSecond,
    'ft/s²': footPerSecondSquared,
    'cm/s²': centimeterPerSecondSquared,
  };

  /// Full word-form names and non-SI abbreviations matched **case-insensitively**.
  static const Map<String, AccelerationUnit> nameAliases = {
    'meter per second squared': meterPerSecondSquared,
    'metre per second squared': meterPerSecondSquared,
    'meterperseconsquared': meterPerSecondSquared,
    'm per s2': meterPerSecondSquared,
    'mpers2': meterPerSecondSquared,
    'standard gravity': standardGravity,
    'standardgravity': standardGravity,
    'g': standardGravity,
    'grav': standardGravity,
    'kilometer per hour per second': kilometerPerHourPerSecond,
    'kilometre per hour per second': kilometerPerHourPerSecond,
    'kilometerperhouerpersecond': kilometerPerHourPerSecond,
    'km per h per s': kilometerPerHourPerSecond,
    'kmperhrpers': kilometerPerHourPerSecond,
    'kmh per s': kilometerPerHourPerSecond,
    'kmhpers': kilometerPerHourPerSecond,
    'km/h/s': kilometerPerHourPerSecond,
    'mile per hour per second': milePerHourPerSecond,
    'mileperhoerpersecond': milePerHourPerSecond,
    'mi per h per s': milePerHourPerSecond,
    'miperhrpers': milePerHourPerSecond,
    'mph per s': milePerHourPerSecond,
    'mphpers': milePerHourPerSecond,
    'mph/s': milePerHourPerSecond,
    'knot per second': knotPerSecond,
    'knotpersecond': knotPerSecond,
    'kn per s': knotPerSecond,
    'knpers': knotPerSecond,
    'kn/s': knotPerSecond,
    'foot per second squared': footPerSecondSquared,
    'feet per second squared': footPerSecondSquared,
    'footperseconsquared': footPerSecondSquared,
    'ft per s2': footPerSecondSquared,
    'ftpers2': footPerSecondSquared,
    'centimeter per second squared': centimeterPerSecondSquared,
    'centimetre per second squared': centimeterPerSecondSquared,
    'centimeterperseconsquared': centimeterPerSecondSquared,
    'cm per s2': centimeterPerSecondSquared,
    'cmpers2': centimeterPerSecondSquared,
    'gal': centimeterPerSecondSquared,
    'galileo': centimeterPerSecondSquared,
  };

  // ignore: unused_field // Used to store the conversion factor to Meter per Second Squared (m/s²).
  final double _toMpssFactor;

  @override
  final String symbol;

  // --- Pre-calculated direct conversion factors ---
  final double _factorToMeterPerSecondSquared;
  final double _factorToStandardGravity;
  final double _factorToKilometerPerHourPerSecond;
  final double _factorToMilePerHourPerSecond;
  final double _factorToKnotPerSecond;
  final double _factorToFootPerSecondSquared;
  final double _factorToCentimeterPerSecondSquared;

  @override
  @internal
  double factorTo(AccelerationUnit targetUnit) {
    switch (targetUnit) {
      case AccelerationUnit.meterPerSecondSquared:
        return _factorToMeterPerSecondSquared;
      case AccelerationUnit.standardGravity:
        return _factorToStandardGravity;
      case AccelerationUnit.kilometerPerHourPerSecond:
        return _factorToKilometerPerHourPerSecond;
      case AccelerationUnit.milePerHourPerSecond:
        return _factorToMilePerHourPerSecond;
      case AccelerationUnit.knotPerSecond:
        return _factorToKnotPerSecond;
      case AccelerationUnit.footPerSecondSquared:
        return _factorToFootPerSecondSquared;
      case AccelerationUnit.centimeterPerSecondSquared:
        return _factorToCentimeterPerSecondSquared;
    }
  }
}
