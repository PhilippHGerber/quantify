import 'package:meta/meta.dart';

import '../../core/quantity.dart';
import '../current/current.dart';
import '../current/current_extensions.dart';
import '../current/current_unit.dart';
import '../time/time.dart';
import '../time/time_extensions.dart';
import '../time/time_unit.dart';
import 'electric_charge_unit.dart';

/// Represents a quantity of electric charge.
///
/// Electric charge is a fundamental property of matter that causes it to experience
/// a force in an electromagnetic field. The SI derived unit is the Coulomb (C),
/// defined as the charge transported by a constant current of one ampere in one second.
@immutable
class ElectricCharge extends Quantity<ElectricChargeUnit> {
  /// Creates a new `ElectricCharge` with a given [value] and [unit].
  const ElectricCharge(super._value, super._unit);

  // --- Dimensional Analysis ---

  /// Creates an `ElectricCharge` from a `Current` flowing over a `Time` duration (Q = I * t).
  ///
  /// Example:
  /// ```dart
  /// final current = 2.A;
  /// final time = 1.h;
  /// final charge = ElectricCharge.from(current, time);
  /// print(charge.inAmpereHours); // Output: 2.0
  /// print(charge.inCoulombs); // Output: 7200.0
  /// ```
  factory ElectricCharge.from(Current current, Time time) {
    final amperes = current.inAmperes;
    final seconds = time.inSeconds;
    return ElectricCharge(amperes * seconds, ElectricChargeUnit.coulomb);
  }

  /// Calculates the `Current` if this charge flows over a given `Time` (I = Q / t).
  ///
  /// Throws an [ArgumentError] if the `time` is zero.
  Current currentOver(Time time) {
    final coulombs = getValue(ElectricChargeUnit.coulomb);
    final seconds = time.inSeconds;
    if (seconds == 0) {
      throw ArgumentError('Time cannot be zero when calculating current from charge.');
    }
    return Current(coulombs / seconds, CurrentUnit.ampere);
  }

  /// Calculates the `Time` it takes for this charge to flow at a given `Current` (t = Q / I).
  ///
  /// Throws an [ArgumentError] if the `current` is zero.
  Time timeFor(Current current) {
    final coulombs = getValue(ElectricChargeUnit.coulomb);
    final amperes = current.inAmperes;
    if (amperes == 0) {
      throw ArgumentError('Current cannot be zero when calculating time from charge.');
    }
    return Time(coulombs / amperes, TimeUnit.second);
  }

  // --- Boilerplate ---

  /// Converts this electric charge's value to the specified [targetUnit].
  ///
  /// This method uses pre-calculated direct conversion factors from the `ElectricChargeUnit`
  /// enum for efficiency, typically involving a single multiplication.
  ///
  /// Example:
  /// ```dart
  /// final q = ElectricCharge(1.0, ElectricChargeUnit.coulomb);
  /// final inMillicoulombs = q.getValue(ElectricChargeUnit.millicoulomb); // 1000.0
  ///
  /// final q2 = ElectricCharge(7200.0, ElectricChargeUnit.coulomb);
  /// final inAmpereHours = q2.getValue(ElectricChargeUnit.ampereHour); // 2.0
  /// ```
  @override
  double getValue(ElectricChargeUnit targetUnit) {
    // If the target unit is the same as the current unit, no conversion is needed.
    if (targetUnit == unit) return value;
    // Otherwise, multiply by the direct conversion factor.
    return value * unit.factorTo(targetUnit);
  }

  /// Creates a new [ElectricCharge] instance with the value converted to the [targetUnit].
  ///
  /// This is useful for obtaining a new `ElectricCharge` object in a different unit
  /// while preserving type safety and the immutability of `Quantity` objects.
  ///
  /// Example:
  /// ```dart
  /// final q = ElectricCharge(1000.0, ElectricChargeUnit.millicoulomb);
  /// final inCoulombs = q.convertTo(ElectricChargeUnit.coulomb);
  /// // inCoulombs is ElectricCharge(1.0, ElectricChargeUnit.coulomb)
  /// print(inCoulombs); // Output: "1.0 C" (depending on toString formatting)
  /// ```
  @override
  ElectricCharge convertTo(ElectricChargeUnit targetUnit) {
    // If the target unit is the same, return this instance (immutable optimization).
    if (targetUnit == unit) return this;
    final newValue = getValue(targetUnit);
    return ElectricCharge(newValue, targetUnit);
  }

