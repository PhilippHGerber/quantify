# Quantify scientific constants

## A Comprehensive Guide to Physical, Astronomical, and Engineering Constants in Dart

For developers working on scientific, engineering, or educational applications in Dart and Flutter, accuracy and reliability are paramount. The **`quantify`** package provides a robust, type-safe solution for handling units of measurement, and its extensive constants library is an indispensable resource for any project requiring precise calculations.

This guide serves as a definitive reference to the built-in scientific constants available in `quantify`. By leveraging these pre-defined, type-safe values, you can eliminate manual errors, improve code readability, and accelerate your development process. Whether you are calculating gravitational forces, modeling thermodynamic systems, or simulating orbital mechanics, this library ensures your foundational values are accurate and sourced from authoritative standards like CODATA 2018 and NIST.

Below, you will find a complete overview of the **Physical**, **Astronomical**, and **Engineering** constants, complete with their data types and descriptions.

## Installation

The scientific constants library is an integral part of the `quantify` package. To use it, you first need to add `quantify` to your project's dependencies.

Add the following to your `pubspec.yaml` file:

```yaml
dependencies:
  quantify: ^0.12.0 # Or the latest version
```

Then, run the appropriate command to fetch the package:

```bash
# For Dart projects
dart pub get

# For Flutter projects
flutter pub get
```

## Usage

Once the package is installed, you can access the full library of constants by importing the dedicated `constants.dart` file. The constants are organized into three static classes: `PhysicalConstants`, `AstronomicalConstants`, and `EngineeringConstants`.

1. **Import the Constants Library**

    Add the following import to your Dart file:

    ```dart
    import 'package:quantify/quantify.dart';
    import 'package:quantify/constants.dart'; // Required for accessing constants
    ```

2. **Accessing Constants**

    The constants are provided as pre-initialized, type-safe `Quantity` objects, making them ready for immediate use in calculations without any need for manual setup.

    ```dart
    void main() {
      // Access a physical constant
      final speedOfLight = PhysicalConstants.speedOfLight;
      print('The speed of light is $speedOfLight.');
      // "The speed of light is 299792458.0 m/s."

      // Access an astronomical constant
      final gravity = AstronomicalConstants.standardGravity;
      print('Standard gravity is $gravity.');
      // "Standard gravity is 9.80665 m/s²."

      // Access an engineering constant and display it in a different unit
      final steelStiffness = EngineeringConstants.steelYoungsModulus;
      print('Young\'s Modulus for steel is ${steelStiffness.asMegaPascals}.');
      // "Young's Modulus for steel is 200000.0 MPa."
    }
    ```

3. **Using Constants in Calculations**

    Because constants are already `Quantity` objects, they integrate seamlessly into arithmetic operations with other quantities, with all unit conversions handled automatically. The library also includes convenience methods for common formulas.

    ```dart
    void main() {
      // Example 1: Calculate the weight of an electron on Earth
      const electronMass = PhysicalConstants.electronMass; // A Mass object
      const earthGravity = AstronomicalConstants.standardGravity; // An Acceleration object

      // The Force.from() factory correctly handles the
      // dimensional calculation (F = m * a)
      final weightOfElectron = Force.from(electronMass, earthGravity);

      print('Weight of an electron on Earth: $weightOfElectron');
      // Output: "Weight of an electron on Earth: 8.933253767631498e-30 N"

      // Example 2: Use a convenience method to calculate photon energy
      final wavelengthOfGreenLight = 550.nm; // Create a Length object
      final greenPhotonEnergy = PhysicalConstants.photonEnergy(wavelengthOfGreenLight); // Returns an Energy object

      // Convert and format the result using the built-in toString() method
      print('Energy of a 550nm photon: ${greenPhotonEnergy.toString(targetUnit: EnergyUnit.electronvolt, fractionDigits: 2)}');
      // Output: "Energy of a 550nm photon: 2.26 eV"
    }
    ```

## List of Constants

### Physical Constants

This collection includes fundamental constants of nature, based primarily on the 2018 CODATA recommended values.

