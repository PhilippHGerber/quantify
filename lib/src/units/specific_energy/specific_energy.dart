import 'package:meta/meta.dart';

import '../../core/linear_quantity.dart';
import '../../core/quantity_format.dart';
import '../../core/quantity_parser.dart';
import '../energy/energy.dart';
import '../energy/energy_extensions.dart';
import '../energy/energy_unit.dart';
import '../mass/mass.dart';
import '../mass/mass_extensions.dart';
import 'specific_energy_unit.dart';

/// Represents a quantity of specific energy.
///
/// Specific energy is the energy per unit mass.
/// It represents the energy stored in a substance per unit mass (e.g., energy density of a fuel or battery).
/// The SI derived unit is Joule per Kilogram (J/kg).
@immutable
class SpecificEnergy extends LinearQuantity<SpecificEnergyUnit, SpecificEnergy> {
  /// Creates a new `SpecificEnergy` with a given [value] and [unit].
  const SpecificEnergy(super._value, super._unit);

  /// Creates a `SpecificEnergy` instance from a given [Energy] and [Mass].
  ///
  /// This factory performs the dimensional calculation `SpecificEnergy = Energy / Mass`.
  /// It converts the inputs to their base SI units (Joules and Kilograms) for correctness.
  /// Throws an [ArgumentError] if the mass is zero.
  factory SpecificEnergy.from(Energy energy, Mass mass) {
    final joules = energy.inJoules;
    final kilograms = mass.inKilograms;
    if (kilograms == 0) {
      throw ArgumentError('Mass cannot be zero when calculating specific energy.');
    }
    return SpecificEnergy(joules / kilograms, SpecificEnergyUnit.joulePerKilogram);
  }

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
  /// This method performs the dimensional calculation `Energy = SpecificEnergy × Mass`.
  /// The calculation is performed in the base units (J/kg and kg) to ensure
  /// correctness, and the result is returned as an `Energy` in Joules.
  Energy energyIn(Mass mass) {
    final specificEnergyInJPerKg = getValue(SpecificEnergyUnit.joulePerKilogram);
    final massInKg = mass.inKilograms;
    final totalEnergyInJoules = specificEnergyInJPerKg * massInKg;
    return Energy(totalEnergyInJoules, EnergyUnit.joule);
  }
}
