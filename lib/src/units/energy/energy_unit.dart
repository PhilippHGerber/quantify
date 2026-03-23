import 'package:meta/meta.dart';

import '../../core/unit.dart';
import 'energy_factors.dart';

/// Represents units of energy.
///
/// This enum implements the [LinearUnit] interface to provide conversion capabilities
/// and a display [symbol] for each energy unit. All conversion factors are
/// pre-calculated in the constructor relative to the Joule (J).
enum EnergyUnit implements LinearUnit<EnergyUnit> {
  /// Joule (J), the SI derived unit of energy.
  joule(1, 'J'),

  /// Millijoule (mJ), common in optics and medical devices.
  millijoule(EnergyFactors.joulesPerMillijoule, 'mJ'),

  /// Microjoule (µJ), used in fiber optics and low-energy physics.
  microjoule(EnergyFactors.joulesPerMicrojoule, 'µJ'),

  /// Kilojoule (kJ), a common multiple of the Joule.
  kilojoule(EnergyFactors.joulesPerKilojoule, 'kJ'),

  /// Megajoule (MJ), a common multiple of the Joule.
  megajoule(EnergyFactors.joulesPerMegajoule, 'MJ'),

  /// Gigajoule (GJ), standard unit for utility billing.
  gigajoule(EnergyFactors.joulesPerGigajoule, 'GJ'),

  /// Terajoule (TJ), used in macro-economics and earth sciences.
  terajoule(EnergyFactors.joulesPerTerajoule, 'TJ'),

  /// Calorie (cal), the thermochemical calorie (4.184 J exact).
  /// This is the IUPAC/ISO 31-4 recommended standard for scientific use.
  /// For the International Table calorie, use [calorieIT].
  calorie(EnergyFactors.joulesPerCalorie, 'cal'),

  /// International Table Calorie (cal_IT), defined as 4.1868 J exact.
  /// Used in steam tables and some engineering applications.
  /// For the standard thermochemical calorie, use [calorie].
  calorieIT(EnergyFactors.joulesPerCalorieIT, 'cal_IT'),

  /// Kilocalorie (kcal), the "food calorie" (4184 J).
  /// Based on 1000 thermochemical calories.
  /// For the International Table kilocalorie, use [kilocalorieIT].
  kilocalorie(EnergyFactors.joulesPerKilocalorie, 'kcal'),

  /// International Table Kilocalorie (kcal_IT), defined as 4186.8 J exact.
  /// Based on 1000 IT calories.
  /// For the standard thermochemical kilocalorie, use [kilocalorie].
  kilocalorieIT(EnergyFactors.joulesPerKilocalorieIT, 'kcal_IT'),

  /// Kilowatt-hour (kWh), a common unit for electrical energy.
  kilowattHour(EnergyFactors.joulesPerKilowattHour, 'kWh'),

  /// Electronvolt (eV), a unit of energy used in particle physics.
  electronvolt(EnergyFactors.joulesPerElectronvolt, 'eV'),

  /// British Thermal Unit (Btu), as defined by the International Table standard.
  btu(EnergyFactors.joulesPerBtu, 'Btu');

  /// Constant constructor for enum members.
  ///
  /// [_toJouleFactor] is the factor to convert from this unit to the base unit (Joule).
  /// [symbol] is the display symbol for the unit.
  ///
  /// The constructor pre-calculates all direct conversion factors
  /// from this unit to every other `EnergyUnit`.
  const EnergyUnit(double toJouleFactor, this.symbol)
      : _toJouleFactor = toJouleFactor,
        _factorToJoule = toJouleFactor / 1.0,
        _factorToMillijoule = toJouleFactor / EnergyFactors.joulesPerMillijoule,
        _factorToMicrojoule = toJouleFactor / EnergyFactors.joulesPerMicrojoule,
        _factorToKilojoule = toJouleFactor / EnergyFactors.joulesPerKilojoule,
        _factorToMegajoule = toJouleFactor / EnergyFactors.joulesPerMegajoule,
        _factorToGigajoule = toJouleFactor / EnergyFactors.joulesPerGigajoule,
        _factorToTerajoule = toJouleFactor / EnergyFactors.joulesPerTerajoule,
        _factorToCalorie = toJouleFactor / EnergyFactors.joulesPerCalorie,
        _factorToCalorieIT = toJouleFactor / EnergyFactors.joulesPerCalorieIT,
        _factorToKilocalorie = toJouleFactor / EnergyFactors.joulesPerKilocalorie,
        _factorToKilocalorieIT = toJouleFactor / EnergyFactors.joulesPerKilocalorieIT,
        _factorToKilowattHour = toJouleFactor / EnergyFactors.joulesPerKilowattHour,
        _factorToElectronvolt = toJouleFactor / EnergyFactors.joulesPerElectronvolt,
        _factorToBtu = toJouleFactor / EnergyFactors.joulesPerBtu;

  /// The factor to convert a value from this unit to the base unit (Joule).
  // ignore: unused_field
  final double _toJouleFactor;

  /// The human-readable symbol for this energy unit (e.g., "J", "kWh").
  @override
  final String symbol;

  // --- Pre-calculated direct conversion factors from this unit to all others ---
  final double _factorToJoule;
  final double _factorToMillijoule;
  final double _factorToMicrojoule;
  final double _factorToKilojoule;
  final double _factorToMegajoule;
  final double _factorToGigajoule;
  final double _factorToTerajoule;
  final double _factorToCalorie;
  final double _factorToCalorieIT;
  final double _factorToKilocalorie;
  final double _factorToKilocalorieIT;
  final double _factorToKilowattHour;
  final double _factorToElectronvolt;
  final double _factorToBtu;

