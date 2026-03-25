import 'package:meta/meta.dart';

import '../../core/linear_quantity.dart';
import '../../core/quantity_format.dart';
import '../../core/quantity_parser.dart';
import '../mass/mass.dart';
import '../mass/mass_extensions.dart';
import '../mass/mass_unit.dart';
import '../volume/volume.dart';
import '../volume/volume_extensions.dart';
import '../volume/volume_unit.dart';
import 'density_unit.dart';

/// Represents a quantity of density.
///
/// Density is a physical quantity representing the mass per unit volume of a substance.
/// The SI derived unit is Kilogram per Cubic Meter (kg/m³).
@immutable
class Density extends LinearQuantity<DensityUnit, Density> {
  /// Creates a new `Density` with a given [value] and [unit].
  const Density(super._value, super._unit);

  /// Creates a `Density` from [mass] and [volume] (ρ = m / V).
  ///
  /// If the combination of [mass]'s unit and [volume]'s unit matches a standard
  /// density unit (kg + m³ → kg/m³, g + cm³ → g/cm³, g + mL → g/mL), the
  /// result uses that unit. Otherwise the result is in
  /// [DensityUnit.kilogramPerCubicMeter].
  /// If [volume] is zero, the result follows IEEE 754 semantics.
  ///
  /// ```dart
  /// Density.from(2000.kg, 2.m3);       // 1000.0 kg/m³
  /// Density.from(13.546.g, 1.0.cm3);   // 13.546 g/cm³
  /// ```
  factory Density.from(Mass mass, Volume volume) {
    final target = _correspondingDensityUnit(mass.unit, volume.unit);
    if (target != null) return Density(mass.value / volume.value, target);
    return Density(mass.inKilograms / volume.inCubicMeters, DensityUnit.kilogramPerCubicMeter);
  }

  /// Maps a [MassUnit] × [VolumeUnit] pair to its natural [DensityUnit].
  static DensityUnit? _correspondingDensityUnit(MassUnit m, VolumeUnit v) => switch ((m, v)) {
        (MassUnit.kilogram, VolumeUnit.cubicMeter) => DensityUnit.kilogramPerCubicMeter,
        (MassUnit.gram, VolumeUnit.cubicCentimeter) => DensityUnit.gramPerCubicCentimeter,
        (MassUnit.gram, VolumeUnit.milliliter) => DensityUnit.gramPerMilliliter,
        _ => null,
      };

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
  /// The result's unit matches the mass component of this density's unit:
  /// `kg/m³` → kilograms, `g/cm³` → grams.
  ///
  /// ```dart
  /// final water = 1000.kgPerM3;
  /// water.massOf(2.m3);       // 2000.0 kg
  ///
  /// final mercury = 13.546.gPerCm3;
  /// mercury.massOf(100.cm3);  // 1354.6 g
  /// ```
  Mass massOf(Volume volume) {
    final massUnit = _correspondingMassUnit(unit);
    final volUnit = _correspondingVolumeUnit(unit);
    return Mass(value * volume.getValue(volUnit), massUnit);
  }

  /// Calculates the [Volume] required for a given [Mass] of this substance.
  ///
  /// The result's unit matches the volume component of this density's unit:
  /// `kg/m³` → m³, `g/cm³` → cm³, `g/mL` → mL.
  /// If the density is zero, the result follows IEEE 754 semantics.
  ///
  /// ```dart
  /// final water = 1000.kgPerM3;
  /// water.volumeFor(2000.kg); // 2.0 m³
  ///
  /// final mercury = 13.546.gPerCm3;
  /// mercury.volumeFor(135.46.g); // 10.0 cm³
  /// ```
  Volume volumeFor(Mass mass) {
    final massUnit = _correspondingMassUnit(unit);
    final volUnit = _correspondingVolumeUnit(unit);
    return Volume(mass.getValue(massUnit) / value, volUnit);
  }

  /// Maps a [DensityUnit] to its mass component unit.
  static MassUnit _correspondingMassUnit(DensityUnit u) => switch (u) {
        DensityUnit.kilogramPerCubicMeter => MassUnit.kilogram,
        DensityUnit.gramPerCubicCentimeter => MassUnit.gram,
        DensityUnit.gramPerMilliliter => MassUnit.gram,
      };

  /// Maps a [DensityUnit] to its volume component unit.
  static VolumeUnit _correspondingVolumeUnit(DensityUnit u) => switch (u) {
        DensityUnit.kilogramPerCubicMeter => VolumeUnit.cubicMeter,
        DensityUnit.gramPerCubicCentimeter => VolumeUnit.cubicCentimeter,
        DensityUnit.gramPerMilliliter => VolumeUnit.milliliter,
      };
}
