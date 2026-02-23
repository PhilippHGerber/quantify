import 'temperature.dart';
import 'temperature_delta.dart';
import 'temperature_delta_unit.dart';
import 'temperature_unit.dart';

/// Provides convenient access to [Temperature] values in specific units.
extension TemperatureValueGetters on Temperature {
  /// Returns the temperature value in Celsius (°C).
  double get inCelsius => getValue(TemperatureUnit.celsius);

  /// Returns the temperature value in Kelvin (K).
  double get inKelvin => getValue(TemperatureUnit.kelvin);

  /// Returns the temperature value in Fahrenheit (°F).
  double get inFahrenheit => getValue(TemperatureUnit.fahrenheit);

  /// Returns the temperature value in Rankine (°R).
  double get inRankine => getValue(TemperatureUnit.rankine);

  /// Returns a Temperature representing this temperature in Celsius (°C).
  Temperature get asCelsius => convertTo(TemperatureUnit.celsius);

  /// Returns a Temperature representing this temperature in Kelvin (K).
  Temperature get asKelvin => convertTo(TemperatureUnit.kelvin);

  /// Returns a Temperature representing this temperature in Fahrenheit (°F).
  Temperature get asFahrenheit => convertTo(TemperatureUnit.fahrenheit);

  /// Returns a Temperature representing this temperature in Rankine (°R).
  Temperature get asRankine => convertTo(TemperatureUnit.rankine);

  /// Converts this absolute temperature into a [TemperatureDelta] relative to
  /// absolute zero.
  ///
  /// The returned delta is always in [TemperatureDeltaUnit.kelvinDelta],
  /// regardless of this temperature's original unit. This is useful when a
  /// Kelvin-magnitude scalar is required, such as in the ideal gas law
  /// (PV = nRT) or Boltzmann energy calculations.
  ///
  /// Example:
  /// ```dart
  /// final temp = 300.kelvin;
  /// print(temp.asDelta.inKelvinDelta); // 300.0
  ///
  /// final tempC = 100.celsius;
  /// print(tempC.asDelta.inKelvinDelta); // 373.15
  /// ```
  TemperatureDelta get asDelta => TemperatureDelta(
        getValue(TemperatureUnit.kelvin),
        TemperatureDeltaUnit.kelvinDelta,
      );
}

/// Provides convenient factory methods for creating [Temperature] instances from [num].
extension TemperatureCreation on num {
  /// Creates a [Temperature] instance representing this numerical value in Celsius (°C).
  Temperature get celsius => Temperature(toDouble(), TemperatureUnit.celsius);

  /// Creates a [Temperature] instance representing this numerical value in Kelvin (K).
  Temperature get kelvin => Temperature(toDouble(), TemperatureUnit.kelvin);

  /// Creates a [Temperature] instance representing this numerical value in Fahrenheit (°F).
  Temperature get fahrenheit => Temperature(toDouble(), TemperatureUnit.fahrenheit);

  /// Creates a [Temperature] instance representing this numerical value in Rankine (°R).
  Temperature get rankine => Temperature(toDouble(), TemperatureUnit.rankine);
}
