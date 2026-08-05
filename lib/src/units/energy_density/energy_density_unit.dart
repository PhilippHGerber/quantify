import 'package:meta/meta.dart';

import '../../core/unit.dart';
import 'energy_density_factors.dart';

/// Represents units of energy density.
///
/// This enum implements the [LinearUnit] interface to provide conversion capabilities
/// and a display [symbol] for each energy density unit.
/// All conversion factors are pre-calculated in the constructor relative to
/// Joule per Cubic Meter (J/m³).
enum EnergyDensityUnit implements LinearUnit<EnergyDensityUnit> {
  /// Joule per Cubic Meter (J/m³), the SI derived unit of energy density.
  joulePerCubicMeter(EnergyDensityFactors.joulePerCubicMeter, 'J/m³'),

  /// Joule per Liter (J/L), a common unit for energy density of fuels and batteries.
  joulePerLiter(EnergyDensityFactors.joulePerLiter, 'J/L'),

  /// Watt-hour per Liter (Wh/L), commonly used for battery energy density.
  wattHourPerLiter(EnergyDensityFactors.wattHourPerLiter, 'Wh/L');

  /// Constant constructor for enum members.
  const EnergyDensityUnit(double toJPerM3Factor, this.symbol)
      : _toJPerM3Factor = toJPerM3Factor,
        _factorToJoulePerCubicMeter = toJPerM3Factor / 1.0,
        _factorToJoulePerLiter = toJPerM3Factor / EnergyDensityFactors.joulePerLiter,
        _factorToWattHourPerLiter = toJPerM3Factor / EnergyDensityFactors.wattHourPerLiter;

  /// SI and unit symbols matched **strictly case-sensitive**.
  static const Map<String, EnergyDensityUnit> symbolAliases = {
    'J/m³': joulePerCubicMeter,
    'J/L': joulePerLiter,
    'Wh/L': wattHourPerLiter,
    'J/l': joulePerLiter,
    'Wh/l': wattHourPerLiter,
  };

  /// Full word-form names and non-SI abbreviations matched **case-insensitively**.
  static const Map<String, EnergyDensityUnit> nameAliases = {
    'joule per cubic meter': joulePerCubicMeter,
    'joule per cubic metre': joulePerCubicMeter,
    'joulepercubicmeter': joulePerCubicMeter,
    'j per m3': joulePerCubicMeter,
    'jperm3': joulePerCubicMeter,
    'joule per liter': joulePerLiter,
    'joule per litre': joulePerLiter,
    'jouleperliter': joulePerLiter,
    'j per l': joulePerLiter,
    'jperl': joulePerLiter,
    'watt hour per liter': wattHourPerLiter,
    'watt hour per litre': wattHourPerLiter,
    'watthourperliter': wattHourPerLiter,
    'wh per l': wattHourPerLiter,
    'whperl': wattHourPerLiter,
  };

  // ignore: unused_field // Used to store the conversion factor to J/m³.
  final double _toJPerM3Factor;

  @override
  final String symbol;

  /// Returns `true` only for [joulePerCubicMeter], the SI derived unit of energy density.
  @override
  bool get isSI => this == EnergyDensityUnit.joulePerCubicMeter;

  /// Returns `true` only for [joulePerCubicMeter], the coherent SI derived
  /// unit; `false` for [joulePerLiter] and [wattHourPerLiter] (contain the
  /// litre and/or the hour, which are accepted for use with the SI but are
  /// not metric).
  @override
  bool get isMetric => this == EnergyDensityUnit.joulePerCubicMeter;

  // --- Pre-calculated direct conversion factors ---
  final double _factorToJoulePerCubicMeter;
  final double _factorToJoulePerLiter;
  final double _factorToWattHourPerLiter;

  @override
  @internal
  double factorTo(EnergyDensityUnit targetUnit) {
    switch (targetUnit) {
      case EnergyDensityUnit.joulePerCubicMeter:
        return _factorToJoulePerCubicMeter;
      case EnergyDensityUnit.joulePerLiter:
        return _factorToJoulePerLiter;
      case EnergyDensityUnit.wattHourPerLiter:
        return _factorToWattHourPerLiter;
    }
  }
}
