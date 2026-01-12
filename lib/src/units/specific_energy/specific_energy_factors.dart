/// Defines base conversion factors for various specific energy units relative to the
/// Joule per Kilogram (J/kg), which is the SI derived unit for specific energy.
///
/// These constants represent: `1 [Unit] = Z [Joules Per Kilogram]`.
class SpecificEnergyFactors {
  /// Joules per Kilogram: 1 J/kg = 1.0 J/kg.
  static const double joulePerKilogram = 1;

  /// Kilojoules per Kilogram: 1 kJ/kg = 1000.0 J/kg.
  static const double kilojoulePerKilogram = 1000;

  /// Watt-hours per Kilogram: 1 Wh/kg = 3600.0 J/kg.
  static const double wattHourPerKilogram = 3600;

  /// Kilowatt-hours per Kilogram: 1 kWh/kg = 3,600,000.0 J/kg.
  static const double kilowattHourPerKilogram = 3600000;
}
