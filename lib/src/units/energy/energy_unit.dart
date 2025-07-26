import 'package:meta/meta.dart';

import '../../core/unit.dart';
import 'energy_factors.dart';

/// Represents units of energy.
///
/// This enum implements the [Unit] interface to provide conversion capabilities
/// and a display [symbol] for each energy unit. All conversion factors are
/// pre-calculated in the constructor relative to the Joule (J).
enum EnergyUnit implements Unit<EnergyUnit> {
  /// Joule (J), the SI derived unit of energy.
  joule(1, 'J'),

  /// Megajoule (MJ), a common multiple of the Joule.
  megajoule(EnergyFactors.joulesPerMegajoule, 'MJ'),

  /// Kilojoule (kJ), a common multiple of the Joule.
  kilojoule(EnergyFactors.joulesPerKilojoule, 'kJ'),

  /// Calorie (cal), the thermochemical calorie, commonly used in science.
  calorie(EnergyFactors.joulesPerCalorie, 'cal'),

  /// Kilocalorie (kcal), the "food calorie", equal to 1000 small calories.
  kilocalorie(EnergyFactors.joulesPerKilocalorie, 'kcal'),

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
        _factorToMegajoule = toJouleFactor / EnergyFactors.joulesPerMegajoule,
        _factorToKilojoule = toJouleFactor / EnergyFactors.joulesPerKilojoule,
        _factorToCalorie = toJouleFactor / EnergyFactors.joulesPerCalorie,
        _factorToKilocalorie = toJouleFactor / EnergyFactors.joulesPerKilocalorie,
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
  final double _factorToMegajoule;
  final double _factorToKilojoule;
  final double _factorToCalorie;
  final double _factorToKilocalorie;
  final double _factorToKilowattHour;
  final double _factorToElectronvolt;
  final double _factorToBtu;

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
      case EnergyUnit.megajoule:
        return _factorToMegajoule;
      case EnergyUnit.kilojoule:
        return _factorToKilojoule;
      case EnergyUnit.calorie:
        return _factorToCalorie;
      case EnergyUnit.kilocalorie:
        return _factorToKilocalorie;
      case EnergyUnit.kilowattHour:
        return _factorToKilowattHour;
      case EnergyUnit.electronvolt:
        return _factorToElectronvolt;
      case EnergyUnit.btu:
        return _factorToBtu;
    }
  }
}
