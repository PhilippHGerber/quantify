import 'area.dart';
import 'area_unit.dart';

/// Provides convenient access to [Area] values in specific units
/// using getter properties.
extension AreaValueGetters on Area {
  /// Returns the area value in Square Meters (m²).
  double get inSquareMeters => getValue(AreaUnit.squareMeter);

  /// Returns the area value in Square Decimeters (dm²).
  double get inSquareDecimeters => getValue(AreaUnit.squareDecimeter);

  /// Returns the area value in Square Centimeters (cm²).
  double get inSquareCentimeters => getValue(AreaUnit.squareCentimeter);

  /// Returns the area value in Square Millimeters (mm²).
  double get inSquareMillimeters => getValue(AreaUnit.squareMillimeter);

  /// Returns the area value in Square Micrometers (µm²).
  double get inSquareMicrometers => getValue(AreaUnit.squareMicrometer);

  /// Returns the area value in Square Decameters (dam²).
  double get inSquareDecameters => getValue(AreaUnit.squareDecameter);

  /// Returns the area value in Square Hectometers (hm²).
  double get inSquareHectometers => getValue(AreaUnit.squareHectometer);

  /// Returns the area value in Hectares (ha).
  double get inHectares => getValue(AreaUnit.hectare);

  /// Returns the area value in Square Kilometers (km²).
  double get inSquareKilometers => getValue(AreaUnit.squareKilometer);

  /// Returns the area value in Square Megameters (Mm²).
  double get inSquareMegameters => getValue(AreaUnit.squareMegameter);

  /// Returns the area value in Square Inches (in²).
  double get inSquareInches => getValue(AreaUnit.squareInch);

  /// Returns the area value in Square Feet (ft²).
  double get inSquareFeet => getValue(AreaUnit.squareFoot);

  /// Returns the area value in Square Yards (yd²).
  double get inSquareYards => getValue(AreaUnit.squareYard);

  /// Returns the area value in Square Miles (mi²).
  double get inSquareMiles => getValue(AreaUnit.squareMile);

  /// Returns the area value in Acres (ac).
  double get inAcres => getValue(AreaUnit.acre);

  /// Returns a new [Area] object representing this area in Square Meters (m²).
  Area get asSquareMeter => convertTo(AreaUnit.squareMeter);

  /// Returns a new [Area] object representing this area in Square Decimeters (dm²).
  Area get asSquareDecimeter => convertTo(AreaUnit.squareDecimeter);

  /// Returns a new [Area] object representing this area in Square Centimeters (cm²).
  Area get asSquareCentimeter => convertTo(AreaUnit.squareCentimeter);

  /// Returns a new [Area] object representing this area in Square Millimeters (mm²).
  Area get asSquareMillimeter => convertTo(AreaUnit.squareMillimeter);

  /// Returns a new [Area] object representing this area in Square Micrometers (µm²).
  Area get asSquareMicrometer => convertTo(AreaUnit.squareMicrometer);

  /// Returns a new [Area] object representing this area in Square Decameters (dam²).
  Area get asSquareDecameter => convertTo(AreaUnit.squareDecameter);

  /// Returns a new [Area] object representing this area in Square Hectometers (hm²).
  Area get asSquareHectometer => convertTo(AreaUnit.squareHectometer);

  /// Returns a new [Area] object representing this area in Hectares (ha).
  Area get asHectare => convertTo(AreaUnit.hectare);

  /// Returns a new [Area] object representing this area in Square Kilometers (km²).
  Area get asSquareKilometer => convertTo(AreaUnit.squareKilometer);

  /// Returns a new [Area] object representing this area in Square Megameters (Mm²).
  Area get asSquareMegameter => convertTo(AreaUnit.squareMegameter);

  /// Returns a new [Area] object representing this area in Square Inches (in²).
  Area get asSquareInch => convertTo(AreaUnit.squareInch);

  /// Returns a new [Area] object representing this area in Square Feet (ft²).
  Area get asSquareFoot => convertTo(AreaUnit.squareFoot);

  /// Returns a new [Area] object representing this area in Square Yards (yd²).
  Area get asSquareYard => convertTo(AreaUnit.squareYard);

  /// Returns a new [Area] object representing this area in Square Miles (mi²).
  Area get asSquareMile => convertTo(AreaUnit.squareMile);

  /// Returns a new [Area] object representing this area in Acres (ac).
  Area get asAcre => convertTo(AreaUnit.acre);
}

/// Provides convenient factory methods for creating [Area] instances from [num]
/// using getter properties named after common unit symbols or names.
///
/// This allows for an intuitive and concise way to create area quantities,
/// for example: `10.m2` or `5.ha`.
extension AreaCreation on num {
  /// Creates an [Area] instance representing this numerical value in Square Meters (m²).
  Area get m2 => Area(toDouble(), AreaUnit.squareMeter);

  /// Creates an [Area] instance representing this numerical value in Square Decimeters (dm²).
  Area get dm2 => Area(toDouble(), AreaUnit.squareDecimeter);

  /// Creates an [Area] instance representing this numerical value in Square Centimeters (cm²).
  Area get cm2 => Area(toDouble(), AreaUnit.squareCentimeter);

  /// Creates an [Area] instance representing this numerical value in Square Millimeters (mm²).
  Area get mm2 => Area(toDouble(), AreaUnit.squareMillimeter);

  /// Creates an [Area] instance representing this numerical value in Square Micrometers (µm²).
  Area get um2 => Area(toDouble(), AreaUnit.squareMicrometer);

  /// Creates an [Area] instance representing this numerical value in Square Decameters (dam²).
  Area get dam2 => Area(toDouble(), AreaUnit.squareDecameter);

  /// Creates an [Area] instance representing this numerical value in Square Hectometers (hm²).
  Area get hm2 => Area(toDouble(), AreaUnit.squareHectometer);

  /// Creates an [Area] instance representing this numerical value in Hectares (ha).
  Area get ha => Area(toDouble(), AreaUnit.hectare);

  /// Creates an [Area] instance representing this numerical value in Square Kilometers (km²).
  Area get km2 => Area(toDouble(), AreaUnit.squareKilometer);

  /// Creates an [Area] instance representing this numerical value in Square Megameters (Mm²).
  /// Alias for `squareMegameter`.
  Area get squareMegameter => Area(toDouble(), AreaUnit.squareMegameter);

  /// Creates an [Area] instance representing this numerical value in Square Inches (in²).
  Area get in2 => Area(toDouble(), AreaUnit.squareInch);

  /// Creates an [Area] instance representing this numerical value in Square Feet (ft²).
  Area get ft2 => Area(toDouble(), AreaUnit.squareFoot);

  /// Creates an [Area] instance representing this numerical value in Square Yards (yd²).
  Area get yd2 => Area(toDouble(), AreaUnit.squareYard);

  /// Creates an [Area] instance representing this numerical value in Square Miles (mi²).
  Area get mi2 => Area(toDouble(), AreaUnit.squareMile);

  /// Creates an [Area] instance representing this numerical value in Acres (ac).
  Area get ac => Area(toDouble(), AreaUnit.acre);
}
