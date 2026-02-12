import 'package:meta/meta.dart';

import '../../core/quantity.dart';
import 'solid_angle_unit.dart';

/// Represents a quantity of solid angle.
///
/// A solid angle is the two-dimensional angle in three-dimensional space that
/// an object subtends at a point. It is a measure of how large the object appears
/// to an observer looking from that point. The SI derived unit is the Steradian (sr).
@immutable
class SolidAngle extends Quantity<SolidAngleUnit> {
  /// Creates a new `SolidAngle` with a given [value] and [unit].
  const SolidAngle(super._value, super._unit);

  // --- Boilerplate ---

  /// Converts this solid angle's value to the specified [targetUnit].
  ///
  /// This method uses pre-calculated direct conversion factors from the `SolidAngleUnit`
  /// enum for efficiency, typically involving a single multiplication.
  ///
  /// Example:
  /// ```dart
  /// final sa = SolidAngle(1.0, SolidAngleUnit.steradian);
  /// final inSquareDegrees = sa.getValue(SolidAngleUnit.squareDegree); // ~3282.806
  ///
  /// final sa2 = SolidAngle(3282.806, SolidAngleUnit.squareDegree);
  /// final inSteradians = sa2.getValue(SolidAngleUnit.steradian); // approx 1.0
  /// ```
  @override
  double getValue(SolidAngleUnit targetUnit) {
    // If the target unit is the same as the current unit, no conversion is needed.
    if (targetUnit == unit) return value;
    // Otherwise, multiply by the direct conversion factor.
    return value * unit.factorTo(targetUnit);
  }

  /// Creates a new [SolidAngle] instance with the value converted to the [targetUnit].
  ///
  /// This is useful for obtaining a new `SolidAngle` object in a different unit
  /// while preserving type safety and the immutability of `Quantity` objects.
  ///
  /// Example:
  /// ```dart
  /// final sa = SolidAngle(1.0, SolidAngleUnit.steradian);
  /// final inSquareDegrees = sa.convertTo(SolidAngleUnit.squareDegree);
  /// // inSquareDegrees is SolidAngle(~3282.806, SolidAngleUnit.squareDegree)
  /// print(inSquareDegrees); // Output: "~3282.806 deg²" (depending on toString formatting)
  /// ```
  @override
  SolidAngle convertTo(SolidAngleUnit targetUnit) {
    // If the target unit is the same, return this instance (immutable optimization).
    if (targetUnit == unit) return this;
    final newValue = getValue(targetUnit);
    return SolidAngle(newValue, targetUnit);
  }

  /// Compares this [SolidAngle] object to another [Quantity<SolidAngleUnit>].
  ///
  /// Comparison is based on the physical magnitude of the solid angles.
  /// For an accurate comparison, this solid angle's value is converted to the unit
  /// of the [other] solid angle before their numerical values are compared.
  ///
  /// Returns:
  /// - A negative integer if this solid angle is less than [other].
  /// - Zero if this solid angle is equal in magnitude to [other].
  /// - A positive integer if this solid angle is greater than [other].
  ///
  /// Example:
  /// ```dart
  /// final sa1 = SolidAngle(1.0, SolidAngleUnit.steradian);
  /// final sa2 = SolidAngle(1.0, SolidAngleUnit.steradian);
  /// final sa3 = SolidAngle(0.5, SolidAngleUnit.steradian);
  ///
  /// print(sa1.compareTo(sa2)); // 0 (equal magnitude)
  /// print(sa1.compareTo(sa3)); // 1 (sa1 > sa3)
  /// print(sa3.compareTo(sa1)); // -1 (sa3 < sa1)
  /// ```
  @override
  int compareTo(Quantity<SolidAngleUnit> other) {
    final thisValueInOtherUnit = getValue(other.unit);
    return thisValueInOtherUnit.compareTo(other.value);
  }

  // --- Arithmetic Operators ---

  /// Adds this solid angle to another.
  ///
  /// The [other] solid angle is converted to the unit of this solid angle before addition.
  /// The result is a new [SolidAngle] instance with the sum, expressed in the unit of this solid angle.
  ///
  /// Example:
  /// ```dart
  /// final sa1 = SolidAngle(1.0, SolidAngleUnit.steradian);
  /// final sa2 = SolidAngle(3282.806, SolidAngleUnit.squareDegree); // approx 1 sr
  /// final total = sa1 + sa2; // Result: SolidAngle(~2.0, SolidAngleUnit.steradian)
  /// ```
  SolidAngle operator +(SolidAngle other) {
    final otherValueInThisUnit = other.getValue(unit);
    return SolidAngle(value + otherValueInThisUnit, unit);
  }

  /// Subtracts another solid angle from this solid angle.
  ///
  /// The [other] solid angle is converted to the unit of this solid angle before subtraction.
  /// The result is a new [SolidAngle] instance with the difference, expressed in the unit of this solid angle.
  ///
  /// Example:
  /// ```dart
  /// final sa1 = SolidAngle(2.0, SolidAngleUnit.steradian);
  /// final sa2 = SolidAngle(3282.806, SolidAngleUnit.squareDegree); // approx 1 sr
  /// final diff = sa1 - sa2; // Result: SolidAngle(~1.0, SolidAngleUnit.steradian)
  /// ```
  SolidAngle operator -(SolidAngle other) {
    final otherValueInThisUnit = other.getValue(unit);
    return SolidAngle(value - otherValueInThisUnit, unit);
  }

  /// Multiplies this solid angle by a scalar value (a dimensionless number).
  ///
  /// Returns a new [SolidAngle] instance with the scaled value, in the original unit of this solid angle.
  ///
  /// Example:
  /// ```dart
  /// final sa = SolidAngle(1.5, SolidAngleUnit.steradian);
  /// final doubled = sa * 2.0; // Result: SolidAngle(3.0, SolidAngleUnit.steradian)
  /// ```
  SolidAngle operator *(double scalar) {
    return SolidAngle(value * scalar, unit);
  }

  /// Divides this solid angle by a scalar value (a dimensionless number).
  ///
  /// Returns a new [SolidAngle] instance with the scaled value, in the original unit of this solid angle.
  /// Throws [ArgumentError] if the [scalar] is zero.
  ///
  /// Example:
  /// ```dart
  /// final sa = SolidAngle(3.0, SolidAngleUnit.steradian);
  /// final scaled = sa / 2.0; // Result: SolidAngle(1.5, SolidAngleUnit.steradian)
  /// ```
  SolidAngle operator /(double scalar) {
    if (scalar == 0) {
      throw ArgumentError('Cannot divide by zero.');
    }
    return SolidAngle(value / scalar, unit);
  }
}
