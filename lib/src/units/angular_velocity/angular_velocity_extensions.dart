import 'angular_velocity.dart';
import 'angular_velocity_unit.dart';

/// Provides convenient access to [AngularVelocity] values in specific units.
extension AngularVelocityValueGetters on AngularVelocity {
  /// Returns the value in Radians per second (rad/s).
  double get inRadiansPerSecond => getValue(AngularVelocityUnit.radianPerSecond);

  /// Returns the value in Degrees per second (°/s).
  double get inDegreesPerSecond => getValue(AngularVelocityUnit.degreePerSecond);

  /// Returns the value in Revolutions per minute (rpm).
  double get inRpm => getValue(AngularVelocityUnit.revolutionPerMinute);

  /// Returns the value in Revolutions per second (rps).
  double get inRps => getValue(AngularVelocityUnit.revolutionPerSecond);

  /// Returns an [AngularVelocity] object in Radians per second (rad/s).
  AngularVelocity get asRadiansPerSecond => convertTo(AngularVelocityUnit.radianPerSecond);

  /// Returns an [AngularVelocity] object in Degrees per second (°/s).
  AngularVelocity get asDegreesPerSecond => convertTo(AngularVelocityUnit.degreePerSecond);

  /// Returns an [AngularVelocity] object in Revolutions per minute (rpm).
  AngularVelocity get asRpm => convertTo(AngularVelocityUnit.revolutionPerMinute);

  /// Returns an [AngularVelocity] object in Revolutions per second (rps).
  AngularVelocity get asRps => convertTo(AngularVelocityUnit.revolutionPerSecond);
}

/// Provides convenient factory methods for creating [AngularVelocity] instances from [num].
extension AngularVelocityCreation on num {
  /// Creates an [AngularVelocity] from this value in Radians per second (rad/s).
  AngularVelocity get radiansPerSecond =>
      AngularVelocity(toDouble(), AngularVelocityUnit.radianPerSecond);

  /// Creates an [AngularVelocity] from this value in Degrees per second (°/s).
  AngularVelocity get degreesPerSecond =>
      AngularVelocity(toDouble(), AngularVelocityUnit.degreePerSecond);

  /// Creates an [AngularVelocity] from this value in Revolutions per minute (rpm).
  AngularVelocity get rpm => AngularVelocity(toDouble(), AngularVelocityUnit.revolutionPerMinute);

  /// Creates an [AngularVelocity] from this value in Revolutions per second (rps).
  AngularVelocity get rps => AngularVelocity(toDouble(), AngularVelocityUnit.revolutionPerSecond);

  /// Alias for `rps`.
  AngularVelocity get revolutionsPerSecond =>
      AngularVelocity(toDouble(), AngularVelocityUnit.revolutionPerSecond);
}
