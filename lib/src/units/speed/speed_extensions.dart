import 'speed.dart';
import 'speed_unit.dart';

/// Provides convenient access to [Speed] values in specific units.
extension SpeedValueGetters on Speed {
  /// Returns the speed value in Meters per second (m/s).
  double get inMetersPerSecond => getValue(SpeedUnit.meterPerSecond);

  /// Returns the speed value in Meters per second (m/s).
  /// Alias for `inMetersPerSecond`.
  double get inMps => getValue(SpeedUnit.meterPerSecond);

  /// Returns the speed value in Kilometers per hour (km/h).
  double get inKilometersPerHour => getValue(SpeedUnit.kilometerPerHour);

  /// Returns the speed value in Kilometers per hour (km/h).
  /// Alias for `inKilometersPerHour`.
  double get inKmh => getValue(SpeedUnit.kilometerPerHour);

  /// Returns the speed value in Miles per hour (mph).
  double get inMilesPerHour => getValue(SpeedUnit.milePerHour);

  /// Returns the speed value in Miles per hour (mph).
  /// Alias for `inMilesPerHour`.
  double get inMph => getValue(SpeedUnit.milePerHour);

  /// Returns the speed value in Knots (kn).
  double get inKnots => getValue(SpeedUnit.knot);

  /// Returns the speed value in Feet per second (ft/s).
  double get inFeetPerSecond => getValue(SpeedUnit.footPerSecond);

  /// Returns an [Speed] object representing this speed in Meters per second (m/s).
  Speed get asMetersPerSecond => convertTo(SpeedUnit.meterPerSecond);

  /// Returns an [Speed] object representing this speed in Kilometers per hour (km/h).
  Speed get asKilometersPerHour => convertTo(SpeedUnit.kilometerPerHour);

  /// Returns an [Speed] object representing this speed in Miles per hour (mph).
  Speed get asMilesPerHour => convertTo(SpeedUnit.milePerHour);

  /// Returns an [Speed] object representing this speed in Knots (kn).
  Speed get asKnots => convertTo(SpeedUnit.knot);

  /// Returns an [Speed] object representing this speed in Feet per second (ft/s).
  Speed get asFeetPerSecond => convertTo(SpeedUnit.footPerSecond);
}

/// Provides convenient factory methods for creating [Speed] instances from [num].
extension SpeedCreation on num {
  /// Creates a [Speed] instance from this value in Meters per second (m/s).
  Speed get mps => Speed(toDouble(), SpeedUnit.meterPerSecond);

  /// Creates a [Speed] instance from this value in Meters per second (m/s).
  Speed get metersPerSecond => Speed(toDouble(), SpeedUnit.meterPerSecond);

  /// Creates a [Speed] instance from this value in Kilometers per hour (km/h).
  Speed get kmh => Speed(toDouble(), SpeedUnit.kilometerPerHour);

  /// Creates a [Speed] instance from this value in Kilometers per hour (km/h).
  Speed get kilometersPerHour => Speed(toDouble(), SpeedUnit.kilometerPerHour);

  /// Creates a [Speed] instance from this value in Miles per hour (mph).
  Speed get mph => Speed(toDouble(), SpeedUnit.milePerHour);

  /// Creates a [Speed] instance from this value in Miles per hour (mph).
  Speed get milesPerHour => Speed(toDouble(), SpeedUnit.milePerHour);

  /// Creates a [Speed] instance from this value in Knots (kn).
  Speed get knots => Speed(toDouble(), SpeedUnit.knot);

  /// Creates a [Speed] instance from this value in Feet per second (ft/s).
  Speed get fps => Speed(toDouble(), SpeedUnit.footPerSecond);

  /// Creates a [Speed] instance from this value in Feet per second (ft/s).
  Speed get feetPerSecond => Speed(toDouble(), SpeedUnit.footPerSecond);
}
