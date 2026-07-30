import 'package:meta/meta.dart';

import '../../core/unit.dart';
import 'volumetric_flow_rate_factors.dart';

/// Represents units of volumetric flow rate.
///
/// This enum implements the [LinearUnit] interface to provide conversion capabilities
/// and a display [symbol] for each volumetric flow rate unit.
/// All conversion factors are pre-calculated in the constructor relative to
/// Cubic Meter per Second (m³/s).
enum VolumetricFlowRateUnit implements LinearUnit<VolumetricFlowRateUnit> {
  /// Cubic meter per second (m³/s), the SI derived unit of volumetric flow rate.
  cubicMeterPerSecond(1, 'm³/s'),

  /// Cubic meter per minute (m³/min), commonly used in HVAC and industrial contexts.
  cubicMeterPerMinute(VolumetricFlowRateFactors.cmpsPerCmpm, 'm³/min'),

  /// Cubic meter per hour (m³/h), commonly used for pumps and industrial flow meters.
  cubicMeterPerHour(VolumetricFlowRateFactors.cmpsPerCmph, 'm³/h'),

  /// Liter per second (L/s), commonly used for water flow and small pumps.
  literPerSecond(VolumetricFlowRateFactors.cmpsPerLps, 'L/s'),

  /// Liter per minute (L/min), commonly used for household appliances and medical dosing.
  literPerMinute(VolumetricFlowRateFactors.cmpsPerLpm, 'L/min'),

  /// Liter per hour (L/h), commonly used for medical infusion rates and irrigation.
  literPerHour(VolumetricFlowRateFactors.cmpsPerLph, 'L/h'),

  /// Milliliter per minute (mL/min), commonly used for medical infusion pumps.
  milliliterPerMinute(VolumetricFlowRateFactors.cmpsPerMlpm, 'mL/min'),

  /// Cubic foot per second (ft³/s, CFS), commonly used in hydrology and civil engineering.
  cubicFootPerSecond(VolumetricFlowRateFactors.cmpsPerCfs, 'ft³/s'),

  /// Cubic foot per minute (ft³/min, CFM), commonly used for HVAC airflow.
  cubicFootPerMinute(VolumetricFlowRateFactors.cmpsPerCfm, 'ft³/min'),

  /// US Gallon per minute (gal/min, GPM), commonly used for pumps in the US.
  gallonPerMinute(VolumetricFlowRateFactors.cmpsPerGpm, 'gal/min'),

  /// US Gallon per hour (gal/h, GPH), commonly used for smaller flow rates in the US.
  gallonPerHour(VolumetricFlowRateFactors.cmpsPerGph, 'gal/h');

  /// Constant constructor for enum members.
  ///
  /// [_toCmpsFactor] is the factor to convert from this unit to the base unit
  /// (Cubic Meter per Second). [symbol] is the display symbol for the unit.
  ///
  /// The constructor pre-calculates all direct conversion factors
  /// from this unit to every other `VolumetricFlowRateUnit`.
  const VolumetricFlowRateUnit(double toCmpsFactor, this.symbol)
      : _toCmpsFactor = toCmpsFactor,
        _factorToCubicMeterPerSecond = toCmpsFactor / 1.0,
        _factorToCubicMeterPerMinute = toCmpsFactor / VolumetricFlowRateFactors.cmpsPerCmpm,
        _factorToCubicMeterPerHour = toCmpsFactor / VolumetricFlowRateFactors.cmpsPerCmph,
        _factorToLiterPerSecond = toCmpsFactor / VolumetricFlowRateFactors.cmpsPerLps,
        _factorToLiterPerMinute = toCmpsFactor / VolumetricFlowRateFactors.cmpsPerLpm,
        _factorToLiterPerHour = toCmpsFactor / VolumetricFlowRateFactors.cmpsPerLph,
        _factorToMilliliterPerMinute = toCmpsFactor / VolumetricFlowRateFactors.cmpsPerMlpm,
        _factorToCubicFootPerSecond = toCmpsFactor / VolumetricFlowRateFactors.cmpsPerCfs,
        _factorToCubicFootPerMinute = toCmpsFactor / VolumetricFlowRateFactors.cmpsPerCfm,
        _factorToGallonPerMinute = toCmpsFactor / VolumetricFlowRateFactors.cmpsPerGpm,
        _factorToGallonPerHour = toCmpsFactor / VolumetricFlowRateFactors.cmpsPerGph;

