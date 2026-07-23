/// Defines base conversion factors for various volumetric flow rate units
/// relative to the Cubic Meter per Second (m³/s), which is the SI derived
/// unit for volumetric flow rate.
///
/// These constants represent: `1 [Unit] = Z [Cubic Meters per Second]`.
/// So, `cmpsPerLpm` means `1 liter per minute = cmpsPerLpm cubic meters per second`.
class VolumetricFlowRateFactors {
  /// Cubic meters per second per Cubic meter per minute: 1 m³/min = 1/60 m³/s.
  static const double cmpsPerCmpm = 1.0 / 60.0;

  /// Cubic meters per second per Cubic meter per hour: 1 m³/h = 1/3600 m³/s.
  static const double cmpsPerCmph = 1.0 / 3600.0;

  /// Cubic meters per second per Liter per second: 1 L/s = 0.001 m³/s.
  static const double cmpsPerLps = 0.001;

  /// Cubic meters per second per Liter per minute: 1 L/min = 0.001/60 m³/s.
  static const double cmpsPerLpm = cmpsPerLps / 60.0;

  /// Cubic meters per second per Liter per hour: 1 L/h = 0.001/3600 m³/s.
  static const double cmpsPerLph = cmpsPerLps / 3600.0;

  /// Cubic meters per second per Milliliter per minute: 1 mL/min = 1e-6/60 m³/s.
  static const double cmpsPerMlpm = 1.0e-6 / 60.0;

  /// Cubic meters per second per Cubic foot per second: 1 ft³/s = 0.028316846592 m³/s.
  /// (based on the exact definition of a foot in meters: 1 ft³ = 28,316,846.592 mm³).
  static const double cmpsPerCfs = 0.028316846592;

  /// Cubic meters per second per Cubic foot per minute: 1 ft³/min = 0.028316846592/60 m³/s.
  static const double cmpsPerCfm = cmpsPerCfs / 60.0;

  /// Cubic meters per second per US Gallon per minute: 1 gal/min = 0.003785411784/60 m³/s.
  /// (based on the exact definition of a US liquid gallon: 1 gal = 3,785,411.784 mm³).
  static const double cmpsPerGpm = 0.003785411784 / 60.0;

  /// Cubic meters per second per US Gallon per hour: 1 gal/h = 0.003785411784/3600 m³/s.
  static const double cmpsPerGph = 0.003785411784 / 3600.0;
}
