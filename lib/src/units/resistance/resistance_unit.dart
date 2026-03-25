import 'package:meta/meta.dart';

import '../../core/unit.dart';
import 'resistance_factors.dart';

/// Represents units for electrical resistance.
///
/// This enum implements the [LinearUnit] interface to provide conversion capabilities
/// and a display [symbol] for each resistance unit.
/// All conversion factors are pre-calculated in the constructor relative to Ohm (Ω),
/// which is the SI derived unit for electrical resistance.
enum ResistanceUnit implements LinearUnit<ResistanceUnit> {
  /// Ohm (Ω), the SI derived unit of electrical resistance.
  /// Defined as the resistance between two points of a conductor when a
  /// constant potential difference of one volt produces a current of one ampere.
  ohm(1, 'Ω'),

  /// Nanoohm (nΩ), equal to 1e-9 ohms.
  nanoohm(ResistanceFactors.ohmsPerNanoohm, 'nΩ'),

  /// Microohm (µΩ), equal to 1e-6 ohms.
  microohm(ResistanceFactors.ohmsPerMicroohm, 'µΩ'),

  /// Milliohm (mΩ), equal to 0.001 ohms.
  milliohm(ResistanceFactors.ohmsPerMilliohm, 'mΩ'),

  /// Kiloohm (kΩ), equal to 1000 ohms.
  kiloohm(ResistanceFactors.ohmsPerKiloohm, 'kΩ'),

  /// Megaohm (MΩ), equal to 1,000,000 ohms.
  megaohm(ResistanceFactors.ohmsPerMegaohm, 'MΩ'),

  /// Gigaohm (GΩ), equal to 1,000,000,000 ohms.
  gigaohm(ResistanceFactors.ohmsPerGigaohm, 'GΩ');

  /// Constant constructor for enum members.
  ///
  /// [_toOhmFactor] is the factor to convert from this unit to the base unit (Ohm).
  /// For Ohm itself, this is 1.0.
  /// [symbol] is the display symbol for the unit.
  ///
  /// The constructor pre-calculates all direct conversion factors
  /// from this unit to every other `ResistanceUnit`.
  const ResistanceUnit(double toOhmFactor, this.symbol)
      : _toOhmFactor = toOhmFactor,
        _factorToOhm = toOhmFactor / 1.0,
        _factorToNanoohm = toOhmFactor / ResistanceFactors.ohmsPerNanoohm,
        _factorToMicroohm = toOhmFactor / ResistanceFactors.ohmsPerMicroohm,
        _factorToMilliohm = toOhmFactor / ResistanceFactors.ohmsPerMilliohm,
        _factorToKiloohm = toOhmFactor / ResistanceFactors.ohmsPerKiloohm,
        _factorToMegaohm = toOhmFactor / ResistanceFactors.ohmsPerMegaohm,
        _factorToGigaohm = toOhmFactor / ResistanceFactors.ohmsPerGigaohm;

  /// The factor to convert a value from this unit to the base unit (Ohm).
  // ignore: unused_field
  final double _toOhmFactor;

  /// The human-readable symbol for this resistance unit (e.g., "Ω", "kΩ").
  @override
  final String symbol;

  // --- Pre-calculated direct conversion factors from this unit to all others ---
  final double _factorToOhm;
  final double _factorToNanoohm;
  final double _factorToMicroohm;
  final double _factorToMilliohm;
  final double _factorToKiloohm;
  final double _factorToMegaohm;
  final double _factorToGigaohm;

  /// SI and unit symbols matched **strictly case-sensitive**.
  ///
  /// Used by `Resistance.parser`.
  @internal
  static const Map<String, ResistanceUnit> symbolAliases = {
    // ohm
    'Ω': ResistanceUnit.ohm,
    'Ohm': ResistanceUnit.ohm,
    // nanoohm
    'nΩ': ResistanceUnit.nanoohm,
    // microohm
    'µΩ': ResistanceUnit.microohm,
    'uΩ': ResistanceUnit.microohm,
    // milliohm
    'mΩ': ResistanceUnit.milliohm,
    // kiloohm
    'kΩ': ResistanceUnit.kiloohm,
    // megaohm
    'MΩ': ResistanceUnit.megaohm,
    // gigaohm
    'GΩ': ResistanceUnit.gigaohm,
  };

  /// Full word-form names matched **case-insensitively**.
  ///
  /// Used by `Resistance.parser`.
  @internal
  static const Map<String, ResistanceUnit> nameAliases = {
    // ohm
    'ohm': ResistanceUnit.ohm,
    'ohms': ResistanceUnit.ohm,
    // nanoohm
    'nanoohm': ResistanceUnit.nanoohm,
    'nanoohms': ResistanceUnit.nanoohm,
    // microohm
    'microohm': ResistanceUnit.microohm,
    'microohms': ResistanceUnit.microohm,
    // milliohm
    'milliohm': ResistanceUnit.milliohm,
    'milliohms': ResistanceUnit.milliohm,
    // kiloohm
    'kiloohm': ResistanceUnit.kiloohm,
    'kiloohms': ResistanceUnit.kiloohm,
    // megaohm
    'megaohm': ResistanceUnit.megaohm,
    'megaohms': ResistanceUnit.megaohm,
    // gigaohm
    'gigaohm': ResistanceUnit.gigaohm,
    'gigaohms': ResistanceUnit.gigaohm,
  };

  /// Returns the direct conversion factor to convert a value from this [ResistanceUnit]
  /// to the [targetUnit].
  @override
  @internal
  double factorTo(ResistanceUnit targetUnit) {
    switch (targetUnit) {
      case ResistanceUnit.ohm:
        return _factorToOhm;
      case ResistanceUnit.nanoohm:
        return _factorToNanoohm;
      case ResistanceUnit.microohm:
        return _factorToMicroohm;
      case ResistanceUnit.milliohm:
        return _factorToMilliohm;
      case ResistanceUnit.kiloohm:
        return _factorToKiloohm;
      case ResistanceUnit.megaohm:
        return _factorToMegaohm;
      case ResistanceUnit.gigaohm:
        return _factorToGigaohm;
    }
  }
}
