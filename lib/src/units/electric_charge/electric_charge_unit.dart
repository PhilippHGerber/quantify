import 'package:meta/meta.dart';

import '../../core/unit.dart';
import 'electric_charge_factors.dart';

/// Represents units of electric charge.
///
/// This enum implements the [Unit] interface to provide conversion capabilities
/// and a display [symbol] for each electric charge unit.
/// All conversion factors are pre-calculated in the constructor relative to
/// Coulomb (C).
enum ElectricChargeUnit implements Unit<ElectricChargeUnit> {
  /// Coulomb (C), the SI derived unit of electric charge.
  coulomb(1, 'C'),

  /// Millicoulomb (mC), a sub-multiple of the Coulomb.
  millicoulomb(ElectricChargeFactors.coulombsPerMillicoulomb, 'mC'),

  /// Microcoulomb (µC), a sub-multiple of the Coulomb.
  microcoulomb(ElectricChargeFactors.coulombsPerMicrocoulomb, 'µC'),

  /// Nanocoulomb (nC), a sub-multiple of the Coulomb.
  nanocoulomb(ElectricChargeFactors.coulombsPerNanocoulomb, 'nC'),

  /// Elementary Charge (e), the charge of a single proton.
  elementaryCharge(ElectricChargeFactors.coulombsPerElementaryCharge, 'e'),

  /// Ampere-hour (Ah), a unit commonly used for battery capacity.
  ampereHour(ElectricChargeFactors.coulombsPerAmpereHour, 'Ah'),

  /// Milliampere-hour (mAh), a smaller unit for battery capacity.
  milliampereHour(ElectricChargeFactors.coulombsPerMilliampereHour, 'mAh'),

  /// Statcoulomb (statC) or Franklin (Fr), the CGS-ESU unit of charge.
  statcoulomb(ElectricChargeFactors.coulombsPerStatcoulomb, 'statC'),

  /// Abcoulomb (abC), the CGS-EMU unit of charge.
  abcoulomb(ElectricChargeFactors.coulombsPerAbcoulomb, 'abC');

  /// Constant constructor for enum members.
  const ElectricChargeUnit(double toCoulombFactor, this.symbol)
      : _toCoulombFactor = toCoulombFactor,
        _factorToCoulomb = toCoulombFactor / 1.0,
        _factorToMillicoulomb = toCoulombFactor / ElectricChargeFactors.coulombsPerMillicoulomb,
        _factorToMicrocoulomb = toCoulombFactor / ElectricChargeFactors.coulombsPerMicrocoulomb,
        _factorToNanocoulomb = toCoulombFactor / ElectricChargeFactors.coulombsPerNanocoulomb,
        _factorToElementaryCharge =
            toCoulombFactor / ElectricChargeFactors.coulombsPerElementaryCharge,
        _factorToAmpereHour = toCoulombFactor / ElectricChargeFactors.coulombsPerAmpereHour,
        _factorToMilliampereHour =
            toCoulombFactor / ElectricChargeFactors.coulombsPerMilliampereHour,
        _factorToStatcoulomb = toCoulombFactor / ElectricChargeFactors.coulombsPerStatcoulomb,
        _factorToAbcoulomb = toCoulombFactor / ElectricChargeFactors.coulombsPerAbcoulomb;

  // ignore: unused_field // The factor to convert this unit to Coulomb (C).
  final double _toCoulombFactor;

  @override
  final String symbol;

  // --- Pre-calculated direct conversion factors ---
  final double _factorToCoulomb;
  final double _factorToMillicoulomb;
  final double _factorToMicrocoulomb;
  final double _factorToNanocoulomb;
  final double _factorToElementaryCharge;
  final double _factorToAmpereHour;
  final double _factorToMilliampereHour;
  final double _factorToStatcoulomb;
  final double _factorToAbcoulomb;

  @override
  @internal
  double factorTo(ElectricChargeUnit targetUnit) {
    switch (targetUnit) {
      case ElectricChargeUnit.coulomb:
        return _factorToCoulomb;
      case ElectricChargeUnit.millicoulomb:
        return _factorToMillicoulomb;
      case ElectricChargeUnit.microcoulomb:
        return _factorToMicrocoulomb;
      case ElectricChargeUnit.nanocoulomb:
        return _factorToNanocoulomb;
      case ElectricChargeUnit.elementaryCharge:
        return _factorToElementaryCharge;
      case ElectricChargeUnit.ampereHour:
        return _factorToAmpereHour;
      case ElectricChargeUnit.milliampereHour:
        return _factorToMilliampereHour;
      case ElectricChargeUnit.statcoulomb:
        return _factorToStatcoulomb;
      case ElectricChargeUnit.abcoulomb:
        return _factorToAbcoulomb;
    }
  }
}
