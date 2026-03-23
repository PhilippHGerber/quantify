import 'package:meta/meta.dart';

import '../../core/unit.dart';
import 'volume_factors.dart';

/// Represents units of volume.
///
/// This enum implements the [LinearUnit] interface to provide conversion capabilities
/// and a display [symbol] for each volume unit.
/// All conversion factors are pre-calculated in the constructor relative to
/// Cubic Millimeter (mm³) for maximum precision.
enum VolumeUnit implements LinearUnit<VolumeUnit> {
  // --- SI Cubic ---
  /// Cubic Meter (m³), the SI derived unit of volume.
  cubicMeter(VolumeFactors.m3, 'm³'),

  /// Cubic Decameter (dam³). Also a Megalitre.
  cubicDecameter(VolumeFactors.dam3, 'dam³'),

  /// Cubic Hectometer (hm³). Also a Gigalitre.
  cubicHectometer(VolumeFactors.hm3, 'hm³'),

  /// Cubic Kilometer (km³). Also a Teralitre.
  cubicKilometer(VolumeFactors.km3, 'km³'),

  /// Cubic Decimeter (dm³). Also a Liter.
  cubicDecimeter(VolumeFactors.dm3, 'dm³'),

  /// Cubic Centimeter (cm³). Also a Milliliter.
  cubicCentimeter(VolumeFactors.cm3, 'cm³'),

  /// Cubic Millimeter (mm³). Also a Microliter.
  cubicMillimeter(VolumeFactors.mm3, 'mm³'),

  // --- Litre-based (aliases for cubic measures) ---
  /// Kilolitre (kl). Equivalent to a cubic meter.
  kiloliter(VolumeFactors.m3, 'kl'),

  /// Megalitre (Ml). Equivalent to a cubic decameter.
  megaliter(VolumeFactors.dam3, 'Ml'),

  /// Gigalitre (Gl). Equivalent to a cubic hectometer.
  gigaliter(VolumeFactors.hm3, 'Gl'),

  /// Teralitre (Tl). Equivalent to a cubic kilometer.
  teraliter(VolumeFactors.km3, 'Tl'),

  /// Litre (L). Equivalent to a cubic decimeter.
  litre(VolumeFactors.dm3, 'L'),

  /// Millilitre (mL). Equivalent to a cubic centimeter.
  milliliter(VolumeFactors.cm3, 'mL'),

  /// Centiliter (cl).
  centiliter(VolumeFactors.cl, 'cl'),

  /// Microlitre (µL). Equivalent to a cubic millimeter.
  microliter(VolumeFactors.mm3, 'µL'),

  // --- Imperial / US Customary Cubic ---
  /// Cubic Inch (in³).
  cubicInch(VolumeFactors.in3, 'in³'),

  /// Cubic Foot (ft³).
  cubicFoot(VolumeFactors.ft3, 'ft³'),

  /// Cubic Mile (mi³).
  cubicMile(VolumeFactors.mi3, 'mi³'),

  // --- US Customary Liquid ---
  /// US Liquid Gallon (gal).
  gallon(VolumeFactors.gal, 'gal'),

  /// US Liquid Quart (qt).
  quart(VolumeFactors.qt, 'qt'),

  /// US Liquid Pint (pt).
  pint(VolumeFactors.pt, 'pt'),

  /// US Fluid Ounce (fl-oz).
  fluidOunce(VolumeFactors.flOz, 'fl-oz'),

  // --- US Customary Cooking ---
  /// Tablespoon (tbsp).
  tablespoon(VolumeFactors.tbsp, 'tbsp'),

  /// Teaspoon (tsp).
  teaspoon(VolumeFactors.tsp, 'tsp');

