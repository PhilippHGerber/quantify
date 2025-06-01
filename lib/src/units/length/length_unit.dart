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

  /// Centimeter (cm), equal to 0.01 meters.
  centimeter(LengthFactors.metersPerCentimeter, 'cm'),

  /// Millimeter (mm), equal to 0.001 meters.
  millimeter(LengthFactors.metersPerMillimeter, 'mm'),

  /// Inch (in), defined as exactly 0.0254 meters.
  inch(LengthFactors.metersPerInch, 'in'),

  /// Foot (ft), defined as exactly 0.3048 meters (12 inches).
  foot(LengthFactors.metersPerFoot, 'ft'),

  /// Yard (yd), defined as exactly 0.9144 meters (3 feet).
  yard(LengthFactors.metersPerYard, 'yd'),

  /// Mile (mi), defined as exactly 1609.344 meters (1760 yards).
  mile(LengthFactors.metersPerMile, 'mi'),

  /// Nautical Mile (nmi), internationally defined as 1852 meters.
  nauticalMile(LengthFactors.metersPerNauticalMile, 'nmi');

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
        // factor_A_to_B = factor_A_to_Base / factor_B_to_Base
        // Here, Base is Meter. So, factor_A_to_Meter = _toMeterFactor_A / 1.0
        _factorToMeter = toBaseFactor / 1.0,
        _factorToKilometer = toBaseFactor / LengthFactors.metersPerKilometer,
        _factorToCentimeter = toBaseFactor / LengthFactors.metersPerCentimeter,
        _factorToMillimeter = toBaseFactor / LengthFactors.metersPerMillimeter,
        _factorToInch = toBaseFactor / LengthFactors.metersPerInch,
        _factorToFoot = toBaseFactor / LengthFactors.metersPerFoot,
        _factorToYard = toBaseFactor / LengthFactors.metersPerYard,
        _factorToMile = toBaseFactor / LengthFactors.metersPerMile,
        _factorToNauticalMile = toBaseFactor / LengthFactors.metersPerNauticalMile;

  /// The factor to convert a value from this unit to the base unit (Meter).
  /// Example: For Kilometer, this is 1000.0 (meaning 1 km = 1000.0 m).
  /// This field itself isn't directly used after constructor initialization
  /// as its value is baked into the specific _factorToXxx fields.
  /// It's kept for clarity of how the _factorToXxx fields are derived.
  // ignore: unused_field
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

  /// Returns the direct conversion factor to convert a value from this [LengthUnit]
  /// to the [targetUnit].
  @override
  @protected
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
