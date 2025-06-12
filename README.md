# Quantify

[![pub version](https://img.shields.io/pub/v/quantify.svg)](https://pub.dev/packages/quantify)
[![license](https://img.shields.io/badge/license-MIT-blue.svg)](https://github.com/PhilippHGerber/quantify/blob/main/LICENSE)

A type-safe units of measurement library for Dart, providing an elegant syntax for unit conversions with good precision and optimal performance.

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

  // Convert and print using enhanced toString()
  print(pathA.toString(targetUnit: LengthUnit.kilometer, fractionDigits: 1));
  // Output: "1.5 km"

  print(pathB.toString(targetUnit: LengthUnit.mile, fractionDigits: 2));
  // Output: "1.55 mi" (approx.)

  // Arithmetic
  final totalDistance = pathA + pathB; // pathB is converted to meters
  print(totalDistance.toString(fractionDigits: 0));
  // Output: "4000 m"

  print(totalDistance.toString(
    targetUnit: LengthUnit.yard,
    fractionDigits: 0,
    unitSymbolSeparator: '\u00A0', // Non-breaking space
  ));
  // Output: "4374 yd" (approx., with non-breaking space)

  // Locale-specific example (if 'intl' is used)
  // final distanceDE = 1234.567.m;
  // print(distanceDE.toString(
  //   targetUnit: LengthUnit.kilometer,
  //   fractionDigits: 2,
  //   locale: 'de_DE',
  // ));
  // Output: "1,23 km"
}
```

## Installation

Add to your `pubspec.yaml`:

```yaml
dependencies:
  quantify: ^0.1.0 # Or latest version
  # Optional, for locale-specific number formatting:
  # intl: ^0.19.0
```

Then run `dart pub get` or `flutter pub get`.

## Supported Units

The library aims to support a wide range of physical quantities, including fundamental SI units and common derived units. Below is an overview:

| Quantity Type        | Status | Example Units Available / Planned (SI units emphasized)                                             | Notes / SI Base Unit Ref. |
| :------------------- | :-: | :----------------------------------------------------------------------------------------------------- | :------------------------ |
| **Length**           | ✅  | **`m`** (meter), `km`, `cm`, `mm`, `in`, `ft`, `yd`, `mi`, `nmi`                                       | SI Base: Meter (m)        |
| **Time**             | ✅  | **`s`** (second), `ms`, `min`, `h`, `d`                                                                | SI Base: Second (s)       |
| **Temperature**      | ✅  | **`K`** (kelvin), `°C` (celsius), `°F` (fahrenheit)                                                    | SI Base: Kelvin (K)       |
| **Mass**             | 🗓️  | **`kg`** (kilogram), `g`, `lb`, `oz` ...                                                               | SI Base: Kilogram (kg)    |
| **Pressure**         | ✅  | **`Pa`** (Pascal), `atm`, `bar`, `psi`, `Torr`, `mmHg`, `inHg`, `kPa`, `hPa`, `mbar`, `cmH₂O`, `inH₂O` | Derived SI: N/m²          |
| Area                 | 🗓️  | **`m²`** (square meter), `km²`, `acre`, `ha` ...                                                       | Derived SI                |
| Volume               | 🗓️  | **`m³`** (cubic meter), `L`, `mL`, `gal`, `fl oz` ...                                                  | Derived SI                |
| Speed / Velocity     | 🗓️  | **`m/s`** (meter per second), `km/h`, `mph` ...                                                        | Derived SI                |
| Force                | 🗓️  | **`N`** (Newton), `lbf` ...                                                                            | Derived SI: kg·m/s²       |
| Energy / Work        | 🗓️  | **`J`** (Joule), `kWh`, `cal` ...                                                                      | Derived SI: N·m           |
| Power                | 💡  | **`W`** (Watt) ...                                                                                     | Derived SI: J/s           |
| Frequency            | 💡  | **`Hz`** (Hertz) ...                                                                                   | Derived SI: 1/s           |
| Amount of Substance  | 💡  | **`mol`** (mole) ...                                                                                   | SI Base: Mole (mol)       |
| --- Electrical ---   |     |                                                                                                        |                           |
| Electric Current     | 💡  | **`A`** (Ampere) ...                                                                                   | SI Base: Ampere (A)       |
| Electric Charge      | 💡  | **`C`** (Coulomb) ...                                                                                  | Derived SI: A·s           |
| Electric Potential   | 💡  | **`V`** (Volt) ...                                                                                     | Derived SI: W/A           |
| Electric Resistance  | 💡  | **`Ω`** (Ohm) ...                                                                                      | Derived SI: V/A           |
| Electric Capacitance | 💡  | **`F`** (Farad) ...                                                                                    | Derived SI: C/V           |
| --- Photometric ---  |     |                                                                                                        |                           |
| Luminous Intensity   | 💡  | **`cd`** (Candela) ...                                                                                 | SI Base: Candela (cd)     |
| --- Other ---        |     |                                                                                                        |                           |
| *...more*            | 💡  | Other common physical quantities based on demand.                                                      |                           |

## Detailed Usage

### Creating Quantities

Use extension methods on `num` for readability:

```dart
final myLength = 25.5.m;
final anotherLength = 10.ft;
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

// Convert to feet, 1 fraction digit, hide unit symbol
print(myDistance.toString(
    targetUnit: LengthUnit.foot,
    fractionDigits: 1,
    showUnitSymbol: false,
));
// Output: "5178.3"

// Parameters:
// - targetUnit: Converts to this unit before formatting.
// - fractionDigits: Sets fixed number of decimal places.
// - showUnitSymbol: (Default: true) Hides unit symbol if false.
// - unitSymbolSeparator: (Default: " ") String between value and symbol. Use '\u00A0' for non-breaking space.
// - locale: (Requires 'intl' package) BCP 47 language tag (e.g., 'en_US', 'de_DE') for locale-aware number formatting.
// - numberFormat: (Requires 'intl' package) An intl.NumberFormat instance for full control.
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
```

### Comparisons & Sorting

Quantities are `Comparable`, allowing them to be sorted even if their units differ. `compareTo()` is used for magnitude comparison. The `==` operator checks for equal value AND unit.

```dart
final oneMeter = 1.m;
final hundredCm = 100.cm;
final twoFeet = 2.ft; // approx 0.6096 meters
final oneYard = 1.yd; // approx 0.9144 meters

print(oneMeter.compareTo(hundredCm) == 0); // true (magnitudes are equal)
print(oneMeter == hundredCm);          // false (units are different)

// Sorting a list of various lengths
final lengths = [
  oneMeter,    // 1.0 m
  twoFeet,     // ~0.61 m
  oneYard,     // ~0.91 m
  50.cm,       // 0.5 m
  0.2.km       // 200.0 m
];

print('Original list:');
lengths.forEach((l) => print(l.toString(fractionDigits: 2)));

lengths.sort(); // Sorts in ascending order by magnitude

print('\nSorted list (ascending):');
lengths.forEach((l) => print(l.toString(fractionDigits: 2)));
// Output (approximate, order will be based on precise double values):
// Sorted list (ascending):
// 50.00 cm
// 2.00 ft
// 1.00 yd
// 1.00 m
// 200.00 km

// To sort descending:
// lengths.sort((a, b) => b.compareTo(a));
```

## Goals & Roadmap

* **V1.0 (Current):** Solid foundation for common units (`double` precision), type safety, elegant API, configurable `toString()`.
* **V2.0 and Beyond:**
  * **High Precision:** Support for `Decimal`.
  * **Enhanced Quantity Arithmetic:** e.g., `Distance / Time = Speed`.
  * **More Unit Types:** See table above.
  * **Serialization support.**

## Contributing

Contributions are welcome! Please open an [Issue](https://github.com/PhilippHGerber/quantify/issues) or a [Pull Request](https://github.com/PhilippHGerber/quantify/pulls).

## License

MIT License - see the `LICENSE` file.
