import 'package:meta/meta.dart';

import '../../core/unit.dart';
import 'length_factors.dart';

/// Represents units of length.
///
/// This enum implements the [Unit] interface to provide conversion capabilities
/// and a display [symbol] for each length unit.
/// All conversion factors are pre-calculated in the constructor relative to Meter.
enum LengthUnit implements Unit<LengthUnit> {
  /// Meter (m), the SI base unit of length.
  meter(1, 'm'),

  /// Kilometer (km), equal to 1000 meters.
  kilometer(LengthFactors.metersPerKilometer, 'km'),

  /// Megameter (Mm), equal to 1e6 meters.
  megameter(LengthFactors.metersPerMegameter, 'Mm'),

  /// Gigameter (Gm), equal to 1e9 meters.
  gigameter(LengthFactors.metersPerGigameter, 'Gm'),

  /// Hectometer (hm), equal to 100 meters.
  hectometer(LengthFactors.metersPerHectometer, 'hm'),

  /// Decameter (dam), equal to 10 meters.
  decameter(LengthFactors.metersPerDecameter, 'dam'),

  /// Decimeter (dm), equal to 0.1 meters.
  decimeter(LengthFactors.metersPerDecimeter, 'dm'),

  /// Centimeter (cm), equal to 0.01 meters.
  centimeter(LengthFactors.metersPerCentimeter, 'cm'),

  /// Millimeter (mm), equal to 0.001 meters.
  millimeter(LengthFactors.metersPerMillimeter, 'mm'),

  /// Micrometer (μm), equal to 1e-6 meters.
  micrometer(LengthFactors.metersPerMicrometer, 'μm'),

  /// Nanometer (nm), equal to 1e-9 meters.
  nanometer(LengthFactors.metersPerNanometer, 'nm'),

  /// Picometer (pm), equal to 1e-12 meters.
  picometer(LengthFactors.metersPerPicometer, 'pm'),

  /// Femtometer (fm), equal to 1e-15 meters.
  femtometer(LengthFactors.metersPerFemtometer, 'fm'),

  /// Inch (in), defined as exactly 0.0254 meters.
  inch(LengthFactors.metersPerInch, 'in'),

  /// Foot (ft), defined as exactly 0.3048 meters (12 inches).
  foot(LengthFactors.metersPerFoot, 'ft'),

  /// Yard (yd), defined as exactly 0.9144 meters (3 feet).
  yard(LengthFactors.metersPerYard, 'yd'),

  /// Mile (mi), defined as exactly 1609.344 meters (1760 yards).
  mile(LengthFactors.metersPerMile, 'mi'),

  /// Nautical Mile (nmi), internationally defined as 1852 meters.
  nauticalMile(LengthFactors.metersPerNauticalMile, 'nmi'),

  /// Astronomical Unit (AU), defined as exactly 149597870700 meters.
  astronomicalUnit(LengthFactors.metersPerAstronomicalUnit, 'AU'),

  /// Light Year (ly), the distance light travels in one Julian year.
  lightYear(LengthFactors.metersPerLightYear, 'ly'),

  /// Parsec (pc), approximately 3.26 light years.
  parsec(LengthFactors.metersPerParsec, 'pc'),

  /// Ångström (Å), equal to 1e-10 meters.
  angstrom(LengthFactors.metersPerAngstrom, 'Å');

