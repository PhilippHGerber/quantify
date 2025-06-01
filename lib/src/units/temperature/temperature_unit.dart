import 'package:meta/meta.dart';

import '../../core/unit.dart';
import 'temperature.dart';

/// Represents units of temperature.
///
/// This enum implements the [Unit] interface but its [factorTo] method
/// will throw an [UnsupportedError] because temperature conversions
/// are affine (involve offsets) and cannot be represented by a single
/// multiplicative factor. Use [Temperature.getValue] or [Temperature.convertTo]
/// for proper conversions.
enum TemperatureUnit implements Unit<TemperatureUnit> {
  /// Celsius (°C).
  celsius('°C'),

  /// Kelvin (K), the SI base unit of thermodynamic temperature.
  kelvin('K'),

  /// Fahrenheit (°F).
  fahrenheit('°F');

  /// Constant constructor for enum members.
  /// [symbol] is the display symbol for the unit.
  const TemperatureUnit(this.symbol);

  @override
  final String symbol;

  /// Throws [UnsupportedError] for temperature units.
  ///
  /// Temperature conversions are affine (involve offsets) and cannot be
  /// represented by a single multiplicative factor.
  /// Use [Temperature.getValue] or [Temperature.convertTo] for proper
  /// temperature conversions.
  @override
  @protected
  double factorTo(TemperatureUnit targetUnit) {
    throw UnsupportedError(
      'Direct multiplicative factor conversion is not supported for temperature units '
      'due to their affine nature (offsets). '
      'Use Temperature.getValue() or Temperature.convertTo() for proper conversions.',
    );
  }
}
