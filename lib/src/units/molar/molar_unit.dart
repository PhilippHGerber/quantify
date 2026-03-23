import 'package:meta/meta.dart';

import '../../core/unit.dart';
import 'molar_factors.dart';

/// Represents units for amount of substance (molar amount).
///
/// This enum implements the [LinearUnit] interface to provide conversion capabilities
/// and a display [symbol] for each molar amount unit.
/// All conversion factors are pre-calculated in the constructor relative to Mole (mol),
/// which is the SI base unit for amount of substance.
enum MolarUnit implements LinearUnit<MolarUnit> {
  /// Mole (mol), the SI base unit for amount of substance.
  /// One mole contains exactly 6.02214076 × 10²³ elementary entities (Avogadro's number).
  mole(1, 'mol'),

  /// Megamole (Mmol), equal to 1e6 moles.
  megamole(MolarFactors.molesPerMegamole, 'Mmol'),

  /// Kilomole (kmol), equal to 1000 moles.
  kilomole(MolarFactors.molesPerKilomole, 'kmol'),

  /// Millimole (mmol), equal to 0.001 moles.
  millimole(MolarFactors.molesPerMillimole, 'mmol'),

  /// Micromole (µmol), equal to 1e-6 moles.
  micromole(MolarFactors.molesPerMicromole, 'µmol'),

  /// Nanomole (nmol), equal to 1e-9 moles.
  nanomole(MolarFactors.molesPerNanomole, 'nmol'),

  /// Picomole (pmol), equal to 1e-12 moles.
  picomole(MolarFactors.molesPerPicomole, 'pmol'),

  /// Femtomole (fmol), equal to 1e-15 moles.
  femtomole(MolarFactors.molesPerFemtomole, 'fmol'),

  /// Pound-mole (lb-mol), an imperial unit used in chemical engineering.
  /// 1 lb-mol = 453.59237 mol (exact, from the pound-to-gram definition).
  poundMole(MolarFactors.molesPerPoundMole, 'lb-mol');

  /// Constant constructor for enum members.
  ///
  /// [_toMoleFactor] is the factor to convert from this unit to the base unit (Mole).
  /// For Mole itself, this is 1.0.
  /// [symbol] is the display symbol for the unit.
  ///
  /// The constructor pre-calculates all direct conversion factors
  /// from this unit to every other `MolarUnit`.
  /// The formula `factor_A_to_B = _toBaseFactor_A / _toBaseFactor_B` is used,
  /// where the base unit is Mole.
  const MolarUnit(double toMoleFactor, this.symbol)
      : _toMoleFactor = toMoleFactor,
        // Initialize direct factors from THIS unit to OTHERS.
        _factorToMole = toMoleFactor / 1.0, // Base unit factor for mole is 1.0
        _factorToMegamole = toMoleFactor / MolarFactors.molesPerMegamole,
        _factorToKilomole = toMoleFactor / MolarFactors.molesPerKilomole,
        _factorToMillimole = toMoleFactor / MolarFactors.molesPerMillimole,
        _factorToMicromole = toMoleFactor / MolarFactors.molesPerMicromole,
        _factorToNanomole = toMoleFactor / MolarFactors.molesPerNanomole,
        _factorToPicomole = toMoleFactor / MolarFactors.molesPerPicomole,
        _factorToFemtomole = toMoleFactor / MolarFactors.molesPerFemtomole,
        _factorToPoundMole = toMoleFactor / MolarFactors.molesPerPoundMole;

  /// SI and unit symbols matched **strictly case-sensitive**.
  static const Map<String, MolarUnit> symbolAliases = {
    'mol': mole,
    'Mmol': megamole,
    'kmol': kilomole,
    'mmol': millimole,
    'µmol': micromole,
    'nmol': nanomole,
    'pmol': picomole,
    'fmol': femtomole,
    'lb-mol': poundMole,
  };

  /// Full word-form names and non-SI abbreviations matched **case-insensitively**.
  static const Map<String, MolarUnit> nameAliases = {
    'mole': mole,
    'megamole': megamole,
    'mega mole': megamole,
    'kilomole': kilomole,
    'kilo mole': kilomole,
    'millimole': millimole,
    'milli mole': millimole,
    'micromole': micromole,
    'micro mole': micromole,
    'nanomole': nanomole,
    'nano mole': nanomole,
    'picomole': picomole,
    'pico mole': picomole,
    'femtomole': femtomole,
    'femto mole': femtomole,
    'pound-mole': poundMole,
    'pound mole': poundMole,
    'poundmole': poundMole,
  };

  /// The factor to convert a value from this unit to the base unit (Mole).
  /// Example: For Millimole, this is 0.001 (meaning 1 mmol = 0.001 mol).
  /// This field is primarily used internally by the constructor to derive
  /// direct inter-unit conversion factors.
  // ignore: unused_field
  final double _toMoleFactor;

  /// The human-readable symbol for this molar amount unit (e.g., "mol", "mmol").
  @override
  final String symbol;

  // --- Pre-calculated direct conversion factors from this unit to all others ---
  // These are calculated once in the const constructor for performance.

  final double _factorToMole;
  final double _factorToMegamole;
  final double _factorToKilomole;
  final double _factorToMillimole;
  final double _factorToMicromole;
  final double _factorToNanomole;
  final double _factorToPicomole;
  final double _factorToFemtomole;
  final double _factorToPoundMole;

  /// Returns the direct conversion factor to convert a value from this [MolarUnit]
  /// to the [targetUnit].
  ///
  /// This method is marked as `@internal` and is primarily used by the `MolarAmount`
  /// class for conversions.
  ///
  /// Example: `MolarUnit.millimole.factorTo(MolarUnit.mole)` would return `0.001`.
  /// `MolarUnit.mole.factorTo(MolarUnit.millimole)` would return `1000.0`.
  ///
  /// - [targetUnit]: The `MolarUnit` to which a value should be converted.
  ///
  /// Returns the multiplication factor.
  @override
  @internal
  double factorTo(MolarUnit targetUnit) {
    switch (targetUnit) {
      case MolarUnit.mole:
        return _factorToMole;
      case MolarUnit.megamole:
        return _factorToMegamole;
      case MolarUnit.kilomole:
        return _factorToKilomole;
      case MolarUnit.millimole:
        return _factorToMillimole;
      case MolarUnit.micromole:
        return _factorToMicromole;
      case MolarUnit.nanomole:
        return _factorToNanomole;
      case MolarUnit.picomole:
        return _factorToPicomole;
      case MolarUnit.femtomole:
        return _factorToFemtomole;
      case MolarUnit.poundMole:
        return _factorToPoundMole;
    }
  }
}
