---
name: quantify-usage
description: How to use the Dart 'quantify' package for type-safe physical unit conversions. Make sure to use this skill whenever the user mentions unit conversions, physical quantities (length, mass, temperature, speed, information/bytes, etc.), engineering calculations, dimensional analysis, or parsing/formatting measurements in Dart or Flutter.
user-invocable: false
metadata:
  version: "0.16.0"
---

# Dart Quantify Package Usage Guide

The `quantify` package provides type-safe physical quantities and unit conversions, relying heavily on `num` extensions and immutable `Quantity` objects.

## Imports
You can import the entire library, but for large projects, prefer granular imports to avoid `num` extension conflicts:
```dart
import 'package:quantify/length.dart'; // Granular
import 'package:quantify/mass.dart';   // Granular
import 'package:quantify/constants.dart'; // PhysicalConstants, AstronomicalConstants
```

## Creating Quantities
Create quantities using the intuitive `num` extensions. For SI units, you can use the official SI symbol or a Dart-idiomatic full word alias. Both compile to the exact same bytecode.
```dart
final length = 15.m;
final weight = 120.lbs;

// Dual API for SI units:
final dist1 = 5.Mm;         // SI symbol (Mega = M)
final dist2 = 5.megameters; // Full word alias

final freq1 = 100.MHz;
final freq2 = 100.megahertz;
```

### ⚠️ Information (Bits vs Bytes) Casing Gotcha
Digital storage sizes in the `Information` quantity are strictly case-sensitive. Lowercase `b` means bit, uppercase `B` means byte.
```dart
final bits = 10.kb;  // kilobits (1,000 bits)
final bytes = 10.kB; // kilobytes (1,000 bytes)
final binary = 10.KiB; // kibibytes (1,024 bytes)
```

## Extracting Values and Converting
To get a raw `double`, use `.in[Unit]` getters. To get a new `Quantity` object in a different unit, use `.as[Unit]` getters or `.convertTo(Unit)`.
```dart
final distance = 1.mi;
double rawMeters = distance.inM;         // ~1609.34
Length metricDistance = distance.asKm;   // Length(1.609344, LengthUnit.kilometer)
```

## Comparisons (CRITICAL)
Because `==` checks for strict representational equality (same value AND same unit), `1.m == 100.cm` will return `false`.
When you want to compare if two quantities represent the same physical magnitude, use `isEquivalentTo()`. It safely handles IEEE 754 floating-point drift using relative tolerances.
```dart
print(1.m.isEquivalentTo(100.cm)); // true

// Standard relational operators evaluate magnitude automatically:
print(1.mi > 1.km); // true
```

## Temperature vs. TemperatureDelta (CRITICAL)
`Temperature` represents an absolute point on a thermometer (affine). `TemperatureDelta` represents a change or interval (linear). Because adding two absolute temperatures is physically meaningless, you must use `TemperatureDelta` for offsets or scientific formulas.
```dart
final temp1 = 20.celsius;
final temp2 = 30.celsius;

// Subtracting two absolute Temperatures yields a TemperatureDelta
final rise = temp2 - temp1; // TemperatureDelta(10.0, TemperatureDeltaUnit.celsiusDelta)

// Adding a Delta to a Temperature yields a new absolute Temperature
final heated = temp1 + 15.kelvinDelta;

// Ratio of Temperatures MUST be done via ratioTo (safely converts to Kelvin first)
final ratio = 300.kelvin.ratioTo(150.kelvin); // 2.0
```

## Dimensional Analysis Bridges
When deriving one physical quantity from others (like calculating Speed from Length and Time), use the factory constructors. This keeps your calculations type-safe and avoids manual raw `double` conversions.
```dart
final area = Area.from(5.m, 4.m);           // 20.0 m²
final volume = Volume.fromArea(area, 2.m);  // 40.0 m³
final speed = Speed.from(100.m, 10.s);      // 10.0 m/s
final force = Force.from(10.kg, 9.8.mpsSquared);

// Constants library includes formulas that return Quantity objects natively:
final photonEnergy = PhysicalConstants.photonEnergy(500.nm); // Returns an Energy object
```
*Note: All inputs to dimensional factories are automatically converted to base SI units internally.*

## Parsing Strings with Fallbacks
Parsing uses `static parse()` and `static tryParse()`. You can provide a prioritized list of `QuantityFormat`s to gracefully handle different locale inputs (like comma vs. dot decimals).
```dart
// Tries US format first, then German format
final parsed = Length.tryParse(
  '1,234.56 km',
  formats: [QuantityFormat.enUs, QuantityFormat.de],
);
```

## Formatting Output
String formatting is handled entirely via the immutable `QuantityFormat` class passed to `toString()`. There are no sprawling optional parameters.
```dart
final dist = 1234.567.m;

// Basic target unit conversion
print(dist.toString(targetUnit: LengthUnit.kilometer)); // "1.234567 km"

// With locale and fraction digits
print(dist.toString(
  targetUnit: LengthUnit.kilometer,
  format: const QuantityFormat.forLocale('de_DE', fractionDigits: 2),
)); // "1,23 km"
```
```
