# Changelog

All notable changes to the `quantify` package will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [Unreleased]

### Changed — Breaking

* **Eliminated `toString()` Parameter Sprawl**: The `Quantity.toString()` method has been completely refactored to reduce API debt. The five overlapping optional parameters (`locale`, `fractionDigits`, `numberFormat`, `showUnitSymbol`, and `unitSymbolSeparator`) have been **removed**. They are replaced by a single `format` parameter.
  * **Migration:**
    * Replace `toString(fractionDigits: 2)` with `toString(format: const QuantityFormat(fractionDigits: 2))`
    * Replace `toString(locale: 'de_DE', fractionDigits: 2)` with `toString(format: const QuantityFormat.forLocale('de_DE', fractionDigits: 2))`
    * Replace `toString(showUnitSymbol: false)` with `toString(format: QuantityFormat.valueOnly)`
    * Replace `toString(numberFormat: myNf)` with `toString(format: QuantityFormat.withNumberFormat(myNf))`
* **`operator /` by zero now returns `Infinity`** — dividing any linear quantity by `0` (e.g. `10.m / 0`) previously threw `ArgumentError`. It now returns a quantity whose `value` is `double.infinity`, consistent with IEEE 754 double arithmetic. Affected types: all 22 linear quantities (`Length`, `Mass`, `Speed`, `Time`, `Area`, `Volume`, `Angle`, `AngularVelocity`, `Acceleration`, `Force`, `Energy`, `Power`, `Pressure`, `Frequency`, `Current`, `ElectricCharge`, `Density`, `SpecificEnergy`, `SolidAngle`, `LuminousIntensity`, `MolarAmount`, `Information`, `TemperatureDelta`). `Temperature.ratioTo()` still throws `ArgumentError` for an absolute-zero divisor.

### Added

* **`QuantityFormat`**: A new, immutable configuration class that unifies formatting and parsing rules. It ensures perfect symmetry between converting a quantity to a string and parsing it back.
* **Predefined Format Constants**: Added convenient, out-of-the-box formats like `QuantityFormat.invariant`, `QuantityFormat.valueOnly`, `QuantityFormat.enUs`, `QuantityFormat.de`, and `QuantityFormat.compact` to eliminate boilerplate.
* **Multi-Format Parsing**: Added `static parse()` and `static tryParse()` methods to all concrete `Quantity` subclasses (e.g., `Length`, `Mass`, `Time`, `Temperature`, etc.). These methods accept a prioritized `List<QuantityFormat>`, allowing the parser to gracefully fall back through multiple expected locales or formats (e.g., trying US format, then German format).
* **`QuantityParseException`**: A new, detailed exception thrown when `parse()` fails. It provides rich diagnostics, including the attempted string and the number of formats tried.
* **New Quantity: `Information`** — digital storage and transfer sizes with full SI (decimal) and IEC (binary) unit support.
  * `InformationUnit` enum with 12 units:
    * **SI / decimal:** `bit`, `byte` (`B`), `kilobyte` (`kB`), `megabyte` (`MB`), `gigabyte` (`GB`), `terabyte` (`TB`), `petabyte` (`PB`).
    * **IEC / binary:** `kibibyte` (`KiB`), `mebibyte` (`MiB`), `gibibyte` (`GiB`), `tebibyte` (`TiB`), `pebibyte` (`PiB`).
  * Symbol parsing is strictly case-sensitive: `'b'` → bit, `'B'` → byte, `'kB'` → kilobyte (SI, 1 000 bytes), `'KiB'` → kibibyte (IEC, 1 024 bytes). The legacy `'KB'` resolves to SI kilobyte.
  * `static Information parse(String, {List<QuantityFormat>})` and `static Information? tryParse(...)` with full locale-aware number parsing.
  * Extension sugar on `num`: `.bit`, `.byte`, `.kB`, `.MB`, `.GB`, `.TB`, `.PB`, `.KiB`, `.MiB`, `.GiB`, `.TiB`, `.PiB`.
  * Value getters on `Information`: `.inBit`, `.inByte`, `.inKB`, `.inMB`, `.inGB`, `.inTB`, `.inPB`, `.inKiB`, `.inMiB`, `.inGiB`, `.inTiB`, `.inPiB` (and `as*` conversion variants).
  * Full arithmetic: `Information + Information`, `- Information`, `* scalar`, `/ scalar`.
  * Available via `package:quantify/quantify.dart` or the new granular `package:quantify/information.dart`.
