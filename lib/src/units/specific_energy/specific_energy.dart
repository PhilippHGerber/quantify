import 'package:meta/meta.dart';

import '../../core/linear_quantity.dart';
import '../../core/quantity_format.dart';
import '../../core/quantity_parser.dart';
import '../energy/energy.dart';
import '../energy/energy_extensions.dart';
import '../energy/energy_unit.dart';
import '../mass/mass.dart';
import '../mass/mass_extensions.dart';
import '../mass/mass_unit.dart';
import 'specific_energy_unit.dart';

/// Represents a quantity of specific energy.
///
/// Specific energy is the energy per unit mass.
/// It represents the energy stored in a substance per unit mass (e.g., energy density of a fuel or battery).
/// The SI derived unit is Joule per Kilogram (J/kg).
@immutable
final class SpecificEnergy extends LinearQuantity<SpecificEnergyUnit, SpecificEnergy> {
  /// Creates a new `SpecificEnergy` with a given [value] and [unit].
  const SpecificEnergy(super._value, super._unit);

  /// Creates a `SpecificEnergy` from [energy] and [mass] (e = E / m).
  ///
  /// If the combination of [energy]'s unit and [mass]'s unit matches a standard
  /// specific energy unit (J + kg → J/kg, kJ + kg → kJ/kg, kWh + kg → kWh/kg),
  /// the result uses that unit. Otherwise the result is in
  /// [SpecificEnergyUnit.joulePerKilogram].
  /// If [mass] is zero, the result follows IEEE 754 semantics.
  ///
  /// ```dart
  /// SpecificEnergy.from(1000.kJ, 2.kg);   // 500.0 kJ/kg
  /// SpecificEnergy.from(0.3.kWh, 1.0.kg); // 0.3 kWh/kg
  /// ```
  factory SpecificEnergy.from(Energy energy, Mass mass) {
    final target = _correspondingSpecificEnergyUnit(energy.unit, mass.unit);
    if (target != null) return SpecificEnergy(energy.value / mass.value, target);
    return SpecificEnergy(energy.inJoules / mass.inKilograms, SpecificEnergyUnit.joulePerKilogram);
  }

  /// Maps an [EnergyUnit] × [MassUnit] pair to its natural [SpecificEnergyUnit].
  static SpecificEnergyUnit? _correspondingSpecificEnergyUnit(EnergyUnit e, MassUnit m) =>
      switch ((e, m)) {
        (EnergyUnit.joule, MassUnit.kilogram) => SpecificEnergyUnit.joulePerKilogram,
        (EnergyUnit.kilojoule, MassUnit.kilogram) => SpecificEnergyUnit.kilojoulePerKilogram,
        (EnergyUnit.wattHour, MassUnit.kilogram) => SpecificEnergyUnit.wattHourPerKilogram,
        (EnergyUnit.kilowattHour, MassUnit.kilogram) => SpecificEnergyUnit.kilowattHourPerKilogram,
        _ => null,
      };

  @override
  @protected
  SpecificEnergy create(double value, SpecificEnergyUnit unit) => SpecificEnergy(value, unit);

  /// The parser instance used to convert strings into [SpecificEnergy]
  /// objects.
  ///
  /// The parser supports both strict symbol aliases and case-insensitive name
  /// aliases configured in [SpecificEnergyUnit].
  static final QuantityParser<SpecificEnergyUnit, SpecificEnergy> parser =
      QuantityParser<SpecificEnergyUnit, SpecificEnergy>(
    symbolAliases: SpecificEnergyUnit.symbolAliases,
    nameAliases: SpecificEnergyUnit.nameAliases,
    factory: SpecificEnergy.new,
  );

  /// Parses a string representation of specific energy into a
  /// [SpecificEnergy] object.
  ///
  /// The [formats] list controls how the numeric portion is interpreted.
  static SpecificEnergy parse(
    String input, {
    List<QuantityFormat> formats = const [QuantityFormat.invariant],
  }) {
    return parser.parse(input, formats: formats);
  }

  /// Parses a string representation of specific energy into a
  /// [SpecificEnergy] object, returning `null` when parsing fails.
  ///
  /// See [parse] for formatting and matching behavior.
  static SpecificEnergy? tryParse(
    String input, {
    List<QuantityFormat> formats = const [QuantityFormat.invariant],
  }) {
    return parser.tryParse(input, formats: formats);
  }

  // --- Dimensional Analysis ---

  /// Calculates the [Energy] contained in a given [Mass] of this substance.
  ///
  /// The result's unit matches the energy component of this specific energy's
  /// unit: `J/kg` → joules, `kJ/kg` → kilojoules, `Wh/kg` → watt-hours,
  /// `kWh/kg` → kilowatt-hours.
  ///
  /// ```dart
  /// 500.kJPerKg.energyIn(2.kg);     // 1000.0 kJ
  /// 0.3.kWhPerKg.energyIn(10.kg);   // 3.0 kWh
  /// ```
  Energy energyIn(Mass mass) {
    final energyInJoules = getValue(SpecificEnergyUnit.joulePerKilogram) * mass.inKilograms;
    final targetUnit = _correspondingEnergyUnit(unit);
    return Energy(energyInJoules * EnergyUnit.joule.factorTo(targetUnit), targetUnit);
  }

  /// Maps a [SpecificEnergyUnit] to its energy component [EnergyUnit].
  static EnergyUnit _correspondingEnergyUnit(SpecificEnergyUnit u) => switch (u) {
        SpecificEnergyUnit.joulePerKilogram => EnergyUnit.joule,
        SpecificEnergyUnit.kilojoulePerKilogram => EnergyUnit.kilojoule,
        SpecificEnergyUnit.wattHourPerKilogram => EnergyUnit.wattHour,
        SpecificEnergyUnit.kilowattHourPerKilogram => EnergyUnit.kilowattHour,
      };
}
