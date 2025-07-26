import 'acceleration.dart';
import 'acceleration_unit.dart';

/// Provides convenient access to [Acceleration] values in specific units.
extension AccelerationValueGetters on Acceleration {
  /// Returns the acceleration value in Meters per second squared (m/s²).
  double get inMetersPerSecondSquared => getValue(AccelerationUnit.meterPerSecondSquared);

  /// Returns the acceleration value in Standard Gravity (g).
  double get inStandardGravity => getValue(AccelerationUnit.standardGravity);

  /// Returns the acceleration value in Kilometers per hour per second.
  double get inKilometersPerHourPerSecond => getValue(AccelerationUnit.kilometerPerHourPerSecond);

  /// Returns the acceleration value in Miles per hour per second.
  double get inMilesPerHourPerSecond => getValue(AccelerationUnit.milePerHourPerSecond);

  /// Returns the acceleration value in Knots per second.
  double get inKnotsPerSecond => getValue(AccelerationUnit.knotPerSecond);

  /// Returns the acceleration value in Feet per second squared.
  double get inFeetPerSecondSquared => getValue(AccelerationUnit.footPerSecondSquared);

  /// Returns the acceleration value in Centimeters per second squared (cm/s²).
  double get inCentimetersPerSecondSquared => getValue(AccelerationUnit.centimeterPerSecondSquared);

  /// Returns an [Acceleration] object in Meters per second squared (m/s²).
  Acceleration get asMetersPerSecondSquared => convertTo(AccelerationUnit.meterPerSecondSquared);

  /// Returns an [Acceleration] object in Standard Gravity (g).
  Acceleration get asStandardGravity => convertTo(AccelerationUnit.standardGravity);

  /// Returns an [Acceleration] object in Kilometers per hour per second.
  Acceleration get asKilometersPerHourPerSecond =>
      convertTo(AccelerationUnit.kilometerPerHourPerSecond);

  /// Returns an [Acceleration] object in Miles per hour per second.
  Acceleration get asMilesPerHourPerSecond => convertTo(AccelerationUnit.milePerHourPerSecond);

  /// Returns an [Acceleration] object in Knots per second.
  Acceleration get asKnotsPerSecond => convertTo(AccelerationUnit.knotPerSecond);

  /// Returns an [Acceleration] object in Feet per second squared.
  Acceleration get asFeetPerSecondSquared => convertTo(AccelerationUnit.footPerSecondSquared);

  /// Returns an [Acceleration] object in Centimeters per second squared (cm/s²).
  Acceleration get asCentimetersPerSecondSquared =>
      convertTo(AccelerationUnit.centimeterPerSecondSquared);
}

/// Provides convenient factory methods for creating [Acceleration] instances from [num].
extension AccelerationCreation on num {
  /// Creates an [Acceleration] instance from this value in Meters per second squared (m/s²).
  Acceleration get mpsSquared => Acceleration(toDouble(), AccelerationUnit.meterPerSecondSquared);

  /// Creates an [Acceleration] instance from this value in Standard Gravity (g).
  /// Note: A trailing underscore is used to avoid conflict with the getter 'g' for grams in Mass.
  Acceleration get gravity => Acceleration(toDouble(), AccelerationUnit.standardGravity);

  /// Creates an [Acceleration] instance from this value in Kilometers per hour per second.
  Acceleration get kmhPerS => Acceleration(toDouble(), AccelerationUnit.kilometerPerHourPerSecond);

  /// Creates an [Acceleration] instance from this value in Miles per hour per second.
  Acceleration get mphPerS => Acceleration(toDouble(), AccelerationUnit.milePerHourPerSecond);

  /// Creates an [Acceleration] instance from this value in Knots per second.
  Acceleration get knotsPerS => Acceleration(toDouble(), AccelerationUnit.knotPerSecond);

  /// Creates an [Acceleration] instance from this value in Feet per second squared (ft/s²).
  Acceleration get fpsSquared => Acceleration(toDouble(), AccelerationUnit.footPerSecondSquared);

  /// Creates an [Acceleration] instance from this value in Centimeters per second squared (cm/s²).
  /// Also known as the Galileo (Gal).
  Acceleration get cmpss => Acceleration(toDouble(), AccelerationUnit.centimeterPerSecondSquared);

  /// Creates an [Acceleration] instance from this value in Galileos (Gal).
  /// Alias for `cmpss`.
  Acceleration get gal => Acceleration(toDouble(), AccelerationUnit.centimeterPerSecondSquared);
}
