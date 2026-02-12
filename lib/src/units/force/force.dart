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
  ///
  /// This method uses pre-calculated direct conversion factors from the `ForceUnit`
  /// enum for efficiency, typically involving a single multiplication.
  ///
  /// Example:
  /// ```dart
  /// final f = Force(1.0, ForceUnit.kilonewton);
  /// final inNewtons = f.getValue(ForceUnit.newton); // 1000.0
  ///
  /// final f2 = Force(500.0, ForceUnit.newton);
  /// final inKiloNewtons = f2.getValue(ForceUnit.kilonewton); // 0.5
  /// ```
  @override
  double getValue(ForceUnit targetUnit) {
    // If the target unit is the same as the current unit, no conversion is needed.
    if (targetUnit == unit) return value;
    // Otherwise, multiply by the direct conversion factor.
    return value * unit.factorTo(targetUnit);
  }

  /// Creates a new [Force] instance with the value converted to the [targetUnit].
  ///
  /// This is useful for obtaining a new `Force` object in a different unit
  /// while preserving type safety and the immutability of `Quantity` objects.
  ///
  /// Example:
  /// ```dart
  /// final f = Force(1000.0, ForceUnit.newton);
  /// final inKiloNewtons = f.convertTo(ForceUnit.kilonewton);
  /// // inKiloNewtons is Force(1.0, ForceUnit.kilonewton)
  /// print(inKiloNewtons); // Output: "1.0 kN" (depending on toString formatting)
  /// ```
  @override
  Force convertTo(ForceUnit targetUnit) {
    // If the target unit is the same, return this instance (immutable optimization).
    if (targetUnit == unit) return this;
    final newValue = getValue(targetUnit);
    return Force(newValue, targetUnit);
  }

  /// Compares this [Force] object to another [Quantity<ForceUnit>].
  ///
  /// Comparison is based on the physical magnitude of the forces.
  /// For an accurate comparison, this force's value is converted to the unit
  /// of the [other] force before their numerical values are compared.
  ///
  /// Returns:
  /// - A negative integer if this force is less than [other].
  /// - Zero if this force is equal in magnitude to [other].
  /// - A positive integer if this force is greater than [other].
  ///
  /// Example:
  /// ```dart
  /// final f1 = Force(1.0, ForceUnit.kilonewton); // 1000 N
  /// final f2 = Force(1000.0, ForceUnit.newton);  // 1000 N
  /// final f3 = Force(500.0, ForceUnit.newton);
  ///
  /// print(f1.compareTo(f2)); // 0 (equal magnitude)
  /// print(f1.compareTo(f3)); // 1 (f1 > f3)
  /// print(f3.compareTo(f1)); // -1 (f3 < f1)
  /// ```
  @override
  int compareTo(Quantity<ForceUnit> other) {
    final thisValueInOtherUnit = getValue(other.unit);
    return thisValueInOtherUnit.compareTo(other.value);
  }

  // --- Arithmetic Operators ---

  /// Adds this force to another.
  ///
  /// The [other] force is converted to the unit of this force before addition.
  /// The result is a new [Force] instance with the sum, expressed in the unit of this force.
  ///
  /// Example:
  /// ```dart
  /// final f1 = Force(500.0, ForceUnit.newton);
  /// final f2 = Force(1.0, ForceUnit.kilonewton); // 1000 N
  /// final total = f1 + f2; // Result: Force(1500.0, ForceUnit.newton)
  /// ```
  Force operator +(Force other) {
    final otherValueInThisUnit = other.getValue(unit);
    return Force(value + otherValueInThisUnit, unit);
  }

  /// Subtracts another force from this force.
  ///
  /// The [other] force is converted to the unit of this force before subtraction.
  /// The result is a new [Force] instance with the difference, expressed in the unit of this force.
  ///
  /// Example:
  /// ```dart
  /// final f1 = Force(1500.0, ForceUnit.newton);
  /// final f2 = Force(1.0, ForceUnit.kilonewton); // 1000 N
  /// final diff = f1 - f2; // Result: Force(500.0, ForceUnit.newton)
  /// ```
  Force operator -(Force other) {
    final otherValueInThisUnit = other.getValue(unit);
    return Force(value - otherValueInThisUnit, unit);
  }

  /// Multiplies this force by a scalar value (a dimensionless number).
  ///
  /// Returns a new [Force] instance with the scaled value, in the original unit of this force.
  ///
  /// Example:
  /// ```dart
  /// final f = Force(10.0, ForceUnit.newton);
  /// final scaled = f * 3.0; // Result: Force(30.0, ForceUnit.newton)
  /// ```
  Force operator *(double scalar) {
    return Force(value * scalar, unit);
  }

  /// Divides this force by a scalar value (a dimensionless number).
  ///
  /// Returns a new [Force] instance with the scaled value, in the original unit of this force.
  /// Throws [ArgumentError] if the [scalar] is zero.
  ///
  /// Example:
  /// ```dart
  /// final f = Force(30.0, ForceUnit.newton);
  /// final scaled = f / 3.0; // Result: Force(10.0, ForceUnit.newton)
  /// ```
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
