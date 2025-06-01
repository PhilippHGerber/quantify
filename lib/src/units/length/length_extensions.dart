import 'length.dart';
import 'length_unit.dart';

/// Provides convenient access to [Length] values in specific units
/// using shortened unit names where appropriate.
extension LengthValueGetters on Length {
  /// Returns the length value in Meters (m).
  double get inM => getValue(LengthUnit.meter);

  /// Returns the length value in Kilometers (km).
  double get inKm => getValue(LengthUnit.kilometer);

  /// Returns the length value in Centimeters (cm).
  double get inCm => getValue(LengthUnit.centimeter);

  /// Returns the length value in Millimeters (mm).
  double get inMm => getValue(LengthUnit.millimeter);

  /// Returns the length value in Inches (in).
  double get inInch => getValue(LengthUnit.inch);

  /// Returns the length value in Feet (ft).
  double get inFt => getValue(LengthUnit.foot);

  /// Returns the length value in Yards (yd).
  double get inYd => getValue(LengthUnit.yard);

  /// Returns the length value in Miles (mi).
  double get inMi => getValue(LengthUnit.mile);

  /// Returns the length value in Nautical Miles (nmi).
  double get inNmi => getValue(LengthUnit.nauticalMile);

  // Longer aliases for clarity if preferred by some users (can be added or chosen over short forms)
  // double get inM => getValue(LengthUnit.meter);
  // double get inKm => getValue(LengthUnit.kilometer);
  // double get inCentimeters => getValue(LengthUnit.centimeter);
  // double get inMillimeters => getValue(LengthUnit.millimeter);
  // double get inInches => getValue(LengthUnit.inch);
  // double get inFt => getValue(LengthUnit.foot);
  // double get inYd => getValue(LengthUnit.yard);
  // double get inMiles => getValue(LengthUnit.mile);
  // double get inNauticalMiles => getValue(LengthUnit.nauticalMile);
}

/// Provides convenient factory methods for creating [Length] instances from [num]
/// using shortened unit names where appropriate.
extension LengthCreation on num {
  /// Creates a [Length] instance representing this numerical value in Meters (m).
  Length get m => Length(toDouble(), LengthUnit.meter);

  /// Creates a [Length] instance representing this numerical value in Kilometers (km).
  Length get km => Length(toDouble(), LengthUnit.kilometer);

  /// Creates a [Length] instance representing this numerical value in Centimeters (cm).
  Length get cm => Length(toDouble(), LengthUnit.centimeter);

  /// Creates a [Length] instance representing this numerical value in Millimeters (mm).
  Length get mm => Length(toDouble(), LengthUnit.millimeter);

  /// Creates a [Length] instance representing this numerical value in Inches (in).
  Length get inch => Length(toDouble(), LengthUnit.inch);

  /// Creates a [Length] instance representing this numerical value in Feet (ft).
  Length get ft => Length(toDouble(), LengthUnit.foot);

  /// Creates a [Length] instance representing this numerical value in Yards (yd).
  Length get yd => Length(toDouble(), LengthUnit.yard);

  /// Creates a [Length] instance representing this numerical value in Miles (mi).
  Length get mi => Length(toDouble(), LengthUnit.mile);

  /// Creates a [Length] instance representing this numerical value in Nautical Miles (nmi).
  Length get nmi => Length(toDouble(), LengthUnit.nauticalMile);

  // Longer aliases (can be added or chosen over short forms)
  // Length get meters => Length(toDouble(), LengthUnit.meter);
  // Length get kilometers => Length(toDouble(), LengthUnit.kilometer);
  // Length get centimeters => Length(toDouble(), LengthUnit.centimeter);
  // Length get millimeters => Length(toDouble(), LengthUnit.millimeter);
  // Length get inches => Length(toDouble(), LengthUnit.inch);
  // Length get feet => Length(toDouble(), LengthUnit.foot);
  // Length get yards => Length(toDouble(), LengthUnit.yard);
  // Length get miles => Length(toDouble(), LengthUnit.mile);
  // Length get nauticalMiles => Length(toDouble(), LengthUnit.nauticalMile);
}
