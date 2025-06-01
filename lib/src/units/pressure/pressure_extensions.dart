import 'pressure.dart';
import 'pressure_unit.dart';

/// Provides convenient access to [Pressure] values in specific units.
extension PressureValueGetters on Pressure {
  /// Returns the pressure value in Pascals (Pa).
  double get inPascals => getValue(PressureUnit.pascal);

  /// Returns the pressure value in Atmospheres (atm).
  double get inAtmospheres => getValue(PressureUnit.atmosphere);

  /// Returns the pressure value in Bars (bar).
  double get inBars => getValue(PressureUnit.bar);

  /// Returns the pressure value in Pounds per Square Inch (psi).
  double get inPsi => getValue(PressureUnit.psi);

  /// Returns the pressure value in Torrs (Torr).
  double get inTorrs => getValue(PressureUnit.torr);

  /// Returns the pressure value in Millimeters of Mercury (mmHg).
  double get inMillimetersOfMercury => getValue(PressureUnit.millimeterOfMercury);

  /// Returns the pressure value in Inches of Mercury (inHg).
  double get inInchesOfMercury => getValue(PressureUnit.inchOfMercury);

  /// Returns the pressure value in Kilopascals (kPa).
  double get inKilopascals => getValue(PressureUnit.kilopascal);

  /// Returns the pressure value in Hectopascals (hPa).
  double get inHectopascals => getValue(PressureUnit.hectopascal);

  /// Returns the pressure value in Millibars (mbar).
  double get inMillibars => getValue(PressureUnit.millibar);

  /// Returns the pressure value in Centimeters of Water (cmH₂O) at 4°C.
  double get inCentimetersOfWater => getValue(PressureUnit.centimeterOfWater);

  /// Returns the pressure value in Inches of Water (inH₂O) at 4°C.
  double get inInchesOfWater => getValue(PressureUnit.inchOfWater);
}

/// Provides convenient factory methods for creating [Pressure] instances from [num].
extension PressureCreation on num {
  /// Creates a [Pressure] instance representing this numerical value in Pascals (Pa).
  Pressure get pascals => Pressure(toDouble(), PressureUnit.pascal);

  /// Creates a [Pressure] instance representing this numerical value in Atmospheres (atm).
  Pressure get atmospheres => Pressure(toDouble(), PressureUnit.atmosphere);

  /// Creates a [Pressure] instance representing this numerical value in Bars (bar).
  Pressure get bars => Pressure(toDouble(), PressureUnit.bar);

  /// Creates a [Pressure] instance representing this numerical value in Pounds per Square Inch (psi).
  Pressure get psi => Pressure(toDouble(), PressureUnit.psi);

  /// Creates a [Pressure] instance representing this numerical value in Torrs (Torr).
  Pressure get torrs => Pressure(toDouble(), PressureUnit.torr);

  /// Creates a [Pressure] instance representing this numerical value in Millimeters of Mercury (mmHg).
  Pressure get millimetersOfMercury => Pressure(toDouble(), PressureUnit.millimeterOfMercury);

  /// Creates a [Pressure] instance representing this numerical value in Inches of Mercury (inHg).
  Pressure get inchesOfMercury => Pressure(toDouble(), PressureUnit.inchOfMercury);

  /// Creates a [Pressure] instance representing this numerical value in Kilopascals (kPa).
  Pressure get kilopascals => Pressure(toDouble(), PressureUnit.kilopascal);

  /// Creates a [Pressure] instance representing this numerical value in Hectopascals (hPa).
  Pressure get hectopascals => Pressure(toDouble(), PressureUnit.hectopascal);

  /// Creates a [Pressure] instance representing this numerical value in Millibars (mbar).
  Pressure get millibars => Pressure(toDouble(), PressureUnit.millibar);

  /// Creates a [Pressure] instance representing this numerical value in Centimeters of Water (cmH₂O) at 4°C.
  Pressure get centimetersOfWater => Pressure(toDouble(), PressureUnit.centimeterOfWater);

  /// Creates a [Pressure] instance representing this numerical value in Inches of Water (inH₂O) at 4°C.
  Pressure get inchesOfWater => Pressure(toDouble(), PressureUnit.inchOfWater);
}