  /// Constant constructor for enum members.
  const VolumeUnit(double toCubicMillimeterFactor, this.symbol)
      : _toCubicMillimeterFactor = toCubicMillimeterFactor,
        _factorToCubicMeter = toCubicMillimeterFactor / VolumeFactors.m3,
        _factorToCubicDecameter = toCubicMillimeterFactor / VolumeFactors.dam3,
        _factorToCubicHectometer = toCubicMillimeterFactor / VolumeFactors.hm3,
        _factorToCubicKilometer = toCubicMillimeterFactor / VolumeFactors.km3,
        _factorToCubicDecimeter = toCubicMillimeterFactor / VolumeFactors.dm3,
        _factorToCubicCentimeter = toCubicMillimeterFactor / VolumeFactors.cm3,
        _factorToCubicMillimeter = toCubicMillimeterFactor / VolumeFactors.mm3,
        _factorToKiloliter = toCubicMillimeterFactor / VolumeFactors.m3,
        _factorToMegaliter = toCubicMillimeterFactor / VolumeFactors.dam3,
        _factorToGigaliter = toCubicMillimeterFactor / VolumeFactors.hm3,
        _factorToTeraliter = toCubicMillimeterFactor / VolumeFactors.km3,
        _factorToLitre = toCubicMillimeterFactor / VolumeFactors.dm3,
        _factorToMilliliter = toCubicMillimeterFactor / VolumeFactors.cm3,
        _factorToCentiliter = toCubicMillimeterFactor / VolumeFactors.cl,
        _factorToMicroliter = toCubicMillimeterFactor / VolumeFactors.mm3,
        _factorToCubicInch = toCubicMillimeterFactor / VolumeFactors.in3,
        _factorToCubicFoot = toCubicMillimeterFactor / VolumeFactors.ft3,
        _factorToCubicMile = toCubicMillimeterFactor / VolumeFactors.mi3,
        _factorToGallon = toCubicMillimeterFactor / VolumeFactors.gal,
        _factorToQuart = toCubicMillimeterFactor / VolumeFactors.qt,
        _factorToPint = toCubicMillimeterFactor / VolumeFactors.pt,
        _factorToFluidOunce = toCubicMillimeterFactor / VolumeFactors.flOz,
        _factorToTablespoon = toCubicMillimeterFactor / VolumeFactors.tbsp,
        _factorToTeaspoon = toCubicMillimeterFactor / VolumeFactors.tsp;

  // ignore: unused_field // Conversion factor to Cubic Meter
  final double _toCubicMillimeterFactor;

  @override
  final String symbol;

  // --- Pre-calculated direct conversion factors ---
  final double _factorToCubicMeter;
  final double _factorToCubicDecameter;
  final double _factorToCubicHectometer;
  final double _factorToCubicKilometer;
  final double _factorToCubicDecimeter;
  final double _factorToCubicCentimeter;
  final double _factorToCubicMillimeter;
  final double _factorToKiloliter;
  final double _factorToMegaliter;
  final double _factorToGigaliter;
  final double _factorToTeraliter;
  final double _factorToLitre;
  final double _factorToMilliliter;
  final double _factorToCentiliter;
  final double _factorToMicroliter;
  final double _factorToCubicInch;
  final double _factorToCubicFoot;
  final double _factorToCubicMile;
  final double _factorToGallon;
  final double _factorToQuart;
  final double _factorToPint;
  final double _factorToFluidOunce;
  final double _factorToTablespoon;
  final double _factorToTeaspoon;

