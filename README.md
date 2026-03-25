# Quantify - Type-safe unit conversion

[![platform](https://img.shields.io/badge/platform-flutter%20%7C%20dart-35B8F7.svg)](https://pub.dev/packages/quantify) [![pub package](https://img.shields.io/pub/v/quantify.svg?label=pub.dev&labelColor=333940&logo=flutter&color=00589B)](https://pub.dev/packages/quantify) [![pub points](https://img.shields.io/pub/points/quantify?logo=dart)](https://pub.dev/packages/quantify/score) [![license](https://img.shields.io/badge/License-MIT-blue.svg)](https://github.com/PhilippHGerber/quantify/blob/main/LICENSE) [![style: very good analysis](https://img.shields.io/badge/Style-very_good_analysis-B22C89.svg)](https://pub.dev/packages/very_good_analysis) [![tests](https://github.com/PhilippHGerber/quantify/actions/workflows/package.yaml/badge.svg)](https://github.com/PhilippHGerber/quantify/actions/workflows/package.yaml) [![coverage](https://raw.githubusercontent.com/PhilippHGerber/quantify/badges/coverage.svg)](https://github.com/PhilippHGerber/quantify/actions/workflows/package.yaml) [![AI Skills](https://img.shields.io/badge/AI-SKILL.md-blueviolet?logo=data:image/svg+xml;base64,PHN2ZyB4bWxucz0iaHR0cDovL3d3dy53My5vcmcvMjAwMC9zdmciIGVuYWJsZS1iYWNrZ3JvdW5kPSJuZXcgMCAwIDI0IDI0IiBoZWlnaHQ9IjI0cHgiIHZpZXdCb3g9IjAgMCAyNCAyNCIgd2lkdGg9IjI0cHgiIGZpbGw9IiNmZmZmZmYiPjxnPjxyZWN0IGZpbGw9Im5vbmUiIGhlaWdodD0iMjQiIHdpZHRoPSIyNCIgeD0iMCIvPjwvZz48Zz48Zz48cG9seWdvbiBwb2ludHM9IjE5LDkgMjAuMjUsNi4yNSAyMyw1IDIwLjI1LDMuNzUgMTksMSAxNy43NSwzLjc1IDE1LDUgMTcuNzUsNi4yNSIvPjxwb2x5Z29uIHBvaW50cz0iMTksMTUgMTcuNzUsMTcuNzUgMTUsMTkgMTcuNzUsMjAuMjUgMTksMjMgMjAuMjUsMjAuMjUgMjMsMTkgMjAuMjUsMTcuNzUiLz48cGF0aCBkPSJNMTEuNSw5LjVMOSw0TDYuNSw5LjVMMSwxMmw1LjUsMi41TDksMjBsMi41LTUuNUwxNywxMkwxMS41LDkuNXogTTkuOTksMTIuOTlMOSwxNS4xN2wtMC45OS0yLjE4TDUuODMsMTJsMi4xOC0wLjk5IEw5LDguODNsMC45OSwyLjE4TDEyLjE3LDEyTDkuOTksMTIuOTl6Ii8+PC9nPjwvZz48L3N2Zz4=&logoColor=white)](./skills/quantify-usage/SKILL.md)

**Quantify** is a comprehensive, type-safe unit conversion library. Convert length, mass, temperature, speed, force, energy, and 20+ other physical quantities with compile-time safety, elegant syntax, and optimal performance. Perfect for scientific computing, engineering applications, fitness tracking, IoT projects, and any cross-platform app that works with measurements.

## Why `quantify`?

`quantify` makes working with physical units in Dart and Flutter safer, more readable, and efficient:

* **Type Safety:** Prevents unit mismatch errors at compile-time - no more accidentally adding kilograms to meters.
* **Elegant API:** Intuitive syntax like `10.m` or `length.inKm` that reads naturally.
* **Cross-Platform:** Works identically across Flutter and pure Dart projects.
* **Rich Constants Library:** Provides type-safe physical, astronomical, and engineering constants ready for calculations.
* **Precise & Performant:** Uses `double` and direct conversion factors for speed and to minimize rounding errors.
* **Immutable:** `Quantity` objects are immutable for safer, more predictable code.
* **Configurable Output:** Highly flexible `toString()` for customized formatting with locale support.
* **Robust Parsing:** Built-in string parsing with locale handling and custom alias support.
* **Lightweight:** Minimal dependencies - just `intl` and `meta`.

## Quick Start

```dart
import 'package:quantify/quantify.dart';

void main() {
  // Create quantities
  final pathA = 1500.m;
  final pathB = 2.5.km;

  // Convert to value / a new Quantity object
  double pathInKm = pathA.inKm;
  final pathAsKm = pathA.asKm;

  // Convert and print
  print(pathA.toString(targetUnit: LengthUnit.kilometer));
  // Output: "1.5 km"
  print(pathB.toString(targetUnit: LengthUnit.mile));
  // Output: "1.55 mi" (approx.)

  // Arithmetic
  final distance = pathA + pathB; // pathB is converted to meters
  print(distance.toString());  // Output: "4000 m"
  print(distance.toString(targetUnit: LengthUnit.yard));
  // Output: "4374 yd" (approx., with non-breaking space)

  // Locale-specific example
  final distanceDE = 1234.567.m;
  print(distanceDE.toString(targetUnit: LengthUnit.kilometer));
  // Output: "1,23 km"

  // Parsing
  final parsed = Length.parse('10.5 km');
  print(parsed.inM); // 10500.0
}
```

### Granular Imports

By default, `import 'package:quantify/quantify.dart'` gives you everything. In large projects or when combining `quantify` with other libraries, extension method conflicts can occur. Import only what you need using per-quantity entry points:

```dart
import 'package:quantify/length.dart';
import 'package:quantify/time.dart';

void main() {
  final distance = 100.m; // Works
  final duration = 30.s;   // Works
  // final weight = 70.kg; // Compile error — Mass not imported
}
```

## Supported Units

The library supports a comprehensive range of physical quantities, including all 7 SI base units and many derived units - ideal for scientific computing, engineering calculations, and any Flutter or Dart application requiring precise unit conversions:

| Quantity Type           | Status | Units Available                                                                                                                        | Notes / SI Base Unit Ref.                               |
| ----------------------- | ------ | -------------------------------------------------------------------------------------------------------------------------------------- | ------------------------------------------------------- |
| **Length**              | ✅     | **`m`** (meter), `km`, `Mm`, `Gm`, `hm`, `dam`, `dm`, `cm`, `mm`, `μm`, `nm`, `pm`, `fm`, `in`, `ft`, `yd`, `mi`, `nmi`, `AU`, `ly`, `pc`, `Å` | SI Base: Meter (m)                                      |
| **Mass**                | ✅     | **`kg`** (kilogram), `hg`, `dag`, `g`, `dg`, `cg`, `mg`, `μg`, `ng`, `Mg`, `Gg`, `t`, `lb`, `oz`, `st`, `slug`, `short ton`, `long ton`, `u`, `ct` | SI Base: Kilogram (kg)                                  |
| **Time**                | ✅     | **`s`** (second), `μs`, `ns`, `ps`, `ms`, `cs`, `ds`, `das`, `hs`, `ks`, `Ms`, `Gs`, `min`, `h`, `d`, `wk`, `fn`, `mo`, `yr`, `dec`, `c` | SI Base: Second (s)                                     |
| **Electric Current**    | ✅     | **`A`** (ampere), `mA`, `μA`, `nA`, `pA`, `fA`, `kA`, `MA`, `GA`, `statA`, `abA`                                             | SI Base: Ampere (A)                                     |
| **Temperature**         | ✅     | **`K`** (kelvin), `°C` (celsius), `°F` (fahrenheit), `°R` (rankine)                                                                    | SI Base: Kelvin (K). Affine conversions.                |
| **TemperatureDelta**    | ✅     | **`K`** (kelvinDelta), `°C` (celsiusDelta), `°F` (fahrenheitDelta), `°R` (rankineDelta)                                                | Linear. Represents a temperature *change*, not a point. |
| **Amount of Substance** | ✅     | **`mol`** (mole), `mmol`, `μmol`, `nmol`, `pmol`, `fmol`, `kmol`, `Mmol`, `lb-mol` (pound-mole)                                        | SI Base: Mole (mol)                                     |
| **Luminous Intensity**  | ✅     | **`cd`** (candela), `mcd`, `μcd`, `kcd`, `Mcd`                                                                                         | SI Base: Candela (cd)                                   |
| *Derived*               |        |                                                                                                                                        |                                                         |
| **Angle**               | ✅     | **`rad`** (radian), `°` (degree), `grad`, `rev`, `arcmin` ('), `arcsec` ("), `mrad`                                                    | Derived SI: dimensionless                               |
| **Angular Velocity**    | ✅     | **`rad/s`**, `°/s`, `rpm`, `rps`                                                                                                       | Derived SI: 1/s                                         |
| **Speed / Velocity**    | ✅     | **`m/s`** (meter per second), `km/s`, `km/h`, `mph`, `kn` (knot), `ft/s`                                                               | Derived SI                                              |
| **Acceleration**        | ✅     | **`m/s²`**, `g` (standard gravity), `km/h/s`, `mph/s`, `kn/s`, `ft/s²`, `cm/s²` (Galileo)                                             | Derived SI                                              |
| **Force**               | ✅     | **`N`** (Newton), `lbf`, `dyn`, `kgf`, `kN`, `MN`, `GN`, `mN`, `µN`, `nN`, `gf`, `pdl`                                                   | Derived SI: kg·m/s²                                     |
| **Pressure**            | ✅     | **`Pa`** (Pascal), `atm`, `bar`, `psi`, `Torr`, `mmHg`, `inHg`, `kPa`, `hPa`, `GPa`, `MPa`, `mbar`, `µPa`, `cmH₂O`, `inH₂O`             | Derived SI: N/m²                                        |
| **Area**                | ✅     | **`m²`**, `Mm²`, `km²`, `hm²`, `dam²`, `dm²`, `cm²`, `mm²`, `µm²`, `ha`, `mi²`, `acre`, `yd²`, `ft²`, `in²`                            | Derived SI                                              |
| **Volume**              | ✅     | **`m³`**, `km³`, `hm³`, `dam³`, `dm³`, `cm³`, `mm³`, `mi³`; **`L`**, `kl`, `Ml`, `Gl`, `Tl`, `cl`, `mL`, `µL`; `gal`, `qt`, `pt`, `fl-oz`, `tbsp`, `tsp`, `ft³`, `in³` | Derived SI: L (Liter)                                   |
| **Frequency**           | ✅     | **`Hz`**, `kHz`, `MHz`, `GHz`, `THz`, `mHz`, `rpm`, `bpm`, `rad/s`, `°/s`                                                              | Derived SI: 1/s                                         |
| **Electric Charge**     | ✅     | **`C`**, `kC`, `mC`, `µC`, `nC`, `pC`, `Ah`, `e`, `mAh`, `statC`, `Fr`, `abC`                                                          | Derived SI: A·s                                         |
| **Solid Angle**         | ✅     | **`sr`**, `deg²` (Square Degree), `sp` (Spat)                                                                                          | Derived SI: dimensionless                               |
| **Energy / Work**       | ✅     | **`J`** (Joule), `kJ`, `MJ`, `GJ`, `TJ`, `kWh`, `mJ`, `µJ`, `cal`, `kcal`, `eV`, `Btu`                                                 | Derived SI: N·m                                         |
| **Power**               | ✅     | **`W`** (Watt), `mW`, `kW`, `MW`, `GW`, `TW`, `μW`, `nW`, `hp`, `PS` (metric hp), `Btu/h`, `erg/s`                                     | Derived SI: J/s                                         |
| **Density**             | ✅     | **`kg/m³`** (kilogram per cubic meter), `g/cm³`, `g/mL`                                                                             | Derived SI: kg/m³                                       |
| **Specific Energy**     | ✅     | **`J/kg`** (joule per kilogram), `kJ/kg`, `Wh/kg`, `kWh/kg`                                                                        | Derived SI: J/kg                                        |
| **Information**         | ✅     | **`bit`**, `B` (byte); SI bits: `kbit`…`Ybit`; SI bytes: `kB`…`YB`; IEC binary: `KiB`…`YiB`                                        | IEC 80000-13. Three tracks: SI bit, SI byte, IEC binary. |

## Detailed Usage

### Creating Quantities

Use extension methods on `num` for readability:

```dart
final myLength = 25.5.m;
final anotherLength = 10.ft; // feet
final verySmall = 500.nm; // nanometers
final astronomical = 4.2.ly; // light years
```

Or use the constructor of the specific `Quantity` class:

```dart
final specificLength = Length(5.0, LengthUnit.yard);
```

#### Dual API: SI Symbols vs. Full-Word Getters

For units with uppercase SI/IEC symbols, `quantify` provides **two equivalent ways** to create quantities — choose whichever reads better in your code:

```dart
// SI symbols (primary): uppercase for international standard compliance
final distance1 = 5.Mm;        // megameters (SI symbol)
final distance2 = 5.megameters; // megameters (Dart-idiomatic full word)
// Both are equivalent: distance1 == distance2

// More examples
final mass1 = 2.Mg;            // megagrams (SI: capital M = mega)
final mass2 = 2.megagrams;     // Same thing, different style

final freq1 = 100.MHz;         // megahertz (SI requires capital H)
final freq2 = 100.megahertz;   // Same, but maybe more readable in context

final energy1 = 50.MJ;         // megajoules
final energy2 = 50.megajoules; // Same quantity
```

This **dual API** ensures:

* **International compliance:** SI symbols (`Mm`, `Hz`, `MJ`, etc.) follow official standards
* **Code readability:** Full-word getters (`megameters`, `hertz`, `megajoules`) read naturally in English
* **Consistency:** All 25 quantities follow the same pattern
* **No performance cost:** Both compile to identical bytecode

### Converting and Retrieving Values

1. **Get Numerical Value:** Use `in[UnitName]` getters or `getValue(TargetUnit)`.

   ```dart
   final oneMile = 1.0.mi;
   double milesInKm = oneMile.inKm; // approx 1.609344
   double milesInMeters = oneMile.getValue(LengthUnit.meter); // approx 1609.344

   final smallDistance = 1.um; // micrometer
   double inNanometers = smallDistance.inNm; // 1000.0
   ```

2. **Get New `Quantity` Object:** Use `convertTo(TargetUnit)` or `as[UnitName]` getters.

   ```dart
   final tenMeters = 10.m;
   final tenMetersInFeetObj = tenMeters.convertTo(LengthUnit.foot);
   // tenMetersInFeetObj is Length(approx 32.8084, LengthUnit.foot)
   final tenMetersInKmObj = tenMeters.asKm;
   // tenMetersInKmObj is Length(0.01, LengthUnit.kilometer)
   ```

### Using the Constants Library

`quantify` includes a comprehensive library of type-safe physical, astronomical, and engineering constants - perfect for scientific computing and engineering applications.

```dart
import 'package:quantify/quantify.dart';
import 'package:quantify/constants.dart'; // Import the constants library

void main() {
  // Constants are already Quantity objects, ready for use.
  final gravity = AstronomicalConstants.standardGravity; // An Acceleration object
  final electron = PhysicalConstants.electronMass; // A Mass object
  final speedOfLight = PhysicalConstants.speedOfLight; // A Speed object
  final steelStiffness = EngineeringConstants.steelYoungsModulus; // A Pressure object

  // Use them in calculations
  final weightOfElectron = Force.from(electron, gravity);
  print('Weight of an electron on Earth: ${weightOfElectron.inNewtons} N');

  // Use convenience methods for common formulas
  final photonEnergy = PhysicalConstants.photonEnergy(500.0.nm); // Returns an Energy object
  print('Energy of a 500nm photon: ${photonEnergy.inElectronvolts.toStringAsFixed(2)} eV');
}
```

### Formatting Output with `toString()`

The `toString()` method on `Quantity` objects is highly configurable with full locale support:

```dart
final myDistance = 1578.345.m;

// Default
print(myDistance.toString()); // "1578.345 m"

// Convert to kilometers, 2 fraction digits
print(myDistance.toString(targetUnit: LengthUnit.kilometer));
// Output: "1.58 km"

// Scientific notation with micrometers
final smallLength = 0.000523.m;
print(smallLength.toString(targetUnit: LengthUnit.micrometer));
// Output: "523 μm"
```

### Parsing Strings & Custom Aliases

`quantify` provides a robust, extensible parsing engine to convert user input back into `Quantity` objects.

```dart
final dist = Length.parse('10.5 km');
final weight = Mass.tryParse('180 lbs'); // Returns null if parsing fails
```

**Case Sensitivity & SI Prefixes:**
To prevent collisions, SI unit prefixes are **strictly case-sensitive** (`10 mm` parses as millimeters, `10 Mm` parses as megameters). However, Non-SI and Imperial units (like `lb`, `ft`, `mi`) are **case-insensitive** (`180 LBS` and `180 lbs` both work perfectly).

**Locale & Number Formatting:**
By default (`QuantityFormat.invariant`), the parser expects **standard machine-readable numbers** — a period (`.`) as the decimal separator and no thousands separators (the same format used by JSON and Dart's `double.parse`). Comma-decimal strings like `"1,5 km"` will return `null` from the default parser.

To safely parse localized user input, pass a prioritized list of `QuantityFormat`s. The parser tries them in order and handles regional ambiguities:

```dart
// Parse a German-formatted string with comma decimal and dot thousands separator
final length = Length.parse('1.234,56 km', formats: [QuantityFormat.de]);

// Ambiguous comma: try US format first (comma = thousands sep), then German (comma = decimal)
final weight = Mass.parse('1,234 kg', formats: [QuantityFormat.enUs, QuantityFormat.de]);
// → 1234.0 kg  (US format matched first)

// Or with a custom NumberFormat from 'intl':
final format = NumberFormat.decimalPattern('de_DE');
final length2 = Length.parse('1.234,56 km', formats: [QuantityFormat.withNumberFormat(format)]);
```

*(Note: Compound imperial units like `6'2"` are not natively supported by a single `.parse()` call. They should be parsed and added individually: `Length.parse("6'") + Length.parse("2\"")`)*

**Custom Localization & Isolated Parsers (Aliases):**
`QuantityParser` is fully immutable. To add custom unit names or abbreviations, use `copyWithAliases` to derive a new parser — the original is never modified.

```dart
// Create a Spanish-language parser derived from the standard one
final spanishLengthParser = Length.parser.copyWithAliases(
  extraNameAliases: {
    'pulgada': LengthUnit.inch,
    'pulgadas': LengthUnit.inch,
  },
  extraSymbolAliases: {'myKM': LengthUnit.kilometer},
);

// Parses successfully using the isolated parser
final tvSize = spanishLengthParser.parse('55 pulgada');

// The global default remains strictly standard
// Length.parse('55 pulgada'); // Throws QuantityParseException
```

For app-wide custom aliases, derive your parser once at startup and inject it where needed:

```dart
// main.dart (or your DI setup)
final appLengthParser = Length.parser.copyWithAliases(
  extraNameAliases: {'pulgada': LengthUnit.inch},
);

// Anywhere in your app:
final dist = appLengthParser.parse('55 pulgada');
```

### Arithmetic Operations

Standard arithmetic operators (`+`, `-`, `*`, `/` by a scalar) are overloaded. The result's unit is typically that of the left-hand operand.

```dart
final segment1 = 500.m;
final segment2 = 0.25.km; // 250 meters
final total = segment1 + segment2; // Result is in meters
print(total.toString()); // "750.0 m"

final scaled = segment1 * 3;
print(scaled.toString()); // "1500.0 m"

// Work with different scales
final bigMass = 5.t; // tonnes
final smallMass = 250.g; // grams
final combined = bigMass + smallMass; // Result: 5.00025 t
```

### Dimensional Analysis

`quantify` provides factory constructors that **derive one physical quantity from two others**, keeping your calculations within the type-safe ecosystem rather than dropping to raw `double`s.

```dart
// Area = Length × Length
final room = Area.from(5.m, 4.m);           // 20.0 m²
final plot = Area.from(1.km, 500.m);        // 500 000.0 m²

// Volume = Length × Length × Length
final box = Volume.from(2.m, 3.m, 4.m);    // 24.0 m³

// Volume = Area × depth
final floor = Area.from(10.m, 5.m);
final pool  = Volume.fromArea(floor, 2.m); // 100.0 m³

// Power = Energy / Time  ↔  Energy = Power × Time
final power  = Power.from(1.kWh, 1.hours);       // 1 000.0 W
final energy = Energy.from(1.kW, 1.hours);        // 3 600 000.0 J

// Pressure = Force / Area  ↔  Force = Pressure × Area
final pressure = Pressure.from(1000.N, 10.m2);   // 100.0 Pa
final force    = Force.fromPressure(pressure, 10.m2); // 1 000.0 N

// AngularVelocity = Angle / Time  ↔  Angle = AngularVelocity × Time
final av    = AngularVelocity.from(1.revolutions, 1.minutes); // 1.0 rpm
final angle = av.totalAngleOver(2.minutes);                   // 2.0 revolutions

// Density = Mass / Volume
final density = Density.from(1.kg, 1.liters);   // 1 000.0 kg/m³

// SpecificEnergy = Energy / Mass
final specific = SpecificEnergy.from(1.kJ, 0.5.kg); // 2 000.0 J/kg

// Frequency = 1 / Time (period → frequency)
final freq = Frequency.from(0.5.s);             // 2.0 Hz
```

All inputs are converted to SI base units before calculation, so **mixed units work correctly without any manual conversion**. Each pair of factories is a symmetric inverse of the other.

#### Dimensionless Ratios

Use `ratioTo` to divide two same-type quantities and get a plain `double`, without dropping to raw `.value` extraction:

```dart
final ratio = 10.km.ratioTo(2.m);   // 5000.0  (unit-independent)
final share = 500.g.ratioTo(2.kg);  // 0.25
```

Returns `double.infinity` when the divisor is zero (IEEE 754).

### Temperature & TemperatureDelta

`Temperature` is an **affine** quantity—absolute temperatures are points on a scale, not linear vectors. This means you cannot add two temperatures (20 °C + 20 °C is not 40 °C), and ratios between Celsius or Fahrenheit values are physically meaningless.

`TemperatureDelta` is the companion **linear** quantity representing a temperature **change**. It behaves like every other quantity: factor-based conversion with no offsets, and full arithmetic support.

```dart
// 1. Creating temperature deltas
final rise   = 20.celsiusDelta;    // A change of 20 °C (equivalent to 20 K)
final drop   = 18.fahrenheitDelta; // A change of 18 °F (equivalent to 10 K)
final step   = 5.kelvinDelta;

// 2. Point − Point = Vector (Temperature subtraction yields a Delta)
final t1 = 10.celsius;
final t2 = 30.celsius;
final delta = t2 - t1;              // Result is a TemperatureDelta object
print(delta.inCelsiusDelta);        // 20.0
print(delta.inFahrenheitDelta);     // 36.0 (Handles the 1.8x scaling automatically!)

// 3. Point + Vector = Point (Heating an object)
final heated = t1 + 20.celsiusDelta; // Temperature(30.0, celsius)

// 4. Point − Vector = Point (Cooling via named method)
final cooled = t2.subtract(5.kelvinDelta); // Temperature(25.0, celsius)

// 5. Vector Arithmetic & Scaling
final doubled = delta * 2.0;        // TemperatureDelta(40.0, celsiusDelta)
final combined = rise + drop;       // 20 + 10 = 30 celsiusDelta

// 6. Thermodynamic Ratios (Always calculated in Kelvin for physical validity)
final efficiency = 1.0 - 300.kelvin.ratioTo(600.kelvin); // Carnot: 0.5

// 7. Engineering constants now require TemperatureDelta (Prevents logic bugs)
final expansion = EngineeringConstants.thermalExpansion(
  10.0.m,
  11.7e-6,
  20.celsiusDelta, // Correctly treated as 20 K
);
```

> [!IMPORTANT]
> **Why a separate type?** Without `TemperatureDelta`, a 20°C *change* passed to a formula would be incorrectly converted to $293.15\,\text{K}$ (by adding the Celsius offset). This makes the result **~14× too large**. The type system now makes this common scientific mistake impossible at compile time.

### Comparisons & Sorting: Magnitude vs. Strict Equality

`quantify` provides a clear and intuitive way to compare quantities, distinguishing between checking for physical magnitude and strict equality.

#### Magnitude Comparison (using `>`, `<`, `>=`, `<=`)

All `Quantity` objects can be compared directly using standard relational operators. The library automatically handles unit conversions, so you can compare any two quantities of the same type (e.g., two `Length` objects) without worrying about their internal units.

```dart
final oneKm = 1.km;
final oneMile = 1.mi;
final thousandMeters = 1000.m;

print(oneMile > oneKm);          // true
print(oneKm < 999.m);            // false
print(oneKm >= thousandMeters);  // true
```

> **Tip:** Relational operators use strict `double` comparison and do not account for floating-point drift. For tolerance-aware boundary checks, combine with `isEquivalentTo`:
> ```dart
> if (a > b || a.isEquivalentTo(b)) { /* a >= b with tolerance */ }
> ```

#### Equality Checks (`isEquivalentTo()` vs. `==`)

There are two types of equality checks available:

1. **Magnitude Equality (`isEquivalentTo`)**: Checks if two quantities represent the **same physical amount**, with IEEE 754-safe relative tolerance.
2. **Strict Equality (`==`)**: Checks if two quantities have the **exact same value AND unit**.

```dart
final oneMeter = 1.m;
final hundredCm = 100.cm;

// Magnitude check: Do they represent the same distance?
print(oneMeter.isEquivalentTo(hundredCm)); // true

// Strict check: Are they represented in the same way?
print(oneMeter == hundredCm);              // false (different units: m vs cm)
print(oneMeter == 1.m);                    // true (same value and unit)
```

This distinction is crucial when working with collections like `Set`s or `Map`s, where the strict equality of `==` is typically the desired behavior.

#### IEEE 754-Safe Comparisons

`isEquivalentTo` uses a **relative tolerance** (default `1e-9`) that scales with the magnitude of the values. This means it is equally reliable across the full numeric range — from subatomic particles to astronomical distances — without any manual tuning:

```dart
// Floating-point arithmetic that would fail strict equality:
(0.1.m + 0.2.m).isEquivalentTo(0.3.m);  // true  ✓

// Astronomical scale (AU → metres):
1.AU.isEquivalentTo(149597870700.m);      // true  ✓

// Tighter or looser tolerance when you need it:
a.isEquivalentTo(b, tolerance: 1e-12);   // stricter
a.isEquivalentTo(b, tolerance: 1e-6);    // looser (e.g. sensor measurements)

// Comparison is always symmetric — a.isEquivalentTo(b) == b.isEquivalentTo(a):
0.0.m.isEquivalentTo(1e-10.m);           // false — relative tolerance collapses to 0 near zero
0.0.m.isEquivalentTo(0.0.km);            // true  — both are exactly zero

// IEEE 754 edge cases are handled correctly:
double.infinity.m.isEquivalentTo(1e300.m); // false — finite ≠ infinite
```

This makes `quantify` suitable for engineering apps, physics simulations, and calculator engines where accumulated floating-point drift is unavoidable.

#### Sorting

```dart
final lengths = [1.mi, 2000.m, 1.km, 5000.ft]
  ..sort(); // Sorts by physical magnitude
print(lengths.map((l) => l.toString()).join(', '));
// Output: 1.0 km, 5000.0 ft, 1.0 mi, 2000.0 m
print(lengths.map((l) => l.asM).join(', '));
// Output: 1000.0 m, 1524.0 m, 1609.344 m, 2000.0 m
```

## Use Cases

`quantify` is ideal for a wide range of applications:

* **Flutter Mobile & Desktop Apps:** Build cross-platform fitness trackers, recipe converters, travel planners, or educational apps that work seamlessly across iOS, Android, web, Windows, macOS, and Linux.
* **Scientific Computing:** Perform precise calculations with physical constants and units in research applications, data analysis tools, or simulation software.
* **Engineering Applications:** Handle structural calculations, electrical circuit design, fluid dynamics, thermodynamics, and other engineering domains requiring robust unit management.
* **IoT & Embedded Systems:** Process sensor readings in various units, convert between measurement systems, and display data in user-preferred formats.
* **Education & Training:** Create interactive learning tools that demonstrate unit conversions and physical relationships.
* **Health & Fitness:** Track running distances, cycling speeds, body measurements, calorie calculations, and nutrition metrics with proper unit handling.

## Goals & Roadmap

* **v1.0:** API stability milestone — no breaking changes after this point.
* **v2.0 and Beyond:**
  * **High Precision:** Support for `Decimal` types for applications requiring arbitrary precision.
  * **Serialization Support:** Built-in JSON serialization/deserialization.

## Contributing

Contributions are welcome! Please open an [Issue](https://github.com/PhilippHGerber/quantify/issues) or a [Pull Request](https://github.com/PhilippHGerber/quantify/pulls).

## License

MIT License - see the `LICENSE` file for details.
