import 'package:meta/meta.dart';

import '../../core/quantity.dart';
import '../mass/mass.dart';
import '../mass/mass_extensions.dart';
import '../mass/mass_unit.dart';
import '../volume/volume.dart';
import '../volume/volume_extensions.dart';
import 'density_unit.dart';

/// Represents a quantity of density.
///
/// Density is a physical quantity representing the mass per unit volume of a substance.
/// The SI derived unit is Kilogram per Cubic Meter (kg/m³).
@immutable
class Density extends Quantity<DensityUnit> {
  /// Creates a new `Density` with a given [value] and [unit].
  const Density(super._value, super._unit);

  /// Creates a `Density` instance from a given [Mass] and [Volume].
  ///
  /// This factory performs the dimensional calculation `Density = Mass / Volume`.
  /// It converts the inputs to their base SI units (kg and m³) for correctness.
  /// Throws an [ArgumentError] if the volume is zero.
  ///
  /// Example:
  /// ```dart
  /// final mass = 1000.kg;
  /// final volume = 1.m3;
  /// final density = Density.from(mass, volume);
  /// print(density.inKilogramsPerCubicMeter); // Output: 1000.0
  /// ```
  factory Density.from(Mass mass, Volume volume) {
    final kilograms = mass.inKilograms;
    final cubicMeters = volume.inCubicMeters;
    if (cubicMeters == 0) {
      throw ArgumentError('Volume cannot be zero when calculating density.');
    }
    return Density(kilograms / cubicMeters, DensityUnit.kilogramPerCubicMeter);
  }

  /// Converts this density's value to the specified [targetUnit].
  ///
  /// This method uses pre-calculated direct conversion factors from the `DensityUnit`
  /// enum for efficiency, typically involving a single multiplication.
  ///
  /// Example:
  /// ```dart
  /// final d = Density(1.0, DensityUnit.kilogramPerCubicMeter);
  /// final inGramsPerCubicMeter = d.getValue(DensityUnit.gramPerCubicMeter); // 1000.0
  ///
  /// final d2 = Density(1000.0, DensityUnit.gramPerCubicMeter);
  /// final inKgPerM3 = d2.getValue(DensityUnit.kilogramPerCubicMeter); // 1.0
  /// ```
  @override
  double getValue(DensityUnit targetUnit) {
    // If the target unit is the same as the current unit, no conversion is needed.
    if (targetUnit == unit) return value;
    // Otherwise, multiply by the direct conversion factor.
    return value * unit.factorTo(targetUnit);
  }

  /// Creates a new [Density] instance with the value converted to the [targetUnit].
  ///
  /// This is useful for obtaining a new `Density` object in a different unit
  /// while preserving type safety and the immutability of `Quantity` objects.
  ///
  /// Example:
  /// ```dart
  /// final d = Density(1000.0, DensityUnit.gramPerCubicMeter);
  /// final inKgPerM3 = d.convertTo(DensityUnit.kilogramPerCubicMeter);
  /// // inKgPerM3 is Density(1.0, DensityUnit.kilogramPerCubicMeter)
  /// print(inKgPerM3); // Output: "1.0 kg/m³" (depending on toString formatting)
  /// ```
  @override
  Density convertTo(DensityUnit targetUnit) {
    // If the target unit is the same, return this instance (immutable optimization).
    if (targetUnit == unit) return this;
    final newValue = getValue(targetUnit);
    return Density(newValue, targetUnit);
  }

  /// Compares this [Density] object to another [Quantity<DensityUnit>].
  ///
  /// Comparison is based on the physical magnitude of the densities.
  /// For an accurate comparison, this density's value is converted to the unit
  /// of the [other] density before their numerical values are compared.
  ///
  /// Returns:
  /// - A negative integer if this density is less than [other].
  /// - Zero if this density is equal in magnitude to [other].
  /// - A positive integer if this density is greater than [other].
  ///
  /// Example:
  /// ```dart
  /// final d1 = Density(1.0, DensityUnit.kilogramPerCubicMeter);  // 1 kg/m³
  /// final d2 = Density(1000.0, DensityUnit.gramPerCubicMeter);   // 1 kg/m³
  /// final d3 = Density(0.5, DensityUnit.kilogramPerCubicMeter);
  ///
  /// print(d1.compareTo(d2)); // 0 (equal magnitude)
  /// print(d1.compareTo(d3)); // 1 (d1 > d3)
  /// print(d3.compareTo(d1)); // -1 (d3 < d1)
  /// ```
  @override
  int compareTo(Quantity<DensityUnit> other) {
    final thisValueInOtherUnit = getValue(other.unit);
    return thisValueInOtherUnit.compareTo(other.value);
  }

