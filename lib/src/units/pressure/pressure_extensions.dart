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

  /// Returns the pressure value in Megapascals (MPa).
  double get inMegaPascals => getValue(PressureUnit.megapascal);

  /// Returns the pressure value in Kilopascals (kPa).
  double get inKiloPascals => getValue(PressureUnit.kilopascal);

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

  /// Returns a Pressure representing this pressure in Pascals (Pa).
  Pressure get asPa => convertTo(PressureUnit.pascal);

  /// Returns a Pressure representing this pressure in Atmospheres (atm).
  Pressure get asAtm => convertTo(PressureUnit.atmosphere);

  /// Returns a Pressure representing this pressure in Bars (bar).
  Pressure get asBar => convertTo(PressureUnit.bar);

  /// Returns a Pressure representing this pressure in Pounds per Square Inch (psi).
  Pressure get asPsi => convertTo(PressureUnit.psi);

  /// Returns a Pressure representing this pressure in Torrs (Torr).
  Pressure get asTorr => convertTo(PressureUnit.torr);

  /// Returns a Pressure representing this pressure in Millimeters of Mercury (mmHg).
  Pressure get asMmHg => convertTo(PressureUnit.millimeterOfMercury);

  /// Returns a Pressure representing this pressure in Inches of Mercury (inHg).
  Pressure get asInHg => convertTo(PressureUnit.inchOfMercury);

  /// Returns a Pressure representing this pressure in Megapascals (MPa).
  Pressure get asMegaPascals => convertTo(PressureUnit.megapascal);

  /// Returns a Pressure representing this pressure in Kilopascals (kPa).
  Pressure get asKiloPascals => convertTo(PressureUnit.kilopascal);

  /// Returns a Pressure representing this pressure in Hectopascals (hPa).
  Pressure get asHPa => convertTo(PressureUnit.hectopascal);

  /// Returns a Pressure representing this pressure in Millibars (mbar).
  Pressure get asMbar => convertTo(PressureUnit.millibar);

  /// Returns a Pressure representing this pressure in Centimeters of Water (cmH₂O).
  Pressure get asCmH2O => convertTo(PressureUnit.centimeterOfWater);

  /// Returns a Pressure representing this pressure in Inches of Water (inH₂O).
  Pressure get asInH2O => convertTo(PressureUnit.inchOfWater);
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

  /// Creates a [Pressure] instance representing this numerical value in Megapascals (MPa).
  Pressure get megaPascals => Pressure(toDouble(), PressureUnit.megapascal);

  /// Creates a [Pressure] instance representing this numerical value in Megapascals (MPa).
  /// Alias for `megaPascals`.
  Pressure get mpa => Pressure(toDouble(), PressureUnit.megapascal);

  /// Creates a [Pressure] instance representing this numerical value in Kilopascals (kPa).
  Pressure get kiloPascals => Pressure(toDouble(), PressureUnit.kilopascal);

  /// Creates a [Pressure] instance representing this numerical value in Kilopascals (kPa).
  /// Alias for `kiloPascals`.
  Pressure get kPa => Pressure(toDouble(), PressureUnit.kilopascal);

  /// Creates a [Pressure] instance representing this numerical value in Hectopascals (hPa).
  Pressure get hPa => Pressure(toDouble(), PressureUnit.hectopascal);

  /// Creates a [Pressure] instance representing this numerical value in Millibars (mbar).
  Pressure get mbar => Pressure(toDouble(), PressureUnit.millibar);

  /// Creates a [Pressure] instance representing this numerical value in Centimeters of Water (cmH₂O) at 4°C.
  Pressure get cmH2O => Pressure(toDouble(), PressureUnit.centimeterOfWater);

  /// Creates a [Pressure] instance representing this numerical value in Inches of Water (inH₂O) at 4°C.
  Pressure get inH2O => Pressure(toDouble(), PressureUnit.inchOfWater);
}
