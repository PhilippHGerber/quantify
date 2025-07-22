import 'package:meta/meta.dart';

import '../../core/unit.dart';
import 'frequency_factors.dart';

/// Represents units of frequency.
///
/// This enum implements the [Unit] interface to provide conversion capabilities
/// and a display [symbol] for each frequency unit.
/// All conversion factors are pre-calculated in the constructor relative to
/// Hertz (Hz).
enum FrequencyUnit implements Unit<FrequencyUnit> {
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

  /// Revolutions per minute (rpm), a unit of rotational speed.
  revolutionsPerMinute(FrequencyFactors.hzPerRpm, 'rpm'),

  /// Beats per minute (bpm), commonly used for heart rate or music tempo.
  beatsPerMinute(FrequencyFactors.hzPerBpm, 'bpm');

  /// Constant constructor for enum members.
  const FrequencyUnit(double toHertzFactor, this.symbol)
      : _toHertzFactor = toHertzFactor,
        _factorToHertz = toHertzFactor / 1.0,
        _factorToTerahertz = toHertzFactor / FrequencyFactors.hzPerTerahertz,
        _factorToGigahertz = toHertzFactor / FrequencyFactors.hzPerGigahertz,
        _factorToMegahertz = toHertzFactor / FrequencyFactors.hzPerMegahertz,
        _factorToKilohertz = toHertzFactor / FrequencyFactors.hzPerKilohertz,
        _factorToRevolutionsPerMinute = toHertzFactor / FrequencyFactors.hzPerRpm,
        _factorToBeatsPerMinute = toHertzFactor / FrequencyFactors.hzPerBpm;

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
  final double _factorToRevolutionsPerMinute;
  final double _factorToBeatsPerMinute;

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
      case FrequencyUnit.revolutionsPerMinute:
        return _factorToRevolutionsPerMinute;
      case FrequencyUnit.beatsPerMinute:
        return _factorToBeatsPerMinute;
    }
  }
}
