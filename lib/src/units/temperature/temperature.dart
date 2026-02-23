// ignore_for_file: prefer_int_literals : all constants are doubles.

import 'package:meta/meta.dart';

import '../../core/quantity.dart';
import 'temperature_delta.dart';
import 'temperature_delta_unit.dart';
import 'temperature_unit.dart';

/// Represents a quantity of temperature.
///
/// Temperature conversions are affine (involve offsets) and are handled by
/// specific formulas within the [getValue] method, rather than simple
/// multiplicative factors.
@immutable
class Temperature extends Quantity<TemperatureUnit> {
  /// Creates a new Temperature quantity with the given [value] and [unit].
  ///
  /// Example:
  /// ```dart
  /// final bodyTemp = Temperature(37.0, TemperatureUnit.celsius);
  /// final absoluteZero = Temperature(0.0, TemperatureUnit.kelvin);
  /// ```
  const Temperature(super._value, super._unit);

  // --- Conversion Constants ---
  // These could also be in a separate TemperatureFactors class if they grew more complex
  // or were needed elsewhere, but for direct formulas they are fine here.

  /// The offset of Kelvin from Celsius (0°C = 273.15K).
  static const double kelvinOffsetFromCelsius = 273.15;

  /// The scaling factor for Fahrenheit to Celsius conversion (9/5).
  static const double fahrenheitScaleFactor = 1.8; // 9.0 / 5.0

  /// The offset for Fahrenheit conversion from Celsius (0°C = 32°F).
  static const double fahrenheitOffset = 32.0;

  /// The offset for Rankine conversion from Fahrenheit (0°F = 459.67°R).
  static const double rankineOffsetFromFahrenheit = 459.67;

  /// Converts this temperature's value to the specified [targetUnit]
  /// using direct, optimized formulas for affine conversions.
  ///
  /// Example:
  /// ```dart
  /// final roomTempC = Temperature(20.0, TemperatureUnit.celsius);
  /// final roomTempF = roomTempC.getValue(TemperatureUnit.fahrenheit); // 68.0
  /// ```
  @override
  double getValue(TemperatureUnit targetUnit) {
    if (targetUnit == unit) return value;

    switch (unit) {
      case TemperatureUnit.celsius:
        switch (targetUnit) {
          case TemperatureUnit.kelvin:
            return value + kelvinOffsetFromCelsius;
          case TemperatureUnit.fahrenheit:
            return (value * fahrenheitScaleFactor) + fahrenheitOffset;
          case TemperatureUnit.rankine:
            // Celsius -> Fahrenheit -> Rankine
            final fahrenheitValue = (value * fahrenheitScaleFactor) + fahrenheitOffset;
            return fahrenheitValue + rankineOffsetFromFahrenheit;
          case TemperatureUnit.celsius:
            return value;
        }
      case TemperatureUnit.kelvin:
        switch (targetUnit) {
          case TemperatureUnit.celsius:
            return value - kelvinOffsetFromCelsius;
          case TemperatureUnit.fahrenheit:
            final celsiusValue = value - kelvinOffsetFromCelsius;
            return (celsiusValue * fahrenheitScaleFactor) + fahrenheitOffset;
          case TemperatureUnit.rankine:
            // Kelvin -> Rankine: multiply by 9/5
            return value * fahrenheitScaleFactor;
          case TemperatureUnit.kelvin:
            return value;
        }
      case TemperatureUnit.fahrenheit:
        switch (targetUnit) {
          case TemperatureUnit.celsius:
            return (value - fahrenheitOffset) / fahrenheitScaleFactor;
          case TemperatureUnit.kelvin:
            final celsiusValue = (value - fahrenheitOffset) / fahrenheitScaleFactor;
            return celsiusValue + kelvinOffsetFromCelsius;
          case TemperatureUnit.rankine:
            return value + rankineOffsetFromFahrenheit;
          case TemperatureUnit.fahrenheit:
            return value;
        }
      case TemperatureUnit.rankine:
        switch (targetUnit) {
          case TemperatureUnit.fahrenheit:
            return value - rankineOffsetFromFahrenheit;
          case TemperatureUnit.celsius:
            // Rankine -> Fahrenheit -> Celsius
            final fahrenheitValue = value - rankineOffsetFromFahrenheit;
            return (fahrenheitValue - fahrenheitOffset) / fahrenheitScaleFactor;
          case TemperatureUnit.kelvin:
            // Rankine -> Kelvin: divide by 9/5
            return value / fahrenheitScaleFactor;
          case TemperatureUnit.rankine:
            return value;
        }
    }
  }

  /// Creates a new [Temperature] instance with the value converted to the [targetUnit].
  ///
  /// Example:
  /// ```dart
  /// final boilingPointC = Temperature(100.0, TemperatureUnit.celsius);
  /// final boilingPointF = boilingPointC.convertTo(TemperatureUnit.fahrenheit);
  /// print(boilingPointF); // Output: "212.0 °F"
  /// ```
  @override
  Temperature convertTo(TemperatureUnit targetUnit) {
    if (targetUnit == unit) return this;
    final newValue = getValue(targetUnit);
    return Temperature(newValue, targetUnit);
  }

