import 'package:intl/intl.dart';
import 'package:quantify/quantify.dart';

void main() {
  print('--- Quantify CLI Example ---');

  // 1. Create and convert lengths
  print('\n--- Length ---');
  final pathA = 1500.m;
  final pathB = 2.5.km;

  print('Path A: $pathA'); // Default toString
  print('Path A in Kilometers: ${pathA.inKm} km');
  print(
    'Path A (formatted): ${pathA.toString(targetUnit: LengthUnit.kilometer)}',
  );
  print(
    'Path B in Miles: ${pathB.toString(targetUnit: LengthUnit.mile)}',
  );

  // 2. Arithmetic with lengths
  final totalDistance = pathA + pathB; // pathB is automatically converted to meters
  print(
    'Total Distance: ${totalDistance.toString(format: const QuantityFormat(fractionDigits: 0))}',
  );
  print(
    'Total Distance in Yards: ${totalDistance.toString(targetUnit: LengthUnit.yard)}',
  );

  final scaledDistance = pathA * 3;
  print('Path A scaled by 3: $scaledDistance');

  // 3. Times
  print('\n--- Time ---');
  final duration1 = 90.minutes;
  final duration2 = 0.5.hours;

  print('Duration 1: $duration1');
  print('Duration 1 in Hours: ${duration1.inHours} h');
  print('Duration 2: ${duration2.toString(targetUnit: TimeUnit.minute)}');

  final totalTime = duration1 + duration2; // 90 min + 30 min = 120 min
  print('Total Time: ${totalTime.toString(targetUnit: TimeUnit.hour)}'); // "2.0 h"

  // 4. Temperatures
  print('\n--- Temperature ---');
  final roomTempC = 20.celsius;
  print('Room Temperature: $roomTempC');
  print('Room Temperature in Fahrenheit: ${roomTempC.inFahrenheit} °F');
  print(
    'Room Temperature in Kelvin: ${roomTempC.convertTo(TemperatureUnit.kelvin)}',
  );

  final boilingPoint = 100.celsius;
  final freezingPoint = 0.celsius;
  final tempDifference = boilingPoint - freezingPoint; // Returns a TemperatureDelta
  print('Difference between boiling and freezing point of water: $tempDifference');

  // Temperature ratios via ratioTo (always in Kelvin for physical meaning)
  final tempRatio = 200.kelvin.ratioTo(100.kelvin);
  print('Ratio 200K / 100K: $tempRatio');

  // 5. Pressures
  print('\n--- Pressure ---');
  final pAtm = 1.atm; // Standard atmosphere
  print('Standard Atmosphere: $pAtm');
  print('Standard Atmosphere in Pascals: ${pAtm.inPa} Pa');
  print(
    'Standard Atmosphere in PSI: ${pAtm.asPsi}',
  );
  print(
    'Standard Atmosphere in bar: ${pAtm.toString(targetUnit: PressureUnit.bar)}',
  );

  final tirePressure = 32.psi;
  print(
    'Tire Pressure: ${tirePressure.toString(targetUnit: PressureUnit.bar)}',
  );

  // 6. Comparisons
  print('\n--- Comparisons ---');
  final oneKm = 1.km;
  final oneMile = 1.mi;
  final thousandMeters = 1000.m; // Using .m

  print(
    '1 km == 1000 m (value & unit): ${oneKm == thousandMeters}',
  ); // false (same value, but km vs m unit)
  print('1 km.compareTo(1000 m): ${oneKm.compareTo(thousandMeters)}'); // 0 (same magnitude)
  print('1 km > 1 mile: ${oneKm.compareTo(oneMile) > 0}'); // false
  // print('1 mile > 1 km: ${oneMile > oneKm}'); // true (syntactic sugar for compareTo)

  final lengths = [10.m, 500.cm, 0.002.km, 1.ft];
  print(
    'Unsorted lengths: ${lengths.map((l) => l.toString(targetUnit: LengthUnit.meter)).toList()}',
  );
  lengths.sort();
  print('Sorted lengths: ${lengths.map((l) => l.toString(targetUnit: LengthUnit.meter)).toList()}');

  // 7. Locale-specific Formatting (requires 'intl' package)
  print('\n--- Locale-specific Formatting ---');
  final distanceDE = 1234.567.m; // Using .m
  // Standard (US-like locale from Dart, usually '.')
  print(
    'Distance DE (default locale): ${distanceDE.toString(targetUnit: LengthUnit.kilometer)}',
  );

  // German (de_DE)
  // To use NumberFormat for a specific locale, it needs to be initialized.
  // Usually, this is done globally with `Intl.defaultLocale = 'de_DE';`
  // or it's passed directly to `NumberFormat`.
  // quantify's toString() uses NumberFormat.decimalPatternDigits if locale and fractionDigits are given.
  print(
    'Distance DE (de_DE locale): ${distanceDE.toString(targetUnit: LengthUnit.kilometer)}',
  );
  // Output: "1,23 km" (with comma as decimal separator)

  // With a custom NumberFormat for decimal pattern
  final valueOnlyFormat = NumberFormat.decimalPatternDigits(locale: 'fr_FR', decimalDigits: 3);
  print(
    'Distance (fr_FR locale, custom NumberFormat, value only): ${distanceDE.toString(targetUnit: LengthUnit.kilometer, format: QuantityFormat.withNumberFormat(valueOnlyFormat, showUnitSymbol: false))}',
  );
  // Output: "1,235" (with comma as decimal separator and 3 decimal places)

  print('\n--- End of Example ---');
}
