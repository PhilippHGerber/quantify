import '../../electric_charge.dart';
import '../../energy.dart';
import '../../force.dart';
import '../../length.dart';
import '../../mass.dart';
import '../../speed.dart';
import '../../temperature.dart';
import '../../time.dart';

/// Fundamental physical constants with their respective units.
///
/// All constants are based on the 2018 CODATA recommended values
/// and are defined as immutable static constants with appropriate
/// Quantity types for type safety.
///
/// References:
/// - CODATA 2018: https://physics.nist.gov/cuu/Constants/
/// - NIST Reference on Constants: https://www.nist.gov/pml/fundamental-physical-constants
class PhysicalConstants {
  // Private constructor to prevent instantiation
  PhysicalConstants._();

  // === FUNDAMENTAL CONSTANTS ===

  /// Speed of light in vacuum (c).
  /// Exact value: 299,792,458 m/s.
  ///
  /// This is an exact value by definition since the meter is defined
  /// in terms of the speed of light.
  static const Speed speedOfLight = Speed(299792458, SpeedUnit.meterPerSecond);

  /// Planck constant (h).
  /// Value: 6.62607015×10⁻³⁴ J⋅s.
  ///
  /// This is an exact value by definition since the 2019 SI redefinition.
  /// Note: This is represented as a [double] as a `JouleSecond` quantity type
  /// is not yet implemented.
  static const double planckConstant = 6.62607015e-34; // J⋅s

  /// Reduced Planck constant (ℏ = h/2π).
  /// Value: 1.054571817×10⁻³⁴ J⋅s.
  static const double reducedPlanckConstant = 1.054571817e-34; // J⋅s

  /// The elementary charge (e) as an [ElectricCharge] quantity.
  /// Value: 1.602176634×10⁻¹⁹ C.
  ///
  /// This is an exact value by definition since the 2019 SI redefinition.
  static const ElectricCharge elementaryCharge = ElectricCharge(
    1.602176634e-19,
    ElectricChargeUnit.coulomb,
  );

  /// Avogadro constant (Nₐ).
  /// Value: 6.02214076×10²³ mol⁻¹.
  ///
  /// This is an exact value by definition since the 2019 SI redefinition.
  /// Note: This is represented as a [double] because its unit is mol⁻¹, a
  /// compound unit not yet represented by a `Quantity` type.
  static const double avogadroConstant = 6.02214076e23; // mol⁻¹

  /// Boltzmann constant (k).
  /// Value: 1.380649×10⁻²³ J/K.
  ///
  /// This is an exact value by definition since the 2019 SI redefinition.
  /// Note: This would ideally be an `Energy` per `Temperature` quantity.
  static const double boltzmannConstant = 1.380649e-23; // J/K

  /// Gas constant (R = Nₐ × k).
  /// Value: 8.314462618 J/(mol⋅K).
  ///
  /// Derived from Avogadro and Boltzmann constants.
  static const double gasConstant = 8.314462618; // J/(mol⋅K)

  /// Faraday constant (F = Nₐ × e).
  /// Value: 96485.33212 C/mol.
  /// Represents the electric charge per mole of elementary charges.
  /// Source: CODATA 2018.
  /// Note: This is a [double] as a `ChargePerMole` quantity is not yet implemented.
  static const double faradayConstant = 96485.33212;

  /// Gravitational constant (G).
  /// Value: 6.67430×10⁻¹¹ m³/(kg⋅s²).
  ///
  /// This is the least precisely known fundamental constant.
  /// Note: This would ideally be a compound `Quantity` type.
  static const double gravitationalConstant = 6.67430e-11; // m³/(kg⋅s²)

  /// Fine-structure constant (α).
  /// Value: 7.2973525693×10⁻³.
  ///
  /// Dimensionless constant characterizing the strength of electromagnetic interaction.
  static const double fineStructureConstant = 7.2973525693e-3;

  /// Vacuum permeability (μ₀).
  /// Value: 4π×10⁻⁷ H/m.
  ///
  /// Exact value by definition.
  /// Note: This would ideally be a `MagneticPermeability` quantity.
  static const double vacuumPermeability = 4.0e-7 * 3.14159265358979323846; // H/m

  /// Vacuum permittivity (ε₀ = 1/(μ₀c²)).
  /// Value: 8.8541878128×10⁻¹² F/m.
  ///
  /// Derived from vacuum permeability and speed of light.
  /// Note: This would ideally be an `ElectricPermittivity` quantity.
  static const double vacuumPermittivity = 8.8541878128e-12; // F/m

  /// Bohr magneton (μB).
  /// Value: 9.2740100783×10⁻²⁴ J/T.
  /// The magnetic moment of an electron caused by its orbital or spin angular momentum.
  /// Source: CODATA 2018.
  /// Note: This is a [double] as a `EnergyPerMagneticFluxDensity` quantity is not yet implemented.
  static const double bohrMagneton = 9.2740100783e-24;