* **`LinearQuantity<T, Q>`** — a new public abstract class that all linear (non-affine) quantity types now extend. Consumers who create custom `Quantity` subclasses can extend `LinearQuantity` instead of `Quantity` to inherit `convertTo`, `+`, `-`, `*`, and `/` automatically; the only method to implement is the factory hook `Q create(double value, T unit)`.

* **IEEE 754-safe `isEquivalentTo({double tolerance = 1e-9})`** — `isEquivalentTo` now accepts an optional `tolerance` parameter and uses a **relative tolerance** comparison instead of strict `double` equality. The acceptable error margin scales with the magnitude of the values, making it reliable across the full numeric range — from picometers to astronomical units. Behaviour summary:
  * Floating-point accumulated drift is absorbed: `(0.1.m + 0.2.m).isEquivalentTo(0.3.m)` returns `true`.
  * When one operand is exactly `0.0`, tolerance acts as an **absolute** threshold (avoids divide-by-zero degeneration).
  * Equal infinities (`+∞ == +∞`) → `true`; mixed finite/infinite → `false`; any `NaN` → `false`.
  * Pass `tolerance: 1e-12` for tighter round-trip checks, or `tolerance: 1e-6` for noisy sensor data.

* **Dimensional bridges** — factory constructors that derive one physical quantity from two others, keeping calculations entirely within the type-safe `quantify` ecosystem:

  | Factory                                     | Formula       | Example                                    |
  | ------------------------------------------- | ------------- | ------------------------------------------ |
  | `Area.from(Length l, Length w)`             | A = l × w     | `Area.from(5.m, 4.m)` → 20 m²              |
  | `Volume.from(Length l, Length w, Length h)` | V = l × w × h | `Volume.from(2.m, 3.m, 4.m)` → 24 m³       |
  | `Volume.fromArea(Area a, Length depth)`     | V = A × d     | `Volume.fromArea(floor, 2.5.m)`            |
  | `Power.from(Energy e, Time t)`              | P = E / t     | `Power.from(1.kWh, 1.hours)` → 1 000 W     |
  | `Energy.from(Power p, Time t)`              | E = P × t     | `Energy.from(1.kW, 1.hours)` → 3 600 000 J |
  | `Pressure.from(Force f, Area a)`            | P = F / A     | `Pressure.from(1000.N, 10.m2)` → 100 Pa    |
  | `Force.fromPressure(Pressure p, Area a)`    | F = P × A     | `Force.fromPressure(p, 5.m2)`              |

  All inputs are automatically converted to SI base units before the calculation. Mixed units work correctly (`Area.from(1.km, 500.m)` gives 500 000 m²). These factories are the symmetric complements of each other — `Power.from` is the inverse of `Energy.from`, and `Pressure.from` is the inverse of `Force.fromPressure`.

### Changed — Non-Breaking

* **`Area` extension: `squareMegameter` renamed to `Mm2`** — the `num.squareMegameter` creation getter is renamed to `num.Mm2` to follow the established `{prefix}m2` naming convention used by every other SI area unit (`m2`, `km2`, `hm2`, `dam2`, `dm2`, `cm2`, `mm2`, `um2`). The old `squareMegameter` getter is retained but marked `@Deprecated` and will be removed in the next major version.

