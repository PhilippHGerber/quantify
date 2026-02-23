import 'package:meta/meta.dart';

import '../../core/quantity.dart';
import 'temperature_delta_unit.dart';

/// A temperature change (interval), distinct from an absolute 'Temperature'.
///
/// ## Point vs. Vector (Affine vs. Linear)
///
/// An absolute temperature (e.g. 20 °C) is a *point* in affine space — it
/// names a position on the thermometer. A [TemperatureDelta] (e.g. a rise of
/// 20 °C) is a *vector* — it describes a displacement between two points.
///
/// Points and vectors obey different rules:
///
/// - **Point − Point = Vector:** `Temperature - Temperature` → `TemperatureDelta`
/// - **Point + Vector = Point:** `Temperature + TemperatureDelta` → `Temperature`
/// - **Vector + Vector = Vector:** `TemperatureDelta + TemperatureDelta` → `TemperatureDelta`
/// - **Scalar × Vector = Vector:** `TemperatureDelta * num` → `TemperatureDelta`
/// - **Point + Point** is *undefined* (adding two absolute temperatures is nonsensical).
///
/// ## Conversions
///
/// Unlike absolute temperatures, deltas convert by a *pure multiplicative
/// factor* — no offsets are involved. A 1-degree Celsius change equals a
/// 1-Kelvin change, and a 1-degree Fahrenheit change equals 5/9 of a Kelvin
/// change.
///
/// ## Example
///
/// ```dart
/// final t1 = 10.celsius;
/// final t2 = 30.celsius;
/// final rise = t2 - t1;         // TemperatureDelta(20.0, celsiusDelta)
/// final t3 = t1 + rise;         // Temperature(30.0, celsius)
/// final doubled = rise * 2.0;   // TemperatureDelta(40.0, celsiusDelta)
/// print(rise.inKelvinDelta);    // 20.0
/// print(rise.inFahrenheitDelta); // 36.0
/// ```
@immutable
class TemperatureDelta extends Quantity<TemperatureDeltaUnit> {
  /// Creates a [TemperatureDelta] with the given [value] and [unit].
  ///
  /// Example:
  /// ```dart
  /// final rise = TemperatureDelta(20.0, TemperatureDeltaUnit.celsiusDelta);
  /// final drop = TemperatureDelta(-5.0, TemperatureDeltaUnit.kelvinDelta);
  /// ```
  const TemperatureDelta(super._value, super._unit);

  /// Returns this delta's value converted to [targetUnit].
  @override
  double getValue(TemperatureDeltaUnit targetUnit) {
    if (targetUnit == unit) return value;
    return value * unit.factorTo(targetUnit);
  }

  /// Returns a new [TemperatureDelta] with the value converted to [targetUnit].
  @override
  TemperatureDelta convertTo(TemperatureDeltaUnit targetUnit) {
    if (targetUnit == unit) return this;
    return TemperatureDelta(getValue(targetUnit), targetUnit);
  }

  @override
  int compareTo(Quantity<TemperatureDeltaUnit> other) {
    final thisValueInOtherUnit = getValue(other.unit);
    return thisValueInOtherUnit.compareTo(other.value);
  }

  // --- Arithmetic ---

  /// Adds two temperature deltas. The result is in the unit of `this`.
  TemperatureDelta operator +(TemperatureDelta other) {
    return TemperatureDelta(value + other.getValue(unit), unit);
  }

  /// Subtracts a temperature delta from this delta. The result is in the
  /// unit of `this`.
  TemperatureDelta operator -(TemperatureDelta other) {
    return TemperatureDelta(value - other.getValue(unit), unit);
  }

  /// Scales this temperature delta by a dimensionless [scalar].
  TemperatureDelta operator *(double scalar) {
    return TemperatureDelta(value * scalar, unit);
  }

  /// Divides this temperature delta by a dimensionless [scalar].
  ///
  /// Throws [ArgumentError] if [scalar] is zero.
  TemperatureDelta operator /(double scalar) {
    if (scalar == 0) throw ArgumentError('Cannot divide by zero.');
    return TemperatureDelta(value / scalar, unit);
  }
}
