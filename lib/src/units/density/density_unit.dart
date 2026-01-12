import 'package:meta/meta.dart';

import '../../core/unit.dart';
import 'density_factors.dart';

/// Represents units of density.
///
/// This enum implements the [Unit] interface to provide conversion capabilities
/// and a display [symbol] for each density unit.
/// All conversion factors are pre-calculated in the constructor relative to
/// Kilogram per Cubic Meter (kg/m³).
enum DensityUnit implements Unit<DensityUnit> {
  /// Kilogram per Cubic Meter (kg/m³), the SI derived unit of density.
  kilogramPerCubicMeter(DensityFactors.kilogramPerCubicMeter, 'kg/m³'),

  /// Gram per Cubic Centimeter (g/cm³), a common CGS unit of density.
  gramPerCubicCentimeter(DensityFactors.gramPerCubicCentimeter, 'g/cm³'),

  /// Gram per Milliliter (g/mL), equivalent to g/cm³, often used for liquids.
  gramPerMilliliter(DensityFactors.gramPerMilliliter, 'g/mL');

  /// Constant constructor for enum members.
  const DensityUnit(double toKgPerM3Factor, this.symbol)
      : _toKgPerM3Factor = toKgPerM3Factor,
        _factorToKilogramPerCubicMeter = toKgPerM3Factor / 1.0,
        _factorToGramPerCubicCentimeter = toKgPerM3Factor / DensityFactors.gramPerCubicCentimeter,
        _factorToGramPerMilliliter = toKgPerM3Factor / DensityFactors.gramPerMilliliter;

  // ignore: unused_field // Used to store the conversion factor to kg/m³.
  final double _toKgPerM3Factor;

  @override
  final String symbol;

  // --- Pre-calculated direct conversion factors ---
  final double _factorToKilogramPerCubicMeter;
  final double _factorToGramPerCubicCentimeter;
  final double _factorToGramPerMilliliter;

  @override
  @internal
  double factorTo(DensityUnit targetUnit) {
    switch (targetUnit) {
      case DensityUnit.kilogramPerCubicMeter:
        return _factorToKilogramPerCubicMeter;
      case DensityUnit.gramPerCubicCentimeter:
        return _factorToGramPerCubicCentimeter;
      case DensityUnit.gramPerMilliliter:
        return _factorToGramPerMilliliter;
    }
  }
}