* **`Information` lowercase extension aliases** — added linter-friendly all-lowercase creation getters as aliases for teams that enforce `lowerCamelCase` identifiers. The existing SI-cased getters (`kB`, `MB`, `GB`, etc.) remain the primary and are not deprecated:
  * SI: `.kb`, `.mb`, `.gb`, `.tb`, `.pb`
  * IEC: `.kib`, `.mib`, `.gib`, `.tib`, `.pib`

* **`VolumeFactors.mi3` precision note** — added a doc comment on the cubic-mile constant documenting the unavoidable ~±500 mm³ IEEE 754 rounding error that occurs on direct mi³ → mm³ conversions (relative error ~3.7 × 10⁻¹⁰).

## [0.15.0]

2026-02-23

### Added

* **New Quantity: `TemperatureDelta`** — a dedicated type for temperature *changes* (intervals), distinct from absolute `Temperature` points.
  * `TemperatureDeltaUnit` enum with four linear units: `kelvinDelta`, `celsiusDelta`, `fahrenheitDelta`, `rankineDelta`.
  * Factors: `kelvinDelta` = `celsiusDelta` = 1.0 K; `fahrenheitDelta` = `rankineDelta` = 5/9 K.
  * Full arithmetic: `TemperatureDelta + TemperatureDelta`, `- TemperatureDelta`, `* scalar`, `/ scalar`.
  * Convenience extensions on `num`: `20.celsiusDelta`, `18.fahrenheitDelta`, `10.kelvinDelta`, `9.rankineDelta`.
  * Value getters on `TemperatureDelta`: `inKelvinDelta`, `inCelsiusDelta`, `inFahrenheitDelta`, `inRankineDelta` and `as*` conversion variants.
  * Interop extension `TemperatureDeltaTemperatureInterop` providing `delta.addTo(temperature)` for the commutative form of heating.
  * Available via `package:quantify/quantify.dart` or the new granular `package:quantify/temperature_delta.dart`.

* **`Temperature.asDelta` getter** — converts an absolute temperature to a `TemperatureDelta` relative to absolute zero (always in `kelvinDelta`). Useful for formulas that require a Kelvin scalar magnitude, such as the ideal gas law or Boltzmann energy calculations.

* **`Temperature.ratioTo(Temperature other)`** — replaces `operator /` for temperature ratios. Always converts both operands to Kelvin before dividing, ensuring thermodynamic validity regardless of the input scale (e.g. `300.celsius.ratioTo(200.celsius)` gives `573.15 / 473.15`, not `3/2`). Throws `ArgumentError` if the divisor is absolute zero.

* **`Temperature.operator +(TemperatureDelta delta)`** — adds a delta to an absolute temperature, returning a new `Temperature` in the same unit. Models heating.

* **`Temperature.subtract(TemperatureDelta delta)`** — subtracts a delta from an absolute temperature, returning a new `Temperature`. Named method (not an operator) because `operator -` is reserved for `Temperature - Temperature`. Equivalent to `temp + (delta * -1.0)`.

### Changed — Breaking

* **`Temperature.operator -(Temperature other)` now returns `TemperatureDelta`** (previously returned `double`). The result's unit mirrors the LHS unit (e.g. subtracting two Celsius temperatures yields a `celsiusDelta`).

  **Migration:** replace `double diff = t2 - t1;` with `double diff = (t2 - t1).inKelvinDelta;` (or `.inCelsiusDelta`, etc.).

* **`Temperature.operator /` removed.** Use `temperature.ratioTo(other)` instead. The new method always uses Kelvin, making the ratio physically meaningful for all input scales.

  **Migration:** replace `t2 / t1` with `t2.ratioTo(t1)`.

* **`EngineeringConstants.thermalExpansion` now accepts `TemperatureDelta`** instead of `Temperature`. The previous signature would apply the Kelvin affine offset to what should be a plain delta, producing results up to ~14× too large for typical Celsius inputs.

  **Migration:** replace `20.celsius` with `20.celsiusDelta`, or pass the result of `t2 - t1` directly (it is now a `TemperatureDelta`).