| Constant Name | Type / Unit | Description |
| :--- | :--- | :--- |
| **`speedOfLight`** | `Speed` | Speed of light in vacuum (c). |
| **`planckConstant`** | `double` (J·s) | The fundamental quantum of electromagnetic action (h). |
| **`reducedPlanckConstant`** | `double` (J·s) | The Planck constant divided by 2π (ℏ). |
| **`elementaryCharge`** | `ElectricCharge` | The magnitude of the electric charge of a single proton or electron (e). |
| **`avogadroConstant`** | `double` (mol⁻¹) | The number of constituent particles per mole of a given substance (Nₐ). |
| **`boltzmannConstant`** | `double` (J/K) | Relates the average relative kinetic energy of particles with temperature (k). |
| **`gasConstant`** | `double` (J/(mol·K)) | A molar constant equivalent to the Boltzmann constant (R). |
| **`faradayConstant`** | `double` (C/mol) | Represents the electric charge per mole of elementary charges (F). |
| **`gravitationalConstant`** | `double` (m³/(kg·s²))| The empirical physical constant quantifying the magnitude of gravitational force (G). |
| **`fineStructureConstant`** | `double` | A dimensionless constant characterizing the strength of electromagnetic interaction (α). |
| **`vacuumPermeability`** | `double` (H/m) | The measure of resistance encountered when forming a magnetic field in a vacuum (μ₀). |
| **`vacuumPermittivity`** | `double` (F/m) | Represents the capability of a vacuum to permit electric field lines (ε₀). |
| **`bohrMagneton`** | `double` (J/T) | The magnetic moment of an electron caused by its orbital or spin angular momentum (μB). |
| **`nuclearMagneton`** | `double` (J/T) | A physical constant of magnetic moment for heavy particles like nucleons (μN). |
| **`electronMass`** | `Mass` | The mass of a stationary electron (mₑ). |
| **`protonMass`** | `Mass` | The mass of a stationary proton (mₚ). |
| **`neutronMass`** | `Mass` | The mass of a stationary neutron (mₙ). |
| **`deuteronMass`** | `Mass` | The mass of the nucleus of a deuterium atom (one proton and one neutron). |
| **`alphaParticleMass`** | `Mass` | The mass of the nucleus of a helium-4 atom (two protons and two neutrons). |
| **`atomicMassConstant`** | `Mass` | Defined as 1/12 of the mass of a carbon-12 atom (mᵤ). |
| **`electronChargeToMassRatio`**| `double` (C/kg) | The ratio of the elementary charge to the electron mass (e/mₑ). |
| **`protonChargeToMassRatio`** | `double` (C/kg) | The ratio of the elementary charge to the proton mass (e/mₚ). |
| **`classicalElectronRadius`**| `Length` | A length scale based on a classical relativistic model of an electron (rₑ). |
| **`bohrRadius`** | `Length` | The most probable distance between the nucleus and the electron in a hydrogen atom (a₀). |
| **`electronComptonWavelength`**| `Length` | The quantum mechanical property of a particle with mass (λC). |
| **`electronVolt`** | `Energy` | Represents the kinetic energy gained by an electron when accelerated through one volt (eV). |
| **`rydbergEnergy`** | `Energy` | The binding energy of the electron in a hydrogen atom in its ground state. |
| **`electronRestEnergy`** | `Energy` | Einstein's mass-energy equivalence for an electron at rest (mₑc²). |
| **`protonRestEnergy`** | `Energy` | Einstein's mass-energy equivalence for a proton at rest (mₚc²). |
| **`stefanBoltzmannConstant`** | `double` (W/(m²·K⁴)) | Relates the total energy radiated from a black body to its temperature (σ). |
| **`wienDisplacementConstant`**| `double` (m·K) | Relates the peak wavelength of black-body radiation to its temperature (b). |
| **`firstRadiationConstant`** | `double` (W·m²) | A constant used in Planck's law for black-body radiation (c₁). |
| **`secondRadiationConstant`** | `double` (m·K) | A constant used in Planck's law for black-body radiation (c₂). |

