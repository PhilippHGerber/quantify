# quantify

A type-safe units of measurement library for Dart, providing elegant syntax for unit conversions with good precision and optimal performance.

**Version:** 0.1.0

## Features

* **Type Safety**: Prevents unit mismatch errors at compile-time.
* **Elegant Syntax**: Natural, readable API for creating quantities and performing conversions (e.g., `10.5.psi.inBar`).
* **Good Precision (V1.0)**: Uses `double` for calculations, with direct conversion factors to minimize rounding errors compared to multi-step approaches.
* **Optimal Performance**: Most conversions involve a single multiplication. Temperature conversions use direct, optimized formulas.
* **Immutable**: Quantity objects are immutable, promoting safer and more predictable code.
* **Extensible**: Designed to be easily extended with new unit types and units.
* **No External Runtime Dependencies (V1.0)**: Lightweight and easy to integrate.

## Goals

* Provide a reliable and easy-to-use units library for common Dart applications.
* Ensure correctness and good performance for everyday unit conversion tasks.
* Offer a clear path for future enhancements like high-precision arithmetic (V2.0).

## Basic Usage (V1.0 - Standard Precision)

```dart
import 'package:quantify/quantify.dart';

void main() {
  // Creating quantities using intuitive extension methods
  final pressure = 14.7.psi;       // Creates a Pressure object of 14.7 PSI
  final temperature = 25.celsius;  // Creates a Temperature object of 25 °C
  final duration = 120.seconds;    // Creates a Time object of 120 seconds

  // Performing conversions using extension getters
  print('Pressure: ${pressure.inBar} bar');                 // Output: approx 1.013 bar
  print('Temperature: ${temperature.inFahrenheit}°F');    // Output: 77.0 °F
  print('Duration: ${duration.inMinutes} minutes');         // Output: 2.0 minutes

  // Example with direct getValue()
  final atmosphericPressure = Pressure(1.0, PressureUnit.atm);
  print('Atmosphere in Pascals: ${atmosphericPressure.getValue(PressureUnit.pascal)} Pa'); // Output: 101325.0 Pa

  // Quantities are immutable
  final initialTemp = 0.celsius;
  final boilingTemp = 100.celsius; // initialTemp is still 0 °C

  // Simple arithmetic (convert to a common unit first)
  final p1 = 10.psi;
  final p2 = 0.5.bar;
  final totalPressureInPsi = p1.inPsi + p2.inPsi;
  print('Total pressure: $totalPressureInPsi psi');
}
```

*(Note: The `*.psi`, `*.celsius`, `*.inBar`, `*.inFahrenheit` syntax relies on extension methods provided by the package.)*

## Installation

This package is currently under development. Once published to [pub.dev](https://pub.dev), you will be able to add it to your `pubspec.yaml`:

```yaml
dependencies:
  quantify: ^0.1.0 # Replace with the latest version
```

Then run `dart pub get` or `flutter pub get`.

## Core Design

`quantify` uses pre-computed direct unit-to-unit conversion factors. For most unit types, this means a conversion is a single multiplication operation. Factors are derived from NIST constants and are embedded within the unit enums themselves, calculated at compile-time where possible. Temperature conversions, due to their offset nature, use specific, optimized formulas for each conversion pair.

## Future Considerations (V2.0 and beyond)

* **High Precision**: Support for arbitrary-precision arithmetic using the `Decimal` type.
* **Quantity Arithmetic**: Operator overloading (`+`, `-`, `*`, `/`) for `Quantity` objects.
* **More Unit Types**: Expanding the library with more physical quantities.

## Contributing

Contributions are welcome! If you find a bug or have a feature request, please open an issue. If you'd like to contribute code, please open a pull request.

## License

This package is licensed under the MIT License - see the `LICENSE` file for details.
