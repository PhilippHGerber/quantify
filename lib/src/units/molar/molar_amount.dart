import 'package:meta/meta.dart';

import '../../core/quantity.dart';
import 'molar_unit.dart';

/// Represents a quantity of amount of substance, typically measured in moles.
///
/// The amount of substance is a measure of the number of elementary entities
/// (such as atoms, molecules, ions, or electrons) in a sample. The SI base unit
/// for amount of substance is the Mole (mol).
///
/// This class provides a type-safe way to handle molar amount values and
/// conversions between different units (e.g., moles, millimoles, kilomoles).
/// It is fundamental in chemistry and related fields.
@immutable
class MolarAmount extends Quantity<MolarUnit> {
  /// Creates a new `MolarAmount` quantity with the given numerical [value] and [unit].
  ///
  /// Example:
  /// ```dart
  /// final glucoseSample = MolarAmount(0.5, MolarUnit.mole);
  /// final reagentAmount = MolarAmount(25.0, MolarUnit.millimole);
  /// ```
  const MolarAmount(super._value, super._unit);

  /// Converts this molar amount's value to the specified [targetUnit].
  ///
  /// This method uses pre-calculated direct conversion factors from the `MolarUnit`
  /// enum for efficiency, involving a single multiplication.
  ///
  /// Example:
  /// ```dart
  /// final substanceInMoles = MolarAmount(0.05, MolarUnit.mole);
  /// final valueInMillimoles = substanceInMoles.getValue(MolarUnit.millimole); // 50.0
  /// ```
  @override
  double getValue(MolarUnit targetUnit) {
    // If the target unit is the same as the current unit, no conversion is needed.
    if (targetUnit == unit) return value;
    // Otherwise, multiply by the direct conversion factor.
    return value * unit.factorTo(targetUnit);
  }

  /// Creates a new [MolarAmount] instance with the value converted to the [targetUnit].
  ///
  /// This is useful for obtaining a new `MolarAmount` object in a different unit
  /// while preserving type safety and the immutability of `Quantity` objects.
  ///
  /// Example:
  /// ```dart
  /// final amountInMillimoles = MolarAmount(1500.0, MolarUnit.millimole);
  /// final amountInMolesObj = amountInMillimoles.convertTo(MolarUnit.mole);
  /// // amountInMolesObj is MolarAmount(1.5, MolarUnit.mole)
  /// print(amountInMolesObj); // Output: "1.5 mol" (depending on toString formatting)
  /// ```
  @override
  MolarAmount convertTo(MolarUnit targetUnit) {
    // If the target unit is the same, return this instance (immutable optimization).
    if (targetUnit == unit) return this;
    final newValue = getValue(targetUnit);
    return MolarAmount(newValue, targetUnit);
  }

  /// Compares this [MolarAmount] object to another [Quantity<MolarUnit>].
  ///
  /// Comparison is based on the physical magnitude of the amounts of substance.
  /// For an accurate comparison, this molar amount's value is converted to the unit
  /// of the [other] molar amount before their numerical values are compared.
  ///
  /// Returns:
  /// - A negative integer if this molar amount is less than [other].
  /// - Zero if this molar amount is equal in magnitude to [other].
  /// - A positive integer if this molar amount is greater than [other].
  ///
  /// Example:
  /// ```dart
  /// final ma1 = MolarAmount(1.0, MolarUnit.mole);      // 1000 mmol
  /// final ma2 = MolarAmount(1000.0, MolarUnit.millimole); // 1000 mmol
  /// final ma3 = MolarAmount(0.5, MolarUnit.mole);     // 500 mmol
  ///
  /// print(ma1.compareTo(ma2)); // 0 (equal magnitude)
  /// print(ma1.compareTo(ma3)); // 1 (ma1 > ma3)
  /// print(ma3.compareTo(ma1)); // -1 (ma3 < ma1)
  /// ```
  @override
  int compareTo(Quantity<MolarUnit> other) {
    // Convert this quantity's value to the unit of the 'other' quantity
    // for a direct numerical comparison of their magnitudes.
    final thisValueInOtherUnit = getValue(other.unit);
    return thisValueInOtherUnit.compareTo(other.value);
  }

  // --- Arithmetic Operators ---

  /// Adds this molar amount to another molar amount.
  ///
  /// The [other] molar amount is converted to the unit of this molar amount before addition.
  /// The result is a new [MolarAmount] instance with the sum, expressed in the unit of this molar amount.
  ///
  /// Example:
  /// ```dart
  /// final reagentA = MolarAmount(0.2, MolarUnit.mole);
  /// final reagentB = MolarAmount(150.0, MolarUnit.millimole); // 0.15 mol
  /// final totalAmount = reagentA + reagentB; // Result: MolarAmount(0.35, MolarUnit.mole)
  /// ```
  MolarAmount operator +(MolarAmount other) {
    final otherValueInThisUnit = other.getValue(unit);
    return MolarAmount(value + otherValueInThisUnit, unit);
  }

  /// Subtracts another molar amount from this molar amount.
  ///
  /// The [other] molar amount is converted to the unit of this molar amount before subtraction.
  /// The result is a new [MolarAmount] instance with the difference, expressed in the unit of this molar amount.
  ///
  /// Example:
  /// ```dart
  /// final initialAmount = MolarAmount(1.0, MolarUnit.mole);
  /// final amountUsed = MolarAmount(250.0, MolarUnit.millimole); // 0.25 mol
  /// final remainingAmount = initialAmount - amountUsed; // Result: MolarAmount(0.75, MolarUnit.mole)
  /// ```
  MolarAmount operator -(MolarAmount other) {
    final otherValueInThisUnit = other.getValue(unit);
    return MolarAmount(value - otherValueInThisUnit, unit);
  }

  /// Multiplies this molar amount by a scalar value (a dimensionless number).
  ///
  /// Returns a new [MolarAmount] instance with the scaled value, in the original unit of this molar amount.
  ///
  /// Example:
  /// ```dart
  /// final singleReactionAmount = MolarAmount(0.05, MolarUnit.mole);
  /// final amountForTenReactions = singleReactionAmount * 10.0; // Result: MolarAmount(0.5, MolarUnit.mole)
  /// ```
  MolarAmount operator *(double scalar) {
    return MolarAmount(value * scalar, unit);
  }

  /// Divides this molar amount by a scalar value (a dimensionless number).
  ///
  /// Returns a new [MolarAmount] instance with the scaled value, in the original unit of this molar amount.
  /// Throws [ArgumentError] if the [scalar] is zero.
  ///
  /// Example:
  /// ```dart
  /// final totalStock = MolarAmount(2.0, MolarUnit.mole);
  /// final amountPerAliquot = totalStock / 20.0; // Result: MolarAmount(0.1, MolarUnit.mole)
  /// ```
  MolarAmount operator /(double scalar) {
    if (scalar == 0) {
      throw ArgumentError('Cannot divide by zero.');
    }
    return MolarAmount(value / scalar, unit);
  }

  // Potential future enhancements for MolarAmount:
  // - MolarAmount / Volume = MolarConcentration (would require Volume and MolarConcentration types)
  // - Mass / MolarAmount = MolarMass (would require Mass and MolarMass types or a way to handle compound units)
}
