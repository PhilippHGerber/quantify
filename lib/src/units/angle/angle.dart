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
  const Angle(super.value, super.unit);

  /// Converts this angle's value to the specified [targetUnit].
  @override
  double getValue(AngleUnit targetUnit) {
    if (targetUnit == unit) return value;
    return value * unit.factorTo(targetUnit);
  }

  /// Creates a new [Angle] instance with the value converted to the [targetUnit].
  @override
  Angle convertTo(AngleUnit targetUnit) {
    if (targetUnit == unit) return this;
    final newValue = getValue(targetUnit);
    return Angle(newValue, targetUnit);
  }

  /// Compares this [Angle] object to another [Quantity<AngleUnit>].
  @override
  int compareTo(Quantity<AngleUnit> other) {
    final thisValueInOtherUnit = getValue(other.unit);
    return thisValueInOtherUnit.compareTo(other.value);
  }

  // --- Arithmetic Operators ---

  /// Adds this angle to another angle.
  Angle operator +(Angle other) {
    final otherValueInThisUnit = other.getValue(unit);
    return Angle(value + otherValueInThisUnit, unit);
  }

  /// Subtracts another angle from this angle.
  Angle operator -(Angle other) {
    final otherValueInThisUnit = other.getValue(unit);
    return Angle(value - otherValueInThisUnit, unit);
  }

  /// Multiplies this angle by a scalar value.
  Angle operator *(double scalar) {
    return Angle(value * scalar, unit);
  }

  /// Divides this angle by a scalar value.
  Angle operator /(double scalar) {
    if (scalar == 0) {
      throw ArgumentError('Cannot divide by zero.');
    }
    return Angle(value / scalar, unit);
  }
}
