import 'package:meta/meta.dart';

import '../../core/quantity.dart';
import 'power_unit.dart';

/// Represents a quantity of power.
///
/// Power is the rate at which energy is transferred or work is done.
/// The SI derived unit for power is the Watt (W), defined as one Joule per second.
/// This class provides a type-safe way to handle power values and conversions
/// between different units (e.g., watts, horsepower, Btu/h).
@immutable
class Power extends Quantity<PowerUnit> {
  /// Creates a new `Power` quantity with the given numerical [value] and [unit].
  ///
  /// Example:
  /// ```dart
  /// final lightBulbPower = Power(60.0, PowerUnit.watt);
  /// final carEnginePower = Power(150.0, PowerUnit.horsepower);
  /// final nuclearPlantOutput = Power(1.2, PowerUnit.gigawatt);
  /// ```
  const Power(super._value, super._unit);

  /// Converts this power's value to the specified [targetUnit].
  ///
  /// This method uses pre-calculated direct conversion factors from the `PowerUnit`
  /// enum for efficiency, typically involving a single multiplication.
  ///
  /// Example:
  /// ```dart
  /// final enginePowerHp = Power(200.0, PowerUnit.horsepower);
  /// final valueInKw = enginePowerHp.getValue(PowerUnit.kilowatt); // approx. 149.14
  /// ```
  @override
  double getValue(PowerUnit targetUnit) {
    if (targetUnit == unit) return value;
    return value * unit.factorTo(targetUnit);
  }

  /// Creates a new [Power] instance with the value converted to the [targetUnit].
  ///
  /// This is useful for obtaining a new `Power` object in a different unit
  /// while preserving type safety and the immutability of `Quantity` objects.
  ///
  /// Example:
  /// ```dart
  /// final powerInWatts = Power(75000.0, PowerUnit.watt);
  /// final powerInHpObj = powerInWatts.convertTo(PowerUnit.horsepower);
  /// // powerInHpObj is Energy(approx. 100.57, PowerUnit.horsepower)
  /// print(powerInHpObj);
  /// ```
  @override
  Power convertTo(PowerUnit targetUnit) {
    if (targetUnit == unit) return this;
    final newValue = getValue(targetUnit);
    return Power(newValue, targetUnit);
  }

  /// Compares this [Power] object to another [Quantity<PowerUnit>].
  ///
  /// Comparison is based on the physical magnitude of the powers. For an
  /// accurate comparison, this power's value is converted to the unit of the
  /// [other] power before their numerical values are compared.
  ///
  /// Returns:
  /// - A negative integer if this power is less than [other].
  /// - Zero if this power is equal in magnitude to [other].
  /// - A positive integer if this power is greater than [other].
  ///
  /// Example:
  /// ```dart
  /// final p1 = Power(1.0, PowerUnit.kilowatt);    // 1000 W
  /// final p2 = Power(1000.0, PowerUnit.watt);      // 1000 W
  /// final p3 = Power(1.0, PowerUnit.horsepower);   // ~745.7 W
  ///
  /// print(p1.compareTo(p2)); // 0 (equal magnitude)
  /// print(p1.compareTo(p3)); // 1 (p1 > p3)
  /// ```
  @override
  int compareTo(Quantity<PowerUnit> other) {
    final thisValueInOtherUnit = getValue(other.unit);
    return thisValueInOtherUnit.compareTo(other.value);
  }

  // --- Arithmetic Operators ---

  /// Adds this power to another power.
  ///
  /// The [other] power is converted to the unit of this power before addition.
  /// The result is a new [Power] instance with the sum, expressed in the unit
  /// of this power (the left-hand operand).
  Power operator +(Power other) {
    final otherValueInThisUnit = other.getValue(unit);
    return Power(value + otherValueInThisUnit, unit);
  }

  /// Subtracts another power from this power.
  ///
  /// The [other] power is converted to the unit of this power before subtraction.
  /// The result is a new [Power] instance with the difference, expressed in the
  /// unit of this power (the left-hand operand).
  Power operator -(Power other) {
    final otherValueInThisUnit = other.getValue(unit);
    return Power(value - otherValueInThisUnit, unit);
  }

  /// Multiplies this power by a scalar value (a dimensionless number).
  ///
  /// Returns a new [Power] instance with the scaled value, in the original
  /// unit of this power.
  Power operator *(double scalar) {
    return Power(value * scalar, unit);
  }

  /// Divides this power by a scalar value (a dimensionless number).
  ///
  /// Returns a new [Power] instance with the scaled value, in the original
  /// unit of this power. Throws [ArgumentError] if the [scalar] is zero.
  Power operator /(double scalar) {
    if (scalar == 0) {
      throw ArgumentError('Cannot divide by zero.');
    }
    return Power(value / scalar, unit);
  }
}