* **`EngineeringConstants.conductiveHeatTransfer` now accepts `TemperatureDelta`** instead of `Temperature`, for the same reason.

  **Migration:** replace `const Temperature(10, TemperatureUnit.kelvin)` with `10.kelvinDelta`.

### Fixed

* `thermalExpansion` and `conductiveHeatTransfer` no longer misinterpret a temperature difference as an absolute temperature, eliminating a silent calculation error where `20.celsius` was internally treated as 293.15 K.

## [0.14.2]

2026-02-20

### Fixed

* fix: correct markdown formatting

## [0.14.1]

2026-02-20

### Fixed

* Quick Start code example had an undeclared variable that prevented compilation.
* Removed unused duplicate imports in mass conversion factors.
* Example project SDK constraint now matches the main package requirement (>=3.5.0).

### Changed

* Standardized barrel file exports for density and specific_energy to match other quantities. Removed unintended public export of internal factor constants.

## [0.14.0]

2026-02-11

### Added

* **Energy: International Table (IT) Calorie Variants**:
  * Added `EnergyUnit.calorieIT` and `EnergyUnit.kilocalorieIT` for International Table calorie (4.1868 J).
  * New extensions: `.calIT`, `.kcalIT`, `.caloriesIT`, `.kilocaloriesIT` for creating Energy instances.
  * New getters: `.inCaloriesIT`, `.inKilocaloriesIT`, `.asCaloriesIT`, `.asKilocaloriesIT` for conversions.
  * Existing `calorie` and `kilocalorie` units continue to use the thermochemical calorie (4.184 J) as the IUPAC/ISO standard.

### Changed

* **Improved Pressure Unit Conversion Accuracy**:
  * Distinguished between **Torr** and **mmHg** (millimeter of mercury) for higher precision.
    * `Torr` is now defined as exactly 1/760 of a standard atmosphere (101325/760 Pa).
    * `mmHg` uses the conventional value based on actual mercury density at 0°C (133.322387415 Pa).
    * The difference is approximately 0.000019 Pa, significant for high-precision scientific applications.
  * Updated **inHg** (inch of mercury) conversion to be based on mmHg rather than Torr for consistency with scientific standards (NIST SP 811).

## [0.13.0]

2026-01-12

* **New Quantity: Density**: Support for `kg/m³`, `g/cm³`, `g/mL`.
* **New Quantity: Specific Energy**: Support for `J/kg`, `Wh/kg`, `kWh/kg`, `kJ/kg`.
* **Volume**: Added `centiliter` (cl) unit.
* **Improved**: Complete unit tests for new quantities.

## [0.12.0]

2025-08-11

### Added

* Major Feature: Comprehensive Constants Library.
  * A library of over 100 type-safe constants, organized into three categories: PhysicalConstants, AstronomicalConstants, and EngineeringConstants.
  * Constants are represented as Quantity objects wherever possible (e.g., PhysicalConstants.speedOfLight is a Speed object, AstronomicalConstants.standardGravity is an Acceleration object).
  * Added convenience methods for common scientific and engineering formulas, such as PhysicalConstants.photonEnergy(), AstronomicalConstants.escapeVelocity(), and EngineeringConstants.mechanicalStress().
  * Constants are accessible via a new, separate import: package:quantify/constants.dart.

## [0.11.0]

2025-07-27

### Changed

* **Conceptual Refinement of `Frequency` and `AngularVelocity`**:
  * `Frequency` is now the comprehensive quantity for all periodic units (inverse time, T⁻¹), including rotational rates.
  * `AngularVelocity` remains a distinct, specialized type for rotational mechanics to ensure semantic type safety.

### Added

