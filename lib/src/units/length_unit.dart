// lib/src/units/length_unit.dart

import '../constants/length_factors.dart'; // Internal constants
import '../core/unit.dart';

/// Represents units of length.
///
/// This enum implements the [Unit] interface to provide conversion capabilities
/// and a display [symbol] for each length unit.
/// All conversion factors are pre-calculated in the constructor relative to Meter.
enum LengthUnit implements Unit<LengthUnit> {
  /// Meter (m), the SI base unit of length.
  meter(1, 'm'),

  /// Kilometer (km), equal to 1000 meters.
  kilometer(LengthNist.metersPerKilometer, 'km'),

  /// Centimeter (cm), equal to 0.01 meters.
  centimeter(LengthNist.metersPerCentimeter, 'cm'),

  /// Millimeter (mm), equal to 0.001 meters.
  millimeter(LengthNist.metersPerMillimeter, 'mm'),

  /// Inch (in), defined as exactly 0.0254 meters.
  inch(LengthNist.metersPerInch, 'in'),

  /// Foot (ft), defined as exactly 0.3048 meters (12 inches).
  foot(LengthNist.metersPerFoot, 'ft'),

  /// Yard (yd), defined as exactly 0.9144 meters (3 feet).
  yard(LengthNist.metersPerYard, 'yd'),

  /// Mile (mi), defined as exactly 1609.344 meters (1760 yards).
  mile(LengthNist.metersPerMile, 'mi'),

  /// Nautical Mile (nmi), internationally defined as 1852 meters.
  nauticalMile(LengthNist.metersPerNauticalMile, 'nmi');

  /// The factor to convert a value from this unit to the base unit (Meter).
  /// For example, for Kilometer, this is 1000.0 (1 km = 1000 m).
  final double _toMeterFactor;

  /// The human-readable symbol for this length unit (e.g., "m", "km").
  @override
  final String symbol;

  // --- Pre-calculated direct conversion factors from this unit to all others ---
  // These are calculated once in the const constructor.

  final double _factorToMeter;
  final double _factorToKilometer;
  final double _factorToCentimeter;
  final double _factorToMillimeter;
  final double _factorToInch;
  final double _factorToFoot;
  final double _factorToYard;
  final double _factorToMile;
  final double _factorToNauticalMile;

  /// Constant constructor for enum members.
  ///
  /// [_toBaseFactor] is the factor to convert from this unit to the base unit (Meter).
  /// For Meter itself, this is 1.0.
  /// [sym] is the display symbol for the unit.
  ///
  /// The constructor pre-calculates all direct conversion factors
  /// from this unit to every other `LengthUnit`.
  /// The formula `factor_A_to_B = _toBaseFactor_A / _toBaseFactor_B` is used.
  const LengthUnit(this._toMeterFactor, this.symbol)
      // Initialize direct factors from THIS unit to OTHERS.
      // Example: factor from 'this' (e.g. Kilometer) to Meter:
      // this._toMeterFactor (1000.0 for km) / _LengthNist.metersPerMeter (which is 1.0)
      : _factorToMeter = _toMeterFactor / 1.0, // Meter's _toMeterFactor is 1.0
        _factorToKilometer = _toMeterFactor / LengthNist.metersPerKilometer,
        _factorToCentimeter = _toMeterFactor / LengthNist.metersPerCentimeter,
        _factorToMillimeter = _toMeterFactor / LengthNist.metersPerMillimeter,
        _factorToInch = _toMeterFactor / LengthNist.metersPerInch,
        _factorToFoot = _toMeterFactor / LengthNist.metersPerFoot,
        _factorToYard = _toMeterFactor / LengthNist.metersPerYard,
        _factorToMile = _toMeterFactor / LengthNist.metersPerMile,
        _factorToNauticalMile = _toMeterFactor / LengthNist.metersPerNauticalMile;

  /// Returns the direct conversion factor to convert a value from this [LengthUnit]
  /// to the [targetUnit].
  @override
  double factorTo(LengthUnit targetUnit) {
    switch (targetUnit) {
      case LengthUnit.meter:
        return _factorToMeter;
      case LengthUnit.kilometer:
        return _factorToKilometer;
      case LengthUnit.centimeter:
        return _factorToCentimeter;
      case LengthUnit.millimeter:
        return _factorToMillimeter;
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
    }
  }
}
