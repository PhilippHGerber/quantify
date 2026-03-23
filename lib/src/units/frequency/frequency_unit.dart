import 'package:meta/meta.dart';

import '../../core/unit.dart';
import 'frequency_factors.dart';

/// Represents units of frequency.
///
/// This enum implements the [LinearUnit] interface to provide conversion capabilities
/// and a display [symbol] for each frequency unit.
/// All conversion factors are pre-calculated in the constructor relative to
/// Hertz (Hz).
enum FrequencyUnit implements LinearUnit<FrequencyUnit> {
  /// Hertz (Hz), the SI derived unit of frequency, equal to one cycle per second.
  hertz(1, 'Hz'),

  /// Terahertz (THz), a multiple of the Hertz.
  terahertz(FrequencyFactors.hzPerTerahertz, 'THz'),

  /// Gigahertz (GHz), a multiple of the Hertz.
  gigahertz(FrequencyFactors.hzPerGigahertz, 'GHz'),

  /// Megahertz (MHz), a multiple of the Hertz.
  megahertz(FrequencyFactors.hzPerMegahertz, 'MHz'),

  /// Kilohertz (kHz), a multiple of the Hertz.
  kilohertz(FrequencyFactors.hzPerKilohertz, 'kHz'),

  /// Millihertz (mHz), a sub-multiple of the Hertz.
  millihertz(FrequencyFactors.hzPerMillihertz, 'mHz'),

  /// Revolutions per minute (rpm), a unit of rotational speed.
  revolutionsPerMinute(FrequencyFactors.hzPerRpm, 'rpm'),

  /// Beats per minute (bpm), commonly used for heart rate or music tempo.
  beatsPerMinute(FrequencyFactors.hzPerBpm, 'bpm'),

  /// Radian per second (rad/s), the SI unit for angular velocity, also a measure of frequency.
  radianPerSecond(FrequencyFactors.hzPerRadPerSecond, 'rad/s'),

  /// Degree per second (°/s), a common unit for rotational speed.
  degreePerSecond(FrequencyFactors.hzPerDegPerSecond, '°/s');

  /// Constant constructor for enum members.
  const FrequencyUnit(double toHertzFactor, this.symbol)
      : _toHertzFactor = toHertzFactor,
        _factorToHertz = toHertzFactor / 1.0,
        _factorToTerahertz = toHertzFactor / FrequencyFactors.hzPerTerahertz,
        _factorToGigahertz = toHertzFactor / FrequencyFactors.hzPerGigahertz,
        _factorToMegahertz = toHertzFactor / FrequencyFactors.hzPerMegahertz,
        _factorToKilohertz = toHertzFactor / FrequencyFactors.hzPerKilohertz,
        _factorToMillihertz = toHertzFactor / FrequencyFactors.hzPerMillihertz,
        _factorToRevolutionsPerMinute = toHertzFactor / FrequencyFactors.hzPerRpm,
        _factorToBeatsPerMinute = toHertzFactor / FrequencyFactors.hzPerBpm,
        _factorToRadianPerSecond = toHertzFactor / FrequencyFactors.hzPerRadPerSecond,
        _factorToDegreePerSecond = toHertzFactor / FrequencyFactors.hzPerDegPerSecond;

  // ignore: unused_field // The factor to convert this unit to Hertz (Hz).
  final double _toHertzFactor;

  @override
  final String symbol;

  // --- Pre-calculated direct conversion factors ---
  final double _factorToHertz;
  final double _factorToTerahertz;
  final double _factorToGigahertz;
  final double _factorToMegahertz;
  final double _factorToKilohertz;
  final double _factorToMillihertz;
  final double _factorToRevolutionsPerMinute;
  final double _factorToBeatsPerMinute;
  final double _factorToRadianPerSecond;
  final double _factorToDegreePerSecond;

  /// SI and unit symbols matched **strictly case-sensitive**.
  ///
  /// Used by `Frequency.parser`.
  @internal
  static const Map<String, FrequencyUnit> symbolAliases = {
    // hertz
    'Hz': FrequencyUnit.hertz,
    // terahertz
    'THz': FrequencyUnit.terahertz,
    // gigahertz
    'GHz': FrequencyUnit.gigahertz,
    // megahertz
    'MHz': FrequencyUnit.megahertz,
    // kilohertz
    'kHz': FrequencyUnit.kilohertz,
    // millihertz
    'mHz': FrequencyUnit.millihertz,
    // revolutions per minute
    'rpm': FrequencyUnit.revolutionsPerMinute,
    // beats per minute
    'bpm': FrequencyUnit.beatsPerMinute,
    // radian per second
    'rad/s': FrequencyUnit.radianPerSecond,
    // degree per second
    '°/s': FrequencyUnit.degreePerSecond,
    'deg/s': FrequencyUnit.degreePerSecond,
  };

  /// Full word-form names matched **case-insensitively**.
  ///
  /// Used by `Frequency.parser`.
  @internal
  static const Map<String, FrequencyUnit> nameAliases = {
    // hertz
    'hertz': FrequencyUnit.hertz,
    // terahertz
    'terahertz': FrequencyUnit.terahertz,
    // gigahertz
    'gigahertz': FrequencyUnit.gigahertz,
    // megahertz
    'megahertz': FrequencyUnit.megahertz,
    // kilohertz
    'kilohertz': FrequencyUnit.kilohertz,
    // millihertz
    'millihertz': FrequencyUnit.millihertz,
    // revolutions per minute
    'revolutions per minute': FrequencyUnit.revolutionsPerMinute,
    'revolution per minute': FrequencyUnit.revolutionsPerMinute,
    'rpm': FrequencyUnit.revolutionsPerMinute,
    // beats per minute
    'beats per minute': FrequencyUnit.beatsPerMinute,
    'beat per minute': FrequencyUnit.beatsPerMinute,
    'bpm': FrequencyUnit.beatsPerMinute,
    // radian per second
    'radian per second': FrequencyUnit.radianPerSecond,
    'radians per second': FrequencyUnit.radianPerSecond,
    // degree per second
    'degree per second': FrequencyUnit.degreePerSecond,
    'degrees per second': FrequencyUnit.degreePerSecond,
  };

  @override
  @internal
  double factorTo(FrequencyUnit targetUnit) {
    switch (targetUnit) {
      case FrequencyUnit.hertz:
        return _factorToHertz;
      case FrequencyUnit.terahertz:
        return _factorToTerahertz;
      case FrequencyUnit.gigahertz:
        return _factorToGigahertz;
      case FrequencyUnit.megahertz:
        return _factorToMegahertz;
      case FrequencyUnit.kilohertz:
        return _factorToKilohertz;
      case FrequencyUnit.millihertz:
        return _factorToMillihertz;
      case FrequencyUnit.revolutionsPerMinute:
        return _factorToRevolutionsPerMinute;
      case FrequencyUnit.beatsPerMinute:
        return _factorToBeatsPerMinute;
      case FrequencyUnit.radianPerSecond:
        return _factorToRadianPerSecond;
      case FrequencyUnit.degreePerSecond:
        return _factorToDegreePerSecond;
    }
  }
}
