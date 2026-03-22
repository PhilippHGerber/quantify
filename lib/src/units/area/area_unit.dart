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
  squareMegameter(AreaFactors.Mm2, 'Mm²'),

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
        _factorToSquareMegameter = toSquareMeterFactor / AreaFactors.Mm2,
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

  /// SI and unit symbols matched **strictly case-sensitive**.
  ///
  /// Used by `Area.parser`.
  @internal
  static const Map<String, AreaUnit> symbolAliases = {
    // square meter
    'm²': AreaUnit.squareMeter,
    'm2': AreaUnit.squareMeter,
    'sq m': AreaUnit.squareMeter,
    // square decimeter
    'dm²': AreaUnit.squareDecimeter,
    'dm2': AreaUnit.squareDecimeter,
    // square centimeter
    'cm²': AreaUnit.squareCentimeter,
    'cm2': AreaUnit.squareCentimeter,
    // square millimeter
    'mm²': AreaUnit.squareMillimeter,
    'mm2': AreaUnit.squareMillimeter,
    // square micrometer
    'µm²': AreaUnit.squareMicrometer,
    'um2': AreaUnit.squareMicrometer,
    // square decameter
    'dam²': AreaUnit.squareDecameter,
    'dam2': AreaUnit.squareDecameter,
    // square hectometer
    'hm²': AreaUnit.squareHectometer,
    'hm2': AreaUnit.squareHectometer,
    // hectare
    'ha': AreaUnit.hectare,
    // square kilometer
    'km²': AreaUnit.squareKilometer,
    'km2': AreaUnit.squareKilometer,
    // square megameter
    'Mm²': AreaUnit.squareMegameter,
    'Mm2': AreaUnit.squareMegameter,
    // square inch
    'in²': AreaUnit.squareInch,
    'in2': AreaUnit.squareInch,
    'sq in': AreaUnit.squareInch,
    // square foot
    'ft²': AreaUnit.squareFoot,
    'ft2': AreaUnit.squareFoot,
    'sq ft': AreaUnit.squareFoot,
    // square yard
    'yd²': AreaUnit.squareYard,
    'yd2': AreaUnit.squareYard,
    'sq yd': AreaUnit.squareYard,
    // square mile
    'mi²': AreaUnit.squareMile,
    'mi2': AreaUnit.squareMile,
    'sq mi': AreaUnit.squareMile,
    // acre
    'ac': AreaUnit.acre,
  };

  /// Full word-form names matched **case-insensitively**.
  ///
  /// Used by `Area.parser`.
  @internal
  static const Map<String, AreaUnit> nameAliases = {
    // square meter
    'square meter': AreaUnit.squareMeter,
    'square meters': AreaUnit.squareMeter,
    'square metre': AreaUnit.squareMeter,
    'square metres': AreaUnit.squareMeter,
    // square decimeter
    'square decimeter': AreaUnit.squareDecimeter,
    'square decimeters': AreaUnit.squareDecimeter,
    'square decimetre': AreaUnit.squareDecimeter,
    'square decimetres': AreaUnit.squareDecimeter,
    // square centimeter
    'square centimeter': AreaUnit.squareCentimeter,
    'square centimeters': AreaUnit.squareCentimeter,
    'square centimetre': AreaUnit.squareCentimeter,
    'square centimetres': AreaUnit.squareCentimeter,
    // square millimeter
    'square millimeter': AreaUnit.squareMillimeter,
    'square millimeters': AreaUnit.squareMillimeter,
    'square millimetre': AreaUnit.squareMillimeter,
    'square millimetres': AreaUnit.squareMillimeter,
    // square micrometer
    'square micrometer': AreaUnit.squareMicrometer,
    'square micrometers': AreaUnit.squareMicrometer,
    'square micrometre': AreaUnit.squareMicrometer,
    'square micrometres': AreaUnit.squareMicrometer,
    // square decameter
    'square decameter': AreaUnit.squareDecameter,
    'square decameters': AreaUnit.squareDecameter,
    'square decametre': AreaUnit.squareDecameter,
    'square decametres': AreaUnit.squareDecameter,
    // square hectometer
    'square hectometer': AreaUnit.squareHectometer,
    'square hectometers': AreaUnit.squareHectometer,
    'square hectometre': AreaUnit.squareHectometer,
    'square hectometres': AreaUnit.squareHectometer,
    // hectare
    'hectare': AreaUnit.hectare,
    'hectares': AreaUnit.hectare,
    'ha': AreaUnit.hectare,
    // square kilometer
    'square kilometer': AreaUnit.squareKilometer,
    'square kilometers': AreaUnit.squareKilometer,
    'square kilometre': AreaUnit.squareKilometer,
    'square kilometres': AreaUnit.squareKilometer,
    // square megameter
    'square megameter': AreaUnit.squareMegameter,
    'square megameters': AreaUnit.squareMegameter,
    'square megametre': AreaUnit.squareMegameter,
    'square megametres': AreaUnit.squareMegameter,
    // square inch
    'square inch': AreaUnit.squareInch,
    'square inches': AreaUnit.squareInch,
    // square foot
    'square foot': AreaUnit.squareFoot,
    'square feet': AreaUnit.squareFoot,
    // square yard
    'square yard': AreaUnit.squareYard,
    'square yards': AreaUnit.squareYard,
    // square mile
    'square mile': AreaUnit.squareMile,
    'square miles': AreaUnit.squareMile,
    // acre
    'acre': AreaUnit.acre,
    'acres': AreaUnit.acre,
    'ac': AreaUnit.acre,
  };

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
