import 'package:meta/meta.dart';

import '../../core/quantity.dart';
import 'length_unit.dart';

/// Represents a quantity of length.
@immutable
class Length extends Quantity<LengthUnit> {
  /// Creates a new Length quantity with the given [value] and [unit].
  const Length(super.value, super.unit);

  /// Converts this length's value to the specified [targetUnit].
  @override
  double getValue(LengthUnit targetUnit) {
    if (targetUnit == unit) return value;
    return value * unit.factorTo(targetUnit);
  }

  /// Creates a new [Length] instance with the value converted to the [targetUnit].
  ///
  /// This is useful for obtaining a new `Length` object in a different unit
  /// without losing the type information.
  ///
  /// Example:
  /// ```dart
  /// final oneFoot = Length(1.0, LengthUnit.foot);
  /// final inInches = oneFoot.convertTo(LengthUnit.inch); // Length(12.0, LengthUnit.inch)
  /// print(inInches.value); // 12.0
  /// ```
  @override
  Quantity<LengthUnit> convertTo(LengthUnit targetUnit) {
    if (targetUnit == unit) return this;
    final newValue = getValue(targetUnit);
    return Length(newValue, targetUnit);
  }

  /// Compares this [Length] object to another [Quantity<LengthUnit>].
  ///
  /// Comparison is based on the physical magnitude of the lengths.
  /// For comparison, this length is converted to the unit of the [other] length.
  ///
  /// Returns:
  /// - A negative integer if this length is less than [other].
  /// - Zero if this length is equal to [other].
  /// - A positive integer if this length is greater than [other].
  @override
  int compareTo(Quantity<LengthUnit> other) {
    // Convert this quantity's value to the unit of the 'other' quantity
    // for a direct numerical comparison.
    final thisValueInOtherUnit = getValue(other.unit);
    return thisValueInOtherUnit.compareTo(other.value);
  }
}