### Astronomical Constants

This collection includes standard values for planetary, solar, and cosmological measurements.

| Constant Name | Type / Unit | Description |
| :--- | :--- | :--- |
| **`astronomicalUnit`** | `Length` | The average distance from the Earth to the Sun (AU). |
| **`lightYear`** | `Length` | The distance light travels in one Julian year (ly). |
| **`parsec`** | `Length` | The distance at which one astronomical unit subtends one arcsecond (pc). |
| **`solarMass`** | `Mass` | The total mass of the Sun (M☉), a fundamental unit for stellar masses. |
| **`solarRadius`** | `Length` | The radius of the Sun from its center to the photosphere (R☉). |
| **`solarLuminosity`** | `Power` | The total power output of the Sun (L☉). |
| **`solarEffectiveTemperature`**| `Temperature` | The effective black-body temperature of the Sun's photosphere. |
| **`earthMass`** | `Mass` | The total mass of Earth (M⊕), a fundamental unit for terrestrial planet masses. |
| **`earthRadius`** | `Length` | Earth's radius at the equator (R⊕). |
| **`earthPolarRadius`** | `Length` | Earth's radius at the poles. |
| **`moonMass`** | `Mass` | The total mass of the Moon. |
| **`moonRadius`** | `Length` | The mean radius of the Moon. |
| **`earthMoonDistance`** | `Length` | The semi-major axis of the Moon's orbit around Earth. |
| **`mercuryMass`** | `Mass` | The total mass of Mercury. |
| **`mercuryRadius`** | `Length` | The mean radius of Mercury. |
| **`venusMass`** | `Mass` | The total mass of Venus. |
| **`venusRadius`** | `Length` | The mean radius of Venus. |
| **`marsMass`** | `Mass` | The total mass of Mars. |
| **`marsRadius`** | `Length` | The mean radius of Mars. |
| **`jupiterMass`** | `Mass` | The total mass of Jupiter (MJ). |
| **`jupiterRadius`** | `Length` | The equatorial radius of Jupiter. |
| **`saturnMass`** | `Mass` | The total mass of Saturn. |
| **`saturnRadius`** | `Length` | The equatorial radius of Saturn. |
| **`uranusMass`** | `Mass` | The total mass of Uranus. |
| **`uranusRadius`** | `Length` | The equatorial radius of Uranus. |
| **`neptuneMass`** | `Mass` | The total mass of Neptune. |
| **`neptuneRadius`** | `Length` | The equatorial radius of Neptune. |
| **`milkyWayMass`** | `Mass` | The estimated total mass of the Milky Way galaxy. |
| **`galacticCenterDistance`** | `Length` | The distance from the Solar System to the galactic center. |
| **`hubbleConstant`** | `Frequency` | The current expansion rate of the universe (H₀). |
| **`criticalDensity`** | `double` (kg/m³) | The mass-energy density required for a flat universe geometry. |
| **`observableUniverseRadius`**| `Length` | The current proper distance to the edge of the observable universe. |
| **`chandrasekharLimit`** | `Mass` | The maximum mass of a stable white dwarf star. |
| **`solarMassSchwarzschildRadius`**| `Length` | The event horizon radius for a black hole with the mass of the Sun. |
| **`planckMass`** | `Mass` | A fundamental mass scale in quantum gravity. |
| **`planckLength`** | `Length` | A fundamental length scale in quantum gravity. |
| **`planckTime`** | `Time` | A fundamental time scale in quantum gravity. |
| **`standardGravity`** | `Acceleration` | The standard acceleration due to gravity at Earth's surface (g₀). |
| **`siderealDay`** | `Time` | The time for one rotation of Earth relative to distant stars. |
| **`siderealYear`** | `Time` | The time for one orbit of Earth around the Sun. |
| **`earthOrbitalVelocity`** | `Speed` | Earth's mean orbital velocity. |
| **`geostationaryOrbitRadius`**| `Length` | The orbital radius from Earth's center for a geostationary satellite. |
| **`solarConstant`** | `double` (W/m²) | The mean solar electromagnetic radiation per unit area at 1 AU. |
| **`earthEscapeVelocity`** | `Speed` | The minimum speed needed to escape Earth's gravitational influence. |
| **`ageOfUniverse`** | `Time` | The time elapsed since the Big Bang. |
| **`cmbTemperature`** | `Temperature` | The current temperature of the cosmic microwave background radiation. |

