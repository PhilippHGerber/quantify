// ignore_for_file: prefer_int_literals :

/// Defines base conversion factors for various length units relative to Meter.
///
/// These constants are based on international standards (e.g., NIST).
/// The `_` prefix indicates that this class is intended for internal use
/// within the `quantify` package, primarily by the `LengthUnit` enum.
class LengthNist {
  // The base unit for internal calculations is Meter.
  // Factors represent: 1 [Unit] = X [Meters]

  /// Meters per Kilometer: 1 kilometer = 1000.0 meters.
  static const double metersPerKilometer = 1000.0;

  /// Meters per Centimeter: 1 centimeter = 0.01 meters.
  static const double metersPerCentimeter = 0.01;

  /// Meters per Millimeter: 1 millimeter = 0.001 meters.
  static const double metersPerMillimeter = 0.001;

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
}
