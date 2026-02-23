import 'temperature_delta.dart';
import 'temperature_delta_unit.dart';

/// Provides convenient access to [TemperatureDelta] values in specific units.
extension TemperatureDeltaValueGetters on TemperatureDelta {
  /// Returns the delta value in Kelvin (K). Equivalent to [inCelsiusDelta].
  double get inKelvinDelta => getValue(TemperatureDeltaUnit.kelvinDelta);

  /// Returns the delta value in Celsius degrees (°C).
  /// Equivalent to [inKelvinDelta] (same degree size).
  double get inCelsiusDelta => getValue(TemperatureDeltaUnit.celsiusDelta);

  /// Returns the delta value in Fahrenheit degrees (°F).
  /// A 1 °F delta = 5/9 K delta.
  double get inFahrenheitDelta => getValue(TemperatureDeltaUnit.fahrenheitDelta);

  /// Returns the delta value in Rankine degrees (°R).
  /// A 1 °R delta = 5/9 K delta.
  double get inRankineDelta => getValue(TemperatureDeltaUnit.rankineDelta);

  /// Returns a [TemperatureDelta] converted to Kelvin (K).
  TemperatureDelta get asKelvinDelta => convertTo(TemperatureDeltaUnit.kelvinDelta);

  /// Returns a [TemperatureDelta] converted to Celsius degrees (°C).
  TemperatureDelta get asCelsiusDelta => convertTo(TemperatureDeltaUnit.celsiusDelta);

  /// Returns a [TemperatureDelta] converted to Fahrenheit degrees (°F).
  TemperatureDelta get asFahrenheitDelta => convertTo(TemperatureDeltaUnit.fahrenheitDelta);

  /// Returns a [TemperatureDelta] converted to Rankine degrees (°R).
  TemperatureDelta get asRankineDelta => convertTo(TemperatureDeltaUnit.rankineDelta);
}

/// Provides convenient factory methods for creating [TemperatureDelta]
/// instances from [num].
extension TemperatureDeltaCreation on num {
  /// Creates a [TemperatureDelta] in Kelvin (K).
  TemperatureDelta get kelvinDelta =>
      TemperatureDelta(toDouble(), TemperatureDeltaUnit.kelvinDelta);

  /// Creates a [TemperatureDelta] in Celsius degrees (°C).
  TemperatureDelta get celsiusDelta =>
      TemperatureDelta(toDouble(), TemperatureDeltaUnit.celsiusDelta);

  /// Creates a [TemperatureDelta] in Fahrenheit degrees (°F).
  TemperatureDelta get fahrenheitDelta =>
      TemperatureDelta(toDouble(), TemperatureDeltaUnit.fahrenheitDelta);

  /// Creates a [TemperatureDelta] in Rankine degrees (°R).
  TemperatureDelta get rankineDelta =>
      TemperatureDelta(toDouble(), TemperatureDeltaUnit.rankineDelta);
}
