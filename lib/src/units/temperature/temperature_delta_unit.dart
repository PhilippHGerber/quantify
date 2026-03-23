// ignore_for_file: prefer_int_literals : all factors are doubles.
//
import 'package:meta/meta.dart';

import '../../core/unit.dart';

/// Represents units of temperature change (intervals/deltas).
///
/// Unlike 'TemperatureUnit', which represents *absolute* temperatures (affine
/// points on a thermometer), [TemperatureDeltaUnit] represents *changes* in
/// temperature (linear vectors). This distinction matters because:
///
/// - A 1 °C change equals a 1 K change (same degree size).
/// - A 1 °F change equals only 5/9 of a 1 K change.
/// - Deltas convert by pure multiplicative factors — no offsets are involved.
///
/// ## Conversion factors
///
/// | Unit              | Factor to kelvinDelta |
/// | ----------------- | --------------------- |
/// | `kelvinDelta`     | 1.0                   |
/// | `celsiusDelta`    | 1.0                   |
/// | `fahrenheitDelta` | 5/9 ≈ 0.5556         |
/// | `rankineDelta`    | 5/9 ≈ 0.5556         |
enum TemperatureDeltaUnit implements LinearUnit<TemperatureDeltaUnit> {
  /// Kelvin delta (K). Base unit of temperature change.
  kelvinDelta(1.0, 'K'),

  /// Celsius delta (°C). Identical in magnitude to [kelvinDelta].
  celsiusDelta(1.0, '°C'),

  /// Fahrenheit delta (°F). A 1 °F change equals 5/9 of a 1 K change.
  fahrenheitDelta(5.0 / 9.0, '°F'),

  /// Rankine delta (°R). Same degree size as Fahrenheit: 5/9 of a Kelvin.
  rankineDelta(5.0 / 9.0, '°R');

  /// Constant constructor for enum members.
  ///
  /// [toKelvinFactor] is the multiplicative factor from this delta unit to
  /// kelvin delta.
  const TemperatureDeltaUnit(double toKelvinFactor, this.symbol)
      : _factorToKelvinDelta = toKelvinFactor / 1.0,
        _factorToCelsiusDelta = toKelvinFactor / 1.0,
        _factorToFahrenheitDelta = toKelvinFactor / (5.0 / 9.0),
        _factorToRankineDelta = toKelvinFactor / (5.0 / 9.0);

  /// SI and unit symbols matched **strictly case-sensitive**.
  static const Map<String, TemperatureDeltaUnit> symbolAliases = {
    'K': kelvinDelta,
    '°C': celsiusDelta,
    'C': celsiusDelta,
    '°F': fahrenheitDelta,
    'F': fahrenheitDelta,
    '°R': rankineDelta,
    'R': rankineDelta,
  };

  /// Full word-form names and non-SI abbreviations matched **case-insensitively**.
  static const Map<String, TemperatureDeltaUnit> nameAliases = {
    'kelvin': kelvinDelta,
    'kelvin delta': kelvinDelta,
    'kelvindelta': kelvinDelta,
    'celsius': celsiusDelta,
    'celsius delta': celsiusDelta,
    'celsiusdelta': celsiusDelta,
    'fahrenheit': fahrenheitDelta,
    'fahrenheit delta': fahrenheitDelta,
    'fahrenheitdelta': fahrenheitDelta,
    'rankine': rankineDelta,
    'rankine delta': rankineDelta,
    'rankinedelta': rankineDelta,
  };

  /// The display symbol for this temperature-delta unit.
  @override
  final String symbol;

  // --- Pre-calculated direct conversion factors ---
  final double _factorToKelvinDelta;
  final double _factorToCelsiusDelta;
  final double _factorToFahrenheitDelta;
  final double _factorToRankineDelta;

  /// Returns the direct conversion factor from this unit to [targetUnit].
  @override
  @internal
  double factorTo(TemperatureDeltaUnit targetUnit) {
    switch (targetUnit) {
      case TemperatureDeltaUnit.kelvinDelta:
        return _factorToKelvinDelta;
      case TemperatureDeltaUnit.celsiusDelta:
        return _factorToCelsiusDelta;
      case TemperatureDeltaUnit.fahrenheitDelta:
        return _factorToFahrenheitDelta;
      case TemperatureDeltaUnit.rankineDelta:
        return _factorToRankineDelta;
    }
  }
}
