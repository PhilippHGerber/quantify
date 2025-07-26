// ignore_for_file: prefer_int_literals // All constants are doubles for precision.

/// Defines base conversion factors for various power units relative to the
/// Watt (W), which is the SI derived unit for power (J/s).
///
/// These constants represent the value of `1 [Unit]` in Watts.
class PowerFactors {
  // --- SI Prefixed Units (relative to Watt) ---

  /// Watts per Gigawatt: 1 GW = 1,000,000,000 W.
  static const double wattsPerGigawatt = 1e9;

  /// Watts per Megawatt: 1 MW = 1,000,000 W.
  static const double wattsPerMegawatt = 1e6;

  /// Watts per Kilowatt: 1 kW = 1,000 W.
  static const double wattsPerKilowatt = 1000.0;

  /// Watts per Milliwatt: 1 mW = 0.001 W.
  static const double wattsPerMilliwatt = 0.001;

  // --- CGS Units ---

  /// Watts per Erg per second: 1 erg/s = 10⁻⁷ W.
  /// The erg is the CGS unit of energy, so 1 erg/s is the CGS unit of power.
  static const double wattsPerErgPerSecond = 1e-7;

  // --- Common and Engineering Units ---

  /// Watts per mechanical Horsepower (hp): 1 hp = 745.69987158227022 W.
  /// This is the exact definition of mechanical horsepower, equivalent to
  /// 550 ft⋅lbf/s. It is commonly used for rating engines and motors.
  static const double wattsPerHorsepower = 745.69987158227022;

  /// Watts per metric Horsepower (PS): 1 PS = 735.49875 W.
  /// This is defined as the power to raise 75 kilograms by 1 meter in 1 second
  /// under standard gravity (75 kgf·m/s).
  static const double wattsPerMetricHorsepower = 735.49875;

  /// Watts per British Thermal Unit per hour (Btu/h): 1 Btu/h ≈ 0.293071 W.
  /// Based on the International Table Btu (1055.056 J) divided by 3600 seconds.
  /// Commonly used in the HVAC and heating/cooling industries.
  static const double wattsPerBtuPerHour = 1055.056 / 3600.0;
}