  /// SI and unit symbols matched **strictly case-sensitive**.
  ///
  /// Used by `Energy.parser`.
  @internal
  static const Map<String, EnergyUnit> symbolAliases = {
    // joule
    'J': EnergyUnit.joule,
    // millijoule
    'mJ': EnergyUnit.millijoule,
    // microjoule
    'µJ': EnergyUnit.microjoule,
    'uJ': EnergyUnit.microjoule,
    // kilojoule
    'kJ': EnergyUnit.kilojoule,
    // megajoule
    'MJ': EnergyUnit.megajoule,
    // gigajoule
    'GJ': EnergyUnit.gigajoule,
    // terajoule
    'TJ': EnergyUnit.terajoule,
    // calorie
    'cal': EnergyUnit.calorie,
    // calorie IT
    'cal_IT': EnergyUnit.calorieIT,
    // kilocalorie
    'kcal': EnergyUnit.kilocalorie,
    'Cal': EnergyUnit.kilocalorie,
    // kilocalorie IT
    'kcal_IT': EnergyUnit.kilocalorieIT,
    // kilowatt-hour
    'kWh': EnergyUnit.kilowattHour,
    // electronvolt
    'eV': EnergyUnit.electronvolt,
    // BTU
    'Btu': EnergyUnit.btu,
    'BTU': EnergyUnit.btu,
  };

  /// Full word-form names matched **case-insensitively**.
  ///
  /// Used by `Energy.parser`.
  @internal
  static const Map<String, EnergyUnit> nameAliases = {
    // joule
    'joule': EnergyUnit.joule,
    'joules': EnergyUnit.joule,
    // millijoule
    'millijoule': EnergyUnit.millijoule,
    'millajoules': EnergyUnit.millijoule,
    'millajoule': EnergyUnit.millijoule,
    'millijoules': EnergyUnit.millijoule,
    // microjoule
    'microjoule': EnergyUnit.microjoule,
    'microjoules': EnergyUnit.microjoule,
    // kilojoule
    'kilojoule': EnergyUnit.kilojoule,
    'kilojoules': EnergyUnit.kilojoule,
    // megajoule
    'megajoule': EnergyUnit.megajoule,
    'megajoules': EnergyUnit.megajoule,
    // gigajoule
    'gigajoule': EnergyUnit.gigajoule,
    'gigajoules': EnergyUnit.gigajoule,
    // terajoule
    'terajoule': EnergyUnit.terajoule,
    'terajoules': EnergyUnit.terajoule,
    // calorie
    'calorie': EnergyUnit.calorie,
    'calories': EnergyUnit.calorie,
    // calorie IT
    'calorie it': EnergyUnit.calorieIT,
    'calories it': EnergyUnit.calorieIT,
    // kilocalorie
    'kilocalorie': EnergyUnit.kilocalorie,
    'kilocalories': EnergyUnit.kilocalorie,
    'food calorie': EnergyUnit.kilocalorie,
    'food calories': EnergyUnit.kilocalorie,
    // kilocalorie IT
    'kilocalorie it': EnergyUnit.kilocalorieIT,
    'kilocalories it': EnergyUnit.kilocalorieIT,
    // kilowatt-hour
    'kilowatt-hour': EnergyUnit.kilowattHour,
    'kilowatt-hours': EnergyUnit.kilowattHour,
    'kilowatt hour': EnergyUnit.kilowattHour,
    'kilowatt hours': EnergyUnit.kilowattHour,
    // electronvolt
    'electronvolt': EnergyUnit.electronvolt,
    'electronvolts': EnergyUnit.electronvolt,
    'electron volt': EnergyUnit.electronvolt,
    'electron volts': EnergyUnit.electronvolt,
    // BTU
    'btu': EnergyUnit.btu,
    'british thermal unit': EnergyUnit.btu,
    'british thermal units': EnergyUnit.btu,
  };

  /// Returns the direct conversion factor to convert a value from this [EnergyUnit]
  /// to the [targetUnit].
  ///
  /// This method is marked as `@internal` and is used by the `Energy` class
  /// for efficient conversions.
  @override
  @internal
  double factorTo(EnergyUnit targetUnit) {
    switch (targetUnit) {
      case EnergyUnit.joule:
        return _factorToJoule;
      case EnergyUnit.millijoule:
        return _factorToMillijoule;
      case EnergyUnit.microjoule:
        return _factorToMicrojoule;
      case EnergyUnit.kilojoule:
        return _factorToKilojoule;
      case EnergyUnit.megajoule:
        return _factorToMegajoule;
      case EnergyUnit.gigajoule:
        return _factorToGigajoule;
      case EnergyUnit.terajoule:
        return _factorToTerajoule;
      case EnergyUnit.calorie:
        return _factorToCalorie;
      case EnergyUnit.calorieIT:
        return _factorToCalorieIT;
      case EnergyUnit.kilocalorie:
        return _factorToKilocalorie;
      case EnergyUnit.kilocalorieIT:
        return _factorToKilocalorieIT;
      case EnergyUnit.kilowattHour:
        return _factorToKilowattHour;
      case EnergyUnit.electronvolt:
        return _factorToElectronvolt;
      case EnergyUnit.btu:
        return _factorToBtu;
    }
  }
}
