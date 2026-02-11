# quantify - Type-Safe Unit Conversion & Measurement for Dart & Flutter

[![pub package](https://img.shields.io/pub/v/quantify.svg?label=pub.dev&labelColor=333940&logo=flutter&color=00589B)](https://pub.dev/packages/quantify) [![license](https://img.shields.io/badge/License-MIT-blue.svg)](https://github.com/PhilippHGerber/quantify/blob/main/LICENSE) [![style: very good analysis](https://img.shields.io/badge/Style-very_good_analysis-B22C89.svg)](https://pub.dev/packages/very_good_analysis) [![tests](https://github.com/PhilippHGerber/quantify/actions/workflows/package.yaml/badge.svg)](https://github.com/PhilippHGerber/quantify/actions/workflows/package.yaml) [![coverage](https://raw.githubusercontent.com/PhilippHGerber/quantify/badges/coverage.svg)](https://github.com/PhilippHGerber/quantify/actions/workflows/package.yaml)

**quantify** is a modern, type-safe unit conversion and measurement library for Dart and Flutter. Convert between physical units with elegant syntax, zero runtime errors, and built-in physics constants — perfect for scientific apps, engineering tools, fitness trackers, and IoT dashboards.

```dart
  // Create quantities
  final pathA = 1500.m;
  final pathB = 2.5.km;

  // Arithmetic
  final distance = pathA + pathB; // pathB is converted to meters

  // Convert to double valuea
  double pathInKm = pathA.inKm;
  // A new Quantity object
  Length pathAsKm = pathA.asKm;

  // Convert and print
  print(pathA);
  // Output: "1500.0 m"
  print(pathA.toString(targetUnit: LengthUnit.kilometer, fractionDigits: 1));
  // Output: "1.5 km"
  print(pathB.toString(targetUnit: LengthUnit.mile, fractionDigits: 2));
  // Output: "1.55 mi" (approx.)
```

---

## ⚡ Quick Start

### Installation

Add to your `pubspec.yaml`:

```yaml
dependencies:
  quantify: ^0.13.0
```

## Why `quantify`?

`quantify` makes working with physical units in Dart safer, more readable, and efficient:

* **Type Safety:** Prevents unit mismatch errors at compile-time.
* **Elegant API:** Intuitive syntax like `10.m` or `length.inKm`.
* **Rich Constants Library:** Provides type-safe physical, astronomical, and engineering constants.
* **Precise & Performant:** Uses `double` and direct conversion factors for speed and to minimize rounding errors.
* **Immutable:** `Quantity` objects are immutable for safer code.
* **Configurable Output:** Highly flexible `toString()` for customized formatting.
* **Lightweight:** Minimal dependencies.

## Quick Start

```dart
import 'package:quantify/quantify.dart';
// For locale-specific number formatting, add 'intl' to your pubspec.yaml
// and import 'package:intl/intl.dart';

void main() {
  // Create quantities
  final pathA = 1500.m;
  final pathB = 2.5.km;

  // Arithmetic
  final distance = pathA + pathB; // pathB is converted to meters

  // Convert to double valuea
  double pathInKm = pathA.inKm;
  // A new Quantity object
  final pathAsKm = pathA.asKm;

  // Convert and print
  print(pathA.toString());
  print(pathA.toString(targetUnit: LengthUnit.kilometer, fractionDigits: 1));
  // Output: "1.5 km"
  print(pathB.toString(targetUnit: LengthUnit.mile, fractionDigits: 2));
  // Output: "1.55 mi" (approx.)


  final distance = pathA + pathB; // pathB is converted to meters
  print(distance.toString(fractionDigits: 0));  // Output: "4000 m"
  print(distance.toString(
    targetUnit: LengthUnit.yard,
    fractionDigits: 0,
  ));  // Output: "4374 yd" (approx., with non-breaking space)

  // Locale-specific example (if 'intl' is used)
  // final distanceDE = 1234.567.m;
  print(distanceDE.toString(
    targetUnit: LengthUnit.kilometer,
    fractionDigits: 2,
    locale: 'de_DE',
  ));  // Output: "1,23 km"
}
```

## Installation

Add to your `pubspec.yaml`:

```yaml
dependencies:
  quantify: ^0.12.0 # Or the latest version
  # Optional, for locale-specific number formatting:
  # intl: ^0.19.0
```

Then run `dart pub get` or `flutter pub get`.

## Supported Units

The library supports a comprehensive range of physical quantities, including all 7 SI base units and many derived units:

| Quantity Type           | Status | Units Available                                                                                                                        | Notes / SI Base Unit Ref. |
| :---------------------- | :----: | :------------------------------------------------------------------------------------------------------------------------------------- | :------------------------ |
| **Length**              |   ✅    | **`m`** (meter), `km`, `hm`, `dam`, `dm`, `cm`, `mm`, `μm`, `nm`, `pm`, `fm`, `in`, `ft`, `yd`, `mi`, `nmi`, `AU`, `ly`, `pc`, `Å`     | SI Base: Meter (m)        |
| **Mass**                |   ✅    | **`kg`** (kilogram), `hg`, `dag`, `g`, `dg`, `cg`, `mg`, `μg`, `ng`, `t`, `lb`, `oz`, `st`, `slug`, `short ton`, `long ton`, `u`, `ct` | SI Base: Kilogram (kg)    |
| **Time**                |   ✅    | **`s`** (second), `μs`, `ns`, `ps`, `ms`, `min`, `h`, `d`, `wk`, `mo`, `yr`                                                            | SI Base: Second (s)       |
| **Electric Current**    |   ✅    | **`A`** (ampere), `mA`, `μA`, `nA`, `kA`                                                                                               | SI Base: Ampere (A)       |
| **Temperature**         |   ✅    | **`K`** (kelvin), `°C` (celsius), `°F` (fahrenheit), `°R` (rankine)                                                                    | SI Base: Kelvin (K)       |
| **Amount of Substance** |   ✅    | **`mol`** (mole), `mmol`, `μmol`, `nmol`, `pmol`, `kmol`                                                                               | SI Base: Mole (mol)       |
| **Luminous Intensity**  |   ✅    | **`cd`** (candela), `mcd`, `kcd`                                                                                                       | SI Base: Candela (cd)     |
| *Derived*               |        |                                                                                                                                        |                           |
| **Angle**               |   ✅    | **`rad`** (radian), `°` (degree), `grad`, `rev`, `arcmin` ('), `arcsec` ("), `mrad`                                                    | Derived SI: dimensionless |
| **Angular Velocity**    |   ✅    | **`rad/s`**, `°/s`, `rpm`, `rps`                                                                                                       | Derived SI: 1/s           |
| **Speed / Velocity**    |   ✅    | **`m/s`** (meter per second), `km/h`, `mph`, `kn` (knot), `ft/s`                                                                       | Derived SI                |
| **Acceleration**        |   ✅    | **`m/s²`**, `g` (standard gravity), `km/h/s`, `cm/s²` (Galileo)                                                                        | Derived SI                |
| **Force**               |   ✅    | **`N`** (Newton), `lbf`, `dyn`, `kgf`, `kN`, `gf`, `pdl`                                                                               | Derived SI: kg·m/s²       |
| **Pressure**            |   ✅    | **`Pa`** (Pascal), `atm`, `bar`, `psi`, `Torr`, `mmHg`, `inHg`, `kPa`, `hPa`, `mbar`, `cmH₂O`, `inH₂O`                                 | Derived SI: N/m²          |
| **Area**                |   ✅    | **`m²`**, `Mm²`, `km²`, `hm²`, `dam²`, `dm²`, `cm²`, `mm²`, `µm²`, `ha`, `mi²`, `acre`, `yd²`, `ft²`, `in²`                            | Derived SI                |
| **Volume**              |   ✅    | **`m³`**, **`L`**, `mL`, `cl`, `gal`, `fl-oz`, `ft³`, `in³`, `qt`, `pt`, `tbsp`, `tsp`...                                              | Derived SI: L (Liter)     |
| **Frequency**           |   ✅    | **`Hz`**, `kHz`, `MHz`, `GHz`, `THz`, `rpm`, `bpm`                                                                                     | Derived SI: 1/s           |
| **Electric Charge**     |   ✅    | **`C`**, `mC`, `µC`, `nC`, `Ah`, `e`, `mAh`, `statC`, `abC`                                                                            | Derived SI: A·s           |
| **Density**             |   ✅    | **`kg/m³`**, `g/cm³`, `g/mL`                                                                                                           | Derived SI: kg/m³         |
| **Solid Angle**         |   ✅    | **`sr`**, `deg²` (Square Degree), `sp` (Spat)                                                                                          | Derived SI: dimensionless |
| **Energy / Work**       |   ✅    | **`J`** (Joule), `kJ`, `MJ`, `kWh`, `cal`, `kcal`, `eV`, `Btu`                                                                         | Derived SI: N·m           |
| **Specific Energy**     |   ✅    | **`J/kg`**, `kJ/kg`, `Wh/kg`, `kWh/kg`                                                                                                 | Derived SI: J/kg          |
| **Power**               |   ✅    | **`W`** (Watt), `mW`, `kW`, `MW`, `GW`, `hp`, `PS` (metric hp), `Btu/h`, `erg/s`                                                       | Derived SI: J/s           |

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

`quantify` includes a comprehensive library of type-safe physical, astronomical, and engineering constants.

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

The `toString()` method on `Quantity` objects is highly configurable:

```dart
final myDistance = 1578.345.m;

// Default
print(myDistance.toString()); // "1578.345 m"

// Convert to kilometers, 2 fraction digits
print(myDistance.toString(targetUnit: LengthUnit.kilometer, fractionDigits: 2));
// Output: "1.58 km"

// Scientific notation with micrometers
final smallLength = 0.000523.m;
print(smallLength.toString(targetUnit: LengthUnit.micrometer, fractionDigits: 0));
// Output: "523 μm"
```

### Arithmetic Operations

Standard arithmetic operators (`+`, `-`, `*`, `/` by a scalar) are overloaded. The result's unit is typically that of the left-hand operand. `Temperature` has specific arithmetic rules.

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

#### Equality Checks (`isEquivalentTo()` vs. `==`)

It's important to understand the two types of equality checks available:

1. **Magnitude Equality (`isEquivalentTo`)**: Checks if two quantities represent the **same physical amount**.
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

#### Sorting

```dart
final lengths = [1.mi, 2000.m, 1.km, 5000.ft]
..sort(); // Sorts by physical magnitude
print(lengths.map((l) => l.toString()).join(', '));
// Output: 1.0 km, 5000.0 ft, 1.0 mi, 2000.0 m
print(lengths.map((l) => l.asM).join(', '));
// Output: 1000.0 m, 1524.0 m, 1609.344 m, 2000.0 m
```

## **Managing Imports and Avoiding Conflicts**

`quantify` is designed to be both convenient and robust. By default, importing `package:quantify/quantify.dart` gives you access to all quantities and their handy extensions (like `10.m` or `5.s`).

However, in large projects or when combining `quantify` with other libraries, this might lead to name conflicts with extension methods. To give you full control over what is imported into your project's namespace, `quantify` provides separate entry points for each quantity type.

If you encounter a name conflict or simply want to be more explicit about your dependencies, you can import only the quantities you need.

### Example: Importing only Length and Time

Instead of the main package, you can import specific libraries:

```dart

// Import only the extensions you need
import 'package:quantify/length.dart';
import 'package:quantify/time.dart';

void main() {
  // Now, only extensions for Length and Time are available.
  final distance = 100.m; // Works
  final duration = 30.s;   // Works

  // This will cause a compile-time error because Mass extensions were not imported.
  // final weight = 70.kg; // ERROR: The getter 'kg' isn't defined for the type 'int'.

  // You can still create the Mass object using its constructor:
  final weight = Mass(70, MassUnit.kilogram); // This always works
}
```

This granular approach ensures that `quantify` can be used safely and effectively in any project, no matter how complex.

## Goals & Roadmap

* **V1.0 (Current):** All 7 SI base units with comprehensive unit coverage and a rich constants library.
* **V2.0 and Beyond:**
  * **High Precision:** Support for `Decimal`.
  * **Serialization support.**
  * **Compound Units:** More advanced `Quantity` types (e.g., `Density`, `Resistivity`).

## Contributing

Contributions are welcome! Please open an [Issue](https://github.com/PhilippHGerber/quantify/issues) or a [Pull Request](https://github.com/PhilippHGerber/quantify/pulls).

## License

MIT License - see the `LICENSE` file.
