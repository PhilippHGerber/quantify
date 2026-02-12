import 'package:meta/meta.dart';

import '../../core/quantity.dart';
import '../energy/energy.dart';
import '../energy/energy_extensions.dart';
import '../energy/energy_unit.dart';
import '../mass/mass.dart';
import '../mass/mass_extensions.dart';
import 'specific_energy_unit.dart';

/// Represents a quantity of specific energy.
///
/// Specific energy is the energy per unit mass.
/// It represents the energy stored in a substance per unit mass (e.g., energy density of a fuel or battery).
/// The SI derived unit is Joule per Kilogram (J/kg).
@immutable
class SpecificEnergy extends Quantity<SpecificEnergyUnit> {
  /// Creates a new `SpecificEnergy` with a given [value] and [unit].
  const SpecificEnergy(super._value, super._unit);

  /// Creates a `SpecificEnergy` instance from a given [Energy] and [Mass].
  ///
  /// This factory performs the dimensional calculation `SpecificEnergy = Energy / Mass`.
  /// It converts the inputs to their base SI units (Joules and Kilograms) for correctness.
  /// Throws an [ArgumentError] if the mass is zero.
  factory SpecificEnergy.from(Energy energy, Mass mass) {
    final joules = energy.inJoules;
    final kilograms = mass.inKilograms;
    if (kilograms == 0) {
      throw ArgumentError('Mass cannot be zero when calculating specific energy.');
    }
    return SpecificEnergy(joules / kilograms, SpecificEnergyUnit.joulePerKilogram);
  }

  /// Converts this specific energy's value to the specified [targetUnit].
  ///
  /// This method uses pre-calculated direct conversion factors from the `SpecificEnergyUnit`
  /// enum for efficiency, typically involving a single multiplication.
  ///
  /// Example:
  /// ```dart
  /// final se = SpecificEnergy(1.0, SpecificEnergyUnit.megajoulePerKilogram);
  /// final inKJPerKg = se.getValue(SpecificEnergyUnit.kilojoulePerKilogram); // 1000.0
  ///
  /// final se2 = SpecificEnergy(1000.0, SpecificEnergyUnit.kilojoulePerKilogram);
  /// final inMJPerKg = se2.getValue(SpecificEnergyUnit.megajoulePerKilogram); // 1.0
  /// ```
  @override
  double getValue(SpecificEnergyUnit targetUnit) {
    // If the target unit is the same as the current unit, no conversion is needed.
    if (targetUnit == unit) return value;
    // Otherwise, multiply by the direct conversion factor.
    return value * unit.factorTo(targetUnit);
  }

  /// Creates a new [SpecificEnergy] instance with the value converted to the [targetUnit].
  ///
  /// This is useful for obtaining a new `SpecificEnergy` object in a different unit
  /// while preserving type safety and the immutability of `Quantity` objects.
  ///
  /// Example:
  /// ```dart
  /// final se = SpecificEnergy(1000.0, SpecificEnergyUnit.kilojoulePerKilogram);
  /// final inMJPerKg = se.convertTo(SpecificEnergyUnit.megajoulePerKilogram);
  /// // inMJPerKg is SpecificEnergy(1.0, SpecificEnergyUnit.megajoulePerKilogram)
  /// print(inMJPerKg); // Output: "1.0 MJ/kg" (depending on toString formatting)
  /// ```
  @override
  SpecificEnergy convertTo(SpecificEnergyUnit targetUnit) {
    // If the target unit is the same, return this instance (immutable optimization).
    if (targetUnit == unit) return this;
    final newValue = getValue(targetUnit);
    return SpecificEnergy(newValue, targetUnit);
  }

  /// Compares this [SpecificEnergy] object to another [Quantity<SpecificEnergyUnit>].
  ///
  /// Comparison is based on the physical magnitude of the specific energies.
  /// For an accurate comparison, this specific energy's value is converted to the unit
  /// of the [other] specific energy before their numerical values are compared.
  ///
  /// Returns:
  /// - A negative integer if this specific energy is less than [other].
  /// - Zero if this specific energy is equal in magnitude to [other].
  /// - A positive integer if this specific energy is greater than [other].
  ///
  /// Example:
  /// ```dart
  /// final se1 = SpecificEnergy(1.0, SpecificEnergyUnit.megajoulePerKilogram); // 1 MJ/kg
  /// final se2 = SpecificEnergy(1000.0, SpecificEnergyUnit.kilojoulePerKilogram); // 1 MJ/kg
  /// final se3 = SpecificEnergy(500.0, SpecificEnergyUnit.kilojoulePerKilogram);
  ///
  /// print(se1.compareTo(se2)); // 0 (equal magnitude)
  /// print(se1.compareTo(se3)); // 1 (se1 > se3)
  /// print(se3.compareTo(se1)); // -1 (se3 < se1)
  /// ```
  @override
  int compareTo(Quantity<SpecificEnergyUnit> other) {
    final thisValueInOtherUnit = getValue(other.unit);
    return thisValueInOtherUnit.compareTo(other.value);
  }