### Engineering Constants

This collection includes practical constants used in material science, thermodynamics, and other engineering fields.

| Constant Name | Type / Unit | Description |
| :--- | :--- | :--- |
| **`standardTemperature`** | `Temperature` | IUPAC standard temperature (0°C or 273.15 K). |
| **`standardPressure`** | `Pressure` | IUPAC standard pressure (1 bar or 100,000 Pa). |
| **`standardAtmosphere`** | `Pressure` | Historical standard pressure (1 atm or 101,325 Pa). |
| **`normalTemperature`** | `Temperature` | Common reference temperature (20°C or 293.15 K). |
| **`roomTemperature`** | `Temperature` | Typical indoor air temperature (22°C or 295.15 K). |
| **`waterDensityMax`** | `double` (kg/m³) | The maximum density of water at 4°C. |
| **`airDensitySTP`** | `double` (kg/m³) | The density of air at standard atmospheric conditions. |
| **`soundSpeedAir20C`** | `Speed` | The speed of sound in dry air at 20°C. |
| **`soundSpeedWater25C`** | `Speed` | The speed of sound in fresh water at 25°C. |
| **`waterViscosity20C`** | `double` (Pa·s) | The dynamic viscosity of water at 20°C. |
| **`airViscosity20C`** | `double` (Pa·s) | The dynamic viscosity of air at 20°C. |
| **`copperThermalConductivity`**| `double` (W/(m·K)) | The thermal conductivity of high-purity copper. |
| **`waterSpecificHeat`** | `double` (J/(kg·K)) | The specific heat capacity of water at constant pressure (15°C). |
| **`waterLatentHeatVaporization`**| `double` (J/kg) | The latent heat of vaporization of water at 100°C. |
| **`waterLatentHeatFusion`** | `double` (J/kg) | The latent heat of fusion of water at 0°C. |
| **`copperResistivity`** | `double` (Ω·m) | The electrical resistivity of copper at 20°C. |
| **`steelYoungsModulus`** | `Pressure` | A measure of stiffness for typical carbon steel. |
| **`aluminumYoungsModulus`** | `Pressure` | A measure of stiffness for typical aluminum. |
| **`concreteYoungsModulus`** | `Pressure` | A measure of stiffness for typical Portland cement concrete. |
| **`steelTensileStrength`** | `Pressure` | The ultimate tensile strength for typical mild steel. |
| **`steelYieldStrength`** | `Pressure` | The yield strength for typical mild steel. |
| **`steelPoissonsRatio`** | `double` | The ratio of transverse to axial strain for steel. |
| **`aluminumPoissonsRatio`**| `double` | The ratio of transverse to axial strain for aluminum. |
| **`concretePoissonsRatio`**| `double` | The ratio of transverse to axial strain for concrete. |
| **`steelThermalExpansion`** | `double` (K⁻¹) | The coefficient of linear thermal expansion for steel. |
| **`methaneHeatingValue`** | `double` (J/kg) | The lower heating value (LHV) of natural gas (methane). |
| **`gasolineAirFuelRatio`** | `double` | The mass ratio of air to fuel for complete combustion of gasoline. |
| **`atomicMassUnit`** | `Mass` | Defined as 1/12 of the mass of a carbon-12 atom. |
| **`nuclearBindingEnergyPerNucleon`**| `Energy` | The typical energy scale for nuclear reactions. |
| **`waterFreezingPoint`** | `Temperature` | The freezing point of water at 1 atm. |
| **`waterBoilingPoint`** | `Temperature` | The boiling point of water at 1 atm. |
| **`bodyTemperature`** | `Temperature` | The typical human body temperature (37°C or 310.15 K). |
