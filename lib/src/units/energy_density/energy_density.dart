import 'package:meta/meta.dart';

import '../../core/linear_quantity.dart';
import '../../core/quantity_format.dart';
import '../../core/quantity_parser.dart';
import '../energy/energy.dart';
import '../energy/energy_extensions.dart';
import '../energy/energy_unit.dart';
import '../volume/volume.dart';
import '../volume/volume_extensions.dart';
import '../volume/volume_unit.dart';
import 'energy_density_unit.dart';

/// Represents a quantity of energy density.
///
/// Energy density is a physical quantity representing the amount of energy
/// stored per unit volume. It is dimensionally identical to Pressure
/// (J/m³ ≡ Pa), but is modeled as a distinct type to preserve semantic
/// meaning. The SI derived unit is Joule per Cubic Meter (J/m³).
@immutable
final class EnergyDensity extends LinearQuantity<EnergyDensityUnit, EnergyDensity> {
  /// Creates a new `EnergyDensity` with a given [value] and [unit].
  const EnergyDensity(super._value, super._unit);

  /// Creates an `EnergyDensity` from [energy] and [volume] (u = E / V).
  ///
  /// If the combination of [energy]'s unit and [volume]'s unit matches a
  /// standard energy density unit (J + m³ → J/m³, J + L → J/L, Wh + L → Wh/L),
  /// the result uses that unit. Otherwise the result is in
  /// [EnergyDensityUnit.joulePerCubicMeter].
  /// If [volume] is zero, the result follows IEEE 754 semantics.
  ///
  /// ```dart
  /// EnergyDensity.from(1000.J, 2.m3);     // 500.0 J/m³
  /// EnergyDensity.from(500.J, 1.0.L);     // 500.0 J/L
  /// EnergyDensity.from(1.Wh, 1.0.L);      // 1.0 Wh/L
  /// ```
  factory EnergyDensity.from(Energy energy, Volume volume) {
    final target = _correspondingEnergyDensityUnit(energy.unit, volume.unit);
    if (target != null) return EnergyDensity(energy.value / volume.value, target);
    return EnergyDensity(
      energy.inJoules / volume.inCubicMeters,
      EnergyDensityUnit.joulePerCubicMeter,
    );
  }

  /// Maps an [EnergyUnit] × [VolumeUnit] pair to its natural [EnergyDensityUnit].
  static EnergyDensityUnit? _correspondingEnergyDensityUnit(EnergyUnit e, VolumeUnit v) =>
      switch ((e, v)) {
        (EnergyUnit.joule, VolumeUnit.cubicMeter) => EnergyDensityUnit.joulePerCubicMeter,
        (EnergyUnit.joule, VolumeUnit.litre) => EnergyDensityUnit.joulePerLiter,
        (EnergyUnit.wattHour, VolumeUnit.litre) => EnergyDensityUnit.wattHourPerLiter,
        _ => null,
      };

  @override
  @protected
  EnergyDensity create(double value, EnergyDensityUnit unit) => EnergyDensity(value, unit);

  /// The parser instance used to convert strings into [EnergyDensity] objects.
  ///
  /// The parser supports both strict symbol aliases and case-insensitive name
  /// aliases configured in [EnergyDensityUnit].
  static final QuantityParser<EnergyDensityUnit, EnergyDensity> parser =
      QuantityParser<EnergyDensityUnit, EnergyDensity>(
    symbolAliases: EnergyDensityUnit.symbolAliases,
    nameAliases: EnergyDensityUnit.nameAliases,
    factory: EnergyDensity.new,
  );

  /// Parses a string representation of energy density into an [EnergyDensity] object.
  ///
  /// The [formats] list controls how the numeric portion is interpreted.
  static EnergyDensity parse(
    String input, {
    List<QuantityFormat> formats = const [QuantityFormat.invariant],
  }) {
    return parser.parse(input, formats: formats);
  }

  /// Parses a string representation of energy density into an [EnergyDensity] object,
  /// returning `null` when parsing fails.
  ///
  /// See [parse] for formatting and matching behavior.
  static EnergyDensity? tryParse(
    String input, {
    List<QuantityFormat> formats = const [QuantityFormat.invariant],
  }) {
    return parser.tryParse(input, formats: formats);
  }

  // --- Dimensional Analysis ---

  /// Calculates the [Energy] stored in a given [Volume] at this energy density.
  ///
  /// The result's unit matches the energy component of this energy density's
  /// unit: `J/m³` → joules, `J/L` → joules, `Wh/L` → watt-hours.
  ///
  /// ```dart
  /// final density = 500.joulesPerLiter;
  /// density.energyOf(2.0.L); // 1000.0 J
  /// ```
  Energy energyOf(Volume volume) {
    final energyUnit = _correspondingEnergyUnit(unit);
    final volUnit = _correspondingVolumeUnit(unit);
    return Energy(value * volume.getValue(volUnit), energyUnit);
  }

  /// Calculates the [Volume] required to store a given amount of [Energy]
  /// at this energy density.
  ///
  /// The result's unit matches the volume component of this energy density's
  /// unit: `J/m³` → m³, `J/L` → L, `Wh/L` → L.
  /// If the energy density is zero, the result follows IEEE 754 semantics.
  ///
  /// ```dart
  /// final density = 500.joulesPerLiter;
  /// density.volumeFor(1000.J); // 2.0 L
  /// ```
  Volume volumeFor(Energy energy) {
    final energyUnit = _correspondingEnergyUnit(unit);
    final volUnit = _correspondingVolumeUnit(unit);
    return Volume(energy.getValue(energyUnit) / value, volUnit);
  }

  /// Maps an [EnergyDensityUnit] to its energy component unit.
  static EnergyUnit _correspondingEnergyUnit(EnergyDensityUnit u) => switch (u) {
        EnergyDensityUnit.joulePerCubicMeter => EnergyUnit.joule,
        EnergyDensityUnit.joulePerLiter => EnergyUnit.joule,
        EnergyDensityUnit.wattHourPerLiter => EnergyUnit.wattHour,
      };

  /// Maps an [EnergyDensityUnit] to its volume component unit.
  static VolumeUnit _correspondingVolumeUnit(EnergyDensityUnit u) => switch (u) {
        EnergyDensityUnit.joulePerCubicMeter => VolumeUnit.cubicMeter,
        EnergyDensityUnit.joulePerLiter => VolumeUnit.litre,
        EnergyDensityUnit.wattHourPerLiter => VolumeUnit.litre,
      };
}
