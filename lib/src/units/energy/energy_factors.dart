// ignore_for_file: prefer_int_literals // All constants are doubles for precision.

/// Defines base conversion factors for various energy units relative to the
/// Joule (J), which is the SI derived unit for energy (kg·m²/s²).
///
/// These constants represent the value of `1 [Unit]` in Joules.
/// For example, `joulesPerKilowattHour` is the number of Joules in one kilowatt-hour.
/// All values are based on internationally recognized standard definitions.
class EnergyFactors {
  // --- SI Prefixed Units (relative to Joule) ---

  /// Joules per Megajoule: 1 MJ = 1,000,000 J.
  static const double joulesPerMegajoule = 1000000.0;

  /// Joules per Kilojoule: 1 kJ = 1,000 J.
  static const double joulesPerKilojoule = 1000.0;

  // --- Other Common and Scientific Units ---

  /// Joules per Calorie (cal): 1 thermochemical calorie = 4.184 J.
  /// This is the "small calorie" or "gram calorie". The thermochemical calorie
  /// is a widely accepted standard in scientific contexts.
  static const double joulesPerCalorie = 4.184;

  /// Joules per Kilocalorie (kcal): 1 kcal = 4184 J.
  /// This is the "large calorie", commonly used in nutrition (food energy).
  /// It is equivalent to 1000 thermochemical calories.
  static const double joulesPerKilocalorie = 4184.0;

  /// Joules per Kilowatt-hour (kWh): 1 kWh = 3.6 × 10⁶ J.
  /// A common unit for electrical energy billing. Derived from Power × Time:
  /// 1 kW × 1 h = 1000 J/s × 3600 s = 3,600,000 J.
  static const double joulesPerKilowattHour = 3600000.0;

  /// Joules per Electronvolt (eV): 1 eV ≈ 1.602176634 × 10⁻¹⁹ J.
  /// This value is exact by the 2019 redefinition of SI base units, as it is
  /// derived from the elementary charge 'e'. It represents the kinetic energy
  /// gained by an electron when accelerated through a potential difference of one volt.
  static const double joulesPerElectronvolt = 1.602176634e-19;

  /// Joules per British Thermal Unit (Btu): 1 Btu (International Table) ≈ 1055.056 J.
  /// The International Table definition is commonly used in engineering and is
  /// based on the properties of steam. There are several slightly different
  /// definitions of the Btu; this is a widely accepted standard.
  static const double joulesPerBtu = 1055.056;
}
