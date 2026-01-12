import 'volume.dart';
import 'volume_unit.dart';

/// Provides convenient access to [Volume] values in specific units
/// using getter properties.
extension VolumeValueGetters on Volume {
  // --- SI Cubic ---

  /// Returns the volume value in Cubic Meters (m³).
  double get inCubicMeters => getValue(VolumeUnit.cubicMeter);

  /// Returns the volume value in Cubic Decameters (dam³).
  double get inCubicDecameters => getValue(VolumeUnit.cubicDecameter);

  /// Returns the volume value in Cubic Hectometers (hm³).
  double get inCubicHectometers => getValue(VolumeUnit.cubicHectometer);

  /// Returns the volume value in Cubic Kilometers (km³).
  double get inCubicKilometers => getValue(VolumeUnit.cubicKilometer);

  /// Returns the volume value in Cubic Decimeters (dm³).
  double get inCubicDecimeters => getValue(VolumeUnit.cubicDecimeter);

  /// Returns the volume value in Cubic Centimeters (cm³).
  double get inCubicCentimeters => getValue(VolumeUnit.cubicCentimeter);

  /// Returns the volume value in Cubic Millimeters (mm³).
  double get inCubicMillimeters => getValue(VolumeUnit.cubicMillimeter);

  // --- Litre-based ---

  /// Returns the volume value in Kiloliters (kl).
  double get inKiloliters => getValue(VolumeUnit.kiloliter);

  /// Returns the volume value in Megaliters (Ml).
  double get inMegaliters => getValue(VolumeUnit.megaliter);

  /// Returns the volume value in Gigaliters (Gl).
  double get inGigaliters => getValue(VolumeUnit.gigaliter);

  /// Returns the volume value in Teraliters (Tl).
  double get inTeraliters => getValue(VolumeUnit.teraliter);

  /// Returns the volume value in Liters (L).
  double get inLiters => getValue(VolumeUnit.litre);

  /// Returns the volume value in Milliliters (mL).
  double get inMilliliters => getValue(VolumeUnit.milliliter);

  /// Returns the volume value in Centiliters (cl).
  double get inCentiliters => getValue(VolumeUnit.centiliter);

  /// Returns the volume value in Microliters (µL).
  double get inMicroliters => getValue(VolumeUnit.microliter);

  // --- Imperial / US Customary Cubic ---

  /// Returns the volume value in Cubic Inches (in³).
  double get inCubicInches => getValue(VolumeUnit.cubicInch);

  /// Returns the volume value in Cubic Feet (ft³).
  double get inCubicFeet => getValue(VolumeUnit.cubicFoot);

  /// Returns the volume value in Cubic Miles (mi³).
  double get inCubicMiles => getValue(VolumeUnit.cubicMile);

  // --- US Customary Liquid ---

  /// Returns the volume value in US Gallons (gal).
  double get inGallons => getValue(VolumeUnit.gallon);

  /// Returns the volume value in US Quarts (qt).
  double get inQuarts => getValue(VolumeUnit.quart);

  /// Returns the volume value in US Pints (pt).
  double get inPints => getValue(VolumeUnit.pint);

  /// Returns the volume value in US Fluid Ounces (fl-oz).
  double get inFluidOunces => getValue(VolumeUnit.fluidOunce);

  // --- US Customary Cooking ---

  /// Returns the volume value in US Tablespoons (tbsp).
  double get inTablespoons => getValue(VolumeUnit.tablespoon);

  /// Returns the volume value in US Teaspoons (tsp).
  double get inTeaspoons => getValue(VolumeUnit.teaspoon);

  // --- "As" Getters for new Volume objects ---

  /// Returns a new [Volume] object representing this volume in Cubic Meters (m³).
  Volume get asCubicMeters => convertTo(VolumeUnit.cubicMeter);

  /// Returns a new [Volume] object representing this volume in Cubic Decameters (dam³).
  Volume get asCubicDecameters => convertTo(VolumeUnit.cubicDecameter);

  /// Returns a new [Volume] object representing this volume in Cubic Hectometers (hm³).
  Volume get asCubicHectometers => convertTo(VolumeUnit.cubicHectometer);

  /// Returns a new [Volume] object representing this volume in Cubic Kilometers (km³).
  Volume get asCubicKilometers => convertTo(VolumeUnit.cubicKilometer);

