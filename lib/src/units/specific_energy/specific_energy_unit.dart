import 'package:meta/meta.dart';

import '../../core/unit.dart';
import 'specific_energy_factors.dart';

/// Represents units of specific energy.
///
/// This enum implements the [Unit] interface to provide conversion capabilities
/// and a display [symbol] for each specific energy unit.
/// All conversion factors are pre-calculated in the constructor relative to
/// Joule per Kilogram (J/kg).
enum SpecificEnergyUnit implements Unit<SpecificEnergyUnit> {
  /// Joule per Kilogram (J/kg), the SI derived unit of specific energy.
  joulePerKilogram(SpecificEnergyFactors.joulePerKilogram, 'J/kg'),

  /// Kilojoule per Kilogram (kJ/kg), a common multiple.
  kilojoulePerKilogram(SpecificEnergyFactors.kilojoulePerKilogram, 'kJ/kg'),

  /// Watt-hour per Kilogram (Wh/kg), used in battery energy density.
  wattHourPerKilogram(SpecificEnergyFactors.wattHourPerKilogram, 'Wh/kg'),

  /// Kilowatt-hour per Kilogram (kWh/kg), also used for energy density.
  kilowattHourPerKilogram(SpecificEnergyFactors.kilowattHourPerKilogram, 'kWh/kg');

  /// Constant constructor for enum members.
  const SpecificEnergyUnit(double toJPerKgFactor, this.symbol)
      : _toJPerKgFactor = toJPerKgFactor,
        _factorToJoulePerKilogram = toJPerKgFactor / 1.0,
        _factorToKilojoulePerKilogram = toJPerKgFactor / SpecificEnergyFactors.kilojoulePerKilogram,
        _factorToWattHourPerKilogram = toJPerKgFactor / SpecificEnergyFactors.wattHourPerKilogram,
        _factorToKilowattHourPerKilogram =
            toJPerKgFactor / SpecificEnergyFactors.kilowattHourPerKilogram;

  // ignore: unused_field // Used to store the conversion factor to J/kg.
  final double _toJPerKgFactor;

  @override
  final String symbol;

  // --- Pre-calculated direct conversion factors ---
  final double _factorToJoulePerKilogram;
  final double _factorToKilojoulePerKilogram;
  final double _factorToWattHourPerKilogram;
  final double _factorToKilowattHourPerKilogram;

  @override
  @internal
  double factorTo(SpecificEnergyUnit targetUnit) {
    switch (targetUnit) {
      case SpecificEnergyUnit.joulePerKilogram:
        return _factorToJoulePerKilogram;
      case SpecificEnergyUnit.kilojoulePerKilogram:
        return _factorToKilojoulePerKilogram;
      case SpecificEnergyUnit.wattHourPerKilogram:
        return _factorToWattHourPerKilogram;
      case SpecificEnergyUnit.kilowattHourPerKilogram:
        return _factorToKilowattHourPerKilogram;
    }
  }
}
