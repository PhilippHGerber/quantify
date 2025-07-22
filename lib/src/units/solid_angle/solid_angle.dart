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
  const SolidAngle(super.value, super.unit);

  // --- Boilerplate ---

  /// Converts this solid angle's value to the specified [targetUnit].
  @override
  double getValue(SolidAngleUnit targetUnit) {
    if (targetUnit == unit) return value;
    return value * unit.factorTo(targetUnit);
  }

  /// Creates a new [SolidAngle] instance with the value converted to the [targetUnit].
  @override
  SolidAngle convertTo(SolidAngleUnit targetUnit) {
    if (targetUnit == unit) return this;
    final newValue = getValue(targetUnit);
    return SolidAngle(newValue, targetUnit);
  }

  @override
  int compareTo(Quantity<SolidAngleUnit> other) {
    final thisValueInOtherUnit = getValue(other.unit);
    return thisValueInOtherUnit.compareTo(other.value);
  }

  // --- Arithmetic Operators ---

  /// Adds this solid angle to another.
  SolidAngle operator +(SolidAngle other) {
    final otherValueInThisUnit = other.getValue(unit);
    return SolidAngle(value + otherValueInThisUnit, unit);
  }

  /// Subtracts another solid angle from this one.
  SolidAngle operator -(SolidAngle other) {
    final otherValueInThisUnit = other.getValue(unit);
    return SolidAngle(value - otherValueInThisUnit, unit);
  }

  /// Multiplies this solid angle by a scalar.
  SolidAngle operator *(double scalar) {
    return SolidAngle(value * scalar, unit);
  }

  /// Divides this solid angle by a scalar.
  SolidAngle operator /(double scalar) {
    if (scalar == 0) {
      throw ArgumentError('Cannot divide by zero.');
    }
    return SolidAngle(value / scalar, unit);
  }
}