  // ignore: unused_field // Used to store the conversion factor to Cubic Meter per Second (m³/s).
  final double _toCmpsFactor;

  @override
  final String symbol;

  /// Returns `true` only for [cubicMeterPerSecond], the SI derived unit of volumetric flow rate.
  @override
  bool get isSI => this == VolumetricFlowRateUnit.cubicMeterPerSecond;

  /// Returns `true` only for [cubicMeterPerSecond], the coherent SI derived
  /// unit; `false` for the imperial/US customary units, for
  /// [cubicMeterPerMinute] and [cubicMeterPerHour] (contain the non-metric
  /// minute/hour), and for all litre-based units ([literPerSecond],
  /// [literPerMinute], [literPerHour], [milliliterPerMinute] — the litre is
  /// accepted for use with the SI but is not metric).
  @override
  bool get isMetric => this == VolumetricFlowRateUnit.cubicMeterPerSecond;

  // --- Pre-calculated direct conversion factors from this unit to all others ---
  final double _factorToCubicMeterPerSecond;
  final double _factorToCubicMeterPerMinute;
  final double _factorToCubicMeterPerHour;
  final double _factorToLiterPerSecond;
  final double _factorToLiterPerMinute;
  final double _factorToLiterPerHour;
  final double _factorToMilliliterPerMinute;
  final double _factorToCubicFootPerSecond;
  final double _factorToCubicFootPerMinute;
  final double _factorToGallonPerMinute;
  final double _factorToGallonPerHour;

  /// Returns the direct conversion factor to convert a value from this
  /// [VolumetricFlowRateUnit] to the [targetUnit].
  @override
  @internal
  double factorTo(VolumetricFlowRateUnit targetUnit) {
    switch (targetUnit) {
      case VolumetricFlowRateUnit.cubicMeterPerSecond:
        return _factorToCubicMeterPerSecond;
      case VolumetricFlowRateUnit.cubicMeterPerMinute:
        return _factorToCubicMeterPerMinute;
      case VolumetricFlowRateUnit.cubicMeterPerHour:
        return _factorToCubicMeterPerHour;
      case VolumetricFlowRateUnit.literPerSecond:
        return _factorToLiterPerSecond;
      case VolumetricFlowRateUnit.literPerMinute:
        return _factorToLiterPerMinute;
      case VolumetricFlowRateUnit.literPerHour:
        return _factorToLiterPerHour;
      case VolumetricFlowRateUnit.milliliterPerMinute:
        return _factorToMilliliterPerMinute;
      case VolumetricFlowRateUnit.cubicFootPerSecond:
        return _factorToCubicFootPerSecond;
      case VolumetricFlowRateUnit.cubicFootPerMinute:
        return _factorToCubicFootPerMinute;
      case VolumetricFlowRateUnit.gallonPerMinute:
        return _factorToGallonPerMinute;
      case VolumetricFlowRateUnit.gallonPerHour:
        return _factorToGallonPerHour;
    }
  }

  /// Case-sensitive symbol aliases for parsing.
  ///
  /// Symbols with slashes (like `m³/s`, `L/min`) are included alongside
  /// ASCII fallbacks (`m3/s`) and common abbreviations (`cfm`, `gpm`).
  static const symbolAliases = <String, VolumetricFlowRateUnit>{
    'm³/s': VolumetricFlowRateUnit.cubicMeterPerSecond,
    'm3/s': VolumetricFlowRateUnit.cubicMeterPerSecond,
    'm³/min': VolumetricFlowRateUnit.cubicMeterPerMinute,
    'm3/min': VolumetricFlowRateUnit.cubicMeterPerMinute,
    'm³/h': VolumetricFlowRateUnit.cubicMeterPerHour,
    'm3/h': VolumetricFlowRateUnit.cubicMeterPerHour,
    'L/s': VolumetricFlowRateUnit.literPerSecond,
    'l/s': VolumetricFlowRateUnit.literPerSecond,
    'L/min': VolumetricFlowRateUnit.literPerMinute,
    'l/min': VolumetricFlowRateUnit.literPerMinute,
    'L/h': VolumetricFlowRateUnit.literPerHour,
    'l/h': VolumetricFlowRateUnit.literPerHour,
    'mL/min': VolumetricFlowRateUnit.milliliterPerMinute,
    'ml/min': VolumetricFlowRateUnit.milliliterPerMinute,
    'ft³/s': VolumetricFlowRateUnit.cubicFootPerSecond,
    'ft3/s': VolumetricFlowRateUnit.cubicFootPerSecond,
    'cfs': VolumetricFlowRateUnit.cubicFootPerSecond,
    'ft³/min': VolumetricFlowRateUnit.cubicFootPerMinute,
    'ft3/min': VolumetricFlowRateUnit.cubicFootPerMinute,
    'cfm': VolumetricFlowRateUnit.cubicFootPerMinute,
    'gal/min': VolumetricFlowRateUnit.gallonPerMinute,
    'gpm': VolumetricFlowRateUnit.gallonPerMinute,
    'gal/h': VolumetricFlowRateUnit.gallonPerHour,
    'gph': VolumetricFlowRateUnit.gallonPerHour,
  };

