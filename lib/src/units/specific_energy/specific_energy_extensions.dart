import 'specific_energy.dart';
import 'specific_energy_unit.dart';

/// Provides convenient access to [SpecificEnergy] values in specific units.
extension SpecificEnergyValueGetters on SpecificEnergy {
  /// Returns the value in Joules per Kilogram (J/kg).
  double get inJoulesPerKilogram => getValue(SpecificEnergyUnit.joulePerKilogram);

  /// Returns the value in Kilojoules per Kilogram (kJ/kg).
  double get inKilojoulesPerKilogram => getValue(SpecificEnergyUnit.kilojoulePerKilogram);

  /// Returns the value in Watt-hours per Kilogram (Wh/kg).
  double get inWattHoursPerKilogram => getValue(SpecificEnergyUnit.wattHourPerKilogram);

  /// Returns the value in Kilowatt-hours per Kilogram (kWh/kg).
  double get inKilowattHoursPerKilogram => getValue(SpecificEnergyUnit.kilowattHourPerKilogram);

  /// Returns a new [SpecificEnergy] object in Joules per Kilogram (J/kg).
  SpecificEnergy get asJoulesPerKilogram => convertTo(SpecificEnergyUnit.joulePerKilogram);

  /// Returns a new [SpecificEnergy] object in Kilojoules per Kilogram (kJ/kg).
  SpecificEnergy get asKilojoulesPerKilogram => convertTo(SpecificEnergyUnit.kilojoulePerKilogram);

  /// Returns a new [SpecificEnergy] object in Watt-hours per Kilogram (Wh/kg).
  SpecificEnergy get asWattHoursPerKilogram => convertTo(SpecificEnergyUnit.wattHourPerKilogram);

  /// Returns a new [SpecificEnergy] object in Kilowatt-hours per Kilogram (kWh/kg).
  SpecificEnergy get asKilowattHoursPerKilogram =>
      convertTo(SpecificEnergyUnit.kilowattHourPerKilogram);
}

/// Provides convenient factory methods for creating [SpecificEnergy] instances from [num].
extension SpecificEnergyCreation on num {
  /// Creates a [SpecificEnergy] instance from this value in Joules per Kilogram (J/kg).
  SpecificEnergy get jPerKg => SpecificEnergy(toDouble(), SpecificEnergyUnit.joulePerKilogram);

  /// Creates a [SpecificEnergy] instance from this value in Kilojoules per Kilogram (kJ/kg).
  SpecificEnergy get kJPerKg => SpecificEnergy(toDouble(), SpecificEnergyUnit.kilojoulePerKilogram);

  /// Creates a [SpecificEnergy] instance from this value in Watt-hours per Kilogram (Wh/kg).
  SpecificEnergy get whPerKg => SpecificEnergy(toDouble(), SpecificEnergyUnit.wattHourPerKilogram);

  /// Creates a [SpecificEnergy] instance from this value in Kilowatt-hours per Kilogram (kWh/kg).
  SpecificEnergy get kWhPerKg =>
      SpecificEnergy(toDouble(), SpecificEnergyUnit.kilowattHourPerKilogram);
}
