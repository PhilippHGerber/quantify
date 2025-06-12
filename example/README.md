# Quantify Package - CLI Example

This directory contains a command-line interface (CLI) example demonstrating the features of the `quantify` package.

## Features Demonstrated

The `quantify_cli_example.dart` script showcases:

* **Creating Quantities:**
  * Using intuitive `num` extensions (e.g., `1500.m`, `2.5.km`).
* **Unit Conversions:**
  * Retrieving numerical values in different units (e.g., `pathA.inKm`).
  * Converting `Quantity` objects to different units (e.g., `pathA.convertTo(LengthUnit.kilometer)`).
* **String Formatting (`toString()`):**
  * Default formatting.
  * Specifying a `targetUnit` for conversion before formatting.
  * Controlling the number of `fractionDigits`.
  * Using a `unitSymbolSeparator`.
  * Locale-specific number formatting using the `locale` parameter (requires the `intl` package).
  * Using a custom `intl.NumberFormat` instance for advanced control over number display.
* **Arithmetic Operations:**
  * Adding (`+`) and subtracting (`-`) quantities (automatic unit conversion for the right-hand operand).
  * Multiplying (`*`) and dividing (`/`) quantities by a scalar.
  * Specific arithmetic for `Temperature` (e.g., difference).
* **Comparisons:**
  * Using `compareTo()` for magnitude comparison.
  * Using `==` to check for equality in both value and unit.
  * Sorting lists of `Quantity` objects.
* **Usage of various implemented quantity types:**
  * Length
  * Time
  * Temperature
  * Pressure

## How to Run

1. Navigate to the root directory of the `quantify` package.
2. Ensure dependencies are fetched:

    ```bash
    dart pub get
    ```

3. Run the example script from the `example` directory:

    ```bash
    dart run example/quantify_cli_example.dart
    ```

    Alternatively, if you are already in the `example` directory:

    ```bash
    dart run quantify_cli_example.dart
    ```

## Dependencies

This example depends on:

* The main `quantify` package (referenced via `path: ../` in its `pubspec.yaml`).
* The `intl` package for locale-specific number formatting features.