  /// Constant constructor for enum members.
  ///
  /// [toBaseFactor] is the factor to convert from this unit to the base unit (Meter).
  /// For Meter itself, this is 1.0.
  /// [symbol] is the display symbol for the unit.
  ///
  /// The constructor pre-calculates all direct conversion factors
  /// from this unit to every other `LengthUnit`.
  /// The formula `factor_A_to_B = _toBaseFactor_A / _toBaseFactor_B` is used.
  const LengthUnit(double toBaseFactor, this.symbol)
      : _toMeterFactor = toBaseFactor,
        // Initialize direct factors from THIS unit to OTHERS.
        _factorToMeter = toBaseFactor / 1.0,
        _factorToKilometer = toBaseFactor / LengthFactors.metersPerKilometer,
        _factorToMegameter = toBaseFactor / LengthFactors.metersPerMegameter,
        _factorToGigameter = toBaseFactor / LengthFactors.metersPerGigameter,
        _factorToHectometer = toBaseFactor / LengthFactors.metersPerHectometer,
        _factorToDecameter = toBaseFactor / LengthFactors.metersPerDecameter,
        _factorToDecimeter = toBaseFactor / LengthFactors.metersPerDecimeter,
        _factorToCentimeter = toBaseFactor / LengthFactors.metersPerCentimeter,
        _factorToMillimeter = toBaseFactor / LengthFactors.metersPerMillimeter,
        _factorToMicrometer = toBaseFactor / LengthFactors.metersPerMicrometer,
        _factorToNanometer = toBaseFactor / LengthFactors.metersPerNanometer,
        _factorToPicometer = toBaseFactor / LengthFactors.metersPerPicometer,
        _factorToFemtometer = toBaseFactor / LengthFactors.metersPerFemtometer,
        _factorToInch = toBaseFactor / LengthFactors.metersPerInch,
        _factorToFoot = toBaseFactor / LengthFactors.metersPerFoot,
        _factorToYard = toBaseFactor / LengthFactors.metersPerYard,
        _factorToMile = toBaseFactor / LengthFactors.metersPerMile,
        _factorToNauticalMile = toBaseFactor / LengthFactors.metersPerNauticalMile,
        _factorToAstronomicalUnit = toBaseFactor / LengthFactors.metersPerAstronomicalUnit,
        _factorToLightYear = toBaseFactor / LengthFactors.metersPerLightYear,
        _factorToParsec = toBaseFactor / LengthFactors.metersPerParsec,
        _factorToAngstrom = toBaseFactor / LengthFactors.metersPerAngstrom;

  /// The factor to convert a value from this unit to the base unit (Meter).
  /// Example: For Kilometer, this is 1000.0 (meaning 1 km = 1000.0 m).
  // ignore: unused_field
  final double _toMeterFactor;

  /// The human-readable symbol for this length unit (e.g., "m", "km").
  @override
  final String symbol;

  // --- Pre-calculated direct conversion factors from this unit to all others ---
  final double _factorToMeter;
  final double _factorToKilometer;
  final double _factorToMegameter;
  final double _factorToGigameter;
  final double _factorToHectometer;
  final double _factorToDecameter;
  final double _factorToDecimeter;
  final double _factorToCentimeter;
  final double _factorToMillimeter;
  final double _factorToMicrometer;
  final double _factorToNanometer;
  final double _factorToPicometer;
  final double _factorToFemtometer;
  final double _factorToInch;
  final double _factorToFoot;
  final double _factorToYard;
  final double _factorToMile;
  final double _factorToNauticalMile;
  final double _factorToAstronomicalUnit;
  final double _factorToLightYear;
  final double _factorToParsec;
  final double _factorToAngstrom;

  /// Returns the direct conversion factor to convert a value from this [LengthUnit]
  /// to the [targetUnit].
  @override
  @internal
  double factorTo(LengthUnit targetUnit) {
    switch (targetUnit) {
      case LengthUnit.meter:
        return _factorToMeter;
      case LengthUnit.kilometer:
        return _factorToKilometer;
      case LengthUnit.megameter:
        return _factorToMegameter;
      case LengthUnit.gigameter:
        return _factorToGigameter;

      case LengthUnit.hectometer:
        return _factorToHectometer;
      case LengthUnit.decameter:
        return _factorToDecameter;
      case LengthUnit.decimeter:
        return _factorToDecimeter;
      case LengthUnit.centimeter:
        return _factorToCentimeter;
      case LengthUnit.millimeter:
        return _factorToMillimeter;
      case LengthUnit.micrometer:
        return _factorToMicrometer;
      case LengthUnit.nanometer:
        return _factorToNanometer;
      case LengthUnit.picometer:
        return _factorToPicometer;
      case LengthUnit.femtometer:
        return _factorToFemtometer;
      case LengthUnit.inch:
        return _factorToInch;
      case LengthUnit.foot:
        return _factorToFoot;
      case LengthUnit.yard:
        return _factorToYard;
      case LengthUnit.mile:
        return _factorToMile;
      case LengthUnit.nauticalMile:
        return _factorToNauticalMile;
      case LengthUnit.astronomicalUnit:
        return _factorToAstronomicalUnit;
      case LengthUnit.lightYear:
        return _factorToLightYear;
      case LengthUnit.parsec:
        return _factorToParsec;
      case LengthUnit.angstrom:
        return _factorToAngstrom;
    }
  }
}