  /// Nuclear magneton (μN).
  /// Value: 5.0507837461×10⁻²⁷ J/T.
  /// A physical constant of magnetic moment for heavy particles like nucleons.
  /// Source: CODATA 2018.
  /// Note: This is a [double] as a `EnergyPerMagneticFluxDensity` quantity is not yet implemented.
  static const double nuclearMagneton = 5.0507837461e-27;

  // === PARTICLE MASSES ===

  /// Electron mass (mₑ).
  /// Value: 9.1093837015×10⁻³¹ kg.
  static const Mass electronMass = Mass(9.1093837015e-31, MassUnit.kilogram);

  /// Proton mass (mₚ).
  /// Value: 1.67262192369×10⁻²⁷ kg.
  static const Mass protonMass = Mass(1.67262192369e-27, MassUnit.kilogram);

  /// Neutron mass (mₙ).
  /// Value: 1.67492749804×10⁻²⁷ kg.
  static const Mass neutronMass = Mass(1.67492749804e-27, MassUnit.kilogram);

  /// Deuteron mass.
  /// The mass of the nucleus of a deuterium atom, consisting of one proton and one neutron.
  /// Value: 3.3435837724×10⁻²⁷ kg.
  /// Source: CODATA 2018.
  static const Mass deuteronMass = Mass(3.3435837724e-27, MassUnit.kilogram);

  /// Alpha particle mass.
  /// The mass of the nucleus of a helium-4 atom, consisting of two protons and two neutrons.
  /// Value: 6.6446573357×10⁻²⁷ kg.
  /// Source: CODATA 2018.
  static const Mass alphaParticleMass = Mass(6.6446573357e-27, MassUnit.kilogram);

  /// Atomic mass constant (mᵤ = 1 u).
  /// Value: 1.66053906660×10⁻²⁷ kg.
  ///
  /// This is exactly 1/12 of the mass of a carbon-12 atom.
  static const Mass atomicMassConstant = Mass(1.66053906660e-27, MassUnit.kilogram);

  // === DERIVED CONSTANTS ===

  /// Electron charge-to-mass ratio (e/mₑ).
  /// Value: 1.75882001076×10¹¹ C/kg.
  ///
  /// Important in electron optics and mass spectrometry.
  static const double electronChargeToMassRatio = 175882001076; // C/kg

  /// Proton charge-to-mass ratio (e/mₚ).
  /// Value: 9.5788331560×10⁷ C/kg.
  static const double protonChargeToMassRatio = 9.5788331560e7; // C/kg

  /// Classical electron radius (rₑ).
  /// Value: 2.8179403262×10⁻¹⁵ m.
  ///
  /// Derived from fundamental constants: rₑ = e²/(4πε₀mₑc²).
  static const Length classicalElectronRadius = Length(2.8179403262e-15, LengthUnit.meter);

  /// Bohr radius (a₀).
  /// Value: 5.29177210903×10⁻¹¹ m.
  ///
  /// The most probable distance between the nucleus and the electron in a hydrogen atom.
  static const Length bohrRadius = Length(5.29177210903e-11, LengthUnit.meter);

  /// Compton wavelength of electron (λC).
  /// Value: 2.42631023867×10⁻¹² m.
  ///
  /// Quantum mechanical property of particles with mass.
  static const Length electronComptonWavelength = Length(2.42631023867e-12, LengthUnit.meter);

  // === ENERGY CONVERSIONS ===

  /// Electron volt (eV) as an [Energy] quantity.
  /// Value: 1.602176634×10⁻¹⁹ J.
  ///
  /// Represents the kinetic energy gained by an electron when accelerated through
  /// a potential difference of one volt.
  static const Energy electronVolt = Energy(1.602176634e-19, EnergyUnit.joule);

  /// Rydberg energy as an [Energy] quantity.
  /// Value: 2.1798723611035×10⁻¹⁸ J.
  ///
  /// The binding energy of the electron in a hydrogen atom in its ground state.
  static const Energy rydbergEnergy = Energy(2.1798723611035e-18, EnergyUnit.joule);

  /// Rest energy of an electron (mₑc²) as an [Energy] quantity.
  /// Value: 8.1871057769×10⁻¹⁴ J.
  ///
  /// Einstein's mass-energy equivalence for an electron at rest.
  static const Energy electronRestEnergy = Energy(8.1871057769e-14, EnergyUnit.joule);

  /// Rest energy of a proton (mₚc²) as an [Energy] quantity.
  /// Value: 1.50327759787×10⁻¹⁰ J.
  ///
  /// Einstein's mass-energy equivalence for a proton at rest.
  static const Energy protonRestEnergy = Energy(1.50327759787e-10, EnergyUnit.joule);