* **`Frequency` Unit Expansion**: Added `rad/s` (radian per second) and `deg/s` (degree per second) to `Frequency`.
* **Interoperability Between `Frequency` and `AngularVelocity`**:
  * Added a safe `.asFrequency` getter to `AngularVelocity` for direct conversion to a `Frequency` object.
  * Added a guarded `.asAngularVelocity` getter to `Frequency` that only converts compatible rotational units (`rpm`, `rad/s`, `Hz`, etc.) and throws an `UnsupportedError` for non-rotational units (like `bpm` or `MHz`), preventing logical errors in calculations.

## [0.10.0]

2025-07-26

* **New Quantities: `Energy` and `Power`**
  * Added the `Energy` quantity with common units (J, kJ, MJ, kWh, kcal, eV, Btu).
  * Added the `Power` quantity with a comprehensive set of SI, engineering, and CGS units (W, kW, MW, GW, hp, PS, Btu/h, erg/s).

* **Expanded Unit Coverage**
  * Added new units to `Acceleration` (cm/s²), `Force` (gf, pdl), and `ElectricCharge` (mAh, statC, abC)
  *

## [0.9.0]

2025-07-22

* **Added relational operators (`>`, `<`, `>=`, `<=`) for all quantities.** Comparisons are now more readable (e.g., `1.m > 99.cm`).
* **Added `isEquivalentTo()` method** for explicit magnitude equality checks (e.g., `1.m.isEquivalentTo(100.cm)`).

## [0.8.0]

2025-07-22

* **New Derived Quantities**
  * `Frequency` with units (`Hz`, `MHz`, `GHz`, `THz`, `rpm`, etc.).
  * `ElectricCharge` with units (`C`, `Ah`, `e`, `µC`, etc.).
  * `SolidAngle` with units (`sr`, `deg²`, `sp`).

## [0.7.0]

2025-07-16

* **New Derived Quantity**
  * `Area` with units (`m²`, `km²`, `ha`, `acre`, `yd²`, `ft²`, etc.).
  * `Volume` with comprehensive SI, US customary, and cooking units (`m³`, `L`, `gal`, `fl-oz`, `tsp`, etc.).

## [0.6.0]

2025-07-05

* **New Derived Quantities**
  * `Speed`: Added `m/s`, `km/h`, `mph`, `kn`, `ft/s`.
  * `Acceleration`: Added `m/s²`, `g` (standard gravity), `km/h/s`.
  * `Force`: Added `N` (Newton), `lbf`, `dyn`, `kgf`, `kN`.

## [0.5.0]

2025-06-29

### Added

* Expanded Unit Coverage:
  * Length: Added Mm (megametre) and Gm (gigametre).
  * Mass: Added Mg (megagram) and Gg (gigagram).
  * Time: Added full range of SI prefixes (Gs to cs) and calendar units (fortnight, decade, century).
  * ElectricCurrent: Added CGS units statA (statampere) and abA (abampere/biot).

* Granular Exports: Added separate library entry points (e.g., package:quantify/length.dart) to allow for explicit imports and prevent namespace conflicts.

## [0.4.0]

2025-06-23

### Added

