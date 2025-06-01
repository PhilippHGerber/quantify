import '../../core/unit.dart';
import 'pressure_factors.dart';

/// Represents units of pressure.
///
/// This enum implements the [Unit] interface to provide conversion capabilities
/// and a display [symbol] for each pressure unit.
/// All conversion factors are pre-calculated in the constructor relative to Pascal (Pa).
enum PressureUnit implements Unit<PressureUnit> {
  /// Pascal (Pa), the SI derived unit of pressure.
  pascal(1, 'Pa'),

  /// Atmosphere (atm), standard atmosphere.
  atmosphere(PressureFactors.pascalsPerAtmosphere, 'atm'),

  /// Bar (bar).
  bar(PressureFactors.pascalsPerBar, 'bar'),

  /// Pound per square inch (psi).
  psi(PressureFactors.pascalsPerPsi, 'psi'),

  /// Torr (Torr), approximately 1 mmHg.
  torr(PressureFactors.pascalsPerTorr, 'Torr'),

  /// Millimeter of mercury (mmHg) at 0°C.
  millimeterOfMercury(PressureFactors.pascalsPerMillimeterOfMercury, 'mmHg'),

  /// Inch of mercury (inHg) at 0°C.
  inchOfMercury(PressureFactors.pascalsPerInchOfMercury, 'inHg'),

  /// Kilopascal (kPa).
  kilopascal(PressureFactors.pascalsPerKilopascal, 'kPa'),

  /// Hectopascal (hPa).
  hectopascal(PressureFactors.pascalsPerHectopascal, 'hPa'),

  /// Millibar (mbar), equivalent to hectopascal.
  millibar(PressureFactors.pascalsPerMillibar, 'mbar'),

  /// Centimeter of water (cmH₂O) at 4°C.
  centimeterOfWater(PressureFactors.conventionalPascalsPerCentimeterOfWater4C, 'cmH₂O'),

  /// Inch of water (inH₂O) at 4°C.
  inchOfWater(PressureFactors.conventionalPascalsPerInchOfWater4C, 'inH₂O');

  /// Constant constructor for enum members.
  ///
  /// [_toPascalFactor] is the factor to convert from this unit to the base unit (Pascal).
  /// [symbol] is the display symbol for the unit.
  ///
  /// The constructor pre-calculates all direct conversion factors
  /// from this unit to every other `PressureUnit`.
  /// The formula `factor_A_to_B = _toPascalFactor_A / _toPascalFactor_B` is used.
  const PressureUnit(this._toPascalFactor, this.symbol)
      : _factorToPascal = _toPascalFactor / 1.0, // Pascal's _toPascalFactor is 1.0
        _factorToAtmosphere = _toPascalFactor / PressureFactors.pascalsPerAtmosphere,
        _factorToBar = _toPascalFactor / PressureFactors.pascalsPerBar,
        _factorToPsi = _toPascalFactor / PressureFactors.pascalsPerPsi,
        _factorToTorr = _toPascalFactor / PressureFactors.pascalsPerTorr,
        _factorToMillimeterOfMercury =
            _toPascalFactor / PressureFactors.pascalsPerMillimeterOfMercury,
        _factorToInchOfMercury = _toPascalFactor / PressureFactors.pascalsPerInchOfMercury,
        _factorToKilopascal = _toPascalFactor / PressureFactors.pascalsPerKilopascal,
        _factorToHectopascal = _toPascalFactor / PressureFactors.pascalsPerHectopascal,
        _factorToMillibar = _toPascalFactor / PressureFactors.pascalsPerMillibar,
        _factorToCentimeterOfWater =
            _toPascalFactor / PressureFactors.conventionalPascalsPerCentimeterOfWater4C,
        _factorToInchOfWater =
            _toPascalFactor / PressureFactors.conventionalPascalsPerInchOfWater4C;

  /// The factor to convert a value from this unit to the base unit (Pascal).
  /// Example: For Bar, this is 100000.0 (meaning 1 bar = 100000.0 Pa).
  // ignore: unused_field
  final double _toPascalFactor;

  /// The human-readable symbol for this pressure unit (e.g., "Pa", "psi").
  @override
  final String symbol;

  // --- Pre-calculated direct conversion factors from this unit to all others ---
  // These are calculated once in the const constructor.

  final double _factorToPascal;
  final double _factorToAtmosphere;
  final double _factorToBar;
  final double _factorToPsi;
  final double _factorToTorr;
  final double _factorToMillimeterOfMercury;
  final double _factorToInchOfMercury;
  final double _factorToKilopascal;
  final double _factorToHectopascal;
  final double _factorToMillibar;
  final double _factorToCentimeterOfWater;
  final double _factorToInchOfWater;

  /// Returns the direct conversion factor to convert a value from this [PressureUnit]
  /// to the [targetUnit].
  @override
  double factorTo(PressureUnit targetUnit) {
    switch (targetUnit) {
      case PressureUnit.pascal:
        return _factorToPascal;
      case PressureUnit.atmosphere:
        return _factorToAtmosphere;
      case PressureUnit.bar:
        return _factorToBar;
      case PressureUnit.psi:
        return _factorToPsi;
      case PressureUnit.torr:
        return _factorToTorr;
      case PressureUnit.millimeterOfMercury:
        return _factorToMillimeterOfMercury;
      case PressureUnit.inchOfMercury:
        return _factorToInchOfMercury;
      case PressureUnit.kilopascal:
        return _factorToKilopascal;
      case PressureUnit.hectopascal:
        return _factorToHectopascal;
      case PressureUnit.millibar:
        return _factorToMillibar;
      case PressureUnit.centimeterOfWater:
        return _factorToCentimeterOfWater;
      case PressureUnit.inchOfWater:
        return _factorToInchOfWater;
    }
  }
}
