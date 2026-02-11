// test/units/power_test.dart

import 'package:quantify/power.dart';
import 'package:test/test.dart';

void main() {
  group('Power', () {
    const strictTolerance = 1e-12;
    const defaultTolerance = 1e-9;

    // Helper for round trip tests
    void testRoundTrip(
      PowerUnit initialUnit,
      PowerUnit intermediateUnit,
      double initialValue, {
      double tol = defaultTolerance,
    }) {
      final p1 = Power(initialValue, initialUnit);
      final p2 = p1.convertTo(intermediateUnit);
      final p3 = p2.convertTo(initialUnit);
      expect(
        p3.value,
        closeTo(initialValue, tol),
        reason:
            '${initialUnit.symbol} -> ${intermediateUnit.symbol} -> ${initialUnit.symbol} failed for $initialValue',
      );
    }

    group('Constructors and Getters', () {
      test('should create Power from num extensions and retrieve values', () {
        final p1 = 150.0.kW;
        expect(p1.value, 150.0);
        expect(p1.unit, PowerUnit.kilowatt);
        expect(p1.inWatts, closeTo(150000.0, strictTolerance));
        expect(p1.inMegawatts, closeTo(0.15, strictTolerance));
      });

      test('should create from all new units', () {
        final pMw = 500.mW;
        expect(pMw.inWatts, closeTo(0.5, strictTolerance));

        final pGw = 1.2.gigaW;
        expect(pGw.inMegawatts, closeTo(1200.0, strictTolerance));

        final pMetricHp = 100.0.metricHp;
        expect(pMetricHp.inWatts, closeTo(73549.875, defaultTolerance));

        final pBtu = 1000.0.btuPerHour;
        expect(pBtu.inWatts, closeTo(293.071, 1e-3));

        final pErg = 1e7.ergPerSecond; // Should be 1 Watt
        expect(pErg.inWatts, closeTo(1.0, defaultTolerance));
      });
    });

    group('Conversions', () {
      test('Horsepower (hp) vs Metric Horsepower (PS)', () {
        final mechHp = 1.0.hp;
        final metricHp = 1.0.metricHp;

        // Mechanical hp should be slightly more powerful than metric hp
        expect(mechHp.compareTo(metricHp), greaterThan(0));
        expect(mechHp.inWatts, closeTo(745.7, 1e-1));
        expect(metricHp.inWatts, closeTo(735.5, 1e-1));
      });

      test('Kilowatt to Horsepower and BTU/h', () {
        final oneKw = 1.0.kW;
        expect(oneKw.inHorsepower, closeTo(1.341, 1e-3));
        expect(oneKw.inMetricHorsepower, closeTo(1.360, 1e-3));
        expect(oneKw.inBtuPerHour, closeTo(3412.14, 1e-2));
      });
    });

    group('Comparison', () {
      test('should correctly compare different units', () {
        final p1 = 100.kW;
        final p2 = 0.1.megaW;
        final p3 = 134.hp; // approx 99.9 kW

        expect(p1.compareTo(p2), 0);
        expect(p1.compareTo(p3), greaterThan(0));
        expect(p3.compareTo(p1), lessThan(0));
      });
    });

    group('Arithmetic', () {
      test('should perform addition and subtraction correctly', () {
        final sum = 1.kW + 500.W; // 1000 W + 500 W = 1500 W
        expect(sum.inKilowatts, closeTo(1.5, defaultTolerance));
        expect(sum.unit, PowerUnit.kilowatt);
      });

      test('should perform scalar multiplication and division', () {
        final power = 20.hp;
        expect((power * 3.0).inHorsepower, closeTo(60.0, defaultTolerance));
        expect((power / 2.0).inHorsepower, closeTo(10.0, defaultTolerance));
        expect(() => power / 0, throwsArgumentError);
      });
    });

    group('Round Trip Conversions', () {
      for (final unit in PowerUnit.values) {
        test('Round trip ${unit.symbol} <-> W', () {
          testRoundTrip(unit, PowerUnit.watt, 123.456);
        });
      }
    });

    group('Practical Examples', () {
      test('Car Engine Power', () {
        // A car engine is rated at 250 PS.
        final enginePower = 250.0.metricHp;
        // Check its equivalent in mechanical horsepower and kilowatts.
        expect(enginePower.inHorsepower, closeTo(246.6, 1e-1));
        expect(enginePower.inKilowatts, closeTo(183.9, 1e-1));
      });

      test('HVAC System', () {
        // A home AC unit has a cooling capacity of 12,000 Btu/h.
        final acPower = 12000.0.btuPerHour;
        // Check its power consumption in kilowatts.
        expect(acPower.inKilowatts, closeTo(3.516, 1e-3));
      });
    });

    group('Comprehensive Extension Coverage', () {
      test('all creation extension aliases', () {
        expect(50.W.unit, PowerUnit.watt);
        expect(50.watts.unit, PowerUnit.watt);
        expect(100.kilowatts.unit, PowerUnit.kilowatt);
        expect(5.megaW.unit, PowerUnit.megawatt);
        expect(5.megawatts.unit, PowerUnit.megawatt);
        expect(1.gigaW.unit, PowerUnit.gigawatt);
        expect(1.gigawatts.unit, PowerUnit.gigawatt);
        expect(500.milliwatts.unit, PowerUnit.milliwatt);
        expect(500.milliwatts.inWatts, closeTo(0.5, defaultTolerance));
      });

      test('all as* conversion getters', () {
        final p = 1000.W;

        final asW = p.asWatts;
        expect(asW.unit, PowerUnit.watt);
        expect(asW.value, closeTo(1000.0, defaultTolerance));

        final asMw = p.asMilliwatts;
        expect(asMw.unit, PowerUnit.milliwatt);
        expect(asMw.value, closeTo(1e6, defaultTolerance));

        final asKw = p.asKilowatts;
        expect(asKw.unit, PowerUnit.kilowatt);
        expect(asKw.value, closeTo(1.0, defaultTolerance));

        final asMegaW = p.asMegawatts;
        expect(asMegaW.unit, PowerUnit.megawatt);
        expect(asMegaW.value, closeTo(0.001, defaultTolerance));

        final asGw = p.asGigawatts;
        expect(asGw.unit, PowerUnit.gigawatt);
        expect(asGw.value, closeTo(1e-6, defaultTolerance));

        final asHp = p.asHorsepower;
        expect(asHp.unit, PowerUnit.horsepower);
        expect(asHp.value, closeTo(1.341, 1e-3));

        final asMetricHp = p.asMetricHorsepower;
        expect(asMetricHp.unit, PowerUnit.metricHorsepower);
        expect(asMetricHp.value, closeTo(1.360, 1e-3));

        final asBtu = p.asBtuPerHour;
        expect(asBtu.unit, PowerUnit.btuPerHour);
        expect(asBtu.value, closeTo(3412.14, 1e-2));

        final asErg = p.asErgPerSecond;
        expect(asErg.unit, PowerUnit.ergPerSecond);
        expect(asErg.value, closeTo(1e10, defaultTolerance));
      });
    });
  });
}
