import 'length.dart';
import 'length_unit.dart';

/// Provides convenient access to [Length] values in specific units.
extension LengthValueGetters on Length {
  /// Returns the length value in Meters (m).
  double get inMeters => getValue(LengthUnit.meter);

  /// Returns the length value in Kilometers (km).
  double get inKilometers => getValue(LengthUnit.kilometer);

  /// Returns the length value in Centimeters (cm).
  double get inCentimeters => getValue(LengthUnit.centimeter);

  /// Returns the length value in Millimeters (mm).
  double get inMillimeters => getValue(LengthUnit.millimeter);

  /// Returns the length value in Inches (in).
  double get inInches => getValue(LengthUnit.inch);

  /// Returns the length value in Feet (ft).
  double get inFeet => getValue(LengthUnit.foot);

  /// Returns the length value in Yards (yd).
  double get inYards => getValue(LengthUnit.yard);

  /// Returns the length value in Miles (mi).
  double get inMiles => getValue(LengthUnit.mile);

  /// Returns the length value in Nautical Miles (nmi).
  double get inNauticalMiles => getValue(LengthUnit.nauticalMile);
}

/// Provides convenient factory methods for creating [Length] instances from [num].
extension LengthCreation on num {
  /// Creates a [Length] instance representing this numerical value in Meters (m).
  Length get meters => Length(toDouble(), LengthUnit.meter);

  /// Creates a [Length] instance representing this numerical value in Kilometers (km).
  Length get kilometers => Length(toDouble(), LengthUnit.kilometer);

  /// Creates a [Length] instance representing this numerical value in Centimeters (cm).
  Length get centimeters => Length(toDouble(), LengthUnit.centimeter);

  /// Creates a [Length] instance representing this numerical value in Millimeters (mm).
  Length get millimeters => Length(toDouble(), LengthUnit.millimeter);

  /// Creates a [Length] instance representing this numerical value in Inches (in).
  Length get inches => Length(toDouble(), LengthUnit.inch);

  /// Creates a [Length] instance representing this numerical value in Feet (ft).
  Length get feet => Length(toDouble(), LengthUnit.foot);

  /// Creates a [Length] instance representing this numerical value in Yards (yd).
  Length get yards => Length(toDouble(), LengthUnit.yard);

  /// Creates a [Length] instance representing this numerical value in Miles (mi).
  Length get miles => Length(toDouble(), LengthUnit.mile);

  /// Creates a [Length] instance representing this numerical value in Nautical Miles (nmi).
  Length get nauticalMiles => Length(toDouble(), LengthUnit.nauticalMile);
}
