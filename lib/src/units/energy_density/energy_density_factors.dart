/// Defines base conversion factors for various energy density units relative to
/// the Joule per Cubic Meter (J/m³), which is the SI derived unit for energy
/// density.
///
/// These constants represent: `1 [Unit] = Z [Joules Per Cubic Meter]`.
class EnergyDensityFactors {
  /// Joules per Cubic Meter: 1 J/m³ = 1.0 J/m³.
  static const double joulePerCubicMeter = 1;

  /// Joules per Liter: 1 J/L = 1000 J/m³ (since 1 L = 0.001 m³).
  static const double joulePerLiter = 1000;

  /// Watt-hours per Liter: 1 Wh/L = 3,600,000 J/m³
  /// (since 1 Wh = 3600 J and 1 L = 0.001 m³, so 1 Wh/L = 3600 J / 0.001 m³).
  static const double wattHourPerLiter = 3600000;
}
