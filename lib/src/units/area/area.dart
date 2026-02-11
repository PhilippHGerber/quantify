import 'package:meta/meta.dart';

import '../../core/quantity.dart';
import 'area_unit.dart';

/// Represents a quantity of area.
///
/// Area is a derived quantity representing the extent of a two-dimensional
/// surface or shape. The SI derived unit is the Square Meter (m²).
@immutable
class Area extends Quantity<AreaUnit> {
  /// Creates a new `Area` quantity with the given numerical [value] and [unit].
  ///
  /// Example:
  /// ```dart
  /// final roomArea = Area(20.0, AreaUnit.squareMeter);
  /// final landArea = Area(2.5, AreaUnit.hectare);
  /// ```
  const Area(super._value, super._unit);

  /// Converts this area's value to the specified [targetUnit].
  ///
  /// This method uses pre-calculated direct conversion factors from the `AreaUnit`
  /// enum for efficiency, typically involving a single multiplication.
  ///
  /// Example:
  /// ```dart
  /// final areaInM2 = Area(1.0, AreaUnit.squareMeter);
  /// final valueInCm2 = areaInM2.getValue(AreaUnit.squareCentimeter); // 10000.0
  /// ```
  @override
  double getValue(AreaUnit targetUnit) {
    if (targetUnit == unit) return value;
    return value * unit.factorTo(targetUnit);
  }

  /// Creates a new [Area] instance with the value converted to the [targetUnit].
  ///
  /// This is useful for obtaining a new `Area` object in a different unit
  /// while preserving type safety and the immutability of `Quantity` objects.
  ///
  /// Example:
  /// ```dart
  /// final areaInCm2 = Area(50000.0, AreaUnit.squareCentimeter);
  /// final areaInM2Obj = areaInCm2.convertTo(AreaUnit.squareMeter);
  /// // areaInM2Obj is Area(5.0, AreaUnit.squareMeter)
  /// print(areaInM2Obj); // Output: "5.0 m²" (depending on toString formatting)
  /// ```
  @override
  Area convertTo(AreaUnit targetUnit) {
    if (targetUnit == unit) return this;
    final newValue = getValue(targetUnit);
    return Area(newValue, targetUnit);
  }

  /// Compares this [Area] object to another [Quantity<AreaUnit>].
  ///
  /// Comparison is based on the physical magnitude of the areas.
  /// For an accurate comparison, this area's value is converted to the unit
  /// of the [other] area before their numerical values are compared.
  ///
  /// Returns:
  /// - A negative integer if this area is less than [other].
  /// - Zero if this area is equal in magnitude to [other].
  /// - A positive integer if this area is greater than [other].
  ///
  /// Example:
  /// ```dart
  /// final a1 = Area(1.0, AreaUnit.squareMeter);      // 10000 cm²
  /// final a2 = Area(10000.0, AreaUnit.squareCentimeter); // 10000 cm²
  /// final a3 = Area(0.5, AreaUnit.squareMeter);     // 5000 cm²
  ///
  /// print(a1.compareTo(a2)); // 0 (equal magnitude)
  /// print(a1.compareTo(a3)); // 1 (a1 > a3)
  /// print(a3.compareTo(a1)); // -1 (a3 < a1)
  /// ```
  @override
  int compareTo(Quantity<AreaUnit> other) {
    final thisValueInOtherUnit = getValue(other.unit);
    return thisValueInOtherUnit.compareTo(other.value);
  }

  // --- Arithmetic Operators ---

  /// Adds this area to another area.
  ///
  /// The [other] area is converted to the unit of this area before addition.
  /// The result is a new [Area] instance with the sum, expressed in the unit of this area.
  ///
  /// Example:
  /// ```dart
  /// final room1 = Area(10.0, AreaUnit.squareMeter);
  /// final room2 = Area(50000.0, AreaUnit.squareCentimeter); // 5 m²
  /// final totalArea = room1 + room2; // Result: Area(15.0, AreaUnit.squareMeter)
  /// ```
  Area operator +(Area other) {
    final otherValueInThisUnit = other.getValue(unit);
    return Area(value + otherValueInThisUnit, unit);
  }

  /// Subtracts another area from this area.
  ///
  /// The [other] area is converted to the unit of this area before subtraction.
  /// The result is a new [Area] instance with the difference, expressed in the unit of this area.
  ///
  /// Example:
  /// ```dart
  /// final totalPlot = Area(1.0, AreaUnit.acre);
  /// final builtArea = Area(500.0, AreaUnit.squareMeter);
  /// final remainingArea = totalPlot - builtArea; // Result: Area(~3546.86, AreaUnit.squareMeter)
  /// ```
  Area operator -(Area other) {
    final otherValueInThisUnit = other.getValue(unit);
    return Area(value - otherValueInThisUnit, unit);
  }

  /// Multiplies this area by a scalar value (a dimensionless number).
  ///
  /// Returns a new [Area] instance with the scaled value, in the original unit of this area.
  ///
  /// Example:
  /// ```dart
  /// final singleTileArea = Area(0.25, AreaUnit.squareMeter);
  /// final areaOf100Tiles = singleTileArea * 100.0; // Result: Area(25.0, AreaUnit.squareMeter)
  /// ```
  Area operator *(double scalar) {
    return Area(value * scalar, unit);
  }

  /// Divides this area by a scalar value (a dimensionless number).
  ///
  /// Returns a new [Area] instance with the scaled value, in the original unit of this area.
  /// Throws [ArgumentError] if the [scalar] is zero.
  ///
  /// Example:
  /// ```dart
  /// final totalFabric = Area(10.0, AreaUnit.squareMeter);
  /// final fabricPerGarment = totalFabric / 5.0; // Result: Area(2.0, AreaUnit.squareMeter)
  /// ```
  Area operator /(double scalar) {
    if (scalar == 0) {
      throw ArgumentError('Cannot divide by zero.');
    }
    return Area(value / scalar, unit);
  }
}
