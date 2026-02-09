// ignore_for_file: prefer_int_literals // All constants are doubles for precision.

/// Defines base conversion factors for various pressure units relative to Pascal (Pa).
///
/// These constants are based on international standards (e.g., NIST) where available.
/// The base unit for internal calculations is Pascal.
/// Factors represent: 1 Unit = X Pascals.
/// All water column units (cmH₂O, inH₂O) refer to a water temperature of 4°C (39.2°F)
/// unless otherwise specified, aligning with common scientific reference points for water density
/// and conventional values (e.g., NIST SP 811).
class PressureFactors {
  /// Pascals per Standard Atmosphere (atm): 1 atm = 101325 Pa (exact definition).
  static const double pascalsPerAtmosphere = 101325.0;

  /// Pascals per Bar (bar): 1 bar = 100000 Pa (exact definition).
  static const double pascalsPerBar = 100000.0;

  /// Pascals per Pound per Square Inch (psi): 1 psi ≈ 6894.757293168361 Pa.
  /// Derived from the international yard and pound agreement:
  /// 1 pound-force (lbf) ≈ 4.4482216152605 N and 1 inch = 0.0254 m.
  static const double pascalsPerPsi = 6894.757293168361;

  /// Pascals per Torr (Torr): 1 Torr ≈ 133.322368421 Pa.
  /// Defined as 1/760 of a standard atmosphere. Mercury at 0°C.
  static const double pascalsPerTorr = pascalsPerAtmosphere / 760.0;

  /// Pascals per Millimeter of Mercury (mmHg) at 0°C.
  /// 1 mmHg (at 0°C) = 133.322 387 415 Pa (NIST SP 811 conventional value).
  /// Note: mmHg differs slightly from Torr (101325/760 Pa) because mmHg is
  /// based on the actual density of mercury at 0°C under standard gravity,
  /// whereas Torr is defined as exactly 1/760 of a standard atmosphere.
  static const double pascalsPerMillimeterOfMercury = 133.322387415;

  /// Pascals per Inch of Mercury (inHg) at 0°C: 1 inHg ≈ 3386.388687636 Pa.
  /// Defined as `pascalsPerMillimeterOfMercury * 25.4` (since 1 inch = 25.4 mm).
  /// Conventional value often cited from NIST SP 811 is 3386.389 Pa.
  /// The calculated value is (101325.0 / 760.0) * 25.4 = 3386.3886876315788
  static const double pascalsPerInchOfMercury = pascalsPerMillimeterOfMercury * 25.4;
  // For reference, NIST SP 811 Appendix B.8 lists:
  // Inch of mercury (0 °C)  = 3.386 389 E+03 Pa
  // The calculated value is extremely close and based on fundamental definitions.
  // Using the calculated one for consistency, the difference is negligible for doubles.

  /// Pascals per Megapascal (MPa): 1 MPa = 1,000,000 Pa.
  static const double pascalsPerMegapascal = 1000000.0;

  /// Pascals per Kilopascal (kPa): 1 kPa = 1000 Pa.
  static const double pascalsPerKilopascal = 1000.0;

  /// Pascals per Hectopascal (hPa): 1 hPa = 100 Pa.
  static const double pascalsPerHectopascal = 100.0;

  /// Pascals per Millibar (mbar): 1 mbar = 100 Pa (same as hPa).
  static const double pascalsPerMillibar = 100.0;

  /// Conventional value for Pascals per Centimeter of Water (cmH₂O) at 4°C.
  /// 1 cmH₂O (at 4°C) = 98.0665 Pa.
  /// This value is commonly cited, e.g., in NIST SP 811, based on a conventional
  /// standard gravity (gₙ = 9.80665 m/s²) and water density of 1000 kg/m³ at 4°C.
  static const double conventionalPascalsPerCentimeterOfWater4C = 98.0665;

  /// Conventional value for Pascals per Inch of Water (inH₂O) at 4°C.
  /// 1 inH₂O (at 4°C) = 249.08891 Pa.
  /// This value is commonly cited, e.g., in NIST SP 811, and is derived from
  /// `conventionalPascalsPerCentimeterOfWater4C * 2.54` (since 1 inch = 2.54 cm).
  static const double conventionalPascalsPerInchOfWater4C = 249.08891;
}
