import 'package:meta/meta.dart';

import '../../core/quantity.dart';
import '../acceleration/acceleration.dart';
import '../acceleration/acceleration_extensions.dart';
import '../acceleration/acceleration_unit.dart';
import '../mass/mass.dart';
import '../mass/mass_extensions.dart';
import '../mass/mass_unit.dart';
import 'force_unit.dart';

/// Represents a quantity of force.
///
/// Force is a derived quantity representing an influence that can change the
/// motion of an object. The SI derived unit is the Newton (N), which is
/// defined as `kg·m/s²`.
@immutable
class Force extends Quantity<ForceUnit> {
  /// Creates a new `Force` with a given [value] and [unit].
  const Force(super._value, super._unit);

  /// Creates a `Force` instance from `Mass` and `Acceleration` (F = m * a).
  ///
  /// This factory performs the dimensional calculation `Force = Mass × Acceleration`.
  /// It converts the inputs to their base SI units (kg and m/s²) for correctness.
  ///
  /// Example:
  /// ```dart
  /// final objectMass = 10.kg;
  /// final objectAcceleration = 2.mpsSquared;
  /// final requiredForce = Force.from(objectMass, objectAcceleration);
  /// print(requiredForce.inNewtons); // Output: 20.0
  /// ```
  factory Force.from(Mass mass, Acceleration acceleration) {
    final kg = mass.inKilograms;
    final mpss = acceleration.inMetersPerSecondSquared;
    return Force(kg * mpss, ForceUnit.newton);
  }

  /// Converts this force's value to the specified [targetUnit].
  @override
  double getValue(ForceUnit targetUnit) {
    if (targetUnit == unit) return value;
    return value * unit.factorTo(targetUnit);
  }

  /// Creates a new [Force] instance with the value converted to the [targetUnit].
  @override
  Force convertTo(ForceUnit targetUnit) {
    if (targetUnit == unit) return this;
    final newValue = getValue(targetUnit);
    return Force(newValue, targetUnit);
  }

  @override
  int compareTo(Quantity<ForceUnit> other) {
    final thisValueInOtherUnit = getValue(other.unit);
    return thisValueInOtherUnit.compareTo(other.value);
  }

  // --- Arithmetic Operators ---

  /// Adds this force to another.
  Force operator +(Force other) {
    final otherValueInThisUnit = other.getValue(unit);
    return Force(value + otherValueInThisUnit, unit);
  }

  /// Subtracts another force from this one.
  Force operator -(Force other) {
    final otherValueInThisUnit = other.getValue(unit);
    return Force(value - otherValueInThisUnit, unit);
  }

  /// Multiplies this force by a scalar.
  Force operator *(double scalar) {
    return Force(value * scalar, unit);
  }

  /// Divides this force by a scalar.
  Force operator /(double scalar) {
    if (scalar == 0) {
      throw ArgumentError('Cannot divide by zero.');
    }
    return Force(value / scalar, unit);
  }

  // --- Dimensional Analysis ---

  /// Calculates the [Acceleration] of a given [Mass] when this force is applied (a = F / m).
  ///
  /// Throws an [ArgumentError] if the `mass` is zero.
  /// The result is returned as an `Acceleration` quantity in m/s².
  ///
  /// Example:
  /// ```dart
  /// final force = 100.N;
  /// final mass = 10.kg;
  /// final resultingAcceleration = force.accelerationOf(mass);
  /// print(resultingAcceleration.inMetersPerSecondSquared); // Output: 10.0
  /// ```
  Acceleration accelerationOf(Mass mass) {
    final newtons = getValue(ForceUnit.newton);
    final kg = mass.inKilograms;
    if (kg == 0) {
      throw ArgumentError('Mass cannot be zero when calculating acceleration.');
    }
    return Acceleration(newtons / kg, AccelerationUnit.meterPerSecondSquared);
  }

  /// Calculates the [Mass] that would be accelerated at a given [Acceleration] by this force (m = F / a).
  ///
  /// Throws an [ArgumentError] if the `acceleration` is zero.
  /// The result is returned as a `Mass` quantity in kilograms.
  ///
  /// Example:
  /// ```dart
  /// final force = 20.N;
  /// final acceleration = 1.gravity; // ~9.8 m/s²
  /// final requiredMass = force.massFrom(acceleration);
  /// print(requiredMass.inKilograms); // Output: ~2.04
  /// ```
  Mass massFrom(Acceleration acceleration) {
    final newtons = getValue(ForceUnit.newton);
    final mpss = acceleration.inMetersPerSecondSquared;
    if (mpss == 0) {
      throw ArgumentError('Acceleration cannot be zero when calculating mass.');
    }
    return Mass(newtons / mpss, MassUnit.kilogram);
  }
}
