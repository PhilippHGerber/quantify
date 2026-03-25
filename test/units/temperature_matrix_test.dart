import 'package:quantify/quantify.dart';
import 'package:test/test.dart';

void main() {
  group('Temperature Conversion Matrix (Affine)', () {
    const tolerance = 1e-9;

    test('All 16 temperature conversion paths', () {
      const units = TemperatureUnit.values;
      final testValues = [0.0, 100.0, -40.0, 273.15, 32.0];

      for (final unitA in units) {
        for (final unitB in units) {
          for (final value in testValues) {
            final t1 = Temperature(value, unitA);
            final t2 = t1.convertTo(unitB);
            final t3 = t2.convertTo(unitA);

            // Round-trip check
            expect(
              t3.value,
              closeTo(value, tolerance),
              reason:
                  'Round-trip failed: $value ${unitA.symbol} -> ${unitB.symbol} -> ${unitA.symbol}',
            );

            // Symmetry check: (A -> B) matches (A -> K -> B)
            final tK = t1.convertTo(TemperatureUnit.kelvin);
            final tBK = tK.convertTo(unitB);

            expect(
              t2.value,
              closeTo(tBK.value, tolerance),
              reason:
                  'Inconsistent conversion: $value ${unitA.symbol} -> ${unitB.symbol} direct vs via Kelvin',
            );
          }
        }
      }
    });

    test('Key calibration points', () {
      // Freezing point of water
      expect(
        const Temperature(0, TemperatureUnit.celsius).getValue(TemperatureUnit.kelvin),
        closeTo(273.15, tolerance),
      );
      expect(
        const Temperature(0, TemperatureUnit.celsius).getValue(TemperatureUnit.fahrenheit),
        closeTo(32.0, tolerance),
      );

      // Boiling point of water
      expect(
        const Temperature(100, TemperatureUnit.celsius).getValue(TemperatureUnit.fahrenheit),
        closeTo(212.0, tolerance),
      );

      // Absolute zero
      expect(
        const Temperature(0, TemperatureUnit.kelvin).getValue(TemperatureUnit.celsius),
        closeTo(-273.15, tolerance),
      );
      expect(
        const Temperature(0, TemperatureUnit.kelvin).getValue(TemperatureUnit.rankine),
        closeTo(0.0, tolerance),
      );

      // -40 intersection
      expect(
        const Temperature(-40, TemperatureUnit.celsius).getValue(TemperatureUnit.fahrenheit),
        closeTo(-40.0, tolerance),
      );
    });
  });
}
