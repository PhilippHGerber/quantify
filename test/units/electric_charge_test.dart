// test/units/electric_charge_test.dart
import 'package:quantify/quantify.dart';
import 'package:test/test.dart';

void main() {
  group('ElectricCharge', () {
    const tolerance = 1e-12;
    const highTolerance = 1e-9; // For very large scale differences
    const atomicTolerance = 1e-24; // For elementary charge conversions

    // Helper for round trip tests
    void testRoundTrip(
      ElectricChargeUnit initialUnit,
      ElectricChargeUnit intermediateUnit,
      double initialValue, {
      double tol = highTolerance,
    }) {
      final q1 = ElectricCharge(initialValue, initialUnit);
      final q2 = q1.convertTo(intermediateUnit);
      final q3 = q2.convertTo(initialUnit);
      expect(
        q3.value,
        closeTo(initialValue, tol),
        reason:
            '${initialUnit.symbol} -> ${intermediateUnit.symbol} -> ${initialUnit.symbol} failed for $initialValue',
      );
    }

    group('Constructors and Getters', () {
      test('should create from num extensions and retrieve values', () {
        final charge = 1.5.coulombs;
        expect(charge.value, 1.5);
        expect(charge.unit, ElectricChargeUnit.coulomb);
        expect(charge.inMillicoulombs, closeTo(1500.0, tolerance));

        final battery = 5.0.ah; // 5 Ampere-hours
        expect(battery.value, 5.0);
        expect(battery.unit, ElectricChargeUnit.ampereHour);
        expect(battery.inCoulombs, closeTo(5.0 * 3600.0, tolerance));
      });
    });

    group('Conversions', () {
      test('Coulomb to other units', () {
        final oneCoulomb = 1.0.C;
        expect(oneCoulomb.inAmpereHours, closeTo(1.0 / 3600.0, tolerance));
        expect(oneCoulomb.inMillicoulombs, closeTo(1000.0, tolerance));
        expect(
          oneCoulomb.inElementaryCharges,
          closeTo(1.0 / 1.602176634e-19, highTolerance),
        );
      });

      test('Ampere-hour to Coulombs', () {
        final phoneBattery = 4.5.ah; // 4500 mAh
        expect(phoneBattery.inCoulombs, closeTo(4.5 * 3600, tolerance));
      });

      test('Elementary Charge to Coulombs', () {
        // One mole of electrons (Faraday constant)
        final oneMoleElectrons = 6.02214076e23.e;
        const faradayConstant = 96485.33212; // C/mol
        expect(oneMoleElectrons.inCoulombs, closeTo(faradayConstant, 1e-4));
      });

      test('mAh and CGS units conversions', () {
        // 1 Ah = 1000 mAh
        final oneAh = 1.0.ah;
        expect(oneAh.inMilliampereHours, closeTo(1000.0, 1e-12));

        // 1 abcoulomb = 10 coulombs
        final oneAbc = 1.0.abC;
        expect(oneAbc.inCoulombs, closeTo(10.0, 1e-12));

        // 1 coulomb to statcoulombs
        final oneCoulomb = 1.0.C;
        const expectedStatC = 1.0 / 3.3356409519815204e-10;
        expect(oneCoulomb.inStatcoulombs, closeTo(expectedStatC, 1e-3));
      });
    });

    group('Comparison', () {
      test('should correctly compare different units', () {
        final q1 = 1.ah; // 3600 C
        final q2 = 3500.C;
        final q3 = 3700.C;

        expect(q1.compareTo(q2), greaterThan(0));
        expect(q1.compareTo(q3), lessThan(0));
        expect(q1.compareTo(3600.C), 0);
      });
    });

    group('Arithmetic', () {
      test('should perform addition and subtraction', () {
        final sum = 1.ah + 400.C; // 3600 C + 400 C = 4000 C
        expect(sum.inCoulombs, closeTo(4000.0, tolerance));
        expect(sum.unit, ElectricChargeUnit.ampereHour); // Left operand's unit
      });

      test('should perform scalar multiplication and division', () {
        final charge = 2.5.ah;
        expect((charge * 2.0).inAmpereHours, closeTo(5.0, tolerance));
        expect((charge / 5.0).inAmpereHours, closeTo(0.5, tolerance));
        expect(() => charge / 0, throwsArgumentError);
      });
    });

    group('Dimensional Analysis (Current/Time Interop)', () {
      test('ElectricCharge.from(Current, Time) creates correct charge', () {
        final charge = ElectricCharge.from(2.A, 1.h);
        expect(charge.inAmpereHours, closeTo(2.0, tolerance));
        expect(charge.inCoulombs, closeTo(7200.0, tolerance));

        final smallCharge = ElectricCharge.from(10.mA, 5.s); // 10e-3 A * 5 s = 0.05 C
        expect(smallCharge.inCoulombs, closeTo(0.05, tolerance));
        expect(smallCharge.inMillicoulombs, closeTo(50.0, tolerance));
      });

      test('charge.currentOver(Time) calculates correct current', () {
        final battery = 5.ah;
        // Discharge over 10 hours -> 0.5 A
        final current = battery.currentOver(10.h);
        expect(current.inAmperes, closeTo(0.5, tolerance));

        // Discharge over 1 minute
        final fastDischarge = 360.C.currentOver(1.min); // 360 C / 60 s = 6 A
        expect(fastDischarge.inAmperes, closeTo(6.0, tolerance));

        expect(() => 1.C.currentOver(0.s), throwsArgumentError);
      });

      test('charge.timeFor(Current) calculates correct time', () {
        final battery = 4.5.ah;
        // Time to discharge at 500 mA (0.5 A) -> 9 hours
        final time = battery.timeFor(500.mA);
        expect(time.inHours, closeTo(9.0, tolerance));

        // Time to transfer 1 Coulomb at 1 Ampere -> 1 second
        final time2 = 1.C.timeFor(1.A);
        expect(time2.inSeconds, closeTo(1.0, tolerance));

        expect(() => 1.C.timeFor(0.A), throwsArgumentError);
      });
    });

    group('Round Trip Conversions', () {
      for (final unit in ElectricChargeUnit.values) {
        test('Round trip ${unit.symbol} <-> C', () {
          testRoundTrip(
            unit,
            ElectricChargeUnit.coulomb,
            123.456,
            tol: unit == ElectricChargeUnit.elementaryCharge ? atomicTolerance : highTolerance,
          );
        });
      }
    });

    group('Practical Examples', () {
      test('Battery Capacity', () {
        // A typical phone battery has a capacity of 4500 mAh.
        // This is equivalent to 4.5 Ah.
        final phoneBattery = 4.5.ah;

        // Verify its value in Coulombs
        expect(phoneBattery.inCoulombs, closeTo(16200, tolerance));

        // How long can it power a device drawing 150 mA?
        // t = Q / I = 4.5 Ah / 0.15 A = 30 h
        final deviceCurrent = 150.mA;
        final runtime = phoneBattery.timeFor(deviceCurrent);
        expect(runtime.inHours, closeTo(30.0, tolerance));
      });

      test('Number of Electrons', () {
        // How many electrons in -1 Coulomb of charge?
        final oneCoulomb = (-1.0).C;
        expect(
          oneCoulomb.inElementaryCharges,
          closeTo(-1.0 / 1.602176634e-19, highTolerance),
        );
        expect(
          oneCoulomb.inElementaryCharges,
          closeTo(-6.241509e18, 1e13),
        );
      });
    });
  });
}
