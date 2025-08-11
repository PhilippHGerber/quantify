import '../../area.dart';
import '../../energy.dart';
import '../../force.dart';
import '../../length.dart';
import '../../mass.dart';
import '../../power.dart';
import '../../pressure.dart';
import '../../speed.dart';
import '../../temperature.dart';

/// Engineering and technical constants with their respective units.
///
/// These constants are commonly used in engineering calculations,
/// material science, and industrial applications.
///
/// References:
/// - NIST Reference Fluid Thermodynamic and Transport Properties
/// - Engineering Standards and Handbooks
/// - International Standards Organization (ISO)
class EngineeringConstants {
  // Private constructor to prevent instantiation
  EngineeringConstants._();

  // === STANDARD CONDITIONS ===

  /// Standard Temperature (STP).
  /// Value: 273.15 K (0°C).
  ///
  /// The IUPAC definition of standard temperature.
  static const Temperature standardTemperature = Temperature(273.15, TemperatureUnit.kelvin);

  /// Standard Pressure (STP).
  /// Value: 100,000 Pa (1 bar).
  ///
  /// The IUPAC definition of standard pressure (changed from 1 atm in 1982).
  static const Pressure standardPressure = Pressure(100000, PressureUnit.pascal);

  /// Standard Atmospheric Pressure.
  /// Value: 101,325 Pa (1 atm).
  ///
  /// The historical standard pressure, still widely used in many engineering fields.
  static const Pressure standardAtmosphere = Pressure(101325, PressureUnit.pascal);

  /// Normal Temperature (NTP).
  /// Value: 293.15 K (20°C).
  ///
  /// A common reference temperature for many engineering calculations.
  static const Temperature normalTemperature = Temperature(293.15, TemperatureUnit.kelvin);

  /// Typical Room Temperature.
  /// Value: 295.15 K (22°C).
  ///
  /// A typical comfortable indoor air temperature.
  static const Temperature roomTemperature = Temperature(295.15, TemperatureUnit.kelvin);

  // === MATERIAL PROPERTIES ===

  /// Density of water at 4°C (maximum density).
  /// Value: 999.97 kg/m³.
  /// Note: This would ideally be a `Density` quantity.
  static const double waterDensityMax = 999.97; // kg/m³

  /// Density of air at STP (standard atmospheric conditions).
  /// Value: 1.225 kg/m³.
  /// Note: This would ideally be a `Density` quantity.
  static const double airDensitySTP = 1.225; // kg/m³

  /// Speed of sound in dry air at 20°C.
  /// Value: 343.2 m/s.
  ///
  /// At sea level, 20°C (293.15 K).
  static const Speed soundSpeedAir20C = Speed(343.2, SpeedUnit.meterPerSecond);

  /// Speed of sound in fresh water at 25°C.
  /// Value: 1497 m/s.
  static const Speed soundSpeedWater25C = Speed(1497, SpeedUnit.meterPerSecond);

  /// Dynamic viscosity of water at 20°C.
  /// Value: 1.002×10⁻³ Pa⋅s.
  /// Note: This would ideally be a `DynamicViscosity` quantity.
  static const double waterViscosity20C = 1.002e-3; // Pa⋅s

  /// Dynamic viscosity of air at 20°C.
  /// Value: 1.81×10⁻⁵ Pa⋅s.
  static const double airViscosity20C = 1.81e-5; // Pa⋅s

  // === THERMAL PROPERTIES ===

  /// Thermal conductivity of copper.
  /// Value: 401 W/(m⋅K).
  ///
  /// High-purity copper at room temperature.
  /// Note: This would ideally be a `ThermalConductivity` quantity.
  static const double copperThermalConductivity = 401; // W/(m⋅K)

  /// Specific heat capacity of water at constant pressure (15°C).
  /// Value: 4184 J/(kg⋅K).
  /// Note: This would ideally be a `SpecificHeatCapacity` quantity.
  static const double waterSpecificHeat = 4184; // J/(kg⋅K)

  /// Latent heat of vaporization of water at 100°C.
  /// Value: 2.26×10⁶ J/kg.
  /// Note: This would ideally be a `SpecificEnergy` quantity.
  static const double waterLatentHeatVaporization = 2260000; // J/kg

