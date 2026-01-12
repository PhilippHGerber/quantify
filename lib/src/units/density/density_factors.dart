/// Defines base conversion factors for various density units relative to the
/// Kilogram per Cubic Meter (kg/m³), which is the SI derived unit for density.
///
/// These constants represent: `1 [Unit] = Z [Kilograms Per Cubic Meter]`.
class DensityFactors {
  /// Kilograms per Cubic Meter: 1 kg/m³ = 1.0 kg/m³.
  static const double kilogramPerCubicMeter = 1;

  /// Grams per Cubic Centimeter: 1 g/cm³ = 1000 kg/m³.
  static const double gramPerCubicCentimeter = 1000;

  /// Grams per Milliliter: 1 g/mL = 1 g/cm³ = 1000 kg/m³.
  static const double gramPerMilliliter = 1000;
}
