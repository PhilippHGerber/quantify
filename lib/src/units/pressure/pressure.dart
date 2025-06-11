import 'package:meta/meta.dart';

import '../../core/quantity.dart';
import 'pressure_unit.dart';

/// Represents a quantity of pressure.
///
/// Pressure is a fundamental physical quantity, defined as force per unit area.
/// This class provides a type-safe way to handle pressure values and conversions
/// between different units of pressure.
@immutable
class Pressure extends Quantity<PressureUnit> {
  /// Creates a new Pressure quantity with the given [value] and [unit].
  ///
  /// Example:
  /// ```dart
  /// final standardAtmosphere = Pressure(1.0, PressureUnit.atmosphere);
  /// final tirePressure = Pressure(32.0, PressureUnit.psi);
  /// ```
  const Pressure(super.value, super.unit);

  /// Converts this pressure's value to the specified [targetUnit].
  ///
  /// This method uses pre-calculated direct conversion factors for efficiency,
  /// typically involving a single multiplication.
  ///
  /// Example:
  /// ```dart
  /// final p_atm = Pressure(1.0, PressureUnit.atmosphere);
  /// final p_pascals = p_atm.getValue(PressureUnit.pascal); // 101325.0
  /// ```
  @override
  double getValue(PressureUnit targetUnit) {
    if (targetUnit == unit) return value;
    return value * unit.factorTo(targetUnit);
  }

  /// Creates a new [Pressure] instance with the value converted to the [targetUnit].
  ///
  /// This is useful for obtaining a new `Pressure` object in a different unit
  /// while preserving type safety and quantity semantics.
  ///
  /// Example:
  /// ```dart
  /// final p_bar = Pressure(1.5, PressureUnit.bar);
  /// final p_psi = p_bar.convertTo(PressureUnit.psi);
  /// print(p_psi); // Output: approx "21.7557 psi"
  /// ```
  @override
  Pressure convertTo(PressureUnit targetUnit) {
    if (targetUnit == unit) return this;
    final newValue = getValue(targetUnit);
    return Pressure(newValue, targetUnit);
  }

  /// Compares this [Pressure] object to another [Quantity<PressureUnit>].
  ///
  /// Comparison is based on the physical magnitude of the pressures.
  /// For comparison, this pressure is converted to the unit of the [other] pressure.
  ///
  /// Returns:
  /// - A negative integer if this pressure is less than [other].
  /// - Zero if this pressure is equal to [other].
  /// - A positive integer if this pressure is greater than [other].
  ///
  /// Example:
  /// ```dart
  /// final p1 = Pressure(1.0, PressureUnit.bar);    // 100000 Pa
  /// final p2 = Pressure(1000.0, PressureUnit.millibar); // 100000 Pa
  /// final p3 = Pressure(15.0, PressureUnit.psi);   // approx 103421 Pa
  ///
  /// print(p1.compareTo(p2)); // 0 (equal)
  /// print(p1.compareTo(p3)); // -1 (p1 < p3)
  /// ```
  @override
  int compareTo(Quantity<PressureUnit> other) {
    // Convert this quantity's value to the unit of the 'other' quantity
    // for a direct numerical comparison.
    final thisValueInOtherUnit = getValue(other.unit);
    return thisValueInOtherUnit.compareTo(other.value);
  }

  // --- Arithmetic Operators ---

  /// Adds this pressure to another pressure.
  /// The [other] pressure is converted to the unit of this pressure before addition.
  /// Returns a new [Pressure] instance with the result in the unit of this pressure.
  Pressure operator +(Pressure other) {
    final otherValueInThisUnit = other.getValue(unit);
    return Pressure(value + otherValueInThisUnit, unit);
  }

  /// Subtracts another pressure from this pressure.
  /// The [other] pressure is converted to the unit of this pressure before subtraction.
  /// Returns a new [Pressure] instance with the result in the unit of this pressure.
  Pressure operator -(Pressure other) {
    final otherValueInThisUnit = other.getValue(unit);
    return Pressure(value - otherValueInThisUnit, unit);
  }

  /// Multiplies this pressure by a scalar value.
  /// Returns a new [Pressure] instance with the scaled value in the original unit.
  Pressure operator *(double scalar) {
    return Pressure(value * scalar, unit);
  }

  /// Divides this pressure by a scalar value.
  /// Returns a new [Pressure] instance with the scaled value in the original unit.
  /// Throws [ArgumentError] if scalar is zero.
  Pressure operator /(double scalar) {
    if (scalar == 0) {
      throw ArgumentError('Cannot divide by zero.');
    }
    return Pressure(value / scalar, unit);
  }
}