  /// Latent heat of fusion of water at 0°C.
  /// Value: 3.34×10⁵ J/kg.
  /// Note: This would ideally be a `SpecificEnergy` quantity.
  static const double waterLatentHeatFusion = 334000; // J/kg

  // === ELECTRICAL PROPERTIES ===

  /// Electrical resistivity of copper at 20°C.
  /// Value: 1.68×10⁻⁸ Ω⋅m.
  /// Note: This would ideally be an `ElectricalResistivity` quantity.
  static const double copperResistivity = 1.68e-8; // Ω⋅m

  // === MECHANICAL PROPERTIES ===

  /// Young's modulus of steel.
  /// Value: 200 GPa (2.0×10¹¹ Pa).
  ///
  /// A measure of stiffness for typical carbon steel.
  static const Pressure steelYoungsModulus = Pressure(200000000000, PressureUnit.pascal);

  /// Young's modulus of aluminum.
  /// Value: 70 GPa (7.0×10¹⁰ Pa).
  static const Pressure aluminumYoungsModulus = Pressure(70000000000, PressureUnit.pascal);

  /// Young's modulus of concrete.
  /// Value: 30 GPa (3.0×10¹⁰ Pa).
  ///
  /// For typical Portland cement concrete.
  static const Pressure concreteYoungsModulus = Pressure(30000000000, PressureUnit.pascal);

  /// Ultimate tensile strength of steel.
  /// Value: 400 MPa (4.0×10⁸ Pa).
  ///
  /// For typical mild steel.
  static const Pressure steelTensileStrength = Pressure(400000000, PressureUnit.pascal);

  /// Yield strength of steel.
  /// Value: 250 MPa (2.5×10⁸ Pa).
  ///
  /// For typical mild steel.
  static const Pressure steelYieldStrength = Pressure(250000000, PressureUnit.pascal);

  /// Poisson's ratio for steel.
  /// Represents the ratio of transverse strain to axial strain.
  /// Value: 0.27-0.30 (using 0.29 as typical).
  static const double steelPoissonsRatio = 0.29;

  /// Poisson's ratio for aluminum.
  /// Value: ~0.33.
  static const double aluminumPoissonsRatio = 0.33;

  /// Poisson's ratio for concrete.
  /// Value: ~0.20.
  static const double concretePoissonsRatio = 0.20;

  /// Coefficient of linear thermal expansion for steel.
  /// Value: 1.2×10⁻⁵ K⁻¹.
  static const double steelThermalExpansion = 1.2e-5; // K⁻¹

  // === COMBUSTION AND ENERGY ===

  /// Lower heating value (LHV) of natural gas (methane).
  /// Value: 5.0×10⁷ J/kg.
  /// Note: This would ideally be a `SpecificEnergy` quantity.
  static const double methaneHeatingValue = 50000000; // J/kg

  /// Stoichiometric air-fuel mass ratio for gasoline.
  /// Value: 14.7.
  ///
  /// The mass ratio of air to fuel for complete combustion.
  static const double gasolineAirFuelRatio = 14.7;

  // === ATOMIC AND NUCLEAR ===

  /// Atomic mass unit in kg.
  /// Value: 1.66053906660×10⁻²⁷ kg.
  static const Mass atomicMassUnit = Mass(1.66053906660e-27, MassUnit.kilogram);

  /// Typical nuclear binding energy per nucleon.
  /// Value: 8 MeV ≈ 1.28×10⁻¹² J.
  ///
  /// The energy scale for nuclear reactions.
  static const Energy nuclearBindingEnergyPerNucleon = Energy(1.28e-12, EnergyUnit.joule);

  // === TYPICAL ENGINEERING VALUES ===

  /// Freezing point of water at 1 atm.
  /// Value: 273.15 K (0°C).
  static const Temperature waterFreezingPoint = Temperature(273.15, TemperatureUnit.kelvin);

  /// Boiling point of water at 1 atm.
  /// Value: 373.15 K (100°C).
  static const Temperature waterBoilingPoint = Temperature(373.15, TemperatureUnit.kelvin);

  /// Typical human body temperature.
  /// Value: 310.15 K (37°C).
  static const Temperature bodyTemperature = Temperature(310.15, TemperatureUnit.kelvin);

  // === CONVENIENCE METHODS ===

