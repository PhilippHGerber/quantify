import 'temperature.dart';
import 'temperature_unit.dart';

/// Provides convenient access to [Temperature] values in specific units.
extension TemperatureValueGetters on Temperature {
  /// Returns the temperature value in Celsius (°C).
  double get inCelsius => getValue(TemperatureUnit.celsius);

  /// Returns the temperature value in Kelvin (K).
  double get inKelvin => getValue(TemperatureUnit.kelvin);

  /// Returns the temperature value in Fahrenheit (°F).
  double get inFahrenheit => getValue(TemperatureUnit.fahrenheit);
}

/// Provides convenient factory methods for creating [Temperature] instances from [num].
extension TemperatureCreation on num {
  /// Creates a [Temperature] instance representing this numerical value in Celsius (°C).
  Temperature get celsius => Temperature(toDouble(), TemperatureUnit.celsius);

  /// Creates a [Temperature] instance representing this numerical value in Kelvin (K).
  Temperature get kelvin => Temperature(toDouble(), TemperatureUnit.kelvin);

  /// Creates a [Temperature] instance representing this numerical value in Fahrenheit (°F).
  Temperature get fahrenheit => Temperature(toDouble(), TemperatureUnit.fahrenheit);
}
