import 'package:meta/meta.dart';

import '../../core/unit.dart';
import 'acceleration_factors.dart';

/// Represents units of acceleration.
///
/// This enum implements the [Unit] interface to provide conversion capabilities
/// and a display [symbol] for each acceleration unit.
/// All conversion factors are pre-calculated in the constructor relative to
/// Meter per Second Squared (m/s²).
enum AccelerationUnit implements Unit<AccelerationUnit> {
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
  footPerSecondSquared(AccelerationFactors.mpssPerFpsSquared, 'ft/s²');

  /// Constant constructor for enum members.
  const AccelerationUnit(double toMpssFactor, this.symbol)
      : _toMpssFactor = toMpssFactor,
        _factorToMeterPerSecondSquared = toMpssFactor / 1.0,
        _factorToStandardGravity = toMpssFactor / AccelerationFactors.mpssPerStandardGravity,
        _factorToKilometerPerHourPerSecond = toMpssFactor / AccelerationFactors.mpssPerKmhPerSec,
        _factorToMilePerHourPerSecond = toMpssFactor / AccelerationFactors.mpssPerMphPerSec,
        _factorToKnotPerSecond = toMpssFactor / AccelerationFactors.mpssPerKnotPerSec,
        _factorToFootPerSecondSquared = toMpssFactor / AccelerationFactors.mpssPerFpsSquared;

  // ignore: unused_field
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
    }
  }
}