  // === QUANTUM CONSTANTS ===

  /// Stefan-Boltzmann constant (σ).
  /// Value: 5.670374419×10⁻⁸ W/(m²⋅K⁴).
  ///
  /// Relates the total energy radiated from a black body to its temperature.
  /// Note: This would ideally be a compound `Quantity` type.
  static const double stefanBoltzmannConstant = 5.670374419e-8; // W/(m²⋅K⁴)

  /// Wien displacement law constant (b).
  /// Value: 2.897771955×10⁻³ m⋅K.
  ///
  /// Relates the peak wavelength of black-body radiation to its temperature.
  /// Note: This would ideally be a `Length` × `Temperature` quantity.
  static const double wienDisplacementConstant = 2.897771955e-3; // m⋅K

  /// First radiation constant (c₁).
  /// Value: 3.741771852×10⁻¹⁶ W⋅m².
  ///
  /// Used in Planck's law for black-body radiation.
  /// Note: This would ideally be a `Power` × `Area` quantity.
  static const double firstRadiationConstant = 3.741771852e-16; // W⋅m²

  /// Second radiation constant (c₂).
  /// Value: 1.438776877×10⁻² m⋅K.
  ///
  /// Used in Planck's law for black-body radiation.
  /// Note: This would ideally be a `Length` × `Temperature` quantity.
  static const double secondRadiationConstant = 1.438776877e-2; // m⋅K

  // === CONVENIENCE METHODS ===

  /// Calculates the distance light travels in a given [Time].
  ///
  /// Usage: `final distance = PhysicalConstants.lightSpeedDistance(1.0.seconds);`
  /// Returns a [Length] quantity.
  static Length lightSpeedDistance(Time time) {
    return speedOfLight.distanceOver(time);
  }

  /// Calculates the energy equivalent of a [Mass] using E = mc².
  ///
  /// Returns the energy as an [Energy] quantity.
  /// Usage: `final energy = PhysicalConstants.massEnergyEquivalence(1.0.kg);`
  static Energy massEnergyEquivalence(Mass mass) {
    final massInKg = mass.getValue(MassUnit.kilogram);
    final speedOfLightMs = speedOfLight.inMetersPerSecond;
    return Energy(massInKg * speedOfLightMs * speedOfLightMs, EnergyUnit.joule);
  }

  /// Calculates the thermal energy of a system at a given [Temperature] using E = kT.
  ///
  /// Returns the energy as an [Energy] quantity.
  /// Usage: `final energy = PhysicalConstants.thermalEnergy(300.0.kelvin);`
  static Energy thermalEnergy(Temperature temperature) {
    final tempInKelvin = temperature.getValue(TemperatureUnit.kelvin);
    return Energy(boltzmannConstant * tempInKelvin, EnergyUnit.joule);
  }

  /// Calculates the gravitational force between two masses at a given distance.
  ///
  /// Returns the force as a [Force] quantity.
  /// Usage: `final force = PhysicalConstants.gravitationalForce(mass1, mass2, distance);`
  static Force gravitationalForce(Mass mass1, Mass mass2, Length distance) {
    final m1 = mass1.getValue(MassUnit.kilogram);
    final m2 = mass2.getValue(MassUnit.kilogram);
    final r = distance.getValue(LengthUnit.meter);
    return Force(gravitationalConstant * m1 * m2 / (r * r), ForceUnit.newton);
  }

  /// Calculates the energy of a photon from its wavelength using E = hc/λ.
  ///
  /// Returns the energy as an [Energy] quantity.
  /// Usage: `final energy = PhysicalConstants.photonEnergy(500.0.nm);`
  static Energy photonEnergy(Length wavelength) {
    final lambdaInMeters = wavelength.getValue(LengthUnit.meter);
    final speedOfLightMs = speedOfLight.inMetersPerSecond;
    return Energy(planckConstant * speedOfLightMs / lambdaInMeters, EnergyUnit.joule);
  }

  /// Calculates the de Broglie wavelength of a particle with a given [Mass]
  /// and velocity.
  ///
  /// Returns the wavelength as a [Length] quantity.
  /// Usage: `final wavelength = PhysicalConstants.deBroglieWavelength(electronMass, 1.0e6);`
  static Length deBroglieWavelength(Mass mass, double velocityMeterPerSecond) {
    final massInKg = mass.getValue(MassUnit.kilogram);
    final momentum = massInKg * velocityMeterPerSecond; // p = mv
    if (momentum == 0) {
      throw ArgumentError(
        'Cannot calculate de Broglie wavelength for a particle with zero momentum.',
      );
    }
    final wavelengthInMeters = planckConstant / momentum; // λ = h/p
    return Length(wavelengthInMeters, LengthUnit.meter);
  }
}
