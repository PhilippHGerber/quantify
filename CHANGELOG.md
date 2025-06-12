# Changelog

All notable changes to the `quantify` package will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [0.1.0]

2025-06-12

### Added

- **Initial Release of `quantify` v0.1.0**
- **Core Functionality:**
  - Type-safe `Quantity` base class for representing physical quantities with a value and a unit.
  - `Unit` interface for defining conversion factors and symbols.
  - Immutable `Quantity` objects.
  - `double` precision for quantity values.
  - Elegant API with extension methods on `num` for quantity creation (e.g., `10.m`, `20.celsius`).
  - Extension methods on `Quantity` for easy value retrieval in target units (e.g., `length.inKm`) and for obtaining new `Quantity` objects in target units (e.g., `length.asKm`).
  - Configurable `toString()` method on `Quantity` objects supporting:
    - Conversion to a `targetUnit` before formatting.
    - Fixed `fractionDigits`.
    - Option to `showUnitSymbol`.
    - Custom `unitSymbolSeparator`.
    - Locale-aware number formatting via `locale` parameter (using `intl` package).
    - Full control over number formatting via `numberFormat` parameter (using `intl` package).
  - Arithmetic operations (`+`, `-`, `*` by scalar, `/` by scalar) for most quantities.
  - Specialized arithmetic for `Temperature` (difference `T - T` returns `double`, ratio `T / T` returns `double`).
  - `Comparable` interface implementation for sorting quantities by magnitude.
  - `==` operator override for value and unit equality.
- **Supported Quantity Types (with units and extensions):**
  - **Length:** Meter (m), Kilometer (km), Centimeter (cm), Millimeter (mm), Inch (in), Foot (ft), Yard (yd), Mile (mi), Nautical Mile (nmi).
  - **Time:** Second (s), Millisecond (ms), Minute (min), Hour (h), Day (d).
  - **Temperature:** Kelvin (K), Celsius (°C), Fahrenheit (°F). Handles affine conversions correctly.
  - **Pressure:** Pascal (Pa), Atmosphere (atm), Bar (bar), PSI (psi), Torr, mmHg, inHg, kPa, hPa, mbar, cmH₂O, inH₂O.
