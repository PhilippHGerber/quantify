import 'package:quantify/quantify.dart';
import 'package:test/test.dart';

void main() {
  const tolerance = 1e-9; // Tolerance for double comparisons

  group('Temperature', () {
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
          () => TemperatureUnit.celsius.factorTo(TemperatureUnit.fahrenheit),
          throwsUnsupportedError,
        );
        expect(
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
        expect(25.0.celsius.toString(), '25.0 °C');
        expect(0.0.kelvin.toString(), '0.0 K');
        expect(77.fahrenheit.toString(), '77.0 °F');
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

      // Operator - (Temperature) -> TemperatureDelta (difference)
      test('operator - calculates temperature difference as TemperatureDelta', () {
        final diffC = t20C - t10C; // 20°C - 10°C = 10 C°
        expect(diffC, isA<TemperatureDelta>());
        expect(diffC.unit, TemperatureDeltaUnit.celsiusDelta);
        expect(diffC.value, closeTo(10.0, tolerance));

        final diffCFromF = t20C - t50F; // 20°C - 10°C = 10 C°
        expect(diffCFromF.value, closeTo(10.0, tolerance));

        // 50°F - (20°C as °F which is 68°F) = -18 F°
        final temp20CAsFahrenheit = t20C.convertTo(TemperatureUnit.fahrenheit);
        final diffF = t50F - temp20CAsFahrenheit;
        expect(diffF.unit, TemperatureDeltaUnit.fahrenheitDelta);
        expect(
          diffF.value,
          closeTo(-18.0, tolerance),
          reason: '50F - 20C (as F) should be -18 F difference',
        );

        final diffK = t283K - t20C; // 283.15K (10°C) - 20°C (converted to K)
        // 283.15K - (20 + 273.15)K = 283.15K - 293.15K = -10.0
        expect(diffK.unit, TemperatureDeltaUnit.kelvinDelta);
        expect(diffK.value, closeTo(-10.0, tolerance));

        final zeroDiff = t10C - t50F; // 10C - 10C (50F)
        expect(zeroDiff.value, closeTo(0.0, tolerance));
      });

      // ratioTo replaces operator /
      test('ratioTo computes Kelvin-based ratio', () {
        final t200K = 200.0.kelvin;
        final t100K = 100.0.kelvin;
        expect(t200K.ratioTo(t100K), closeTo(2.0, tolerance));

        // Celsius inputs are converted to Kelvin before dividing
        final t10CVal = 10.0.celsius; // 283.15K
        final t20CVal = 20.0.celsius; // 293.15K
        final ratioC = t20CVal.ratioTo(t10CVal);
        expect(ratioC, closeTo(293.15 / 283.15, tolerance));

        expect(
          () => t20C.ratioTo(0.0.kelvin),
          throwsArgumentError,
          reason: 'Should throw on ratio to absolute zero',
        );
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
      test('operator / is not defined for Temperature', () {
        final dynamic tempA = 10.celsius;
        // ignore: avoid_dynamic_calls : Using dynamic to simulate a missing operator
        expect(() => tempA / 2.0, throwsA(anyOf(isA<NoSuchMethodError>(), isA<TypeError>())));
        expect(
          // ignore: avoid_dynamic_calls : Using dynamic to simulate a missing operator
          () => tempA / 10.celsius,
          throwsA(anyOf(isA<NoSuchMethodError>(), isA<TypeError>())),
        );
      });
    });
  });

  group('Rankine Conversions', () {
    test('absolute zero conversions', () {
      final absoluteZeroK = 0.0.kelvin;
      final absoluteZeroR = 0.0.rankine;
      final absoluteZeroC = (-273.15).celsius;
      final absoluteZeroF = (-459.67).fahrenheit;

      // All should represent absolute zero
      expect(absoluteZeroK.inRankine, closeTo(0.0, tolerance));
      expect(absoluteZeroR.inKelvin, closeTo(0.0, tolerance));
      expect(absoluteZeroC.inRankine, closeTo(0.0, tolerance));
      expect(absoluteZeroF.inRankine, closeTo(0.0, tolerance));
    });

    test('freezing point of water conversions', () {
      final freezingC = 0.0.celsius;
      final freezingF = 32.0.fahrenheit;
      final freezingK = 273.15.kelvin;
      final freezingR = 491.67.rankine; // 32°F + 459.67

      expect(freezingC.inRankine, closeTo(491.67, tolerance));
      expect(freezingF.inRankine, closeTo(491.67, tolerance));
      expect(freezingK.inRankine, closeTo(491.67, tolerance));
      expect(freezingR.inCelsius, closeTo(0.0, tolerance));
      expect(freezingR.inFahrenheit, closeTo(32.0, tolerance));
      expect(freezingR.inKelvin, closeTo(273.15, tolerance));
    });

    test('boiling point of water conversions', () {
      final boilingC = 100.0.celsius;
      final boilingF = 212.0.fahrenheit;
      final boilingK = 373.15.kelvin;
      final boilingR = 671.67.rankine; // 212°F + 459.67

      expect(boilingC.inRankine, closeTo(671.67, tolerance));
      expect(boilingF.inRankine, closeTo(671.67, tolerance));
      expect(boilingK.inRankine, closeTo(671.67, tolerance));
      expect(boilingR.inCelsius, closeTo(100.0, tolerance));
      expect(boilingR.inFahrenheit, closeTo(212.0, tolerance));
      expect(boilingR.inKelvin, closeTo(373.15, tolerance));
    });

    test('rankine to other units', () {
      final temp500R = 500.0.rankine;
      const tolerance = 1e-9;

      const expectedF = 500.0 - Temperature.rankineOffsetFromFahrenheit;
      const expectedC =
          (expectedF - Temperature.fahrenheitOffset) / Temperature.fahrenheitScaleFactor;
      const expectedK = 500.0 / Temperature.fahrenheitScaleFactor;

      expect(temp500R.inFahrenheit, closeTo(expectedF, tolerance));
      expect(temp500R.inCelsius, closeTo(expectedC, tolerance));
      expect(temp500R.inKelvin, closeTo(expectedK, tolerance));
    });

    test('engineering temperature examples', () {
      // Gas turbine inlet temperature ≈ 2500°R
      final turbineTemp = 2500.0.rankine;
      const tolerance = 1e-9;

      const expectedF = 2500.0 - Temperature.rankineOffsetFromFahrenheit;
      const expectedC =
          (expectedF - Temperature.fahrenheitOffset) / Temperature.fahrenheitScaleFactor;
      const expectedK = 2500.0 / Temperature.fahrenheitScaleFactor;

      expect(turbineTemp.inFahrenheit, closeTo(expectedF, tolerance));
      expect(turbineTemp.inCelsius, closeTo(expectedC, tolerance));
      expect(turbineTemp.inKelvin, closeTo(expectedK, tolerance));

      // Cryogenic nitrogen ≈ 140°R
      final liquidNitrogen = 140.0.rankine;

      const expectedFahrenheit = 140.0 - Temperature.rankineOffsetFromFahrenheit;
      const expectedCelsius =
          (expectedFahrenheit - Temperature.fahrenheitOffset) / Temperature.fahrenheitScaleFactor;
      const expectedKelvin =
          140.0 / Temperature.fahrenheitScaleFactor; // Direct conversion from Rankine to Kelvin

      expect(liquidNitrogen.inFahrenheit, closeTo(expectedFahrenheit, tolerance));
      expect(liquidNitrogen.inCelsius, closeTo(expectedCelsius, tolerance));
      expect(liquidNitrogen.inKelvin, closeTo(expectedKelvin, tolerance));
    });
  });

  group('Rankine Scale Properties', () {
    test('rankine is absolute scale like kelvin', () {
      // Both Rankine and Kelvin start at absolute zero
      final absoluteZeroR = 0.0.rankine;
      final absoluteZeroK = 0.0.kelvin;

      expect(absoluteZeroR.inKelvin, closeTo(0.0, tolerance));
      expect(absoluteZeroK.inRankine, closeTo(0.0, tolerance));
    });

    test('rankine degree size equals fahrenheit degree size', () {
      // Temperature difference should be the same in °R and °F
      final temp1R = 100.0.rankine;
      final temp2R = 200.0.rankine;
      final diffR = temp2R - temp1R; // 100 degree difference

      final temp1F = temp1R.asFahrenheit;
      final temp2F = temp2R.asFahrenheit;
      final diffF = temp2F - temp1F;

      expect(diffR.value, closeTo(diffF.inRankineDelta, tolerance));
      expect(diffR.value, closeTo(100.0, tolerance));
    });

    test('kelvin to rankine conversion factor', () {
      // 1 K = 9/5 °R (same ratio as C to F degree size)
      final oneKelvin = 1.0.kelvin;
      final zeroKelvin = 0.0.kelvin;

      final oneKelvinInRankine = oneKelvin.inRankine;
      final zeroKelvinInRankine = zeroKelvin.inRankine;

      final conversionFactor = oneKelvinInRankine - zeroKelvinInRankine;
      expect(conversionFactor, closeTo(1.8, tolerance)); // 9/5
    });
  });

  group('Round Trip Conversions with Rankine', () {
    test('all temperature units round trip through rankine', () {
      const testTemps = [0.0, 100.0, 273.15, 373.15, 500.0];

      for (final temp in testTemps) {
        // Celsius round trip
        final celsius = temp.celsius;
        final celsiusRoundTrip = celsius.asRankine.asCelsius;
        expect(celsiusRoundTrip.value, closeTo(temp, tolerance));

        // Kelvin round trip
        final kelvin = temp.kelvin;
        final kelvinRoundTrip = kelvin.asRankine.asKelvin;
        expect(kelvinRoundTrip.value, closeTo(temp, tolerance));

        // Fahrenheit round trip
        final fahrenheit = temp.fahrenheit;
        final fahrenheitRoundTrip = fahrenheit.asRankine.asFahrenheit;
        expect(fahrenheitRoundTrip.value, closeTo(temp, tolerance));

        // Rankine round trip
        final rankine = temp.rankine;
        final rankineRoundTrip = rankine.asKelvin.asRankine;
        expect(rankineRoundTrip.value, closeTo(temp, tolerance));
      }
    });
  });

  group('Temperature Arithmetic with Rankine', () {
    test('temperature difference calculations', () {
      final temp1 = 500.0.rankine;
      final temp2 = 600.0.rankine;

      final difference = temp2 - temp1;
      expect(difference, isA<TemperatureDelta>());
      expect(difference.unit, TemperatureDeltaUnit.rankineDelta);
      expect(difference.value, closeTo(100.0, tolerance));

      // Same difference in other units
      final temp1F = temp1.asFahrenheit;
      final temp2F = temp2.asFahrenheit;
      final differenceF = temp2F - temp1F;
      expect(differenceF.unit, TemperatureDeltaUnit.fahrenheitDelta);
      expect(differenceF.value, closeTo(100.0, tolerance));
    });

    test('temperature ratios on absolute scales via ratioTo', () {
      final temp1 = 200.0.rankine;
      final temp2 = 400.0.rankine;

      final ratio = temp2.ratioTo(temp1);
      expect(ratio, closeTo(2.0, tolerance));

      // Same ratio in Kelvin
      final temp1K = temp1.asKelvin;
      final temp2K = temp2.asKelvin;
      final ratioK = temp2K.ratioTo(temp1K);
      expect(ratioK, closeTo(2.0, tolerance));
    });
  });

  group('Engineering Applications', () {
    test('thermodynamic cycle calculations via ratioTo', () {
      // Simple heat engine with Rankine cycle
      final hotReservoir = 1000.0.rankine; // High temperature
      final coldReservoir = 500.0.rankine; // Low temperature

      // Carnot efficiency = 1 - T_cold/T_hot (absolute temperatures)
      final carnotEfficiency = 1.0 - coldReservoir.ratioTo(hotReservoir);
      expect(carnotEfficiency, closeTo(0.5, tolerance)); // 50% efficiency

      // Same calculation in Kelvin should give same result
      final hotK = hotReservoir.asKelvin;
      final coldK = coldReservoir.asKelvin;
      final carnotEfficiencyK = 1.0 - coldK.ratioTo(hotK);
      expect(carnotEfficiencyK, closeTo(carnotEfficiency, tolerance));
    });

    test('gas law calculations', () {
      // Ideal gas law: PV = nRT (requires absolute temperature)
      final roomTemp = 70.0.fahrenheit; // Room temperature
      final roomTempR = roomTemp.inRankine;
      final roomTempK = roomTemp.inKelvin;

      // Both should be above absolute zero
      expect(roomTempR, greaterThan(0.0));
      expect(roomTempK, greaterThan(0.0));

      // Ratio should be the conversion factor (Rankine/Kelvin = 9/5)
      expect(roomTempR / roomTempK, closeTo(1.8, tolerance));
    });
  });

  group('Comparison and Sorting with Rankine', () {
    test('temperature comparison across all scales', () {
      final freezingC = 0.0.celsius;
      final freezingR = 491.67.rankine;
      final boilingF = 212.0.fahrenheit;
      final roomTempK = 295.0.kelvin; // About 22°C

      // All should be comparable
      expect(freezingC.compareTo(freezingR), 0); // Equal
      expect(roomTempK.compareTo(freezingC), greaterThan(0)); // Room temp > freezing
      expect(boilingF.compareTo(roomTempK), greaterThan(0)); // Boiling > room temp
    });

    test('sorting mixed temperature units', () {
      final temps = [
        100.0.celsius, // Boiling water
        32.0.fahrenheit, // Freezing water
        300.0.kelvin, // Room temperature
        671.67.rankine, // Boiling water in Rankine
        0.0.kelvin, // Absolute zero
      ];

      // ignore: cascade_invocations // Sort by magnitude
      temps.sort();

      // Should be sorted by actual temperature value
      expect(temps[0].unit, TemperatureUnit.kelvin); // Absolute zero
      expect(temps[0].value, 0.0);
      expect(temps[1].unit, TemperatureUnit.fahrenheit); // Freezing
      expect(temps[2].unit, TemperatureUnit.kelvin); // Room temp
      // Last two should be boiling point (equal temperatures)
      expect(temps[3].inCelsius, closeTo(100.0, tolerance));
      expect(temps[4].inCelsius, closeTo(100.0, tolerance));
    });
  });

  group('toString formatting for Rankine', () {
    test('should display correct symbol', () {
      expect(100.0.rankine.toString(), '100.0\u00A0°R');
      expect(459.67.rankine.toString(), '459.67\u00A0°R');
    });

    test('formatting with conversion', () {
      final tempR = 600.0.rankine;
      // Check the Fahrenheit conversion first
      expect(
        tempR.toString(targetUnit: TemperatureUnit.fahrenheit, fractionDigits: 1),
        '140.3\u00A0°F', // Use non-breaking space
      );
      // Now check the Celsius conversion with the correct rounded value
      expect(
        tempR.toString(targetUnit: TemperatureUnit.celsius, fractionDigits: 2),
        '60.18\u00A0°C', // Corrected value and non-breaking space
      );
    });
  });
}
