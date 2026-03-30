import 'package:meta/meta.dart';

import '../../core/unit.dart';

/// Represents units of fuel consumption and fuel economy.
///
/// These units are reciprocal views of the same physical concept and are
/// routed internally through canonical liters per kilometer.
enum FuelConsumptionUnit implements Unit<FuelConsumptionUnit> {
  /// Liters per 100 kilometers.
  litersPer100Km('L/100km'),

  /// Kilometers per liter.
  kilometerPerLiter('km/L'),

  /// Miles per US gallon.
  mpgUs('mpg(US)'),

  /// Miles per imperial gallon.
  mpgUk('mpg(UK)');

  /// Constant constructor for enum members.
  const FuelConsumptionUnit(this.symbol);

  /// The display symbol for this fuel consumption unit.
  @override
  final String symbol;

  /// Unit symbols matched strictly case-sensitive.
  ///
  /// Note: The unqualified abbreviation `mpg` defaults to US gallons.
  /// For imperial gallons, explicitly pass `mpg(UK)`.
  @internal
  static const Map<String, FuelConsumptionUnit> symbolAliases = {
    'L/100km': FuelConsumptionUnit.litersPer100Km,
    'km/L': FuelConsumptionUnit.kilometerPerLiter,
    'mpg': FuelConsumptionUnit.mpgUs,
    'mpg(US)': FuelConsumptionUnit.mpgUs,
    'mpg(UK)': FuelConsumptionUnit.mpgUk,
  };

  /// Full word-form names matched case-insensitively.
  ///
  /// Note: The unqualified abbreviation `mpg` and the generic phrase
  /// `miles per gallon` default to US gallons. For imperial gallons,
  /// explicitly pass `mpg(UK)` or `miles per imperial gallon`.
  @internal
  static const Map<String, FuelConsumptionUnit> nameAliases = {
    'l/100km': FuelConsumptionUnit.litersPer100Km,
    'liter per 100 kilometer': FuelConsumptionUnit.litersPer100Km,
    'liters per 100 kilometer': FuelConsumptionUnit.litersPer100Km,
    'liter per 100 kilometers': FuelConsumptionUnit.litersPer100Km,
    'liters per 100 kilometers': FuelConsumptionUnit.litersPer100Km,
    'km/l': FuelConsumptionUnit.kilometerPerLiter,
    'kilometer per liter': FuelConsumptionUnit.kilometerPerLiter,
    'kilometers per liter': FuelConsumptionUnit.kilometerPerLiter,
    'mpg': FuelConsumptionUnit.mpgUs,
    'mpg(us)': FuelConsumptionUnit.mpgUs,
    'mpg(uk)': FuelConsumptionUnit.mpgUk,
    'miles per gallon': FuelConsumptionUnit.mpgUs,
    'miles per us gallon': FuelConsumptionUnit.mpgUs,
    'miles per uk gallon': FuelConsumptionUnit.mpgUk,
    'miles per imperial gallon': FuelConsumptionUnit.mpgUk,
  };
}