* **New Quantity: `Angle`**
  * `Angle` quantity
  * `AngleUnit`:
    * **`radian` (rad):** The SI-derived unit, used as the base for conversions.
    * **`degree` (°):** The most common unit for angles.
    * **`gradian` (grad):** Unit used in surveying (400 grad in a circle).
    * **`revolution` (rev):** Represents a full circle or turn.
    * **`arcminute` ('):** High-precision unit (1/60 of a degree).
    * **`arcsecond` ("):** High-precision unit (1/60 of an arcminute).
    * **`milliradian` (mrad):** Common in optics and ballistics.
  * Standard arithmetic operators (`+`, `-`, `*`, `/`) for `Angle`.

* **New Quantity: `AngularVelocity`**
  * `AngularVelocity` quantity - represents rotational speed.
  * `AngularVelocityUnit`:
    * **`radianPerSecond` (rad/s):** The SI-derived unit.
    * **`degreePerSecond` (°/s).**
    * **`revolutionPerMinute` (rpm):** A widely used unit for rotational speed.
    * **`revolutionPerSecond` (rps).**
  * Standard arithmetic operators for `AngularVelocity`.

## [0.3.0]

2025-06-21

### Added

* **Expanded Unit Coverage:**
  * **Length:**
    * SI Prefixes: `hm` (hectometer), `dam` (decameter), `dm` (decimeter), `μm` (micrometer), `nm` (nanometer), `pm` (picometer), `fm` (femtometer).
    * Astronomical: `AU` (astronomical unit), `ly` (light year), `pc` (parsec).
    * Special: `Å` (ångström).
  * **Mass:**
    * SI Prefixes: `hg` (hectogram), `dag` (decagram), `dg` (decigram), `cg` (centigram), `μg` (microgram), `ng` (nanogram).
    * Imperial/US: `short ton`, `long ton`.
    * Special: `u` (atomic mass unit), `ct` (carat).
  * **Time:**
    * SI Prefixes: `μs` (microsecond), `ns` (nanosecond), `ps` (picosecond).
    * Calendar: `wk` (week), `mo` (month), `yr` (year).
  * **Temperature:**
    * Absolute Scale: `°R` (rankine).

## [0.2.0]

2025-06-16

### Added

* **New SI Base Quantity Types (completing all 7 SI base units):**
  * **Mass:**
    * `Mass` class and `MassUnit` enum (`kg`, `g`, `mg`, `t` (tonne), `lb`, `oz`, `st` (stone), `slug`).
  * **Amount of Substance (Molar Amount):**
    * `MolarAmount` class and `MolarUnit` enum (`mol`, `mmol`, `µmol`, `nmol`, `pmol`, `kmol`).
  * **Electric Current:**
    * `Current` class and `CurrentUnit` enum (`A`, `mA`, `µA`, `nA`, `kA`).
  * **Luminous Intensity:**
    * `LuminousIntensity` class and `LuminousIntensityUnit` enum (`cd`, `mcd`, `kcd`).

## [0.1.0]

2025-06-12

### Added

* **Initial Release of `quantify` v0.1.0**
* **Core Functionality:**
  * Type-safe `Quantity` base class for representing physical quantities with a value and a unit.
  * `Unit` interface for defining conversion factors and symbols.
  * Immutable `Quantity` objects.
  * `double` precision for quantity values.
  * Elegant API with extension methods on `num` for quantity creation (e.g., `10.m`, `20.celsius`).
  * Extension methods on `Quantity` for easy value retrieval in target units (e.g., `length.inKm`) and for obtaining new `Quantity` objects in target units (e.g., `length.asKm`).
  * Configurable `toString()` method on `Quantity` objects supporting:
    * Conversion to a `targetUnit` before formatting.
    * Fixed `fractionDigits`.
    * Option to `showUnitSymbol`.
    * Custom `unitSymbolSeparator`.
    * Locale-aware number formatting via `locale` parameter (using `intl` package).
    * Full control over number formatting via `numberFormat` parameter (using `intl` package).
  * Arithmetic operations (`+`, `-`, `*` by scalar, `/` by scalar) for most quantities.
  * Specialized arithmetic for `Temperature` (difference `T - T` returns `double`, ratio `T / T` returns `double`).
  * `Comparable` interface implementation for sorting quantities by magnitude.
  * `==` operator override for value and unit equality.
* **Supported Quantity Types (with units and extensions):**
  * **Length:** Meter (m), Kilometer (km), Centimeter (cm), Millimeter (mm), Inch (in), Foot (ft), Yard (yd), Mile (mi), Nautical Mile (nmi).
  * **Time:** Second (s), Millisecond (ms), Minute (min), Hour (h), Day (d).
  * **Temperature:** Kelvin (K), Celsius (°C), Fahrenheit (°F). Handles affine conversions correctly.
  * **Pressure:** Pascal (Pa), Atmosphere (atm), Bar (bar), PSI (psi), Torr, mmHg, inHg, kPa, hPa, mbar, cmH₂O, inH₂O.
