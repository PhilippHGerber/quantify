# Changelog

All notable changes to the `quantify` package will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [0.13.0]

- **New Quantity: Density**: Support for `kg/m³`, `g/cm³`, `g/mL`.
- **New Quantity: Specific Energy**: Support for `J/kg`, `Wh/kg`, `kWh/kg`, `kJ/kg`.
- **Volume**: Added `centiliter` (cl) unit.
- **Improved**: Complete unit tests for new quantities.

## [0.12.0]

### Added

* Major Feature: Comprehensive Constants Library.
  * A library of over 100 type-safe constants, organized into three categories: PhysicalConstants, AstronomicalConstants, and EngineeringConstants.
  * Constants are represented as Quantity objects wherever possible (e.g., PhysicalConstants.speedOfLight is a Speed object, AstronomicalConstants.standardGravity is an Acceleration object).
  * Added convenience methods for common scientific and engineering formulas, such as PhysicalConstants.photonEnergy(), AstronomicalConstants.escapeVelocity(), and EngineeringConstants.mechanicalStress().
  * Constants are accessible via a new, separate import: package:quantify/constants.dart.

## [0.11.0]

2025-07-27

### Changed

- **Conceptual Refinement of `Frequency` and `AngularVelocity`**:
  - `Frequency` is now the comprehensive quantity for all periodic units (inverse time, T⁻¹), including rotational rates.
  - `AngularVelocity` remains a distinct, specialized type for rotational mechanics to ensure semantic type safety.

### Added

- **`Frequency` Unit Expansion**: Added `rad/s` (radian per second) and `deg/s` (degree per second) to `Frequency`.
- **Interoperability Between `Frequency` and `AngularVelocity`**:
  - Added a safe `.asFrequency` getter to `AngularVelocity` for direct conversion to a `Frequency` object.
  - Added a guarded `.asAngularVelocity` getter to `Frequency` that only converts compatible rotational units (`rpm`, `rad/s`, `Hz`, etc.) and throws an `UnsupportedError` for non-rotational units (like `bpm` or `MHz`), preventing logical errors in calculations.

## [0.10.0]

2025-07-26

- **New Quantities: `Energy` and `Power`**
  - Added the `Energy` quantity with common units (J, kJ, MJ, kWh, kcal, eV, Btu).
  - Added the `Power` quantity with a comprehensive set of SI, engineering, and CGS units (W, kW, MW, GW, hp, PS, Btu/h, erg/s).

- **Expanded Unit Coverage**
  - Added new units to `Acceleration` (cm/s²), `Force` (gf, pdl), and `ElectricCharge` (mAh, statC, abC)
  -

## [0.9.0]

2025-07-22

- **Added relational operators (`>`, `<`, `>=`, `<=`) for all quantities.** Comparisons are now more readable (e.g., `1.m > 99.cm`).
- **Added `isEquivalentTo()` method** for explicit magnitude equality checks (e.g., `1.m.isEquivalentTo(100.cm)`).

## [0.8.0]

2025-07-22

- **New Derived Quantities**
  - `Frequency` with units (`Hz`, `MHz`, `GHz`, `THz`, `rpm`, etc.).
  - `ElectricCharge` with units (`C`, `Ah`, `e`, `µC`, etc.).
  - `SolidAngle` with units (`sr`, `deg²`, `sp`).

## [0.7.0]

2025-07-16

- **New Derived Quantity**
  - `Area` with units (`m²`, `km²`, `ha`, `acre`, `yd²`, `ft²`, etc.).
  - `Volume` with comprehensive SI, US customary, and cooking units (`m³`, `L`, `gal`, `fl-oz`, `tsp`, etc.).

## [0.6.0]

2025-07-05

- **New Derived Quantities**
  - `Speed`: Added `m/s`, `km/h`, `mph`, `kn`, `ft/s`.
  - `Acceleration`: Added `m/s²`, `g` (standard gravity), `km/h/s`.
  - `Force`: Added `N` (Newton), `lbf`, `dyn`, `kgf`, `kN`.

## [0.5.0]

2025-06-29

### Added

- Expanded Unit Coverage:
  - Length: Added Mm (megametre) and Gm (gigametre).
  - Mass: Added Mg (megagram) and Gg (gigagram).
  - Time: Added full range of SI prefixes (Gs to cs) and calendar units (fortnight, decade, century).
  - ElectricCurrent: Added CGS units statA (statampere) and abA (abampere/biot).

- Granular Exports: Added separate library entry points (e.g., package:quantify/length.dart) to allow for explicit imports and prevent namespace conflicts.

## [0.4.0]

2025-06-23

### Added

- **New Quantity: `Angle`**
  - `Angle` quantity
  - `AngleUnit`:
    - **`radian` (rad):** The SI-derived unit, used as the base for conversions.
    - **`degree` (°):** The most common unit for angles.
    - **`gradian` (grad):** Unit used in surveying (400 grad in a circle).
    - **`revolution` (rev):** Represents a full circle or turn.
    - **`arcminute` ('):** High-precision unit (1/60 of a degree).
    - **`arcsecond` ("):** High-precision unit (1/60 of an arcminute).
    - **`milliradian` (mrad):** Common in optics and ballistics.
  - Standard arithmetic operators (`+`, `-`, `*`, `/`) for `Angle`.

- **New Quantity: `AngularVelocity`**
  - `AngularVelocity` quantity - represents rotational speed.
  - `AngularVelocityUnit`:
    - **`radianPerSecond` (rad/s):** The SI-derived unit.
    - **`degreePerSecond` (°/s).**
    - **`revolutionPerMinute` (rpm):** A widely used unit for rotational speed.
    - **`revolutionPerSecond` (rps).**
  - Standard arithmetic operators for `AngularVelocity`.

## [0.3.0]

2025-06-21

### Added

- **Expanded Unit Coverage:**
  - **Length:**
    - SI Prefixes: `hm` (hectometer), `dam` (decameter), `dm` (decimeter), `μm` (micrometer), `nm` (nanometer), `pm` (picometer), `fm` (femtometer).
    - Astronomical: `AU` (astronomical unit), `ly` (light year), `pc` (parsec).
    - Special: `Å` (ångström).
  - **Mass:**
    - SI Prefixes: `hg` (hectogram), `dag` (decagram), `dg` (decigram), `cg` (centigram), `μg` (microgram), `ng` (nanogram).
    - Imperial/US: `short ton`, `long ton`.
    - Special: `u` (atomic mass unit), `ct` (carat).
  - **Time:**
    - SI Prefixes: `μs` (microsecond), `ns` (nanosecond), `ps` (picosecond).
    - Calendar: `wk` (week), `mo` (month), `yr` (year).
  - **Temperature:**
    - Absolute Scale: `°R` (rankine).

## [0.2.0]

2025-06-16

### Added

- **New SI Base Quantity Types (completing all 7 SI base units):**
  - **Mass:**
    - `Mass` class and `MassUnit` enum (`kg`, `g`, `mg`, `t` (tonne), `lb`, `oz`, `st` (stone), `slug`).
  - **Amount of Substance (Molar Amount):**
    - `MolarAmount` class and `MolarUnit` enum (`mol`, `mmol`, `µmol`, `nmol`, `pmol`, `kmol`).
  - **Electric Current:**
    - `Current` class and `CurrentUnit` enum (`A`, `mA`, `µA`, `nA`, `kA`).
  - **Luminous Intensity:**
    - `LuminousIntensity` class and `LuminousIntensityUnit` enum (`cd`, `mcd`, `kcd`).

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
