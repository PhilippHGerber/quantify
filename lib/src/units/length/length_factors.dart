// ignore_for_file: prefer_int_literals : all constants are doubles.

/// Defines base conversion factors for various length units relative to Meter.
///
/// These constants are based on international standards (e.g., NIST).
class LengthFactors {
  // The base unit for internal calculations is Meter.
  // Factors represent: 1 [Unit] = X [Meters]

  /// Meters per Kilometer: 1 kilometer = 1000.0 meters.
  static const double metersPerKilometer = 1000.0;

  /// Meters per Hectometer: 1 hectometer = 100.0 meters.
  static const double metersPerHectometer = 100.0;

  /// Meters per Decameter: 1 decameter = 10.0 meters.
  static const double metersPerDecameter = 10.0;

  /// Meters per Decimeter: 1 decimeter = 0.1 meters.
  static const double metersPerDecimeter = 0.1;

  /// Meters per Centimeter: 1 centimeter = 0.01 meters.
  static const double metersPerCentimeter = 0.01;

  /// Meters per Millimeter: 1 millimeter = 0.001 meters.
  static const double metersPerMillimeter = 0.001;

  /// Meters per Micrometer: 1 micrometer = 1e-6 meters.
  static const double metersPerMicrometer = 1e-6;

  /// Meters per Nanometer: 1 nanometer = 1e-9 meters.
  static const double metersPerNanometer = 1e-9;

  /// Meters per Picometer: 1 picometer = 1e-12 meters.
  static const double metersPerPicometer = 1e-12;

  /// Meters per Femtometer: 1 femtometer = 1e-15 meters.
  static const double metersPerFemtometer = 1e-15;

  /// Meters per Inch: 1 inch = 0.0254 meters (exact definition).
  static const double metersPerInch = 0.0254;

  /// Meters per Foot: 1 foot = 0.3048 meters (exact definition, as 1 foot = 12 inches).
  static const double metersPerFoot = 0.3048;

  /// Meters per Yard: 1 yard = 0.9144 meters (exact definition, as 1 yard = 3 feet).
  static const double metersPerYard = 0.9144;

  /// Meters per Mile: 1 mile = 1609.344 meters (exact definition, as 1 mile = 1760 yards).
  static const double metersPerMile = 1609.344;

  /// Meters per Nautical Mile: 1 nautical mile = 1852.0 meters (international definition).
  static const double metersPerNauticalMile = 1852.0;

  /// Meters per Astronomical Unit: 1 AU = 149597870700.0 meters (exact definition, IAU 2012).
  static const double metersPerAstronomicalUnit = 149597870700.0;

  /// Meters per Light Year: 1 light year = 9460730472580800.0 meters.
  /// Based on Julian year (365.25 days) and exact speed of light.
  static const double metersPerLightYear = 9460730472580800.0;

  /// Meters per Parsec: 1 parsec ≈ 3.0856775814913673e16 meters.
  /// Derived from astronomical unit: 1 pc = 648000/π AU.
  static const double metersPerParsec = 3.0856775814913673e16;

  /// Meters per Ångström: 1 ångström = 1e-10 meters (exact definition).
  static const double metersPerAngstrom = 1e-10;
}