  /// Case-insensitive name aliases for parsing (all lowercase).
  ///
  /// Includes singular, plural, and regional spelling variants.
  static const nameAliases = <String, VolumetricFlowRateUnit>{
    'cubic meter per second': VolumetricFlowRateUnit.cubicMeterPerSecond,
    'cubic meters per second': VolumetricFlowRateUnit.cubicMeterPerSecond,
    'cubic metre per second': VolumetricFlowRateUnit.cubicMeterPerSecond,
    'cubic metres per second': VolumetricFlowRateUnit.cubicMeterPerSecond,
    'cubic meter per minute': VolumetricFlowRateUnit.cubicMeterPerMinute,
    'cubic meters per minute': VolumetricFlowRateUnit.cubicMeterPerMinute,
    'cubic metre per minute': VolumetricFlowRateUnit.cubicMeterPerMinute,
    'cubic metres per minute': VolumetricFlowRateUnit.cubicMeterPerMinute,
    'cubic meter per hour': VolumetricFlowRateUnit.cubicMeterPerHour,
    'cubic meters per hour': VolumetricFlowRateUnit.cubicMeterPerHour,
    'cubic metre per hour': VolumetricFlowRateUnit.cubicMeterPerHour,
    'cubic metres per hour': VolumetricFlowRateUnit.cubicMeterPerHour,
    'liter per second': VolumetricFlowRateUnit.literPerSecond,
    'liters per second': VolumetricFlowRateUnit.literPerSecond,
    'litre per second': VolumetricFlowRateUnit.literPerSecond,
    'litres per second': VolumetricFlowRateUnit.literPerSecond,
    'liter per minute': VolumetricFlowRateUnit.literPerMinute,
    'liters per minute': VolumetricFlowRateUnit.literPerMinute,
    'litre per minute': VolumetricFlowRateUnit.literPerMinute,
    'litres per minute': VolumetricFlowRateUnit.literPerMinute,
    'liter per hour': VolumetricFlowRateUnit.literPerHour,
    'liters per hour': VolumetricFlowRateUnit.literPerHour,
    'litre per hour': VolumetricFlowRateUnit.literPerHour,
    'litres per hour': VolumetricFlowRateUnit.literPerHour,
    'milliliter per minute': VolumetricFlowRateUnit.milliliterPerMinute,
    'milliliters per minute': VolumetricFlowRateUnit.milliliterPerMinute,
    'millilitre per minute': VolumetricFlowRateUnit.milliliterPerMinute,
    'millilitres per minute': VolumetricFlowRateUnit.milliliterPerMinute,
    'cubic foot per second': VolumetricFlowRateUnit.cubicFootPerSecond,
    'cubic feet per second': VolumetricFlowRateUnit.cubicFootPerSecond,
    'cfs': VolumetricFlowRateUnit.cubicFootPerSecond,
    'cubic foot per minute': VolumetricFlowRateUnit.cubicFootPerMinute,
    'cubic feet per minute': VolumetricFlowRateUnit.cubicFootPerMinute,
    'cfm': VolumetricFlowRateUnit.cubicFootPerMinute,
    'gallon per minute': VolumetricFlowRateUnit.gallonPerMinute,
    'gallons per minute': VolumetricFlowRateUnit.gallonPerMinute,
    'gpm': VolumetricFlowRateUnit.gallonPerMinute,
    'gallon per hour': VolumetricFlowRateUnit.gallonPerHour,
    'gallons per hour': VolumetricFlowRateUnit.gallonPerHour,
    'gph': VolumetricFlowRateUnit.gallonPerHour,
  };
}
