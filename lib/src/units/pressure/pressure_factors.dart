// ignore_for_file: prefer_int_literals : all constants are doubles.

import '../../../quantify.dart' show Unit;
import '../../core/unit.dart' show Unit;

/// Defines base conversion factors for various pressure units relative to Pascal (Pa).
///
/// These constants are based on international standards (e.g., NIST) where available.
/// The base unit for internal calculations is Pascal.
/// Factors represent: 1 [Unit] = X Pascals
class PressureFactors {
  /// Pascals per Atmosphere (standard atmosphere): 1 atm = 101325 Pa (exact definition).
  static const double pascalsPerAtmosphere = 101325.0;

  /// Pascals per Bar: 1 bar = 100000 Pa (exact definition).
  static const double pascalsPerBar = 100000.0;

  /// Pascals per Pound per Square Inch (PSI): 1 psi ≈ 6894.757293168361 Pa.
  /// Derived from 1 lbf = 4.4482216152605 N and 1 inch = 0.0254 m.
  static const double pascalsPerPsi = 6894.757293168361;

  /// Pascals per Torr (millimeter of mercury at 0°C): 1 Torr ≈ 133.322368421 Pa.
  /// Defined as 1/760 of a standard atmosphere.
  static const double pascalsPerTorr = pascalsPerAtmosphere / 760.0;

  /// Pascals per Millimeter of Mercury (mmHg at 0°C): Same as Torr.
  static const double pascalsPerMillimeterOfMercury = pascalsPerTorr;

  /// Pascals per Inch of Mercury (inHg at 0°C): 1 inHg ≈ 3386.389 Pa.
  /// 1 inHg = 25.4 mmHg
  static const double pascalsPerInchOfMercury = pascalsPerMillimeterOfMercury * 25.4;

  /// Pascals per Kilopascal (kPa): 1 kPa = 1000 Pa.
  static const double pascalsPerKilopascal = 1000.0;

  /// Pascals per Hectopascal (hPa): 1 hPa = 100 Pa.
  static const double pascalsPerHectopascal = 100.0;

  /// Pascals per Millibar (mbar): 1 mbar = 100 Pa (same as hPa).
  static const double pascalsPerMillibar = 100.0;

  /// Pascals per Centimeter of Water (cmH2O at 4°C): 1 cmH2O ≈ 98.0665 Pa.
  /// Based on g = 9.80665 m/s² and water density at 4°C ≈ 999.9720 kg/m³.
  /// 1 cmH2O = 0.01 m * 999.9720 kg/m³ * 9.80665 m/s²
  static const double pascalsPerCentimeterOfWater =
      98.0638; // More common value for 4°C, check NIST SP 811 (2008) appendix B.8 for convention.
  // NIST SP 811 uses density of water at 4 °C as 1000 kg/m³ which gives 98.0665 Pa for 1 cmH2O
  // Let's use the one based on 1000 kg/m³ for conventional cmH2O
  // static const double pascalsPerCentimeterOfWater = 98.0665; // Using conventional g_n and rho_H2O_4C

  /// Pascals per Inch of Water (inH2O at 4°C): 1 inH2O ≈ 249.0889 Pa.
  /// 1 inH2O = 2.54 cmH2O
  // static const double pascalsPerInchOfWater = pascalsPerCentimeterOfWater * 2.54;

  // Let's use common conventional values for water column units, often defined with specific conditions
  // or by direct relation to other units.
  // According to NIST Guide for the Use of the International System of Units (SI), Appendix B.8:
  // conventional value for cmH2O (at 4 °C) is 98.0665 Pa
  // conventional value for inH2O (at 4 °C) is 249.088 91 Pa
  // conventional value for inHg (at 0 °C) is 3386.389 Pa

  // Re-evaluating water column based on common engineering tables and NIST SP 811.
  // Often, "conventional" values are used.
  // For cmH2O (at 4°C), often 98.0665 Pa is cited.
  // For inH2O (at 4°C), often 249.08891 Pa is cited.
  // Let's align with these conventional values for clarity.

  static const double conventionalPascalsPerCentimeterOfWater4C = 98.0665;
  // (249.08891: which is 98.0665 Pa/cmH2O * 2.54 cm/in)
  static const double conventionalPascalsPerInchOfWater4C = 249.08891;

  // Note: Some sources might specify inH2O at 60°F (15.56°C).
  // For V1.0, we'll stick to one clearly defined standard, 4°C,
  // and document it as such.
  // 1 inch of water (60 °F) = 248.84 pascals
  // We will use 4°C (39.2°F) as the reference for cmH2O and inH2O
  // as it's a common scientific reference point for water density.
}
