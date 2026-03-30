import 'package:meta/meta.dart';

import '../../core/inverse_quantity.dart';
import '../../core/quantity_format.dart';
import '../../core/quantity_parser.dart';
import '../length/length_factors.dart';
import '../volume/volume_factors.dart';
import 'fuel_consumption_unit.dart';

/// Represents fuel consumption and fuel economy.
///
/// [FuelConsumption] is an inverse quantity. Its conversions route through an
/// internal canonical form of liters per kilometer, and it intentionally does
/// not expose generic arithmetic operators.
///
/// ## The "50 mpg < 25 mpg" Paradox
///
/// Because this class fundamentally represents **fuel consumption** (volume
/// of fuel consumed per given distance, e.g., L/100km), its internal
/// magnitude *increases* as efficiency *decreases*.
///
/// As a result, comparing fuel economy units like MPG operates mathematically
/// on the underlying consumed volume. A vehicle getting 50 MPG consumes *less*
/// fuel than one getting 25 MPG. Therefore, its physical magnitude is smaller:
///
/// ```dart
/// print(50.mpg < 25.mpg); // true
/// ```
///
/// **Sorting Behavior:** If you call `.sort()` on a `List<FuelConsumption>`,
/// the list will naturally sort from **most efficient** (lowest consumption,
/// highest MPG) to **least efficient** (highest consumption, lowest MPG).
@immutable
final class FuelConsumption extends InverseQuantity<FuelConsumptionUnit, FuelConsumption> {
  /// Creates a new [FuelConsumption] with the given [value] and [unit].
  const FuelConsumption(super._value, super._unit);

  // Derive conversion factors directly from the Single Source of Truth (SSOT).
  static const double _litersPerUsGallon = VolumeFactors.gal / VolumeFactors.dm3;
  static const double _litersPerUkGallon = VolumeFactors.ukGal / VolumeFactors.dm3;
  static const double _kilometersPerMile = LengthFactors.metersPerMile / 1000.0;

  @override
  @protected
  FuelConsumption create(double value, FuelConsumptionUnit unit) {
    return FuelConsumption(value, unit);
  }

  @override
  @protected
  double get comparisonValue => switch (unit) {
        FuelConsumptionUnit.litersPer100Km => value / 100.0,
        FuelConsumptionUnit.kilometerPerLiter => 1.0 / value,
        FuelConsumptionUnit.mpgUs => 1.0 / (value * _kilometersPerMile / _litersPerUsGallon),
        FuelConsumptionUnit.mpgUk => 1.0 / (value * _kilometersPerMile / _litersPerUkGallon),
      };

  /// The parser instance used to convert strings into [FuelConsumption].
  static final QuantityParser<FuelConsumptionUnit, FuelConsumption> parser =
      QuantityParser<FuelConsumptionUnit, FuelConsumption>(
    symbolAliases: FuelConsumptionUnit.symbolAliases,
    nameAliases: FuelConsumptionUnit.nameAliases,
    factory: FuelConsumption.new,
  );

  /// Parses a string representation of fuel consumption into a [FuelConsumption].
  ///
  /// Note: The unqualified abbreviation `mpg` defaults to US gallons.
  /// For imperial gallons, explicitly pass `mpg(UK)`.
  static FuelConsumption parse(
    String input, {
    List<QuantityFormat> formats = const [QuantityFormat.invariant],
  }) {
    return parser.parse(input, formats: formats);
  }

  /// Parses a string representation of fuel consumption, returning `null` on failure.
  ///
  /// Note: The unqualified abbreviation `mpg` defaults to US gallons.
  /// For imperial gallons, explicitly pass `mpg(UK)`.
  static FuelConsumption? tryParse(
    String input, {
    List<QuantityFormat> formats = const [QuantityFormat.invariant],
  }) {
    return parser.tryParse(input, formats: formats);
  }

  /// Converts this fuel consumption value to [targetUnit].
  @override
  double getValue(FuelConsumptionUnit targetUnit) {
    if (targetUnit == unit) return value;

    final litersPerKilometer = comparisonValue;

    return switch (targetUnit) {
      FuelConsumptionUnit.litersPer100Km => litersPerKilometer * 100.0,
      FuelConsumptionUnit.kilometerPerLiter => 1.0 / litersPerKilometer,
      FuelConsumptionUnit.mpgUs =>
        (1.0 / litersPerKilometer) / (_kilometersPerMile / _litersPerUsGallon),
      FuelConsumptionUnit.mpgUk =>
        (1.0 / litersPerKilometer) / (_kilometersPerMile / _litersPerUkGallon),
    };
  }
}
