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
  @override
  double getValue(SpecificEnergyUnit targetUnit) {
    if (targetUnit == unit) return value;
    return value * unit.factorTo(targetUnit);
  }

  /// Creates a new [SpecificEnergy] instance with the value converted to the [targetUnit].
  @override
  SpecificEnergy convertTo(SpecificEnergyUnit targetUnit) {
    if (targetUnit == unit) return this;
    final newValue = getValue(targetUnit);
    return SpecificEnergy(newValue, targetUnit);
  }

  @override
  int compareTo(Quantity<SpecificEnergyUnit> other) {
    final thisValueInOtherUnit = getValue(other.unit);
    return thisValueInOtherUnit.compareTo(other.value);
  }

  // --- Arithmetic Operators ---

  /// Adds this specific energy to another.
  SpecificEnergy operator +(SpecificEnergy other) {
    final otherValueInThisUnit = other.getValue(unit);
    return SpecificEnergy(value + otherValueInThisUnit, unit);
  }

  /// Subtracts another specific energy from this one.
  SpecificEnergy operator -(SpecificEnergy other) {
    final otherValueInThisUnit = other.getValue(unit);
    return SpecificEnergy(value - otherValueInThisUnit, unit);
  }

  /// Multiplies this specific energy by a scalar.
  SpecificEnergy operator *(double scalar) {
    return SpecificEnergy(value * scalar, unit);
  }

  /// Divides this specific energy by a scalar.
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