  /// SI and unit symbols matched **strictly case-sensitive**.
  ///
  /// Used by `Volume.parser`.
  @internal
  static const Map<String, VolumeUnit> symbolAliases = {
    // cubic meter
    'm³': VolumeUnit.cubicMeter,
    'm3': VolumeUnit.cubicMeter,
    // cubic kilometer
    'km³': VolumeUnit.cubicKilometer,
    'km3': VolumeUnit.cubicKilometer,
    // cubic centimeter
    'cm³': VolumeUnit.cubicCentimeter,
    'cm3': VolumeUnit.cubicCentimeter,
    'cc': VolumeUnit.cubicCentimeter,
    // cubic millimeter
    'mm³': VolumeUnit.cubicMillimeter,
    'mm3': VolumeUnit.cubicMillimeter,
    // liter
    'L': VolumeUnit.litre,
    'l': VolumeUnit.litre,
    // milliliter
    'mL': VolumeUnit.milliliter,
    'ml': VolumeUnit.milliliter,
    // centiliter
    'cL': VolumeUnit.centiliter,
    'cl': VolumeUnit.centiliter,
    // microliter
    'µL': VolumeUnit.microliter,
    'uL': VolumeUnit.microliter,
    // kiloliter
    'kL': VolumeUnit.kiloliter,
    'kl': VolumeUnit.kiloliter,
    // megaliter (capital M)
    'ML': VolumeUnit.megaliter,
    'Ml': VolumeUnit.megaliter,
    // gigaliter
    'GL': VolumeUnit.gigaliter,
    'Gl': VolumeUnit.gigaliter,
    // teraliter
    'TL': VolumeUnit.teraliter,
    'Tl': VolumeUnit.teraliter,
    // cubic inch
    'in³': VolumeUnit.cubicInch,
    'in3': VolumeUnit.cubicInch,
    // cubic foot
    'ft³': VolumeUnit.cubicFoot,
    'ft3': VolumeUnit.cubicFoot,
    // cubic mile
    'mi³': VolumeUnit.cubicMile,
    'mi3': VolumeUnit.cubicMile,
    // gallon
    'gal': VolumeUnit.gallon,
    // quart
    'qt': VolumeUnit.quart,
    // pint
    'pt': VolumeUnit.pint,
    // fluid ounce
    'fl-oz': VolumeUnit.fluidOunce,
    'fl oz': VolumeUnit.fluidOunce,
    // tablespoon
    'tbsp': VolumeUnit.tablespoon,
    'T': VolumeUnit.tablespoon,
    // teaspoon
    'tsp': VolumeUnit.teaspoon,
    't': VolumeUnit.teaspoon,
  };

  /// Full word-form names matched **case-insensitively**.
  ///
  /// Used by `Volume.parser`.
  @internal
  static const Map<String, VolumeUnit> nameAliases = {
    // cubic meter
    'cubic meter': VolumeUnit.cubicMeter,
    'cubic meters': VolumeUnit.cubicMeter,
    'cubic metre': VolumeUnit.cubicMeter,
    'cubic metres': VolumeUnit.cubicMeter,
    // cubic kilometer
    'cubic kilometer': VolumeUnit.cubicKilometer,
    'cubic kilometers': VolumeUnit.cubicKilometer,
    'cubic kilometre': VolumeUnit.cubicKilometer,
    'cubic kilometres': VolumeUnit.cubicKilometer,
    // cubic centimeter
    'cubic centimeter': VolumeUnit.cubicCentimeter,
    'cubic centimeters': VolumeUnit.cubicCentimeter,
    'cubic centimetre': VolumeUnit.cubicCentimeter,
    'cubic centimetres': VolumeUnit.cubicCentimeter,
    // cubic millimeter
    'cubic millimeter': VolumeUnit.cubicMillimeter,
    'cubic millimeters': VolumeUnit.cubicMillimeter,
    'cubic millimetre': VolumeUnit.cubicMillimeter,
    'cubic millimetres': VolumeUnit.cubicMillimeter,
    // liter
    'liter': VolumeUnit.litre,
    'liters': VolumeUnit.litre,
    'litre': VolumeUnit.litre,
    'litres': VolumeUnit.litre,
    // milliliter
    'milliliter': VolumeUnit.milliliter,
    'milliliters': VolumeUnit.milliliter,
    'millilitre': VolumeUnit.milliliter,
    'millilitres': VolumeUnit.milliliter,
    // centiliter
    'centiliter': VolumeUnit.centiliter,
    'centiliters': VolumeUnit.centiliter,
    'centilitre': VolumeUnit.centiliter,
    'centilitres': VolumeUnit.centiliter,
    // microliter
    'microliter': VolumeUnit.microliter,
    'microliters': VolumeUnit.microliter,
    'microlitre': VolumeUnit.microliter,
    'microlitres': VolumeUnit.microliter,
    // kiloliter
    'kiloliter': VolumeUnit.kiloliter,
    'kiloliters': VolumeUnit.kiloliter,
    'kilolitre': VolumeUnit.kiloliter,
    'kilolitres': VolumeUnit.kiloliter,
    // megaliter
    'megaliter': VolumeUnit.megaliter,
    'megaliters': VolumeUnit.megaliter,
    'megalitre': VolumeUnit.megaliter,
    'megalitres': VolumeUnit.megaliter,
    // gigaliter
    'gigaliter': VolumeUnit.gigaliter,
    'gigaliters': VolumeUnit.gigaliter,
    'gigalitre': VolumeUnit.gigaliter,
    'gigalitres': VolumeUnit.gigaliter,
    // teraliter
    'teraliter': VolumeUnit.teraliter,
    'teraliters': VolumeUnit.teraliter,
    'teralitre': VolumeUnit.teraliter,
    'teralitres': VolumeUnit.teraliter,
    // cubic inch
    'cubic inch': VolumeUnit.cubicInch,
    'cubic inches': VolumeUnit.cubicInch,
    // cubic foot
    'cubic foot': VolumeUnit.cubicFoot,
    'cubic feet': VolumeUnit.cubicFoot,
    // cubic mile
    'cubic mile': VolumeUnit.cubicMile,
    'cubic miles': VolumeUnit.cubicMile,
    // gallon
    'gallon': VolumeUnit.gallon,
    'gallons': VolumeUnit.gallon,
    // quart
    'quart': VolumeUnit.quart,
    'quarts': VolumeUnit.quart,
    // pint
    'pint': VolumeUnit.pint,
    'pints': VolumeUnit.pint,
    // fluid ounce
    'fluid ounce': VolumeUnit.fluidOunce,
    'fluid ounces': VolumeUnit.fluidOunce,
    // tablespoon
    'tablespoon': VolumeUnit.tablespoon,
    'tablespoons': VolumeUnit.tablespoon,
    // teaspoon
    'teaspoon': VolumeUnit.teaspoon,
    'teaspoons': VolumeUnit.teaspoon,
  };

