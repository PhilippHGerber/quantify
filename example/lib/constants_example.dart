import 'package:quantify/constants.dart';
import 'package:quantify/quantify.dart';

void main() {
  print('--- Quantify Constants and Formatting Showcase ---');

  // --- 1. Basic Usage: Accessing Type-Safe Constants ---
  print('\n--- 1. Basic Usage ---');

  // Constants are pre-defined, type-safe Quantity objects.
  const speedOfLight = PhysicalConstants.speedOfLight;
  const earthMass = AstronomicalConstants.earthMass;

  // The built-in toString() method provides sensible defaults.
  print('Speed of Light: $speedOfLight'); // A Speed object
  print('Mass of the Earth: $earthMass'); // A Mass object

  // --- 2. Type Safety in Action ---
  print('\n--- 2. Type Safety Showcase ---');

  // CORRECT: The Force.from() constructor requires Mass and Acceleration.
  // Using constants ensures you provide the correct physical quantities.
  final weightOfElectron = Force.from(
    PhysicalConstants.electronMass,
    AstronomicalConstants.standardGravity,
  );
  print('Weight of an electron on Earth: $weightOfElectron');

  // INCORRECT: The compiler prevents mistakes like adding a speed to a mass.
  // final compileError = PhysicalConstants.speedOfLight + PhysicalConstants.electronMass;
  print('✅ Type safety prevents dimensionally incorrect operations at compile-time.');

  // --- 3. Practical Calculations & Formatting ---
  print('\n--- 3. Practical Calculations & Formatting ---');

  // Example A: Calculate the energy of a red light photon (~650 nm).
  final redLightWavelength = 650.nm;
  final photonEnergy = PhysicalConstants.photonEnergy(redLightWavelength);
  print(
    'Energy of a 650 nm photon: ${photonEnergy.toString(targetUnit: EnergyUnit.electronvolt, fractionDigits: 2)}',
  );

  // Example B: Calculate the escape velocity from the Moon's surface.
  final moonEscapeVelocity = AstronomicalConstants.escapeVelocity(
    AstronomicalConstants.moonMass,
    AstronomicalConstants.moonRadius,
  );
  print(
    'Escape velocity from the Moon: ${moonEscapeVelocity.asKilometersPerSecond.toString(fractionDigits: 2)}',
  );

  // Example C: Compare material strengths.
  final steelStrength = EngineeringConstants.steelTensileStrength.asMegaPascals;
  final aluminumModulus = EngineeringConstants.aluminumYoungsModulus.asAtm;
  final isSteelStronger = steelStrength > aluminumModulus;

  print(
    "Is steel's tensile strength (${steelStrength.toString(fractionDigits: 0)})"
    " greater than aluminum's stiffness (${aluminumModulus.toString(fractionDigits: 0)})?",
  );
  print('Answer: $isSteelStronger');

  // Example D: How many times more massive is the Sun than the Earth?
  const sunMass = AstronomicalConstants.solarMass;
  // To get a ratio, convert both quantities to the same unit and divide their double values.
  final massRatio = sunMass.inKilograms / earthMass.inKilograms;
  print(
    'The Sun is ${massRatio.toStringAsFixed(0)} times more massive than the Earth.',
  );

  // --- 4. Advanced Formatting with Locales ---
  print('\n--- 4. Advanced Formatting with Locales (requires intl package) ---');

  // Let's calculate a large distance, like the nearest star system.
  final alphaCentauriDistance = 4.37.ly;

  // Default US-style formatting with thousands separators.
  print(
    'Distance to Alpha Centauri: ${alphaCentauriDistance.toString(targetUnit: LengthUnit.kilometer, fractionDigits: 0, locale: 'en_US')}',
  );
}
