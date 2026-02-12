import 'package:meta/meta.dart';

import '../../core/quantity.dart';
import 'angle_unit.dart';

/// Represents a quantity of a plane angle.
///
/// Although angle is a dimensionless quantity in the SI system, it is treated
/// as a distinct quantity type for type safety and clarity. This class provides a
/// way to handle angle values and conversions between different units like
/// degrees, radians, and revolutions.
@immutable
class Angle extends Quantity<AngleUnit> {
  /// Creates a new `Angle` quantity with the given numerical [value] and [unit].
  const Angle(super._value, super._unit);

  /// Converts this angle's value to the specified [targetUnit].
  ///
  /// This method uses pre-calculated direct conversion factors from the `AngleUnit`
  /// enum for efficiency, typically involving a single multiplication.
  ///
  /// Example:
  /// ```dart
  /// final a = Angle(1.0, AngleUnit.revolution);
  /// final inDegrees = a.getValue(AngleUnit.degree); // 360.0
  ///
  /// final a2 = Angle(180.0, AngleUnit.degree);
  /// final inRevolutions = a2.getValue(AngleUnit.revolution); // 0.5
  /// ```
  @override
  double getValue(AngleUnit targetUnit) {
    // If the target unit is the same as the current unit, no conversion is needed.
    if (targetUnit == unit) return value;
    // Otherwise, multiply by the direct conversion factor.
    return value * unit.factorTo(targetUnit);
  }

  /// Creates a new [Angle] instance with the value converted to the [targetUnit].
  ///
  /// This is useful for obtaining a new `Angle` object in a different unit
  /// while preserving type safety and the immutability of `Quantity` objects.
  ///
  /// Example:
  /// ```dart
  /// final a = Angle(180.0, AngleUnit.degree);
  /// final inRevolutions = a.convertTo(AngleUnit.revolution);
  /// // inRevolutions is Angle(0.5, AngleUnit.revolution)
  /// print(inRevolutions); // Output: "0.5 rev" (depending on toString formatting)
  /// ```
  @override
  Angle convertTo(AngleUnit targetUnit) {
    // If the target unit is the same, return this instance (immutable optimization).
    if (targetUnit == unit) return this;
    final newValue = getValue(targetUnit);
    return Angle(newValue, targetUnit);
  }

  /// Compares this [Angle] object to another [Quantity<AngleUnit>].
  ///
  /// Comparison is based on the physical magnitude of the angles.
  /// For an accurate comparison, this angle's value is converted to the unit
  /// of the [other] angle before their numerical values are compared.
  ///
  /// Returns:
  /// - A negative integer if this angle is less than [other].
  /// - Zero if this angle is equal in magnitude to [other].
  /// - A positive integer if this angle is greater than [other].
  ///
  /// Example:
  /// ```dart
  /// final a1 = Angle(180.0, AngleUnit.degree);  // π rad
  /// final a2 = Angle(1.0, AngleUnit.revolution); // 360°
  /// final a3 = Angle(90.0, AngleUnit.degree);
  ///
  /// print(a2.compareTo(a1)); // 1 (a2 > a1, since 360° > 180°)
  /// print(a1.compareTo(a3)); // 1 (a1 > a3)
  /// print(a3.compareTo(a1)); // -1 (a3 < a1)
  /// ```
  @override
  int compareTo(Quantity<AngleUnit> other) {
    final thisValueInOtherUnit = getValue(other.unit);
    return thisValueInOtherUnit.compareTo(other.value);
  }

  // --- Arithmetic Operators ---

  /// Adds this angle to another angle.
  ///
  /// The [other] angle is converted to the unit of this angle before addition.
  /// The result is a new [Angle] instance with the sum, expressed in the unit of this angle.
  ///
  /// Example:
  /// ```dart
  /// final a1 = Angle(270.0, AngleUnit.degree);
  /// final a2 = Angle(0.25, AngleUnit.revolution); // 90°
  /// final total = a1 + a2; // Result: Angle(360.0, AngleUnit.degree)
  /// ```
  Angle operator +(Angle other) {
    final otherValueInThisUnit = other.getValue(unit);
    return Angle(value + otherValueInThisUnit, unit);
  }

  /// Subtracts another angle from this angle.
  ///
  /// The [other] angle is converted to the unit of this angle before subtraction.
  /// The result is a new [Angle] instance with the difference, expressed in the unit of this angle.
  ///
  /// Example:
  /// ```dart
  /// final a1 = Angle(360.0, AngleUnit.degree);
  /// final a2 = Angle(0.25, AngleUnit.revolution); // 90°
  /// final diff = a1 - a2; // Result: Angle(270.0, AngleUnit.degree)
  /// ```
  Angle operator -(Angle other) {
    final otherValueInThisUnit = other.getValue(unit);
    return Angle(value - otherValueInThisUnit, unit);
  }

  /// Multiplies this angle by a scalar value (a dimensionless number).
  ///
  /// Returns a new [Angle] instance with the scaled value, in the original unit of this angle.
  ///
  /// Example:
  /// ```dart
  /// final a = Angle(45.0, AngleUnit.degree);
  /// final doubled = a * 2.0; // Result: Angle(90.0, AngleUnit.degree)
  /// ```
  Angle operator *(double scalar) {
    return Angle(value * scalar, unit);
  }

  /// Divides this angle by a scalar value (a dimensionless number).
  ///
  /// Returns a new [Angle] instance with the scaled value, in the original unit of this angle.
  /// Throws [ArgumentError] if the [scalar] is zero.
  ///
  /// Example:
  /// ```dart
  /// final a = Angle(90.0, AngleUnit.degree);
  /// final halved = a / 2.0; // Result: Angle(45.0, AngleUnit.degree)
  /// ```
  Angle operator /(double scalar) {
    if (scalar == 0) {
      throw ArgumentError('Cannot divide by zero.');
    }
    return Angle(value / scalar, unit);
  }
}