  /// Returns a new [Volume] object representing this volume in Cubic Decimeters (dm³).
  Volume get asCubicDecimeters => convertTo(VolumeUnit.cubicDecimeter);

  /// Returns a new [Volume] object representing this volume in Cubic Centimeters (cm³).
  Volume get asCubicCentimeters => convertTo(VolumeUnit.cubicCentimeter);

  /// Returns a new [Volume] object representing this volume in Cubic Millimeters (mm³).
  Volume get asCubicMillimeters => convertTo(VolumeUnit.cubicMillimeter);

  /// Returns a new [Volume] object representing this volume in Kiloliters (kl).
  Volume get asKiloliters => convertTo(VolumeUnit.kiloliter);

  /// Returns a new [Volume] object representing this volume in Megaliters (Ml).
  Volume get asMegaliters => convertTo(VolumeUnit.megaliter);

  /// Returns a new [Volume] object representing this volume in Gigaliters (Gl).
  Volume get asGigaliters => convertTo(VolumeUnit.gigaliter);

  /// Returns a new [Volume] object representing this volume in Teraliters (Tl).
  Volume get asTeraliters => convertTo(VolumeUnit.teraliter);

  /// Returns a new [Volume] object representing this volume in Liters (L).
  Volume get asLiters => convertTo(VolumeUnit.litre);

  /// Returns a new [Volume] object representing this volume in Milliliters (mL).
  Volume get asMilliliters => convertTo(VolumeUnit.milliliter);

  /// Returns a new [Volume] object representing this volume in Centiliters (cl).
  Volume get asCentiliters => convertTo(VolumeUnit.centiliter);

  /// Returns a new [Volume] object representing this volume in Microliters (µL).
  Volume get asMicroliters => convertTo(VolumeUnit.microliter);

  /// Returns a new [Volume] object representing this volume in Cubic Inches (in³).
  Volume get asCubicInches => convertTo(VolumeUnit.cubicInch);

  /// Returns a new [Volume] object representing this volume in Cubic Feet (ft³).
  Volume get asCubicFeet => convertTo(VolumeUnit.cubicFoot);

  /// Returns a new [Volume] object representing this volume in Cubic Miles (mi³).
  Volume get asCubicMiles => convertTo(VolumeUnit.cubicMile);

  /// Returns a new [Volume] object representing this volume in US Gallons (gal).
  Volume get asGallons => convertTo(VolumeUnit.gallon);

  /// Returns a new [Volume] object representing this volume in US Quarts (qt).
  Volume get asQuarts => convertTo(VolumeUnit.quart);

  /// Returns a new [Volume] object representing this volume in US Pints (pt).
  Volume get asPints => convertTo(VolumeUnit.pint);

  /// Returns a new [Volume] object representing this volume in US Fluid Ounces (fl-oz).
  Volume get asFluidOunces => convertTo(VolumeUnit.fluidOunce);

  /// Returns a new [Volume] object representing this volume in US Tablespoons (tbsp).
  Volume get asTablespoons => convertTo(VolumeUnit.tablespoon);

  /// Returns a new [Volume] object representing this volume in US Teaspoons (tsp).
  Volume get asTeaspoons => convertTo(VolumeUnit.teaspoon);
}

/// Provides convenient factory methods for creating [Volume] instances from [num]
/// using getter properties named after common unit symbols or names.
extension VolumeCreation on num {
  // --- SI and Litre Aliases ---

  /// Creates a [Volume] instance from this value in Cubic Meters (m³).
  Volume get m3 => Volume(toDouble(), VolumeUnit.cubicMeter);

  /// Creates a [Volume] instance from this value in Kiloliters (kl).
  Volume get kl => Volume(toDouble(), VolumeUnit.kiloliter);

  /// Creates a [Volume] instance from this value in Cubic Decimeters (dm³).
  Volume get dm3 => Volume(toDouble(), VolumeUnit.cubicDecimeter);

  /// Creates a [Volume] instance from this value in Liters (L).
  Volume get l => Volume(toDouble(), VolumeUnit.litre);

  /// Creates a [Volume] instance from this value in Liters (L).
  /// Alias for `l`.
  Volume get liters => Volume(toDouble(), VolumeUnit.litre);

  /// Creates a [Volume] instance from this value in Cubic Centimeters (cm³).
  Volume get cm3 => Volume(toDouble(), VolumeUnit.cubicCentimeter);

