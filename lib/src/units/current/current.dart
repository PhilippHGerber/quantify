import 'package:meta/meta.dart';

import '../../core/quantity.dart';
import 'current_unit.dart';

/// Represents a quantity of electric current.
///
/// Electric current is the rate of flow of electric charge. The SI base unit
/// for electric current is the Ampere (A). It is a fundamental quantity in
/// electrical engineering and physics.
///
/// This class provides a type-safe way to handle electric current values and
/// conversions between different units (e.g., amperes, milliamperes, kiloamperes).
@immutable
class Current extends Quantity<CurrentUnit> {
  /// Creates a new `Current` quantity with the given numerical [value] and [unit].
  ///
  /// Example:
  /// ```dart
  /// final circuitCurrent = Current(1.5, CurrentUnit.ampere);
  /// final sensorOutput = Current(20.0, CurrentUnit.milliampere);
  /// ```
  const Current(super._value, super._unit);

  /// Converts this electric current's value to the specified [targetUnit].
  ///
  /// This method uses pre-calculated direct conversion factors from the `CurrentUnit`
  /// enum for efficiency, typically involving a single multiplication.
  ///
  /// Example:
  /// ```dart
  /// final currentInAmperes = Current(0.05, CurrentUnit.ampere);
  /// final valueInMilliamperes = currentInAmperes.getValue(CurrentUnit.milliampere); // 50.0
  /// ```
  @override
  double getValue(CurrentUnit targetUnit) {
    if (targetUnit == unit) return value;
    return value * unit.factorTo(targetUnit);
  }

  /// Creates a new [Current] instance with the value converted to the [targetUnit].
  ///
  /// This is useful for obtaining a new `Current` object in a different unit
  /// while preserving type safety and the immutability of `Quantity` objects.
  ///
  /// Example:
  /// ```dart
  /// final currentInMilliamperes = Current(2500.0, CurrentUnit.milliampere);
  /// final currentInAmperesObj = currentInMilliamperes.convertTo(CurrentUnit.ampere);
  /// // currentInAmperesObj is Current(2.5, CurrentUnit.ampere)
  /// print(currentInAmperesObj); // Output: "2.5 A" (depending on toString formatting)
  /// ```
  @override
  Current convertTo(CurrentUnit targetUnit) {
    if (targetUnit == unit) return this;
    final newValue = getValue(targetUnit);
    return Current(newValue, targetUnit);
  }

  /// Compares this [Current] object to another [Quantity<CurrentUnit>].
  ///
  /// Comparison is based on the physical magnitude of the electric currents.
  /// For an accurate comparison, this current's value is converted to the unit
  /// of the [other] current before their numerical values are compared.
  ///
  /// Returns:
  /// - A negative integer if this current is less than [other].
  /// - Zero if this current is equal in magnitude to [other].
  /// - A positive integer if this current is greater than [other].
  ///
  /// Example:
  /// ```dart
  /// final c1 = Current(1.0, CurrentUnit.ampere);        // 1000 mA
  /// final c2 = Current(1000.0, CurrentUnit.milliampere); // 1000 mA
  /// final c3 = Current(0.5, CurrentUnit.ampere);       // 500 mA
  ///
  /// print(c1.compareTo(c2)); // 0 (equal magnitude)
  /// print(c1.compareTo(c3)); // 1 (c1 > c3)
  /// print(c3.compareTo(c1)); // -1 (c3 < c1)
  /// ```
  @override
  int compareTo(Quantity<CurrentUnit> other) {
    final thisValueInOtherUnit = getValue(other.unit);
    return thisValueInOtherUnit.compareTo(other.value);
  }

  // --- Arithmetic Operators ---

  /// Adds this electric current to another electric current.
  ///
  /// The [other] current is converted to the unit of this current before addition.
  /// The result is a new [Current] instance with the sum, expressed in the unit of this current.
  /// This is physically meaningful in contexts like Kirchhoff's Current Law (junction rule).
  ///
  /// Example:
  /// ```dart
  /// final currentBranchA = Current(0.75, CurrentUnit.ampere);
  /// final currentBranchB = Current(250.0, CurrentUnit.milliampere); // 0.25 A
  /// final totalCurrent = currentBranchA + currentBranchB; // Result: Current(1.0, CurrentUnit.ampere)
  /// ```
  Current operator +(Current other) {
    final otherValueInThisUnit = other.getValue(unit);
    return Current(value + otherValueInThisUnit, unit);
  }

  /// Subtracts another electric current from this electric current.
  ///
  /// The [other] current is converted to the unit of this current before subtraction.
  /// The result is a new [Current] instance with the difference, expressed in the unit of this current.
  ///
  /// Example:
  /// ```dart
  /// final mainCurrent = Current(2.0, CurrentUnit.ampere);
  /// final currentToDevice = Current(800.0, CurrentUnit.milliampere); // 0.8 A
  /// final remainingCurrent = mainCurrent - currentToDevice; // Result: Current(1.2, CurrentUnit.ampere)
  /// ```
  Current operator -(Current other) {
    final otherValueInThisUnit = other.getValue(unit);
    return Current(value - otherValueInThisUnit, unit);
  }

  /// Multiplies this electric current by a scalar value (a dimensionless number).
  ///
  /// Returns a new [Current] instance with the scaled value, in the original unit of this current.
  /// This might be used, for example, if a current is distributed equally among several paths.
  ///
  /// Example:
  /// ```dart
  /// final currentPerWire = Current(0.1, CurrentUnit.ampere);
  /// final totalCurrentFor5Wires = currentPerWire * 5.0; // Result: Current(0.5, CurrentUnit.ampere)
  /// ```
  Current operator *(double scalar) {
    return Current(value * scalar, unit);
  }

  /// Divides this electric current by a scalar value (a dimensionless number).
  ///
  /// Returns a new [Current] instance with the scaled value, in the original unit of this current.
  /// Throws [ArgumentError] if the [scalar] is zero.
  ///
  /// Example:
  /// ```dart
  /// final totalCurrent = Current(1.0, CurrentUnit.ampere);
  /// final currentPerBranch = totalCurrent / 4.0; // Result: Current(0.25, CurrentUnit.ampere)
  /// ```
  Current operator /(double scalar) {
    if (scalar == 0) {
      throw ArgumentError('Cannot divide by zero.');
    }
    return Current(value / scalar, unit);
  }

  // Potential future enhancements for Current:
  // - Current * Time = ElectricCharge (would require ElectricCharge type)
  // - ElectricPotential / Current = Resistance (would require ElectricPotential and Resistance types)
  // - Power / Current = ElectricPotential (would require Power and ElectricPotential types)
}