  /// Compares this [Temperature] object to another [Quantity<TemperatureUnit>].
  ///
  /// Comparison is based on the physical magnitude of the temperatures.
  /// For comparison, this temperature is converted to the unit of the [other] temperature.
  @override
  int compareTo(Quantity<TemperatureUnit> other) {
    // Convert this quantity's value to the unit of the 'other' quantity
    // for a direct numerical comparison.
    final thisValueInOtherUnit = getValue(other.unit);
    return thisValueInOtherUnit.compareTo(other.value);
  }

  // --- Arithmetic Operators (Specific for Temperature) ---

  /// Subtracts another [Temperature] from this, yielding a [TemperatureDelta].
  ///
  /// The result is expressed in the delta unit corresponding to this
  /// temperature's unit (e.g. celsius → celsiusDelta). The [other] temperature
  /// is converted to this temperature's unit before subtraction.
  ///
  /// Example:
  /// ```dart
  /// final delta = 30.celsius - 10.celsius;
  /// print(delta.inKelvinDelta); // 20.0
  /// print(delta.unit);          // TemperatureDeltaUnit.celsiusDelta
  /// ```
  TemperatureDelta operator -(Temperature other) {
    final otherValueInThisUnit = other.getValue(unit);
    final deltaValue = value - otherValueInThisUnit;
    return TemperatureDelta(deltaValue, _correspondingDeltaUnit(unit));
  }

  /// Adds a [TemperatureDelta] to this temperature, returning a new
  /// [Temperature] in the same unit.
  ///
  /// Models heating (positive delta) or cooling (negative delta).
  ///
  /// Example:
  /// ```dart
  /// final heated = 10.celsius + 20.celsiusDelta;
  /// print(heated.inCelsius); // 30.0
  /// ```
  Temperature operator +(TemperatureDelta delta) {
    final deltaInThisUnit = delta.getValue(_correspondingDeltaUnit(unit));
    return Temperature(value + deltaInThisUnit, unit);
  }

  /// Subtracts a [TemperatureDelta] from this temperature, returning a new
  /// [Temperature] in the same unit. Models cooling.
  ///
  /// This is a named method because `operator -` is already defined for
  /// `Temperature - Temperature` → `TemperatureDelta`. To cool by a delta,
  /// use this method or `temp + (-amount).celsiusDelta`.
  ///
  /// Example:
  /// ```dart
  /// final cooled = 30.celsius.subtract(20.celsiusDelta);
  /// print(cooled.inCelsius); // 10.0
  /// ```
  Temperature subtract(TemperatureDelta delta) {
    final deltaInThisUnit = delta.getValue(_correspondingDeltaUnit(unit));
    return Temperature(value - deltaInThisUnit, unit);
  }

  // Operator + (Temperature other) is intentionally not implemented as adding
  // absolute temperatures (e.g., 20°C + 10°C) is not physically meaningful.

  // Operator * (double scalar) is intentionally not implemented as scaling
  // absolute temperatures is generally not meaningful.

  // Operator / (double scalar) is intentionally not implemented as it's
  // generally not physically meaningful for absolute temperatures.

  /// Computes the thermodynamically valid ratio of this temperature to [other].
  ///
  /// Both temperatures are converted to Kelvin before dividing, ensuring the
  /// result is meaningful regardless of the input scale. This replaces the
  /// former `operator /`, which was removed because ratios on non-absolute
  /// scales (e.g. 20 °C / 10 °C) are physically meaningless.
  ///
  /// Throws [ArgumentError] if [other] is absolute zero (0 K).
  ///
  /// Example:
  /// ```dart
  /// // Carnot efficiency: η = 1 − T_cold / T_hot
  /// final efficiency = 1.0 - coldReservoir.ratioTo(hotReservoir);
  /// ```
  double ratioTo(Temperature other) {
    final thisK = getValue(TemperatureUnit.kelvin);
    final otherK = other.getValue(TemperatureUnit.kelvin);
    if (otherK == 0.0) {
      throw ArgumentError(
        'Cannot compute ratio: the divisor temperature is absolute zero (0 K).',
      );
    }
    return thisK / otherK;
  }

  /// Maps an absolute [TemperatureUnit] to its corresponding
  /// [TemperatureDeltaUnit].
  static TemperatureDeltaUnit _correspondingDeltaUnit(TemperatureUnit absUnit) {
    switch (absUnit) {
      case TemperatureUnit.kelvin:
        return TemperatureDeltaUnit.kelvinDelta;
      case TemperatureUnit.celsius:
        return TemperatureDeltaUnit.celsiusDelta;
      case TemperatureUnit.fahrenheit:
        return TemperatureDeltaUnit.fahrenheitDelta;
      case TemperatureUnit.rankine:
        return TemperatureDeltaUnit.rankineDelta;
    }
  }
}