  // --- Arithmetic Operators ---

  /// Adds this specific energy to another.
  ///
  /// The [other] specific energy is converted to the unit of this specific energy before addition.
  /// The result is a new [SpecificEnergy] instance with the sum, expressed in the unit of this specific energy.
  ///
  /// Example:
  /// ```dart
  /// final se1 = SpecificEnergy(500.0, SpecificEnergyUnit.kilojoulePerKilogram);
  /// final se2 = SpecificEnergy(0.5, SpecificEnergyUnit.megajoulePerKilogram); // 500 kJ/kg
  /// final total = se1 + se2; // Result: SpecificEnergy(1000.0, SpecificEnergyUnit.kilojoulePerKilogram)
  /// ```
  SpecificEnergy operator +(SpecificEnergy other) {
    final otherValueInThisUnit = other.getValue(unit);
    return SpecificEnergy(value + otherValueInThisUnit, unit);
  }

  /// Subtracts another specific energy from this specific energy.
  ///
  /// The [other] specific energy is converted to the unit of this specific energy before subtraction.
  /// The result is a new [SpecificEnergy] instance with the difference, expressed in the unit of this specific energy.
  ///
  /// Example:
  /// ```dart
  /// final se1 = SpecificEnergy(1000.0, SpecificEnergyUnit.kilojoulePerKilogram);
  /// final se2 = SpecificEnergy(0.5, SpecificEnergyUnit.megajoulePerKilogram); // 500 kJ/kg
  /// final diff = se1 - se2; // Result: SpecificEnergy(500.0, SpecificEnergyUnit.kilojoulePerKilogram)
  /// ```
  SpecificEnergy operator -(SpecificEnergy other) {
    final otherValueInThisUnit = other.getValue(unit);
    return SpecificEnergy(value - otherValueInThisUnit, unit);
  }

  /// Multiplies this specific energy by a scalar value (a dimensionless number).
  ///
  /// Returns a new [SpecificEnergy] instance with the scaled value, in the original unit of this specific energy.
  ///
  /// Example:
  /// ```dart
  /// final se = SpecificEnergy(5.0, SpecificEnergyUnit.megajoulePerKilogram);
  /// final scaled = se * 2.0; // Result: SpecificEnergy(10.0, SpecificEnergyUnit.megajoulePerKilogram)
  /// ```
  SpecificEnergy operator *(double scalar) {
    return SpecificEnergy(value * scalar, unit);
  }

  /// Divides this specific energy by a scalar value (a dimensionless number).
  ///
  /// Returns a new [SpecificEnergy] instance with the scaled value, in the original unit of this specific energy.
  /// Throws [ArgumentError] if the [scalar] is zero.
  ///
  /// Example:
  /// ```dart
  /// final se = SpecificEnergy(10.0, SpecificEnergyUnit.megajoulePerKilogram);
  /// final scaled = se / 2.0; // Result: SpecificEnergy(5.0, SpecificEnergyUnit.megajoulePerKilogram)
  /// ```
  SpecificEnergy operator /(double scalar) {
    if (scalar == 0) {
      throw ArgumentError('Cannot divide by zero.');
    }
    return SpecificEnergy(value / scalar, unit);
  }

  // --- Dimensional Analysis ---

  /// Calculates the [Energy] contained in a given [Mass] of this substance.
  ///
  /// This method performs the dimensional calculation `Energy = SpecificEnergy × Mass`.
  /// The calculation is performed in the base units (J/kg and kg) to ensure
  /// correctness, and the result is returned as an `Energy` in Joules.
  Energy energyIn(Mass mass) {
    final specificEnergyInJPerKg = getValue(SpecificEnergyUnit.joulePerKilogram);
    final massInKg = mass.inKilograms;
    final totalEnergyInJoules = specificEnergyInJPerKg * massInKg;
    return Energy(totalEnergyInJoules, EnergyUnit.joule);
  }
}
