import 'package:quantify/quantify.dart';
import 'package:test/test.dart';

void main() {
  group('Temperature', () {
    const tolerance = 1e-9; // Tolerance for double comparisons

    group('Constructors and Getters', () {
      test('should create Temperature from num extensions and retrieve values', () {
        final t1 = 25.0.celsius;
        expect(t1.value, 25.0);
        expect(t1.unit, TemperatureUnit.celsius);
        expect(t1.inFahrenheit, closeTo(77.0, tolerance));

        final t2 = 0.0.kelvin;
        expect(t2.value, 0.0);
        expect(t2.unit, TemperatureUnit.kelvin);
        expect(t2.inCelsius, closeTo(-273.15, tolerance));

        final t3 = 32.fahrenheit;
        expect(t3.value, 32.0);
        expect(t3.unit, TemperatureUnit.fahrenheit);
        expect(t3.inCelsius, closeTo(0.0, tolerance));
      });

      test('getValue should return correct value for same unit', () {
        const temp = Temperature(100, TemperatureUnit.celsius);
        expect(temp.getValue(TemperatureUnit.celsius), 100.0);
      });

      test('Unit.factorTo should throw UnsupportedError for TemperatureUnit', () {
        expect(
          // ignore: invalid_use_of_protected_member : protected member access
          () => TemperatureUnit.celsius.factorTo(TemperatureUnit.fahrenheit),
          throwsUnsupportedError,
        );
        expect(
          // ignore: invalid_use_of_protected_member : protected member access
          () => TemperatureUnit.kelvin.factorTo(TemperatureUnit.celsius),
          throwsUnsupportedError,
        );
      });
    });

    group('Conversions', () {
      // Celsius to others
      test('0°C to Fahrenheit and Kelvin', () {
        final tempC = 0.0.celsius;
        expect(tempC.inFahrenheit, closeTo(32.0, tolerance));
        expect(tempC.inKelvin, closeTo(273.15, tolerance));
      });
      test('100°C to Fahrenheit and Kelvin', () {
        final tempC = 100.0.celsius;
        expect(tempC.inFahrenheit, closeTo(212.0, tolerance));
        expect(tempC.inKelvin, closeTo(373.15, tolerance));
      });
      test('-40°C to Fahrenheit and Kelvin', () {
        final tempC = (-40.0).celsius;
        expect(tempC.inFahrenheit, closeTo(-40.0, tolerance));
        expect(tempC.inKelvin, closeTo(233.15, tolerance));
      });

      // Kelvin to others
      test('0K to Celsius and Fahrenheit', () {
        final tempK = 0.0.kelvin;
        expect(tempK.inCelsius, closeTo(-273.15, tolerance));
        // (-273.15 * 1.8) + 32 = -491.67 + 32 = -459.67
        expect(tempK.inFahrenheit, closeTo(-459.67, tolerance));
      });
      test('273.15K to Celsius and Fahrenheit', () {
        final tempK = 273.15.kelvin;
        expect(tempK.inCelsius, closeTo(0.0, tolerance));
        expect(tempK.inFahrenheit, closeTo(32.0, tolerance));
      });

      // Fahrenheit to others
      test('32°F to Celsius and Kelvin', () {
        final tempF = 32.0.fahrenheit;
        expect(tempF.inCelsius, closeTo(0.0, tolerance));
        expect(tempF.inKelvin, closeTo(273.15, tolerance));
      });
      test('212°F to Celsius and Kelvin', () {
        final tempF = 212.0.fahrenheit;
        expect(tempF.inCelsius, closeTo(100.0, tolerance));
        expect(tempF.inKelvin, closeTo(373.15, tolerance));
      });
      test('-40°F to Celsius and Kelvin', () {
        final tempF = (-40.0).fahrenheit;
        expect(tempF.inCelsius, closeTo(-40.0, tolerance));
        expect(tempF.inKelvin, closeTo(233.15, tolerance));
      });
    });

    group('convertTo method', () {
      test('should return new Temperature object with converted value and unit', () {
        final tempC = 20.0.celsius;
        final tempF = tempC.convertTo(TemperatureUnit.fahrenheit);

        expect(tempF.unit, TemperatureUnit.fahrenheit);
        expect(tempF.value, closeTo(68.0, tolerance));
        expect(tempC.unit, TemperatureUnit.celsius); // Original should be unchanged
        expect(tempC.value, 20.0);
      });

      test('convertTo same unit should return same instance (or equal if optimized)', () {
        final t1 = 10.0.kelvin;
        final t2 = t1.convertTo(TemperatureUnit.kelvin);
        expect(identical(t1, t2), isTrue);
      });
    });

    group('Comparison (compareTo)', () {
      final t0c = 0.0.celsius;
      final t32f = 32.0.fahrenheit;
      final t273k = 273.15.kelvin;

      final t10c = 10.0.celsius;
      final t50f = 50.0.fahrenheit; // 10°C

      test('should correctly compare temperatures of different units', () {
        expect(t0c.compareTo(t32f), 0); // 0°C == 32°F
        expect(t0c.compareTo(t273k), 0); // 0°C == 273.15K
        expect(t32f.compareTo(t273k), 0); // 32°F == 273.15K

        expect(t10c.compareTo(t0c), greaterThan(0)); // 10°C > 0°C
        expect(t50f.compareTo(t32f), greaterThan(0)); // 50°F > 32°F (10°C > 0°C)
        expect(t10c.compareTo(t32f), greaterThan(0)); // 10°C > 32°F (0°C)
        expect(t0c.compareTo(t10c), lessThan(0));
      });
    });

    group('Equality and HashCode', () {
      test('should be equal for same value and unit', () {
        const t1 = Temperature(25, TemperatureUnit.celsius);
        const t2 = Temperature(25, TemperatureUnit.celsius);
        expect(t1 == t2, isTrue);
        expect(t1.hashCode == t2.hashCode, isTrue);
      });

      test('should not be equal for different values or units', () {
        const t1 = Temperature(25, TemperatureUnit.celsius);
        const t2 = Temperature(25.1, TemperatureUnit.celsius);
        const t3 = Temperature(25, TemperatureUnit.fahrenheit);
        expect(t1 == t2, isFalse);
        expect(t1 == t3, isFalse);
      });
    });

    group('toString()', () {
      test('should return formatted string', () {
        expect(25.0.celsius.toString(), '25.0 °C');
        expect(0.0.kelvin.toString(), '0.0 K');
        expect(77.fahrenheit.toString(), '77.0 °F');
      });
    });

    group('Round Trip Conversions (via direct methods)', () {
      const initialCelsius = 23.45;
      const initialKelvin = 300.12;
      const initialFahrenheit = 68.78;

      test('Celsius round trips', () {
        final c1 = initialCelsius.celsius;
        expect(
          c1.convertTo(TemperatureUnit.fahrenheit).convertTo(TemperatureUnit.celsius).value,
          closeTo(initialCelsius, tolerance),
        );
        expect(
          c1.convertTo(TemperatureUnit.kelvin).convertTo(TemperatureUnit.celsius).value,
          closeTo(initialCelsius, tolerance),
        );
      });

      test('Kelvin round trips', () {
        final k1 = initialKelvin.kelvin;
        expect(
          k1.convertTo(TemperatureUnit.celsius).convertTo(TemperatureUnit.kelvin).value,
          closeTo(initialKelvin, tolerance),
        );
        expect(
          k1.convertTo(TemperatureUnit.fahrenheit).convertTo(TemperatureUnit.kelvin).value,
          closeTo(initialKelvin, tolerance),
        );
      });

      test('Fahrenheit round trips', () {
        final f1 = initialFahrenheit.fahrenheit;
        expect(
          f1.convertTo(TemperatureUnit.celsius).convertTo(TemperatureUnit.fahrenheit).value,
          closeTo(initialFahrenheit, tolerance),
        );
        expect(
          f1.convertTo(TemperatureUnit.kelvin).convertTo(TemperatureUnit.fahrenheit).value,
          closeTo(initialFahrenheit, tolerance),
        );
      });
    });
  });
}
