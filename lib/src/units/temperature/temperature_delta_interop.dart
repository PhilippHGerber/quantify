import 'temperature.dart';
import 'temperature_delta.dart';

/// Provides cross-type arithmetic between [TemperatureDelta] and [Temperature].
extension TemperatureDeltaTemperatureInterop on TemperatureDelta {
  /// Adds this delta to an absolute [Temperature], returning a new
  /// [Temperature].
  ///
  /// This is the commutative form of `Temperature.operator +`:
  /// `delta.addTo(temperature)` is equivalent to `temperature + delta`.
  ///
  /// The result is expressed in the unit of the [temperature] operand.
  ///
  /// Example:
  /// ```dart
  /// final rise = 20.celsiusDelta;
  /// final newTemp = rise.addTo(10.celsius); // Temperature(30.0, celsius)
  /// ```
  Temperature addTo(Temperature temperature) {
    return temperature + this;
  }
}
