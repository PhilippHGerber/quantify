// ignore_for_file: prefer_int_literals // All constants are doubles for precision.

/// Defines base conversion factors for various force units relative to the
/// Newton (N), which is the SI derived unit for force (kg·m/s²).
///
/// These constants represent: `1 [Unit] = Z [Newtons]`.
class ForceFactors {
  /// Newtons per Kilonewton (kN): 1 kN = 1000 N.
  static const double newtonsPerKilonewton = 1000.0;

  /// Newtons per Meganewton (MN): 1 MN = 1,000,000 N.
  static const double newtonsPerMeganewton = 1e6;

  /// Newtons per Millinewton (mN): 1 mN = 0.001 N.
  static const double newtonsPerMillinewton = 0.001;

  /// Newtons per Pound-force (lbf): 1 lbf = 0.45359237 kg * 9.80665 m/s².
  /// This is based on the standard weight of one pound of mass.
  static const double newtonsPerPoundForce = 4.4482216152605;

  /// Newtons per Dyne (dyn): 1 dyn = 1 g·cm/s² = 10⁻³ kg · 10⁻² m/s² = 10⁻⁵ N.
  /// This is the CGS unit of force.
  static const double newtonsPerDyne = 1e-5;

  /// Newtons per Kilogram-force (kgf) or Kilopond (kp): 1 kgf = 9.80665 N.
  /// This is the force exerted by one kilogram of mass in standard gravity.
  static const double newtonsPerKilogramForce = 9.80665;

  /// Newtons per Gram-force (gf): 1 gf = 0.00980665 N.
  /// The force exerted by one gram of mass in standard gravity.
  static const double newtonsPerGramForce = 0.00980665;

  /// Newtons per Poundal (pdl): 1 pdl ≈ 0.138255 N.
  /// The force required to accelerate 1 pound-mass by 1 ft/s².
  /// Defined as `0.45359237 kg * 0.3048 m/s²`.
  static const double newtonsPerPoundal = 0.138254954376;
}
