// ignore_for_file: prefer_int_literals : all constants are doubles.

import 'package:meta/meta.dart';

import '../../core/quantity.dart';
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
  const Temperature(super.value, super.unit);

  // --- Conversion Constants ---
  // These could also be in a separate TemperatureFactors class if they grew more complex
  // or were needed elsewhere, but for direct formulas they are fine here.

  /// The offset of Kelvin from Celsius (0°C = 273.15K).
  static const double kelvinOffsetFromCelsius = 273.15;

  /// The scaling factor for Fahrenheit to Celsius conversion (9/5).
  static const double fahrenheitScaleFactor = 1.8; // 9.0 / 5.0

  /// The offset for Fahrenheit conversion from Celsius (0°C = 32°F).
  static const double fahrenheitOffset = 32.0;

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
          case TemperatureUnit.fahrenheit:
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

  /// Subtracts another temperature from this temperature, yielding a temperature difference.
  /// The [other] temperature is converted to the unit of this temperature before subtraction.
  /// Returns a [double] representing the difference in the unit of this temperature.
  /// For example, `20.celsius - 10.celsius` yields `10.0` (a difference of 10 Celsius degrees).
  double operator -(Temperature other) {
    final otherValueInThisUnit = other.getValue(unit);
    return value - otherValueInThisUnit;
  }

  // Operator + (Temperature other) is intentionally not implemented as it's
  // generally not physically meaningful for absolute temperatures.

  // Operator * (double scalar) is intentionally not implemented as it's
  // generally not physically meaningful for absolute temperatures.

  // Operator / (double scalar) is intentionally not implemented as it's
  // generally not physically meaningful for absolute temperatures.

  /// Divides this temperature by another temperature.
  /// The [other] temperature is converted to the unit of this temperature before division.
  /// Returns a scalar [double] representing the ratio.
  /// Note: This operation is only meaningful in specific thermodynamic contexts (e.g., Carnot efficiency)
  /// and should be used with caution. Both temperatures should ideally be on an absolute scale (Kelvin)
  /// for physical meaning, though the calculation will be performed based on converted values.
  /// Throws [ArgumentError] if the effective value of [other] in this unit is zero.
  double operator /(Temperature other) {
    // For ratio calculations, it's often more meaningful if both are converted to Kelvin first,
    // but to keep consistent with other quantity divisions, we convert to `this.unit`.
    final otherValueInThisUnit = other.getValue(unit);
    if (otherValueInThisUnit == 0 && value != 0) {
      // Avoid 0/0 resulting in NaN without error
      // A zero temperature on a non-Kelvin scale might not be absolute zero.
      // However, division by zero magnitude is the primary concern.
      throw ArgumentError('Cannot divide by a zero temperature if the dividend is non-zero.');
    }
    // Handle 0.0 / 0.0 case, which results in NaN. Could throw or return as is.
    // Standard double division handles 0.0/0.0 as NaN.
    if (value == 0 && otherValueInThisUnit == 0) {
      return double.nan; // Or throw, depending on desired strictness for 0/0
    }
    return value / otherValueInThisUnit;
  }
}