  /// Compares this [ElectricCharge] object to another [Quantity<ElectricChargeUnit>].
  ///
  /// Comparison is based on the physical magnitude of the electric charges.
  /// For an accurate comparison, this charge's value is converted to the unit
  /// of the [other] charge before their numerical values are compared.
  ///
  /// Returns:
  /// - A negative integer if this charge is less than [other].
  /// - Zero if this charge is equal in magnitude to [other].
  /// - A positive integer if this charge is greater than [other].
  ///
  /// Example:
  /// ```dart
  /// final q1 = ElectricCharge(1.0, ElectricChargeUnit.coulomb);        // 1 C
  /// final q2 = ElectricCharge(1000.0, ElectricChargeUnit.millicoulomb); // 1 C
  /// final q3 = ElectricCharge(0.5, ElectricChargeUnit.coulomb);
  ///
  /// print(q1.compareTo(q2)); // 0 (equal magnitude)
  /// print(q1.compareTo(q3)); // 1 (q1 > q3)
  /// print(q3.compareTo(q1)); // -1 (q3 < q1)
  /// ```
  @override
  int compareTo(Quantity<ElectricChargeUnit> other) {
    final thisValueInOtherUnit = getValue(other.unit);
    return thisValueInOtherUnit.compareTo(other.value);
  }

  // --- Arithmetic Operators ---

  /// Adds this electric charge to another.
  ///
  /// The [other] charge is converted to the unit of this charge before addition.
  /// The result is a new [ElectricCharge] instance with the sum, expressed in the unit of this charge.
  ///
  /// Example:
  /// ```dart
  /// final q1 = ElectricCharge(1.0, ElectricChargeUnit.coulomb); // 1000 mC
  /// final q2 = ElectricCharge(500.0, ElectricChargeUnit.millicoulomb); // 0.5 C
  /// final total = q1 + q2; // Result: ElectricCharge(1.5, ElectricChargeUnit.coulomb)
  /// ```
  ElectricCharge operator +(ElectricCharge other) {
    final otherValueInThisUnit = other.getValue(unit);
    return ElectricCharge(value + otherValueInThisUnit, unit);
  }

  /// Subtracts another electric charge from this charge.
  ///
  /// The [other] charge is converted to the unit of this charge before subtraction.
  /// The result is a new [ElectricCharge] instance with the difference, expressed in the unit of this charge.
  ///
  /// Example:
  /// ```dart
  /// final q1 = ElectricCharge(2.0, ElectricChargeUnit.coulomb);
  /// final q2 = ElectricCharge(500.0, ElectricChargeUnit.millicoulomb); // 0.5 C
  /// final diff = q1 - q2; // Result: ElectricCharge(1.5, ElectricChargeUnit.coulomb)
  /// ```
  ElectricCharge operator -(ElectricCharge other) {
    final otherValueInThisUnit = other.getValue(unit);
    return ElectricCharge(value - otherValueInThisUnit, unit);
  }

  /// Multiplies this electric charge by a scalar value (a dimensionless number).
  ///
  /// Returns a new [ElectricCharge] instance with the scaled value, in the original unit of this charge.
  ///
  /// Example:
  /// ```dart
  /// final q = ElectricCharge(2.0, ElectricChargeUnit.coulomb);
  /// final scaled = q * 3.0; // Result: ElectricCharge(6.0, ElectricChargeUnit.coulomb)
  /// ```
  ElectricCharge operator *(double scalar) {
    return ElectricCharge(value * scalar, unit);
  }

  /// Divides this electric charge by a scalar value (a dimensionless number).
  ///
  /// Returns a new [ElectricCharge] instance with the scaled value, in the original unit of this charge.
  /// Throws [ArgumentError] if the [scalar] is zero.
  ///
  /// Example:
  /// ```dart
  /// final q = ElectricCharge(6.0, ElectricChargeUnit.coulomb);
  /// final scaled = q / 3.0; // Result: ElectricCharge(2.0, ElectricChargeUnit.coulomb)
  /// ```
  ElectricCharge operator /(double scalar) {
    if (scalar == 0) {
      throw ArgumentError('Cannot divide by zero.');
    }
    return ElectricCharge(value / scalar, unit);
  }
}
