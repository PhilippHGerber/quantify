# Quantify

[![pub version](https://img.shields.io/pub/v/quantify.svg)](https://pub.dev/packages/quantify)
[![license](https://img.shields.io/badge/license-MIT-blue.svg)](https://github.com/PhilippHGerber/quantify/blob/main/LICENSE)

A type-safe unit of measurement converter library for Dart with elegant syntax, high precision, and optimal performance.

## Why `quantify`?

`quantify` makes working with physical units in Dart safer, more readable, and efficient:

* **Type Safety:** Prevents unit mismatch errors at compile-time.
* **Elegant API:** Intuitive syntax like `10.m` or `length.inKm`.
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

  // Convert to value / a new Quantity object
  double pathInKm = pathA.inKm;
  final pathAsKm = pathA.asKm;

  // Convert and print
  print(pathA.toString(targetUnit: LengthUnit.kilometer, fractionDigits: 1));  // Output: "1.5 km"
  print(pathB.toString(targetUnit: LengthUnit.mile, fractionDigits: 2));  // Output: "1.55 mi" (approx.)

  // Arithmetic
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
  quantify: ^0.6.0 # Or latest version
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
| --- Derived ---         |        |                                                                                                                                        |                           |
| **Angle**               |   ✅    | **`rad`** (radian), `°` (degree), `grad`, `rev`, `arcmin` ('), `arcsec` ("), `mrad`                                                    | Derived SI: dimensionless |
| **Angular Velocity**    |   ✅    | **`rad/s`**, `°/s`, `rpm`, `rps`                                                                                                       | Derived SI: 1/s           |
| **Speed / Velocity**    |   ✅    | **`m/s`** (meter per second), `km/h`, `mph`, `kn` (knot), `ft/s`                                                                       | Derived SI                |
| **Acceleration**        |   ✅    | **`m/s²`** (meter per second squared), `g` (standard gravity), `km/h/s`                                                                | Derived SI                |
| **Force**               |   ✅    | **`N`** (Newton), `lbf` (pound-force), `dyn` (dyne), `kgf` (kilogram-force), `kN`                                                      | Derived SI: kg·m/s²       |
| **Pressure**            |   ✅    | **`Pa`** (Pascal), `atm`, `bar`, `psi`, `Torr`, `mmHg`, `inHg`, `kPa`, `hPa`, `mbar`, `cmH₂O`, `inH₂O`                                 | Derived SI: N/m²          |
| Area                    |   🗓️    | **`m²`** (square meter), `km²`, `cm²`, `ha` (hectare), `acre` ...                                                                      | Derived SI                |
| Volume                  |   🗓️    | **`m³`** (cubic meter), `L` (liter), `mL`, `cm³`, `gal` (gallon), `fl oz` ...                                                          | Derived SI                |
| Energy / Work           |   🗓️    | **`J`** (Joule), `kWh` (kilowatt-hour), `cal` (calorie), `eV` (electronvolt) ...                                                       | Derived SI: N·m           |
| Power                   |   💡    | **`W`** (Watt), `hp` (horsepower) ...                                                                                                  | Derived SI: J/s           |
| Frequency               |   💡    | **`Hz`** (Hertz), `kHz`, `MHz` ...                                                                                                     | Derived SI: 1/s           |

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

### Comparisons & Sorting

Quantities are `Comparable`, allowing them to be sorted even if their units differ. `compareTo()` is used for magnitude comparison. The `==` operator checks for equal value AND unit.

```dart
final oneMeter = 1.m;
final hundredCm = 100.cm;
final oneYard = 1.yd;

print(oneMeter.compareTo(hundredCm) == 0); // true (magnitudes are equal)
print(oneMeter == hundredCm);          // false (units are different)

// Sort mixed units
final lengths = [1.mi, 2000.m, 1.km, 5000.ft];
lengths.sort(); // Sorts by physical magnitude
```

## **Managing Imports and Avoiding Conflicts**

`quantify` is designed to be both convenient and robust. By default, importing `package:quantify/quantify.dart` gives you access to all quantities and their handy extensions (like `10.m` or `5.s`).

However, in large projects or when combining `quantify` with other libraries, this might lead to name conflicts with extension methods. To give you full control over what is imported into your project's namespace, `quantify` provides separate entry points for each quantity type.

If you encounter a name conflict or simply want to be more explicit about your dependencies, you can import only the quantities you need.

**Example: Importing only Length and Time**

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

* **V1.0 (Current):** All 7 SI base units with comprehensive unit coverage
* **V2.0 and Beyond:**
  * **High Precision:** Support for `Decimal`.
  * **Enhanced Quantity Arithmetic:** e.g., `Distance / Time = Speed`.
  * **More Derived Units:** Area, Volume, Speed, Force, Energy, Power, etc.
  * **Serialization support.**

## Contributing

Contributions are welcome! Please open an [Issue](https://github.com/PhilippHGerber/quantify/issues) or a [Pull Request](https://github.com/PhilippHGerber/quantify/pulls).

## License

MIT License - see the `LICENSE` file.
