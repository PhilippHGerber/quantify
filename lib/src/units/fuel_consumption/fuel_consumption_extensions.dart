import 'fuel_consumption.dart';
import 'fuel_consumption_unit.dart';

// Unit symbol getters intentionally preserve domain notation.
// ignore_for_file: non_constant_identifier_names

/// Provides convenient access to [FuelConsumption] values in specific units.
extension FuelConsumptionValueGetters on FuelConsumption {
  /// Returns the fuel consumption value in liters per 100 kilometers.
  double get inLPer100Km => getValue(FuelConsumptionUnit.litersPer100Km);

  /// Returns the fuel economy value in kilometers per liter.
  double get inKmPerL => getValue(FuelConsumptionUnit.kilometerPerLiter);

  /// Returns the fuel economy value in miles per US gallon.
  double get inMpgUs => getValue(FuelConsumptionUnit.mpgUs);

  /// Returns the fuel economy value in miles per imperial gallon.
  double get inMpgUk => getValue(FuelConsumptionUnit.mpgUk);

  /// Returns a [FuelConsumption] converted to liters per 100 kilometers.
  FuelConsumption get asLPer100Km => convertTo(FuelConsumptionUnit.litersPer100Km);

  /// Returns a [FuelConsumption] converted to kilometers per liter.
  FuelConsumption get asKmPerL => convertTo(FuelConsumptionUnit.kilometerPerLiter);

  /// Returns a [FuelConsumption] converted to miles per US gallon.
  FuelConsumption get asMpgUs => convertTo(FuelConsumptionUnit.mpgUs);

  /// Returns a [FuelConsumption] converted to miles per imperial gallon.
  FuelConsumption get asMpgUk => convertTo(FuelConsumptionUnit.mpgUk);
}

/// Provides convenient factory methods for creating [FuelConsumption] instances.
extension FuelConsumptionCreation on num {
  /// Creates a [FuelConsumption] in liters per 100 kilometers.
  FuelConsumption get LPer100Km {
    return FuelConsumption(toDouble(), FuelConsumptionUnit.litersPer100Km);
  }

  /// Creates a [FuelConsumption] in liters per 100 kilometers.
  FuelConsumption get litersPer100Km {
    return FuelConsumption(toDouble(), FuelConsumptionUnit.litersPer100Km);
  }

  /// Creates a [FuelConsumption] in kilometers per liter.
  FuelConsumption get kmPerL {
    return FuelConsumption(toDouble(), FuelConsumptionUnit.kilometerPerLiter);
  }

  /// Creates a [FuelConsumption] in kilometers per liter.
  FuelConsumption get kilometersPerLiter {
    return FuelConsumption(toDouble(), FuelConsumptionUnit.kilometerPerLiter);
  }

  /// Creates a [FuelConsumption] in miles per US gallon.
  ///
  /// Note: The unqualified alias `mpg` defaults to US gallons.
  /// Use [mpgUk] for imperial gallons.
  FuelConsumption get mpg {
    return FuelConsumption(toDouble(), FuelConsumptionUnit.mpgUs);
  }

  /// Creates a [FuelConsumption] in miles per US gallon.
  FuelConsumption get mpgUs {
    return FuelConsumption(toDouble(), FuelConsumptionUnit.mpgUs);
  }

  /// Creates a [FuelConsumption] in miles per UK gallon.
  FuelConsumption get mpgUk {
    return FuelConsumption(toDouble(), FuelConsumptionUnit.mpgUk);
  }
}