  @override
  @internal
  double factorTo(VolumeUnit targetUnit) {
    switch (targetUnit) {
      case VolumeUnit.cubicMeter:
        return _factorToCubicMeter;
      case VolumeUnit.cubicDecameter:
        return _factorToCubicDecameter;
      case VolumeUnit.cubicHectometer:
        return _factorToCubicHectometer;
      case VolumeUnit.cubicKilometer:
        return _factorToCubicKilometer;
      case VolumeUnit.cubicDecimeter:
        return _factorToCubicDecimeter;
      case VolumeUnit.cubicCentimeter:
        return _factorToCubicCentimeter;
      case VolumeUnit.cubicMillimeter:
        return _factorToCubicMillimeter;
      case VolumeUnit.kiloliter:
        return _factorToKiloliter;
      case VolumeUnit.megaliter:
        return _factorToMegaliter;
      case VolumeUnit.gigaliter:
        return _factorToGigaliter;
      case VolumeUnit.teraliter:
        return _factorToTeraliter;
      case VolumeUnit.litre:
        return _factorToLitre;
      case VolumeUnit.milliliter:
        return _factorToMilliliter;
      case VolumeUnit.centiliter:
        return _factorToCentiliter;
      case VolumeUnit.microliter:
        return _factorToMicroliter;
      case VolumeUnit.cubicInch:
        return _factorToCubicInch;
      case VolumeUnit.cubicFoot:
        return _factorToCubicFoot;
      case VolumeUnit.cubicMile:
        return _factorToCubicMile;
      case VolumeUnit.gallon:
        return _factorToGallon;
      case VolumeUnit.quart:
        return _factorToQuart;
      case VolumeUnit.pint:
        return _factorToPint;
      case VolumeUnit.fluidOunce:
        return _factorToFluidOunce;
      case VolumeUnit.tablespoon:
        return _factorToTablespoon;
      case VolumeUnit.teaspoon:
        return _factorToTeaspoon;
    }
  }
}
