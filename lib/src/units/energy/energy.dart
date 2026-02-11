import 'package:meta/meta.dart';

import '../../core/quantity.dart';
import 'energy_unit.dart';

/// Represents a quantity of energy.
///
/// Energy is a fundamental physical quantity representing the capacity to do work.
/// The SI derived unit for energy is the Joule (J). This class provides a
/// type-safe way to handle energy values and conversions between different units
/// (e.g., joules, calories, kilowatt-hours).
@immutable
class Energy extends Quantity<EnergyUnit> {
  /// Creates a new `Energy` quantity with the given numerical [value] and [unit].
  ///
  /// Example:
  /// ```dart
  /// final workDone = Energy(500.0, EnergyUnit.joule);
  /// final foodEnergy = Energy(250.0, EnergyUnit.kilocalorie);
  /// final electricityUsed = Energy(1.2, EnergyUnit.kilowattHour);
  /// ```
  const Energy(super._value, super._unit);

  /// Converts this energy's value to the specified [targetUnit].
  ///
  /// This method uses pre-calculated direct conversion factors from the `EnergyUnit`
  /// enum for efficiency, typically involving a single multiplication.
  ///
  /// Example:
  /// ```dart
  /// final energyInKcal = Energy(1.0, EnergyUnit.kilocalorie);
  /// final valueInJoules = energyInKcal.getValue(EnergyUnit.joule); // 4184.0
  /// ```
  @override
  double getValue(EnergyUnit targetUnit) {
    if (targetUnit == unit) return value;
    return value * unit.factorTo(targetUnit);
  }

  /// Creates a new [Energy] instance with the value converted to the [targetUnit].
  ///
  /// This is useful for obtaining a new `Energy` object in a different unit
  /// while preserving type safety and the immutability of `Quantity` objects.
  ///
  /// Example:
  /// ```dart
  /// final energyInJoules = Energy(10000.0, EnergyUnit.joule);
  /// final energyInKcalObj = energyInJoules.convertTo(EnergyUnit.kilocalorie);
  /// // energyInKcalObj is Energy(approx. 2.39, EnergyUnit.kilocalorie)
  /// print(energyInKcalObj);
  /// ```
  @override
  Energy convertTo(EnergyUnit targetUnit) {
    if (targetUnit == unit) return this;
    final newValue = getValue(targetUnit);
    return Energy(newValue, targetUnit);
  }

  /// Compares this [Energy] object to another [Quantity<EnergyUnit>].
  ///
  /// Comparison is based on the physical magnitude of the energies. For an
  /// accurate comparison, this energy's value is converted to the unit of the
  /// [other] energy before their numerical values are compared.
  ///
  /// Returns:
  /// - A negative integer if this energy is less than [other].
  /// - Zero if this energy is equal in magnitude to [other].
  /// - A positive integer if this energy is greater than [other].
  ///
  /// Example:
  /// ```dart
  /// final e1 = Energy(1.0, EnergyUnit.kilocalorie);    // 4184 J
  /// final e2 = Energy(4184.0, EnergyUnit.joule);      // 4184 J
  /// final e3 = Energy(1.0, EnergyUnit.btu);           // ~1055 J
  ///
  /// print(e1.compareTo(e2)); // 0 (equal magnitude)
  /// print(e1.compareTo(e3)); // 1 (e1 > e3)
  /// ```
  @override
  int compareTo(Quantity<EnergyUnit> other) {
    final thisValueInOtherUnit = getValue(other.unit);
    return thisValueInOtherUnit.compareTo(other.value);
  }

  // --- Arithmetic Operators ---

  /// Adds this energy to another energy.
  ///
  /// The [other] energy is converted to the unit of this energy before addition.
  /// The result is a new [Energy] instance with the sum, expressed in the unit
  /// of this energy (the left-hand operand).
  ///
  /// Example:
  /// ```dart
  /// final work = Energy(100.0, EnergyUnit.joule);
  /// final heat = Energy(0.5, EnergyUnit.kilocalorie); // 2092 J
  /// final totalEnergy = work + heat; // Result: Energy(2192.0, EnergyUnit.joule)
  /// ```
  Energy operator +(Energy other) {
    final otherValueInThisUnit = other.getValue(unit);
    return Energy(value + otherValueInThisUnit, unit);
  }

  /// Subtracts another energy from this energy.
  ///
  /// The [other] energy is converted to the unit of this energy before subtraction.
  /// The result is a new [Energy] instance with the difference, expressed in the
  /// unit of this energy (the left-hand operand).
  ///
  /// Example:
  /// ```dart
  /// final totalOutput = Energy(5.0, EnergyUnit.kilowattHour);
  /// final energyConsumed = Energy(1.2, EnergyUnit.kilowattHour);
  /// final netEnergy = totalOutput - energyConsumed; // Result: Energy(3.8, EnergyUnit.kilowattHour)
  /// ```
  Energy operator -(Energy other) {
    final otherValueInThisUnit = other.getValue(unit);
    return Energy(value - otherValueInThisUnit, unit);
  }

  /// Multiplies this energy by a scalar value (a dimensionless number).
  ///
  /// Returns a new [Energy] instance with the scaled value, in the original
  /// unit of this energy.
  ///
  /// Example:
  /// ```dart
  /// final singleEventEnergy = Energy(150.0, EnergyUnit.joule);
  /// final energyOfTenEvents = singleEventEnergy * 10.0; // Result: Energy(1500.0, EnergyUnit.joule)
  /// ```
  Energy operator *(double scalar) {
    return Energy(value * scalar, unit);
  }

  /// Divides this energy by a scalar value (a dimensionless number).
  ///
  /// Returns a new [Energy] instance with the scaled value, in the original
  /// unit of this energy. Throws [ArgumentError] if the [scalar] is zero.
  ///
  /// Example:
  /// ```dart
  /// final totalEnergy = Energy(1000.0, EnergyUnit.kilocalorie);
  /// final energyPerServing = totalEnergy / 4.0; // Result: Energy(250.0, EnergyUnit.kilocalorie)
  /// ```
  Energy operator /(double scalar) {
    if (scalar == 0) {
      throw ArgumentError('Cannot divide by zero.');
    }
    return Energy(value / scalar, unit);
  }
}
