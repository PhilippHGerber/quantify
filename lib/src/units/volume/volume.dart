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
  @override
  double getValue(VolumeUnit targetUnit) {
    if (targetUnit == unit) return value;
    return value * unit.factorTo(targetUnit);
  }

  /// Creates a new [Volume] instance with the value converted to the [targetUnit].
  @override
  Volume convertTo(VolumeUnit targetUnit) {
    if (targetUnit == unit) return this;
    final newValue = getValue(targetUnit);
    return Volume(newValue, targetUnit);
  }

  /// Compares this [Volume] object to another [Quantity<VolumeUnit>].
  @override
  int compareTo(Quantity<VolumeUnit> other) {
    final thisValueInOtherUnit = getValue(other.unit);
    return thisValueInOtherUnit.compareTo(other.value);
  }

  // --- Arithmetic Operators ---

  /// Adds this volume to another volume.
  Volume operator +(Volume other) {
    final otherValueInThisUnit = other.getValue(unit);
    return Volume(value + otherValueInThisUnit, unit);
  }

  /// Subtracts another volume from this volume.
  Volume operator -(Volume other) {
    final otherValueInThisUnit = other.getValue(unit);
    return Volume(value - otherValueInThisUnit, unit);
  }

  /// Multiplies this volume by a scalar value.
  Volume operator *(double scalar) {
    return Volume(value * scalar, unit);
  }

  /// Divides this volume by a scalar value.
  Volume operator /(double scalar) {
    if (scalar == 0) {
      throw ArgumentError('Cannot divide by zero.');
    }
    return Volume(value / scalar, unit);
  }
}
