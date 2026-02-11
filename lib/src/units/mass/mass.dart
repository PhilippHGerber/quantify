// BEGIN FILE: lib/src/units/mass/mass.dart
import 'package:meta/meta.dart';

import '../../core/quantity.dart';
import 'mass_unit.dart';

/// Represents a quantity of mass.
///
/// Mass is a fundamental physical property of matter. It is a measure of an
/// object's resistance to acceleration (a change in its state of motion)
/// when a net force is applied. It also determines the strength of its
/// mutual gravitational attraction to other bodies. The SI base unit of mass
/// is the Kilogram (kg).
///
/// This class provides a type-safe way to handle mass values and conversions
/// between different units of mass (e.g., kilograms, grams, pounds, ounces).
@immutable
class Mass extends Quantity<MassUnit> {
  /// Creates a new `Mass` quantity with the given numerical [value] and [unit].
  ///
  /// Example:
  /// ```dart
  /// final personWeightKg = Mass(70.0, MassUnit.kilogram);
  /// final sugarAmountGrams = Mass(500.0, MassUnit.gram);
  /// final packageWeightLbs = Mass(5.0, MassUnit.pound);
  /// ```
  const Mass(super._value, super._unit);

  /// Converts this mass's value to the specified [targetUnit].
  ///
  /// This method uses pre-calculated direct conversion factors from the `MassUnit`
  /// enum for efficiency, typically involving a single multiplication.
  ///
  /// Example:
  /// ```dart
  /// final weightInKg = Mass(1.0, MassUnit.kilogram);
  /// final weightInGramsValue = weightInKg.getValue(MassUnit.gram); // 1000.0
  ///
  /// final weightInLbs = Mass(2.20462, MassUnit.pound);
  /// final weightInKgValue = weightInLbs.getValue(MassUnit.kilogram); // approx 1.0
  /// ```
  @override
  double getValue(MassUnit targetUnit) {
    // If the target unit is the same as the current unit, no conversion is needed.
    if (targetUnit == unit) return value;
    // Otherwise, multiply by the direct conversion factor.
    return value * unit.factorTo(targetUnit);
  }

  /// Creates a new [Mass] instance with the value converted to the [targetUnit].
  ///
  /// This is useful for obtaining a new `Mass` object in a different unit
  /// while preserving type safety and the immutability of `Quantity` objects.
  ///
  /// Example:
  /// ```dart
  /// final weightInGrams = Mass(1500.0, MassUnit.gram);
  /// final weightInKilogramsObj = weightInGrams.convertTo(MassUnit.kilogram);
  /// // weightInKilogramsObj is Mass(1.5, MassUnit.kilogram)
  /// print(weightInKilogramsObj); // Output: "1.5 kg" (depending on toString formatting)
  /// ```
  @override
  Mass convertTo(MassUnit targetUnit) {
    // If the target unit is the same, return this instance (immutable optimization).
    if (targetUnit == unit) return this;
    final newValue = getValue(targetUnit);
    return Mass(newValue, targetUnit);
  }

  /// Compares this [Mass] object to another [Quantity<MassUnit>].
  ///
  /// Comparison is based on the physical magnitude of the masses.
  /// For an accurate comparison, this mass's value is converted to the unit
  /// of the [other] mass before their numerical values are compared.
  ///
  /// Returns:
  /// - A negative integer if this mass is less than [other].
  /// - Zero if this mass is equal in magnitude to [other].
  /// - A positive integer if this mass is greater than [other].
  ///
  /// Example:
  /// ```dart
  /// final m1 = Mass(1.0, MassUnit.kilogram);    // 1000 g
  /// final m2 = Mass(1000.0, MassUnit.gram);    // 1000 g
  /// final m3 = Mass(2.0, MassUnit.pound);     // approx 907.18 g
  ///
  /// print(m1.compareTo(m2)); // 0 (equal magnitude)
  /// print(m1.compareTo(m3)); // 1 (m1 > m3, since 1kg > 2lb)
  /// print(m3.compareTo(m1)); // -1 (m3 < m1)
  /// ```
  @override
  int compareTo(Quantity<MassUnit> other) {
    // Convert this quantity's value to the unit of the 'other' quantity
    // for a direct numerical comparison of their magnitudes.
    final thisValueInOtherUnit = getValue(other.unit);
    return thisValueInOtherUnit.compareTo(other.value);
  }

  // --- Arithmetic Operators ---

  /// Adds this mass to another mass.
  ///
  /// The [other] mass is converted to the unit of this mass before addition.
  /// The result is a new [Mass] instance with the sum, expressed in the unit of this mass.
  ///
  /// Example:
  /// ```dart
  /// final item1 = Mass(1.5, MassUnit.kilogram);
  /// final item2 = Mass(500.0, MassUnit.gram); // 0.5 kg
  /// final totalMass = item1 + item2; // Result: Mass(2.0, MassUnit.kilogram)
  /// ```
  Mass operator +(Mass other) {
    final otherValueInThisUnit = other.getValue(unit);
    return Mass(value + otherValueInThisUnit, unit);
  }

  /// Subtracts another mass from this mass.
  ///
  /// The [other] mass is converted to the unit of this mass before subtraction.
  /// The result is a new [Mass] instance with the difference, expressed in the unit of this mass.
  ///
  /// Example:
  /// ```dart
  /// final containerWithContents = Mass(5.0, MassUnit.kilogram);
  /// final contents = Mass(1500.0, MassUnit.gram); // 1.5 kg
  /// final emptyContainer = containerWithContents - contents; // Result: Mass(3.5, MassUnit.kilogram)
  /// ```
  Mass operator -(Mass other) {
    final otherValueInThisUnit = other.getValue(unit);
    return Mass(value - otherValueInThisUnit, unit);
  }

  /// Multiplies this mass by a scalar value (a dimensionless number).
  ///
  /// Returns a new [Mass] instance with the scaled value, in the original unit of this mass.
  ///
  /// Example:
  /// ```dart
  /// final singleItemMass = Mass(0.25, MassUnit.kilogram);
  /// final massOfFourItems = singleItemMass * 4.0; // Result: Mass(1.0, MassUnit.kilogram)
  /// ```
  Mass operator *(double scalar) {
    return Mass(value * scalar, unit);
  }

  /// Divides this mass by a scalar value (a dimensionless number).
  ///
  /// Returns a new [Mass] instance with the scaled value, in the original unit of this mass.
  /// Throws [ArgumentError] if the [scalar] is zero.
  ///
  /// Example:
  /// ```dart
  /// final totalMass = Mass(10.0, MassUnit.kilogram);
  /// final massPerPortion = totalMass / 5.0; // Result: Mass(2.0, MassUnit.kilogram)
  /// ```
  Mass operator /(double scalar) {
    if (scalar == 0) {
      throw ArgumentError('Cannot divide by zero.');
    }
    return Mass(value / scalar, unit);
  }

  // Potential future enhancement:
  // Mass / Volume = Density (would require a Density quantity type)
  // Mass * Acceleration = Force (would require Force and Acceleration types)
}
