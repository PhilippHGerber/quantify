import 'energy_density.dart';
import 'energy_density_unit.dart';

/// Provides convenient access to [EnergyDensity] values in specific units.
extension EnergyDensityValueGetters on EnergyDensity {
  /// Returns the energy density value in Joules per Cubic Meter (J/m³).
  double get inJoulesPerCubicMeter => getValue(EnergyDensityUnit.joulePerCubicMeter);

  /// Returns the energy density value in Joules per Liter (J/L).
  double get inJoulesPerLiter => getValue(EnergyDensityUnit.joulePerLiter);

  /// Returns the energy density value in Watt-hours per Liter (Wh/L).
  double get inWattHoursPerLiter => getValue(EnergyDensityUnit.wattHourPerLiter);

  /// Returns a new [EnergyDensity] object representing this energy density in
  /// Joules per Cubic Meter (J/m³).
  EnergyDensity get asJoulesPerCubicMeter => convertTo(EnergyDensityUnit.joulePerCubicMeter);

  /// Returns a new [EnergyDensity] object representing this energy density in
  /// Joules per Liter (J/L).
  EnergyDensity get asJoulesPerLiter => convertTo(EnergyDensityUnit.joulePerLiter);

  /// Returns a new [EnergyDensity] object representing this energy density in
  /// Watt-hours per Liter (Wh/L).
  EnergyDensity get asWattHoursPerLiter => convertTo(EnergyDensityUnit.wattHourPerLiter);
}

/// Provides convenient factory methods for creating [EnergyDensity] instances from [num].
extension EnergyDensityCreation on num {
  /// Creates an [EnergyDensity] instance from this value in Joules per Cubic Meter (J/m³).
  EnergyDensity get joulesPerCubicMeter =>
      EnergyDensity(toDouble(), EnergyDensityUnit.joulePerCubicMeter);

  /// Creates an [EnergyDensity] instance from this value in Joules per Liter (J/L).
  EnergyDensity get joulesPerLiter => EnergyDensity(toDouble(), EnergyDensityUnit.joulePerLiter);

  /// Creates an [EnergyDensity] instance from this value in Watt-hours per Liter (Wh/L).
  EnergyDensity get wattHoursPerLiter =>
      EnergyDensity(toDouble(), EnergyDensityUnit.wattHourPerLiter);
}
