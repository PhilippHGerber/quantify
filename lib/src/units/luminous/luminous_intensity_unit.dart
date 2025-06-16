import 'package:meta/meta.dart';

import '../../core/unit.dart';
import 'luminous_intensity_factors.dart';

/// Represents units for luminous intensity.
///
/// This enum implements the [Unit] interface to provide conversion capabilities
/// and a display [symbol] for each luminous intensity unit.
/// All conversion factors are pre-calculated in the constructor relative to Candela (cd),
/// which is the SI base unit for luminous intensity.
enum LuminousIntensityUnit implements Unit<LuminousIntensityUnit> {
  /// Candela (cd), the SI base unit of luminous intensity.
  /// It is defined by taking the fixed numerical value of the luminous efficacy
  /// of monochromatic radiation of frequency 540 × 10¹² Hz, Kcd, to be 683
  /// when expressed in the unit lm W⁻¹, which is equal to cd sr W⁻¹ or
  /// cd sr kg⁻¹ m⁻² s³.
  candela(1, 'cd'),

  /// Millicandela (mcd), equal to 0.001 candelas.
  /// Commonly used for LEDs and indicator lights.
  millicandela(LuminousIntensityFactors.candelasPerMillicandela, 'mcd'),

  /// Kilocandela (kcd), equal to 1000 candelas.
  /// A less common unit, might be used for very high-intensity light sources
  /// like searchlights or lighthouses.
  kilocandela(LuminousIntensityFactors.candelasPerKilocandela, 'kcd');

  // If Hefnerkerze were to be added:
  // /// Hefnerkerze (HK) or Hefner candle, an old German unit.
  // /// 1 HK ≈ 0.903 cd.
  // hefnerCandle(LuminousIntensityFactors.candelasPerHefnerCandle, 'HK');

  /// Constant constructor for enum members.
  ///
  /// [_toCandelaFactor] is the factor to convert from this unit to the base unit (Candela).
  /// For Candela itself, this is 1.0.
  /// [symbol] is the display symbol for the unit.
  ///
  /// The constructor pre-calculates all direct conversion factors
  /// from this unit to every other `LuminousIntensityUnit`.
  const LuminousIntensityUnit(double toCandelaFactor, this.symbol)
      : _toCandelaFactor = toCandelaFactor,
        // Initialize direct factors from THIS unit to OTHERS.
        _factorToCandela = toCandelaFactor / 1.0, // Base unit factor for candela is 1.0
        _factorToMillicandela = toCandelaFactor / LuminousIntensityFactors.candelasPerMillicandela,
        _factorToKilocandela = toCandelaFactor / LuminousIntensityFactors.candelasPerKilocandela;
  // If hefnerCandle were added:
  // _factorToHefnerCandle = toCandelaFactor / LuminousIntensityFactors.candelasPerHefnerCandle;

  /// The factor to convert a value from this unit to the base unit (Candela).
  /// Example: For Millicandela, this is 0.001 (meaning 1 mcd = 0.001 cd).
  /// This field is primarily used internally by the constructor.
  // ignore: unused_field
  final double _toCandelaFactor;

  /// The human-readable symbol for this luminous intensity unit (e.g., "cd", "mcd").
  @override
  final String symbol;

  // --- Pre-calculated direct conversion factors from this unit to all others ---
  final double _factorToCandela;
  final double _factorToMillicandela;
  final double _factorToKilocandela;
  // If hefnerCandle were added:
  // final double _factorToHefnerCandle;

  /// Returns the direct conversion factor to convert a value from this [LuminousIntensityUnit]
  /// to the [targetUnit].
  ///
  /// This method is marked as `@internal` and is primarily used by the `LuminousIntensity`
  /// class for conversions.
  @override
  @internal
  double factorTo(LuminousIntensityUnit targetUnit) {
    switch (targetUnit) {
      case LuminousIntensityUnit.candela:
        return _factorToCandela;
      case LuminousIntensityUnit.millicandela:
        return _factorToMillicandela;
      case LuminousIntensityUnit.kilocandela:
        return _factorToKilocandela;
      // If hefnerCandle were added:
      // case LuminousIntensityUnit.hefnerCandle:
      //  return _factorToHefnerCandle;
    }
  }
}
