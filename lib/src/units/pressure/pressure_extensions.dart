import 'pressure.dart';
import 'pressure_unit.dart';

/// Provides convenient access to [Pressure] values in specific units
/// using shortened unit names where appropriate.
extension PressureValueGetters on Pressure {
  /// Returns the pressure value in Pascals (Pa).
  double get inPa => getValue(PressureUnit.pascal);

  /// Returns the pressure value in Atmospheres (atm).
  double get inAtm => getValue(PressureUnit.atmosphere); // "atm" is already short

  /// Returns the pressure value in Bars (bar).
  double get inBar => getValue(PressureUnit.bar); // "bar" is already short

  /// Returns the pressure value in Pounds per Square Inch (psi).
  double get inPsi => getValue(PressureUnit.psi); // "psi" is already short

  /// Returns the pressure value in Torrs (Torr).
  double get inTorr => getValue(PressureUnit.torr);

  /// Returns the pressure value in Millimeters of Mercury (mmHg).
  double get inMmHg => getValue(PressureUnit.millimeterOfMercury);

  /// Returns the pressure value in Inches of Mercury (inHg).
  double get inInHg => getValue(PressureUnit.inchOfMercury);

  /// Returns the pressure value in Kilopascals (kPa).
  double get inKPa => getValue(PressureUnit.kilopascal);

  /// Returns the pressure value in Hectopascals (hPa).
  double get inHPa => getValue(PressureUnit.hectopascal);

  /// Returns the pressure value in Millibars (mbar).
  double get inMbar => getValue(PressureUnit.millibar);

  /// Returns the pressure value in Centimeters of Water (cmH₂O) at 4°C.
  double get inCmH2O => getValue(PressureUnit.centimeterOfWater); 

  /// Returns the pressure value in Inches of Water (inH₂O) at 4°C.
  double get inInH2O => getValue(PressureUnit.inchOfWater);

  // Longer aliases (optional)
  // double get inPascals => getValue(PressureUnit.pascal);
  // double get inAtmospheres => getValue(PressureUnit.atmosphere);
  // double get inBars => getValue(PressureUnit.bar);
  // double get inPoundsPerSquareInch => getValue(PressureUnit.psi); // psi is already standard
  // double get inTorrs => getValue(PressureUnit.torr);
  // double get inMillimetersOfMercury => getValue(PressureUnit.millimeterOfMercury);
  // double get inInchesOfMercury => getValue(PressureUnit.inchOfMercury);
  // double get inKilopascals => getValue(PressureUnit.kilopascal);
  // double get inHectopascals => getValue(PressureUnit.hectopascal);
  // double get inMillibars => getValue(PressureUnit.millibar);
  // double get inCentimetersOfWater => getValue(PressureUnit.centimeterOfWater);
  // double get inInchesOfWater => getValue(PressureUnit.inchOfWater);
}

/// Provides convenient factory methods for creating [Pressure] instances from [num]
/// using shortened unit names where appropriate.
extension PressureCreation on num {
  /// Creates a [Pressure] instance representing this numerical value in Pascals (Pa).
  Pressure get pa => Pressure(toDouble(), PressureUnit.pascal);

  /// Creates a [Pressure] instance representing this numerical value in Atmospheres (atm).
  Pressure get atm => Pressure(toDouble(), PressureUnit.atmosphere);

  /// Creates a [Pressure] instance representing this numerical value in Bars (bar).
  Pressure get bar => Pressure(toDouble(), PressureUnit.bar);

  /// Creates a [Pressure] instance representing this numerical value in Pounds per Square Inch (psi).
  Pressure get psi => Pressure(toDouble(), PressureUnit.psi);

  /// Creates a [Pressure] instance representing this numerical value in Torrs (Torr).
  Pressure get torr => Pressure(toDouble(), PressureUnit.torr);

  /// Creates a [Pressure] instance representing this numerical value in Millimeters of Mercury (mmHg).
  Pressure get mmHg => Pressure(toDouble(), PressureUnit.millimeterOfMercury);

  /// Creates a [Pressure] instance representing this numerical value in Inches of Mercury (inHg).
  Pressure get inHg => Pressure(toDouble(), PressureUnit.inchOfMercury);

  /// Creates a [Pressure] instance representing this numerical value in Kilopascals (kPa).
  Pressure get kPa => Pressure(toDouble(), PressureUnit.kilopascal);

  /// Creates a [Pressure] instance representing this numerical value in Hectopascals (hPa).
  Pressure get hPa => Pressure(toDouble(), PressureUnit.hectopascal);

  /// Creates a [Pressure] instance representing this numerical value in Millibars (mbar).
  Pressure get mbar => Pressure(toDouble(), PressureUnit.millibar);

  /// Creates a [Pressure] instance representing this numerical value in Centimeters of Water (cmH₂O) at 4°C.
  Pressure get cmH2O => Pressure(toDouble(), PressureUnit.centimeterOfWater);

  /// Creates a [Pressure] instance representing this numerical value in Inches of Water (inH₂O) at 4°C.
  Pressure get inH2O => Pressure(toDouble(), PressureUnit.inchOfWater);

  // Longer aliases (optional)
  // Pressure get pascals => Pressure(toDouble(), PressureUnit.pascal);
  // Pressure get atmospheres => Pressure(toDouble(), PressureUnit.atmosphere);
  // Pressure get bars => Pressure(toDouble(), PressureUnit.bar);
  // Pressure get poundsPerSquareInch => Pressure(toDouble(), PressureUnit.psi);
  // Pressure get torrs => Pressure(toDouble(), PressureUnit.torr);
  // Pressure get millimetersOfMercury => Pressure(toDouble(), PressureUnit.millimeterOfMercury);
  // Pressure get inchesOfMercury => Pressure(toDouble(), PressureUnit.inchOfMercury);
  // Pressure get kilopascals => Pressure(toDouble(), PressureUnit.kilopascal);
  // Pressure get hectopascals => Pressure(toDouble(), PressureUnit.hectopascal);
  // Pressure get millibars => Pressure(toDouble(), PressureUnit.millibar);
  // Pressure get centimetersOfWater => Pressure(toDouble(), PressureUnit.centimeterOfWater);
  // Pressure get inchesOfWater => Pressure(toDouble(), PressureUnit.inchOfWater);
}