  // --- Arithmetic Operators ---

  /// Adds this density to another.
  ///
  /// The [other] density is converted to the unit of this density before addition.
  /// The result is a new [Density] instance with the sum, expressed in the unit of this density.
  ///
  /// Example:
  /// ```dart
  /// final d1 = Density(999.0, DensityUnit.kilogramPerCubicMeter);
  /// final d2 = Density(1000.0, DensityUnit.gramPerCubicMeter); // 1 kg/m³
  /// final total = d1 + d2; // Result: Density(1000.0, DensityUnit.kilogramPerCubicMeter)
  /// ```
  Density operator +(Density other) {
    final otherValueInThisUnit = other.getValue(unit);
    return Density(value + otherValueInThisUnit, unit);
  }

  /// Subtracts another density from this density.
  ///
  /// The [other] density is converted to the unit of this density before subtraction.
  /// The result is a new [Density] instance with the difference, expressed in the unit of this density.
  ///
  /// Example:
  /// ```dart
  /// final d1 = Density(1000.0, DensityUnit.kilogramPerCubicMeter);
  /// final d2 = Density(1000.0, DensityUnit.gramPerCubicMeter); // 1 kg/m³
  /// final diff = d1 - d2; // Result: Density(999.0, DensityUnit.kilogramPerCubicMeter)
  /// ```
  Density operator -(Density other) {
    final otherValueInThisUnit = other.getValue(unit);
    return Density(value - otherValueInThisUnit, unit);
  }

  /// Multiplies this density by a scalar value (a dimensionless number).
  ///
  /// Returns a new [Density] instance with the scaled value, in the original unit of this density.
  ///
  /// Example:
  /// ```dart
  /// final d = Density(500.0, DensityUnit.kilogramPerCubicMeter);
  /// final scaled = d * 2.0; // Result: Density(1000.0, DensityUnit.kilogramPerCubicMeter)
  /// ```
  Density operator *(double scalar) {
    return Density(value * scalar, unit);
  }

  /// Divides this density by a scalar value (a dimensionless number).
  ///
  /// Returns a new [Density] instance with the scaled value, in the original unit of this density.
  /// Throws [ArgumentError] if the [scalar] is zero.
  ///
  /// Example:
  /// ```dart
  /// final d = Density(1000.0, DensityUnit.kilogramPerCubicMeter);
  /// final scaled = d / 2.0; // Result: Density(500.0, DensityUnit.kilogramPerCubicMeter)
  /// ```
  Density operator /(double scalar) {
    if (scalar == 0) {
      throw ArgumentError('Cannot divide by zero.');
    }
    return Density(value / scalar, unit);
  }

  // --- Dimensional Analysis ---

  /// Calculates the [Mass] of a given [Volume] of this substance.
  ///
  /// This method performs the dimensional calculation `Mass = Density × Volume`.
  /// The calculation is performed in the base units (kg/m³ and m³) to ensure
  /// correctness, and the result is returned as a `Mass` in kilograms.
  ///
  /// Example:
  /// ```dart
  /// final waterDensity = 1000.kgPerM3;
  /// final volume = 2.m3;
  /// final mass = waterDensity.massOf(volume);
  /// print(mass.inKilograms); // Output: 2000.0
  /// ```
  Mass massOf(Volume volume) {
    final densityInKgPerM3 = getValue(DensityUnit.kilogramPerCubicMeter);
    final volumeInM3 = volume.inCubicMeters;
    final massInKg = densityInKgPerM3 * volumeInM3;
    return Mass(massInKg, MassUnit.kilogram);
  }
}
