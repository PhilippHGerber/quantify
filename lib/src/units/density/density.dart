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
  const Density(super.value, super.unit);

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
  @override
  double getValue(DensityUnit targetUnit) {
    if (targetUnit == unit) return value;
    return value * unit.factorTo(targetUnit);
  }

  /// Creates a new [Density] instance with the value converted to the [targetUnit].
  @override
  Density convertTo(DensityUnit targetUnit) {
    if (targetUnit == unit) return this;
    final newValue = getValue(targetUnit);
    return Density(newValue, targetUnit);
  }

  @override
  int compareTo(Quantity<DensityUnit> other) {
    final thisValueInOtherUnit = getValue(other.unit);
    return thisValueInOtherUnit.compareTo(other.value);
  }

  // --- Arithmetic Operators ---

  /// Adds this density to another.
  Density operator +(Density other) {
    final otherValueInThisUnit = other.getValue(unit);
    return Density(value + otherValueInThisUnit, unit);
  }

  /// Subtracts another density from this one.
  Density operator -(Density other) {
    final otherValueInThisUnit = other.getValue(unit);
    return Density(value - otherValueInThisUnit, unit);
  }

  /// Multiplies this density by a scalar.
  Density operator *(double scalar) {
    return Density(value * scalar, unit);
  }

  /// Divides this density by a scalar.
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
