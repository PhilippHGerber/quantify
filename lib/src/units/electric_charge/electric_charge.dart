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
  const ElectricCharge(super.value, super.unit);

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
  @override
  double getValue(ElectricChargeUnit targetUnit) {
    if (targetUnit == unit) return value;
    return value * unit.factorTo(targetUnit);
  }

  /// Creates a new [ElectricCharge] instance with the value converted to the [targetUnit].
  @override
  ElectricCharge convertTo(ElectricChargeUnit targetUnit) {
    if (targetUnit == unit) return this;
    final newValue = getValue(targetUnit);
    return ElectricCharge(newValue, targetUnit);
  }

  @override
  int compareTo(Quantity<ElectricChargeUnit> other) {
    final thisValueInOtherUnit = getValue(other.unit);
    return thisValueInOtherUnit.compareTo(other.value);
  }

  // --- Arithmetic Operators ---

  /// Adds this electric charge to another.
  ElectricCharge operator +(ElectricCharge other) {
    final otherValueInThisUnit = other.getValue(unit);
    return ElectricCharge(value + otherValueInThisUnit, unit);
  }

  /// Subtracts another electric charge from this one.
  ElectricCharge operator -(ElectricCharge other) {
    final otherValueInThisUnit = other.getValue(unit);
    return ElectricCharge(value - otherValueInThisUnit, unit);
  }

  /// Multiplies this electric charge by a scalar.
  ElectricCharge operator *(double scalar) {
    return ElectricCharge(value * scalar, unit);
  }

  /// Divides this electric charge by a scalar.
  ElectricCharge operator /(double scalar) {
    if (scalar == 0) {
      throw ArgumentError('Cannot divide by zero.');
    }
    return ElectricCharge(value / scalar, unit);
  }
}