  /// Creates a [Volume] instance from this value in Milliliters (mL).
  Volume get ml => Volume(toDouble(), VolumeUnit.milliliter);

  /// Creates a [Volume] instance from this value in Milliliters (mL).
  /// Alias for `ml`.
  Volume get milliliters => Volume(toDouble(), VolumeUnit.milliliter);

  /// Creates a [Volume] instance from this value in Centiliters (cl).
  Volume get cl => Volume(toDouble(), VolumeUnit.centiliter);

  /// Creates a [Volume] instance from this value in Centiliters (cl).
  /// Alias for `cl`.
  Volume get centiliters => Volume(toDouble(), VolumeUnit.centiliter);

  /// Creates a [Volume] instance from this value in Cubic Millimeters (mm³).
  Volume get mm3 => Volume(toDouble(), VolumeUnit.cubicMillimeter);

  /// Creates a [Volume] instance from this value in Microliters (µL).
  Volume get ul => Volume(toDouble(), VolumeUnit.microliter);

  /// Creates a [Volume] instance from this value in Cubic Decameters (dam³).
  Volume get dam3 => Volume(toDouble(), VolumeUnit.cubicDecameter);

  /// Creates a [Volume] instance from this value in Megaliters (Ml).
  Volume get megaliter => Volume(toDouble(), VolumeUnit.megaliter);

  /// Creates a [Volume] instance from this value in Cubic Hectometers (hm³).
  Volume get hm3 => Volume(toDouble(), VolumeUnit.cubicHectometer);

  /// Creates a [Volume] instance from this value in Gigaliters (Gl).
  Volume get gigaliter => Volume(toDouble(), VolumeUnit.gigaliter);

  /// Creates a [Volume] instance from this value in Cubic Kilometers (km³).
  Volume get km3 => Volume(toDouble(), VolumeUnit.cubicKilometer);

  /// Creates a [Volume] instance from this value in Teraliters (Tl).
  Volume get teraliter => Volume(toDouble(), VolumeUnit.teraliter);

  // --- Imperial / US Customary ---

  /// Creates a [Volume] instance from this value in Cubic Inches (in³).
  Volume get in3 => Volume(toDouble(), VolumeUnit.cubicInch);

  /// Creates a [Volume] instance from this value in Cubic Feet (ft³).
  Volume get ft3 => Volume(toDouble(), VolumeUnit.cubicFoot);

  /// Creates a [Volume] instance from this value in Cubic Miles (mi³).
  Volume get mi3 => Volume(toDouble(), VolumeUnit.cubicMile);

  /// Creates a [Volume] instance from this value in US Gallons (gal).
  Volume get gal => Volume(toDouble(), VolumeUnit.gallon);

  /// Creates a [Volume] instance from this value in US Gallons (gal).
  /// Alias for `gal`.
  Volume get gallons => Volume(toDouble(), VolumeUnit.gallon);

  /// Creates a [Volume] instance from this value in US Quarts (qt).
  Volume get qt => Volume(toDouble(), VolumeUnit.quart);

  /// Creates a [Volume] instance from this value in US Quarts (qt).
  /// Alias for `qt`.
  Volume get quarts => Volume(toDouble(), VolumeUnit.quart);

  /// Creates a [Volume] instance from this value in US Pints (pt).
  Volume get pt => Volume(toDouble(), VolumeUnit.pint);

  /// Creates a [Volume] instance from this value in US Pints (pt).
  /// Alias for `pt`.
  Volume get pints => Volume(toDouble(), VolumeUnit.pint);

  /// Creates a [Volume] instance from this value in US Fluid Ounces (fl-oz).
  Volume get flOz => Volume(toDouble(), VolumeUnit.fluidOunce);

  /// Creates a [Volume] instance from this value in US Tablespoons (tbsp).
  Volume get tbsp => Volume(toDouble(), VolumeUnit.tablespoon);

  /// Creates a [Volume] instance from this value in US Tablespoons (tbsp).
  /// Alias for `tbsp`.
  Volume get tablespoons => Volume(toDouble(), VolumeUnit.tablespoon);

  /// Creates a [Volume] instance from this value in US Teaspoons (tsp).
  Volume get tsp => Volume(toDouble(), VolumeUnit.teaspoon);

  /// Creates a [Volume] instance from this value in US Teaspoons (tsp).
  /// Alias for `tsp`.
  Volume get teaspoons => Volume(toDouble(), VolumeUnit.teaspoon);
}
