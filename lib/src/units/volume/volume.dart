import 'package:meta/meta.dart';

import '../../core/quantity.dart';
import 'volume_unit.dart';

/// Represents a quantity of volume.
///
/// Volume is a derived quantity representing the amount of three-dimensional
/// space occupied by a substance. The SI derived unit is the Cubic Meter (m³).
@immutable
class Volume extends Quantity<VolumeUnit> {
  /// Creates a new `Volume` quantity with the given numerical [value] and [unit].
  const Volume(super._value, super._unit);

  /// Converts this volume's value to the specified [targetUnit].
  ///
  /// This method uses pre-calculated direct conversion factors from the `VolumeUnit`
  /// enum for efficiency, typically involving a single multiplication.
  ///
  /// Example:
  /// ```dart
  /// final v = Volume(1.0, VolumeUnit.liter);
  /// final inCubicCentimeters = v.getValue(VolumeUnit.cubicCentimeter); // 1000.0
  ///
  /// final v2 = Volume(1000.0, VolumeUnit.cubicCentimeter);
  /// final inLiters = v2.getValue(VolumeUnit.liter); // 1.0
  /// ```
  @override
  double getValue(VolumeUnit targetUnit) {
    // If the target unit is the same as the current unit, no conversion is needed.
    if (targetUnit == unit) return value;
    // Otherwise, multiply by the direct conversion factor.
    return value * unit.factorTo(targetUnit);
  }

  /// Creates a new [Volume] instance with the value converted to the [targetUnit].
  ///
  /// This is useful for obtaining a new `Volume` object in a different unit
  /// while preserving type safety and the immutability of `Quantity` objects.
  ///
  /// Example:
  /// ```dart
  /// final v = Volume(1000.0, VolumeUnit.cubicCentimeter);
  /// final inLiters = v.convertTo(VolumeUnit.liter);
  /// // inLiters is Volume(1.0, VolumeUnit.liter)
  /// print(inLiters); // Output: "1.0 L" (depending on toString formatting)
  /// ```
  @override
  Volume convertTo(VolumeUnit targetUnit) {
    // If the target unit is the same, return this instance (immutable optimization).
    if (targetUnit == unit) return this;
    final newValue = getValue(targetUnit);
    return Volume(newValue, targetUnit);
  }

  /// Compares this [Volume] object to another [Quantity<VolumeUnit>].
  ///
  /// Comparison is based on the physical magnitude of the volumes.
  /// For an accurate comparison, this volume's value is converted to the unit
  /// of the [other] volume before their numerical values are compared.
  ///
  /// Returns:
  /// - A negative integer if this volume is less than [other].
  /// - Zero if this volume is equal in magnitude to [other].
  /// - A positive integer if this volume is greater than [other].
  ///
  /// Example:
  /// ```dart
  /// final v1 = Volume(1.0, VolumeUnit.liter);               // 1000 cm³
  /// final v2 = Volume(1000.0, VolumeUnit.cubicCentimeter);  // 1000 cm³
  /// final v3 = Volume(0.5, VolumeUnit.liter);
  ///
  /// print(v1.compareTo(v2)); // 0 (equal magnitude)
  /// print(v1.compareTo(v3)); // 1 (v1 > v3)
  /// print(v3.compareTo(v1)); // -1 (v3 < v1)
  /// ```
  @override
  int compareTo(Quantity<VolumeUnit> other) {
    final thisValueInOtherUnit = getValue(other.unit);
    return thisValueInOtherUnit.compareTo(other.value);
  }

  // --- Arithmetic Operators ---

  /// Adds this volume to another volume.
  ///
  /// The [other] volume is converted to the unit of this volume before addition.
  /// The result is a new [Volume] instance with the sum, expressed in the unit of this volume.
  ///
  /// Example:
  /// ```dart
  /// final v1 = Volume(1.5, VolumeUnit.liter);
  /// final v2 = Volume(500.0, VolumeUnit.cubicCentimeter); // 0.5 L
  /// final total = v1 + v2; // Result: Volume(2.0, VolumeUnit.liter)
  /// ```
  Volume operator +(Volume other) {
    final otherValueInThisUnit = other.getValue(unit);
    return Volume(value + otherValueInThisUnit, unit);
  }

  /// Subtracts another volume from this volume.
  ///
  /// The [other] volume is converted to the unit of this volume before subtraction.
  /// The result is a new [Volume] instance with the difference, expressed in the unit of this volume.
  ///
  /// Example:
  /// ```dart
  /// final v1 = Volume(2.0, VolumeUnit.liter);
  /// final v2 = Volume(500.0, VolumeUnit.cubicCentimeter); // 0.5 L
  /// final diff = v1 - v2; // Result: Volume(1.5, VolumeUnit.liter)
  /// ```
  Volume operator -(Volume other) {
    final otherValueInThisUnit = other.getValue(unit);
    return Volume(value - otherValueInThisUnit, unit);
  }

  /// Multiplies this volume by a scalar value (a dimensionless number).
  ///
  /// Returns a new [Volume] instance with the scaled value, in the original unit of this volume.
  ///
  /// Example:
  /// ```dart
  /// final v = Volume(0.5, VolumeUnit.liter);
  /// final scaled = v * 3.0; // Result: Volume(1.5, VolumeUnit.liter)
  /// ```
  Volume operator *(double scalar) {
    return Volume(value * scalar, unit);
  }

  /// Divides this volume by a scalar value (a dimensionless number).
  ///
  /// Returns a new [Volume] instance with the scaled value, in the original unit of this volume.
  /// Throws [ArgumentError] if the [scalar] is zero.
  ///
  /// Example:
  /// ```dart
  /// final v = Volume(1.5, VolumeUnit.liter);
  /// final scaled = v / 3.0; // Result: Volume(0.5, VolumeUnit.liter)
  /// ```
  Volume operator /(double scalar) {
    if (scalar == 0) {
      throw ArgumentError('Cannot divide by zero.');
    }
    return Volume(value / scalar, unit);
  }
}
