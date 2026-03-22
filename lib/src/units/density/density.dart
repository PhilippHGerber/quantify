import 'package:meta/meta.dart';

import '../../core/linear_quantity.dart';
import '../../core/quantity_format.dart';
import '../../core/quantity_parser.dart';
import '../mass/mass.dart';
import '../mass/mass_extensions.dart';
import '../mass/mass_unit.dart';
import '../volume/volume.dart';
import '../volume/volume_extensions.dart';
import 'density_unit.dart';

/// Represents a quantity of density.
///
/// Density is a physical quantity representing the mass per unit volume of a substance.
/// The SI derived unit is Kilogram per Cubic Meter (kg/m³).
@immutable
class Density extends LinearQuantity<DensityUnit, Density> {
  /// Creates a new `Density` with a given [value] and [unit].
  const Density(super._value, super._unit);

  /// Creates a `Density` instance from a given [Mass] and [Volume].
  ///
  /// This factory performs the dimensional calculation `Density = Mass / Volume`.
  /// It converts the inputs to their base SI units (kg and m³) for correctness.
  /// Throws an [ArgumentError] if the volume is zero.
  ///
  /// Example:
  /// ```dart
  /// final mass = 1000.kg;
  /// final volume = 1.m3;
  /// final density = Density.from(mass, volume);
  /// print(density.inKilogramsPerCubicMeter); // Output: 1000.0
  /// ```
  factory Density.from(Mass mass, Volume volume) {
    final kilograms = mass.inKilograms;
    final cubicMeters = volume.inCubicMeters;
    if (cubicMeters == 0) {
      throw ArgumentError('Volume cannot be zero when calculating density.');
    }
    return Density(kilograms / cubicMeters, DensityUnit.kilogramPerCubicMeter);
  }

  @override
  @protected
  Density create(double value, DensityUnit unit) => Density(value, unit);

  /// The parser instance used to convert strings into [Density] objects.
  ///
  /// The parser supports both strict symbol aliases and case-insensitive name
  /// aliases configured in [DensityUnit].
  static final QuantityParser<DensityUnit, Density> parser = QuantityParser<DensityUnit, Density>(
    symbolAliases: DensityUnit.symbolAliases,
    nameAliases: DensityUnit.nameAliases,
    factory: Density.new,
  );

  /// Parses a string representation of density into a [Density] object.
  ///
  /// The [formats] list controls how the numeric portion is interpreted.
  static Density parse(
    String input, {
    List<QuantityFormat> formats = const [QuantityFormat.invariant],
  }) {
    return parser.parse(input, formats: formats);
  }

  /// Parses a string representation of density into a [Density] object,
  /// returning `null` when parsing fails.
  ///
  /// See [parse] for formatting and matching behavior.
  static Density? tryParse(
    String input, {
    List<QuantityFormat> formats = const [QuantityFormat.invariant],
  }) {
    return parser.tryParse(input, formats: formats);
  }

  // --- Dimensional Analysis ---

  /// Calculates the [Mass] of a given [Volume] of this substance.
  ///
  /// This method performs the dimensional calculation `Mass = Density × Volume`.
  /// The calculation is performed in the base units (kg/m³ and m³) to ensure
  /// correctness, and the result is returned as a `Mass` in kilograms.
  ///
  /// Example:
  /// ```dart
  /// final waterDensity = 1000.kgPerM3;
  /// final volume = 2.m3;
  /// final mass = waterDensity.massOf(volume);
  /// print(mass.inKilograms); // Output: 2000.0
  /// ```
  Mass massOf(Volume volume) {
    final densityInKgPerM3 = getValue(DensityUnit.kilogramPerCubicMeter);
    final volumeInM3 = volume.inCubicMeters;
    final massInKg = densityInKgPerM3 * volumeInM3;
    return Mass(massInKg, MassUnit.kilogram);
  }
}
