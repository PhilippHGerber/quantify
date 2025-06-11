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
    group('Arithmetic Operators for Temperature', () {
      final t20C = 20.0.celsius;
      final t10C = 10.0.celsius;
      final t50F = 50.0.fahrenheit; // 10 °C
      final t283K = 283.15.kelvin; // 10 °C

      // Operator - (Temperature) -> double (difference)
      test('operator - calculates temperature difference as double', () {
        final diffC = t20C - t10C; // 20°C - 10°C = 10 C°
        expect(diffC, closeTo(10.0, tolerance));

        final diffCFromF = t20C - t50F; // 20°C - 10°C = 10 C°
        expect(diffCFromF, closeTo(10.0, tolerance));

        final diffF = t50F - t20C.convertTo(TemperatureUnit.fahrenheit); // 50°F - 68°F = -18 F°
        expect(diffF, closeTo(-18.0, tolerance));

        final diffK = t283K - t20C; // 283.15K (10°C) - 20°C (converted to K) = -10 K diff
        // 283.15K - (20 + 273.15)K = 283.15K - 293.15K = -10.0
        expect(t283K - t20C, closeTo(-10.0, tolerance));

        final zeroDiff = t10C - t50F; // 10C - 10C (50F)
        expect(zeroDiff, closeTo(0.0, tolerance));
      });

      // Operator / (Temperature) -> double (ratio)
      test('operator / divides temperature by another, returning double ratio', () {
        // Note: Ratios of Celsius or Fahrenheit are generally not physically meaningful.
        // Kelvin should be used for meaningful ratios. Test calculates as per implementation.

        final t200K = 200.0.kelvin;
        final t100K = 100.0.kelvin;
        final ratioK = t200K / t100K;
        expect(ratioK, closeTo(2.0, tolerance));

        final t10CVal = 10.0.celsius; // Not 283.15K
        final t20CVal = 20.0.celsius; // Not 293.15K
        // Ratio based on C values: 20/10 = 2.0. If converted to K first, result would be different.
        // The implementation converts the 'other' to 'this.unit'
        final ratioC = t20CVal / t10CVal;
        expect(ratioC, closeTo(2.0, tolerance));

        // 20 C / 50 F => 20 C / 10 C (as 50F is 10C)
        final ratioCF = t20CVal / 50.0.fahrenheit;
        expect(ratioCF, closeTo(2.0, tolerance));

        expect(
          () => t20C / 0.0.celsius,
          throwsArgumentError,
          reason: 'Should throw on division by zero magnitude if dividend is non-zero',
        );
        expect(0.0.celsius / 0.0.celsius, isNaN, reason: '0.0/0.0 should be NaN');
        expect(0.0.kelvin / 0.0.kelvin, isNaN);

        final tZeroKelvin = 0.0.kelvin;
        final tNonZeroKelvin = 10.0.kelvin;
        expect(() => tNonZeroKelvin / tZeroKelvin, throwsArgumentError);
      });

      test('operator + is not defined for Temperature + Temperature', () {
        // This is a check that the operator isn't inadvertently available.
        // Since Dart doesn't allow removing operators via inheritance easily
        // without an abstract method in the base or a linter rule,
        // we just ensure it's not implemented directly in Temperature.
        // If it were inherited from a base that defined it, this test would need adjustment.
        // For now, it's just a conceptual check.
        final dynamic tempA = 10.celsius;
        final dynamic tempB = 20.celsius;
        // Check if calling the '+' operator results in an error,
        // typically NoSuchMethodError if not defined, or TypeError in some dynamic contexts.
        expect(
          // ignore: avoid_dynamic_calls : Using dynamic to simulate a missing operator
          () => tempA + tempB,
          throwsA(
            anyOf(
              isA<NoSuchMethodError>(),
              isA<TypeError>(),
              // Falls eine Basisklasse es doch implementieren würde und Temperature es blockiert:
              // isA<UnsupportedError>()
            ),
          ),
        );
      });

      test('operator * (scalar) is not defined for Temperature', () {
        final dynamic tempA = 10.celsius;
        // ignore: avoid_dynamic_calls : Using dynamic to simulate a missing operator
        expect(() => tempA * 2.0, throwsA(anyOf(isA<NoSuchMethodError>(), isA<TypeError>())));
      });
      test('operator / (scalar) is not defined for Temperature', () {
        final dynamic tempA = 10.celsius;
        // ignore: avoid_dynamic_calls : Using dynamic to simulate a missing operator
        expect(() => tempA / 2.0, throwsA(anyOf(isA<NoSuchMethodError>(), isA<TypeError>())));
      });
    });
  });
}
