import 'package:meta/meta.dart';

import '../../core/unit.dart';
import 'area_factors.dart';

/// Represents units of area.
///
/// This enum implements the [Unit] interface to provide conversion capabilities
/// and a display [symbol] for each area unit.
/// All conversion factors are pre-calculated in the constructor relative to
/// Square Meter (m²).
enum AreaUnit implements Unit<AreaUnit> {
  /// Square Meter (m²), the SI derived unit of area.
  squareMeter(1, 'm²'),

  /// Square Decimeter (dm²).
  squareDecimeter(AreaFactors.dm2, 'dm²'),

  /// Square Centimeter (cm²).
  squareCentimeter(AreaFactors.cm2, 'cm²'),

  /// Square Millimeter (mm²).
  squareMillimeter(AreaFactors.mm2, 'mm²'),

  /// Square Micrometer (µm²).
  squareMicrometer(AreaFactors.um2, 'µm²'),

  /// Square Decameter (dam²).
  squareDecameter(AreaFactors.dam2, 'dam²'),

  /// Square Hectometer (hm²).
  squareHectometer(AreaFactors.hm2, 'hm²'),

  /// Hectare (ha), a common unit for land area, equal to 10,000 m².
  hectare(AreaFactors.hm2, 'ha'),

  /// Square Kilometer (km²).
  squareKilometer(AreaFactors.km2, 'km²'),

  /// Square Megameter (Mm²).
  squareMegameter(AreaFactors.squareMegameter, 'Mm²'),

  /// Square Inch (in²).
  squareInch(AreaFactors.in2, 'in²'),

  /// Square Foot (ft²).
  squareFoot(AreaFactors.ft2, 'ft²'),

  /// Square Yard (yd²).
  squareYard(AreaFactors.yd2, 'yd²'),

  /// Square Mile (mi²).
  squareMile(AreaFactors.mi2, 'mi²'),

  /// Acre (ac).
  acre(AreaFactors.ac, 'ac');

  /// Constant constructor for enum members.
  const AreaUnit(double toSquareMeterFactor, this.symbol)
      : _toSquareMeterFactor = toSquareMeterFactor,
        _factorToSquareMeter = toSquareMeterFactor / 1.0,
        _factorToSquareDecimeter = toSquareMeterFactor / AreaFactors.dm2,
        _factorToSquareCentimeter = toSquareMeterFactor / AreaFactors.cm2,
        _factorToSquareMillimeter = toSquareMeterFactor / AreaFactors.mm2,
        _factorToSquareMicrometer = toSquareMeterFactor / AreaFactors.um2,
        _factorToSquareDecameter = toSquareMeterFactor / AreaFactors.dam2,
        _factorToSquareHectometer = toSquareMeterFactor / AreaFactors.hm2,
        _factorToHectare = toSquareMeterFactor / AreaFactors.hm2,
        _factorToSquareKilometer = toSquareMeterFactor / AreaFactors.km2,
        _factorToSquareMegameter = toSquareMeterFactor / AreaFactors.squareMegameter,
        _factorToSquareInch = toSquareMeterFactor / AreaFactors.in2,
        _factorToSquareFoot = toSquareMeterFactor / AreaFactors.ft2,
        _factorToSquareYard = toSquareMeterFactor / AreaFactors.yd2,
        _factorToSquareMile = toSquareMeterFactor / AreaFactors.mi2,
        _factorToAcre = toSquareMeterFactor / AreaFactors.ac;

  // ignore: unused_field // The factor to convert this unit to Square Meter (m²).
  final double _toSquareMeterFactor;

  @override
  final String symbol;

  // --- Pre-calculated direct conversion factors ---
  final double _factorToSquareMeter;
  final double _factorToSquareDecimeter;
  final double _factorToSquareCentimeter;
  final double _factorToSquareMillimeter;
  final double _factorToSquareMicrometer;
  final double _factorToSquareDecameter;
  final double _factorToSquareHectometer;
  final double _factorToHectare;
  final double _factorToSquareKilometer;
  final double _factorToSquareMegameter;
  final double _factorToSquareInch;
  final double _factorToSquareFoot;
  final double _factorToSquareYard;
  final double _factorToSquareMile;
  final double _factorToAcre;

  @override
  @internal
  double factorTo(AreaUnit targetUnit) {
    switch (targetUnit) {
      case AreaUnit.squareMeter:
        return _factorToSquareMeter;
      case AreaUnit.squareDecimeter:
        return _factorToSquareDecimeter;
      case AreaUnit.squareCentimeter:
        return _factorToSquareCentimeter;
      case AreaUnit.squareMillimeter:
        return _factorToSquareMillimeter;
      case AreaUnit.squareMicrometer:
        return _factorToSquareMicrometer;
      case AreaUnit.squareDecameter:
        return _factorToSquareDecameter;
      case AreaUnit.squareHectometer:
        return _factorToSquareHectometer;
      case AreaUnit.hectare:
        return _factorToHectare;
      case AreaUnit.squareKilometer:
        return _factorToSquareKilometer;
      case AreaUnit.squareMegameter:
        return _factorToSquareMegameter;
      case AreaUnit.squareInch:
        return _factorToSquareInch;
      case AreaUnit.squareFoot:
        return _factorToSquareFoot;
      case AreaUnit.squareYard:
        return _factorToSquareYard;
      case AreaUnit.squareMile:
        return _factorToSquareMile;
      case AreaUnit.acre:
        return _factorToAcre;
    }
  }
}