  /// Calculates the Reynolds number for internal pipe flow.
  ///
  /// Returns a dimensionless Reynolds number.
  /// Usage: `final Re = EngineeringConstants.reynoldsNumberPipe(velocity, diameter, kinematicViscosity);`
  static double reynoldsNumberPipe(Speed velocity, Length diameter, double kinematicViscosity) {
    final v = velocity.inMetersPerSecond;
    final d = diameter.inM;
    return v * d / kinematicViscosity; // Re = vD/ν
  }

  /// Calculates the pressure drop in a pipe using the Darcy-Weisbach equation.
  ///
  /// Returns the pressure drop as a [Pressure] quantity.
  /// Usage: `final dp = EngineeringConstants.pipePressureDrop(frictionFactor, length, diameter, velocity, density);`
  static Pressure pipePressureDrop(
    double frictionFactor,
    Length length,
    Length diameter,
    Speed velocity,
    double density,
  ) {
    final L = length.inM;
    final D = diameter.inM;
    final v = velocity.inMetersPerSecond;
    final pressureDropPa = frictionFactor * (L / D) * (density * v * v / 2.0); // Δp = f(L/D)(ρv²/2)
    return Pressure(pressureDropPa, PressureUnit.pascal);
  }

  /// Calculates the thermal expansion of a material.
  ///
  /// Returns the change in length as a [Length] quantity.
  /// Usage: `final deltaL = EngineeringConstants.thermalExpansion(originalLength, expansionCoeff, tempChange);`
  static Length thermalExpansion(
    Length originalLength,
    double expansionCoefficient,
    Temperature temperatureChange,
  ) {
    final l0 = originalLength.inM;
    // Temperature difference is valid regardless of the unit scale, but value must be absolute diff
    final deltaT = temperatureChange.getValue(TemperatureUnit.kelvin);
    final deltaL = l0 * expansionCoefficient * deltaT; // ΔL = L₀αΔT
    return Length(deltaL, LengthUnit.meter);
  }

  /// Calculates the heat transfer rate by conduction through a material.
  ///
  /// Returns the heat transfer rate as a [Power] quantity (in Watts).
  /// Usage: `final q = EngineeringConstants.conductiveHeatTransfer(k, area, thickness, tempDiff);`
  static Power conductiveHeatTransfer(
    double thermalConductivity, // W/(m⋅K)
    Area area,
    Length thickness,
    Temperature temperatureDifference,
  ) {
    final A = area.inSquareMeters;
    final dx = thickness.inM;
    final deltaT = temperatureDifference.getValue(TemperatureUnit.kelvin);
    final heatRateW = thermalConductivity * A * deltaT / dx; // q = kA(ΔT/Δx)
    return Power(heatRateW, PowerUnit.watt);
  }

  /// Calculates the electrical resistance of a conductor.
  ///
  /// Returns the resistance in Ohms (Ω) as a [double].
  /// Usage: `final R = EngineeringConstants.electricalResistance(resistivity, length, area);`
  static double electricalResistance(double resistivity, Length length, Area crossSectionArea) {
    final L = length.inM;
    final A = crossSectionArea.inSquareMeters;
    return resistivity * L / A; // R = ρL/A
  }

  /// Calculates the stress from a [Force] applied over an [Area].
  ///
  /// Returns the stress as a [Pressure] quantity (in Pascals).
  /// Usage: `final stress = EngineeringConstants.mechanicalStress(force, area);`
  static Pressure mechanicalStress(Force force, Area area) {
    final F = force.inNewtons;
    final A = area.inSquareMeters;
    return Pressure(F / A, PressureUnit.pascal); // σ = F/A
  }

  /// Calculates the strain from a given [Pressure] (stress) and Young's modulus.
  ///
  /// Both stress and Young's modulus are represented by [Pressure].
  /// Returns a dimensionless strain value.
  /// Usage: `final strain = EngineeringConstants.mechanicalStrain(stress, youngsModulus);`
  static double mechanicalStrain(Pressure stress, Pressure youngsModulus) {
    // Convert both to the same base unit (Pascals) for a dimensionless ratio.
    final s = stress.inPa;
    final e = youngsModulus.inPa;
    if (e == 0) {
      throw ArgumentError('Youngs modulus cannot be zero.');
    }
    return s / e; // ε = σ/E
  }
}
