// ignore_for_file: prefer_int_literals // All constants are doubles for precision.

/// Defines base conversion factors for various torque units relative to the
/// Newton-meter (N·m), which is the SI derived unit for torque (kg·m²/s²).
///
/// These constants represent the value of `1 [Unit]` in Newton-meters.
/// For example, `newtonMetersPerPoundFoot` is the number of Newton-meters
/// in one pound-force-foot.
///
/// Note: Torque is dimensionally identical to energy (both have SI unit N·m),
/// but they are semantically distinct physical quantities. Torque represents
/// a rotational moment (force × moment arm), not stored or transferred energy.
class TorqueFactors {
  // --- SI Prefixed Units (relative to Newton-meter) ---

  /// Newton-meters per millinewton-meter: 1 mN·m = 0.001 N·m.
  static const double newtonMetersPerMillinewtonMeter = 0.001;

  /// Newton-meters per kilonewton-meter: 1 kN·m = 1,000 N·m.
  static const double newtonMetersPerKilonewtonMeter = 1000.0;

  /// Newton-meters per meganewton-meter: 1 MN·m = 1,000,000 N·m.
  static const double newtonMetersPerMeganewtonMeter = 1e6;

  // --- Imperial / US Customary Units ---

  /// Newton-meters per pound-force-foot (lbf·ft): 1 lbf·ft ≈ 1.3558179483314004 N·m.
  ///
  /// Derived from: 1 lbf = 4.4482216152605 N (exact, NIST) and 1 ft = 0.3048 m (exact).
  /// Therefore: 4.4482216152605 × 0.3048 = 1.3558179483314004 N·m.
  static const double newtonMetersPerPoundFoot = 1.3558179483314004;

  /// Newton-meters per pound-force-inch (lbf·in): 1 lbf·in ≈ 0.11298482902761670 N·m.
  ///
  /// Derived from: `newtonMetersPerPoundFoot / 12` (12 inches in a foot).
  static const double newtonMetersPerPoundInch = 0.11298482902761670;

  // --- Gravitational Metric Units ---

  /// Newton-meters per kilogram-force-meter (kgf·m): 1 kgf·m = 9.80665 N·m.
  ///
  /// Derived from: 1 kgf = 9.80665 N (standard acceleration of gravity, exact, ISO 80000-3).
  static const double newtonMetersPerKilogramForceMeter = 9.80665;

  /// Newton-meters per ounce-force-inch (ozf·in): 1 ozf·in ≈ 0.007061551814226044 N·m.
  ///
  /// Derived from: `newtonMetersPerPoundInch / 16` (16 ounces in a pound).
  static const double newtonMetersPerOunceForceInch = 0.007061551814226044;

  // --- CGS Units ---

  /// Newton-meters per dyne-centimeter (dyn·cm): 1 dyn·cm = 1 × 10⁻⁷ N·m.
  ///
  /// Derived from: 1 dyn = 1 × 10⁻⁵ N and 1 cm = 0.01 m.
  /// Therefore: 1 × 10⁻⁵ × 0.01 = 1 × 10⁻⁷ N·m.
  static const double newtonMetersPerDyneCentimeter = 1e-7;
}
