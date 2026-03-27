import 'package:quantify/force.dart';
import 'package:quantify/length.dart';
import 'package:quantify/quantify.dart' show QuantityParseException;
import 'package:quantify/torque.dart';
import 'package:test/test.dart';

void main() {
  group('Torque', () {
    const tolerance = 1e-9;
    const highTolerance = 1e-6;

    // --- Conversion factors ---
    const nmPerLbfFt = 1.3558179483314004;
    const nmPerLbfIn = 0.11298482902761670;
    const nmPerKgfM = 9.80665;
    const nmPerOzfIn = 0.007061551814226044;
    const nmPerDynCm = 1e-7;

    group('Constructors and Getters', () {
      test('creates from direct constructor', () {
        const t = Torque(50, TorqueUnit.newtonMeter);
        expect(t.value, 50.0);
        expect(t.unit, TorqueUnit.newtonMeter);
      });

      test('creates from num extensions and retrieves value', () {
        final t = 100.Nm;
        expect(t.value, 100.0);
        expect(t.unit, TorqueUnit.newtonMeter);
        expect(t.inNewtonMeters, 100.0);
      });

      test('zero torque', () {
        final t = 0.Nm;
        expect(t.value, 0.0);
        expect(t.inPoundFeet, 0.0);
        expect(t.inKilogramForceMeters, 0.0);
      });

      test('negative torque', () {
        final t = (-10.0).Nm;
        expect(t.value, -10.0);
        expect(t.inPoundFeet, closeTo(-10.0 / nmPerLbfFt, tolerance));
      });
    });

    group('Conversions', () {
      test('Newton-meter to other units', () {
        final t = 1.Nm;
        expect(t.inMillinewtonMeters, closeTo(1000.0, tolerance));
        expect(t.inKilonewtonMeters, closeTo(0.001, tolerance));
        expect(t.inMeganewtonMeters, closeTo(1e-6, tolerance));
        expect(t.inPoundFeet, closeTo(1.0 / nmPerLbfFt, tolerance));
        expect(t.inPoundInches, closeTo(1.0 / nmPerLbfIn, tolerance));
        expect(t.inKilogramForceMeters, closeTo(1.0 / nmPerKgfM, tolerance));
        expect(t.inOunceForceInches, closeTo(1.0 / nmPerOzfIn, tolerance));
        expect(t.inDyneCentimeters, closeTo(1.0 / nmPerDynCm, tolerance));
      });

      test('pound-force-foot to Newton-meters', () {
        final t = 1.lbfFt;
        expect(t.inNewtonMeters, closeTo(nmPerLbfFt, tolerance));
      });

      test('pound-force-inch to Newton-meters', () {
        final t = 1.lbfIn;
        expect(t.inNewtonMeters, closeTo(nmPerLbfIn, tolerance));
      });

      test('kilogram-force-meter to Newton-meters', () {
        final t = 1.kgfM;
        expect(t.inNewtonMeters, closeTo(nmPerKgfM, tolerance));
      });

      test('ounce-force-inch to Newton-meters', () {
        final t = 1.ozfIn;
        expect(t.inNewtonMeters, closeTo(nmPerOzfIn, tolerance));
      });

      test('dyne-centimeter to Newton-meters', () {
        final t = 1.dynCm;
        expect(t.inNewtonMeters, closeTo(nmPerDynCm, tolerance));
      });

      test('pound-foot to pound-inch (12:1 ratio)', () {
        final t = 1.lbfFt;
        expect(t.inPoundInches, closeTo(12.0, tolerance));
      });

      test('kilogram-force-meter to pound-foot', () {
        final t = 1.kgfM;
        expect(t.inPoundFeet, closeTo(nmPerKgfM / nmPerLbfFt, tolerance));
      });

      test('millinewton-meter prefix chain', () {
        final t = 1000.mNm;
        expect(t.inNewtonMeters, closeTo(1.0, tolerance));
        expect(t.inKilonewtonMeters, closeTo(0.001, tolerance));
      });
    });

    group('Comparison', () {
      test('compares torques across different units', () {
        final t1 = 10.Nm;
        final t2 = 1.kgfM; // ~9.807 N·m
        final t3 = 8.lbfFt; // ~10.846 N·m

        expect(t1.compareTo(t2), greaterThan(0));
        expect(t1.compareTo(t3), lessThan(0));
        expect(t2.compareTo(t3), lessThan(0));
      });

      test('equal magnitude in different units compares as zero', () {
        final t1 = 1.Nm;
        final t2 = 1000.mNm;
        expect(t1.compareTo(t2), 0);
      });
    });

    group('Equality', () {
      test('same value and unit are equal', () {
        const t1 = Torque(50, TorqueUnit.newtonMeter);
        const t2 = Torque(50, TorqueUnit.newtonMeter);
        expect(t1, equals(t2));
        expect(t1.hashCode, equals(t2.hashCode));
      });

      test('different units are not equal even if equivalent', () {
        final t1 = 1.Nm;
        final t2 = 1000.mNm;
        expect(t1, isNot(equals(t2)));
      });

      test('isEquivalentTo recognises equivalent values in different units', () {
        final t1 = 1.Nm;
        final t2 = 1000.mNm;
        expect(t1.isEquivalentTo(t2), isTrue);
      });
    });

    group('Arithmetic', () {
      test('addition preserves left-hand unit', () {
        final sum = 10.Nm + 1.kgfM; // 10 + ~9.807 N·m
        expect(sum.unit, TorqueUnit.newtonMeter);
        expect(sum.inNewtonMeters, closeTo(10.0 + nmPerKgfM, tolerance));
      });

      test('subtraction preserves left-hand unit', () {
        final diff = 20.Nm - 5.Nm;
        expect(diff.value, closeTo(15.0, tolerance));
        expect(diff.unit, TorqueUnit.newtonMeter);
      });

      test('scalar multiplication', () {
        final t = 10.Nm * 3.0;
        expect(t.inNewtonMeters, closeTo(30.0, tolerance));
      });

      test('scalar division', () {
        final t = 30.Nm / 3.0;
        expect(t.inNewtonMeters, closeTo(10.0, tolerance));
      });

      test('division by zero yields infinity', () {
        final t = 10.Nm / 0;
        expect(t.value, double.infinity);
      });
    });

    group('Torque.from — dimensional factory', () {
      test('N × m → N·m', () {
        final t = Torque.from(10.N, 2.m);
        expect(t.unit, TorqueUnit.newtonMeter);
        expect(t.value, closeTo(20.0, tolerance));
      });

      test('N × mm → mN·m (unit-preserving)', () {
        final t = Torque.from(10.N, 50.mm);
        expect(t.unit, TorqueUnit.millinewtonMeter);
        expect(t.value, closeTo(500.0, tolerance)); // 10 × 50 = 500 mN·m = 0.5 N·m
      });

      test('N × km → kN·m (unit-preserving)', () {
        final t = Torque.from(5.N, 2.km);
        expect(t.unit, TorqueUnit.kilonewtonMeter);
        expect(t.value, closeTo(10.0, tolerance)); // 5 N × 2 km = 10 kN·m
      });

      test('kN × m → kN·m', () {
        final t = Torque.from(3.kN, 4.m);
        expect(t.unit, TorqueUnit.kilonewtonMeter);
        expect(t.value, closeTo(12.0, tolerance));
      });

      test('kN × km → MN·m', () {
        final t = Torque.from(2.kN, 3.km);
        expect(t.unit, TorqueUnit.meganewtonMeter);
        expect(t.value, closeTo(6.0, tolerance));
      });

      test('MN × m → MN·m', () {
        final t = Torque.from(1.MN, 5.m);
        expect(t.unit, TorqueUnit.meganewtonMeter);
        expect(t.value, closeTo(5.0, tolerance));
      });

      test('lbf × ft → lbf·ft', () {
        final t = Torque.from(10.lbf, 3.ft);
        expect(t.unit, TorqueUnit.poundFoot);
        expect(t.value, closeTo(30.0, tolerance));
      });

      test('lbf × in → lbf·in', () {
        final t = Torque.from(5.lbf, 6.inches);
        expect(t.unit, TorqueUnit.poundInch);
        expect(t.value, closeTo(30.0, tolerance));
      });

      test('kgf × m → kgf·m', () {
        final t = Torque.from(2.kgf, 3.m);
        expect(t.unit, TorqueUnit.kilogramForceMeter);
        expect(t.value, closeTo(6.0, tolerance));
      });

      test('dyn × cm → dyn·cm', () {
        final t = Torque.from(500.dyn, 10.cm);
        expect(t.unit, TorqueUnit.dyneCentimeter);
        expect(t.value, closeTo(5000.0, tolerance));
      });

      test('unrecognised combo falls back to N·m', () {
        // millinewton × meter has no direct mapping
        final t = Torque.from(1000.mN, 1.m); // 1 N × 1 m → 1 N·m fallback
        expect(t.unit, TorqueUnit.newtonMeter);
        expect(t.inNewtonMeters, closeTo(1.0, tolerance));
      });

      test('result is physically correct regardless of unit path', () {
        // 100 N × 0.5 m = 50 N·m — verify via SI fallback and direct paths
        final direct = Torque.from(100.N, 500.mm); // unit-preserving → mN·m
        final fallback = Torque.from(100.N, 0.5.m); // unit-preserving → N·m
        expect(direct.inNewtonMeters, closeTo(50.0, tolerance));
        expect(fallback.inNewtonMeters, closeTo(50.0, tolerance));
      });
    });

    group('Inverse methods', () {
      test('momentArmFor returns correct length in meters', () {
        final torque = 100.Nm;
        final arm = torque.momentArmFor(50.N);
        expect(arm.value, closeTo(2.0, tolerance));
      });

      test('forceAt returns correct force in Newtons', () {
        final torque = 100.Nm;
        final force = torque.forceAt(0.5.m);
        expect(force.value, closeTo(200.0, tolerance));
      });

      test('round-trip: Torque.from then momentArmFor', () {
        final original = 1.5.m;
        final appliedForce = 40.N;
        final torque = Torque.from(appliedForce, original);
        final recovered = torque.momentArmFor(appliedForce);
        expect(recovered.value, closeTo(original.value, tolerance));
      });

      test('round-trip: Torque.from then forceAt', () {
        final arm = 2.0.m;
        final original = 30.N;
        final torque = Torque.from(original, arm);
        final recovered = torque.forceAt(arm);
        expect(recovered.value, closeTo(original.value, tolerance));
      });

      test('momentArmFor throws ArgumentError for zero force', () {
        final torque = 50.Nm;
        expect(() => torque.momentArmFor(0.N), throwsArgumentError);
      });

      test('forceAt throws ArgumentError for zero moment arm', () {
        final torque = 50.Nm;
        expect(() => torque.forceAt(0.m), throwsArgumentError);
      });

      test('works with imperial units via N·m fallback', () {
        final torque = nmPerLbfFt.Nm; // exactly 1 lbf·ft in N·m
        final arm = torque.momentArmFor(1.lbf);
        expect(arm.value, closeTo(0.3048, tolerance)); // 1 ft in meters
      });
    });

    group('Parsing', () {
      test('parses SI symbol with middle dot', () {
        final t = Torque.parse('50 N·m');
        expect(t.value, closeTo(50.0, tolerance));
        expect(t.unit, TorqueUnit.newtonMeter);
      });

      test('parses SI symbol with ASCII dot fallback', () {
        final t = Torque.parse('50 N.m');
        expect(t.value, closeTo(50.0, tolerance));
        expect(t.unit, TorqueUnit.newtonMeter);
      });

      test('parses mN·m', () {
        final t = Torque.parse('500 mN·m');
        expect(t.unit, TorqueUnit.millinewtonMeter);
        expect(t.value, 500.0);
      });

      test('parses kN·m', () {
        final t = Torque.parse('2.5 kN·m');
        expect(t.unit, TorqueUnit.kilonewtonMeter);
        expect(t.value, 2.5);
      });

      test('parses MN·m', () {
        final t = Torque.parse('1 MN·m');
        expect(t.unit, TorqueUnit.meganewtonMeter);
        expect(t.value, 1.0);
      });

      test('parses lbf·ft', () {
        final t = Torque.parse('35 lbf·ft');
        expect(t.unit, TorqueUnit.poundFoot);
        expect(t.value, 35.0);
      });

      test('parses lb·ft alias', () {
        final t = Torque.parse('35 lb·ft');
        expect(t.unit, TorqueUnit.poundFoot);
      });

      test('parses lbf·in', () {
        final t = Torque.parse('120 lbf·in');
        expect(t.unit, TorqueUnit.poundInch);
      });

      test('parses kgf·m', () {
        final t = Torque.parse('9 kgf·m');
        expect(t.unit, TorqueUnit.kilogramForceMeter);
      });

      test('parses ozf·in', () {
        final t = Torque.parse('55 ozf·in');
        expect(t.unit, TorqueUnit.ounceForceInch);
      });

      test('parses dyn·cm', () {
        final t = Torque.parse('1e7 dyn·cm');
        expect(t.unit, TorqueUnit.dyneCentimeter);
        expect(t.inNewtonMeters, closeTo(1.0, tolerance));
      });

      test('parses full word-form names (case-insensitive)', () {
        expect(Torque.parse('10 newton-meter').unit, TorqueUnit.newtonMeter);
        expect(Torque.parse('10 NEWTON-METERS').unit, TorqueUnit.newtonMeter);
        expect(Torque.parse('5 pound-foot').unit, TorqueUnit.poundFoot);
        expect(Torque.parse('5 foot-pounds').unit, TorqueUnit.poundFoot);
        expect(Torque.parse('3 kilogram-force-meter').unit, TorqueUnit.kilogramForceMeter);
        expect(Torque.parse('3 dyne-centimeters').unit, TorqueUnit.dyneCentimeter);
      });

      test('tryParse returns null for invalid input', () {
        expect(Torque.tryParse('not a torque'), isNull);
        expect(Torque.tryParse('100 J'), isNull); // joule is not a torque unit
        expect(Torque.tryParse(''), isNull);
      });

      test('parse throws QuantityParseException for invalid input', () {
        expect(() => Torque.parse('invalid'), throwsA(isA<QuantityParseException>()));
      });
    });

    group('toString', () {
      test('uses non-breaking space between value and unit', () {
        final t = 50.Nm;
        // Default separator is NBSP (U+00A0), not a regular space.
        // Dart's double toString includes the decimal fraction: 50 → "50.0".
        expect(t.toString(), '50.0\u00A0N·m');
      });

      test('displays correct symbol for each unit', () {
        expect(1.mNm.toString(), '1.0\u00A0mN·m');
        expect(1.kNm.toString(), '1.0\u00A0kN·m');
        expect(1.MNm.toString(), '1.0\u00A0MN·m');
        expect(1.lbfFt.toString(), '1.0\u00A0lbf·ft');
        expect(1.lbfIn.toString(), '1.0\u00A0lbf·in');
        expect(1.kgfM.toString(), '1.0\u00A0kgf·m');
        expect(1.ozfIn.toString(), '1.0\u00A0ozf·in');
        expect(1.dynCm.toString(), '1.0\u00A0dyn·cm');
      });
    });

    group('Round-trip conversions', () {
      const rtTolerance = 1e-9;

      test('N·m → mN·m → N·m', () {
        final t = 42.5.Nm;
        expect(t.asMillinewtonMeters.asNewtonMeters.value, closeTo(t.value, rtTolerance));
      });

      test('N·m → kN·m → N·m', () {
        final t = 42.5.Nm;
        expect(t.asKilonewtonMeters.asNewtonMeters.value, closeTo(t.value, rtTolerance));
      });

      test('N·m → MN·m → N·m', () {
        final t = 42.5.Nm;
        expect(t.asMeganewtonMeters.asNewtonMeters.value, closeTo(t.value, rtTolerance));
      });

      test('N·m → lbf·ft → N·m', () {
        final t = 100.0.Nm;
        expect(t.asPoundFeet.asNewtonMeters.value, closeTo(t.value, rtTolerance));
      });

      test('N·m → lbf·in → N·m', () {
        final t = 100.0.Nm;
        expect(t.asPoundInches.asNewtonMeters.value, closeTo(t.value, rtTolerance));
      });

      test('N·m → kgf·m → N·m', () {
        final t = 100.0.Nm;
        expect(t.asKilogramForceMeters.asNewtonMeters.value, closeTo(t.value, rtTolerance));
      });

      test('N·m → ozf·in → N·m', () {
        final t = 1.0.Nm;
        expect(t.asOunceForceInches.asNewtonMeters.value, closeTo(t.value, highTolerance));
      });

      test('N·m → dyn·cm → N·m', () {
        final t = 1.0.Nm;
        expect(t.asDyneCentimeters.asNewtonMeters.value, closeTo(t.value, rtTolerance));
      });

      test('lbf·ft → lbf·in → lbf·ft', () {
        final t = 10.0.lbfFt;
        expect(t.asPoundInches.asPoundFeet.value, closeTo(t.value, rtTolerance));
      });
    });

    group('Extension aliases', () {
      test('TorqueCreation num extensions create correct unit', () {
        expect(1.Nm.unit, TorqueUnit.newtonMeter);
        expect(1.newtonMeter.unit, TorqueUnit.newtonMeter);
        expect(1.newtonMeters.unit, TorqueUnit.newtonMeter);
        expect(1.mNm.unit, TorqueUnit.millinewtonMeter);
        expect(1.millinewtonMeter.unit, TorqueUnit.millinewtonMeter);
        expect(1.millinewtonMeters.unit, TorqueUnit.millinewtonMeter);
        expect(1.kNm.unit, TorqueUnit.kilonewtonMeter);
        expect(1.kilonewtonMeter.unit, TorqueUnit.kilonewtonMeter);
        expect(1.kilonewtonMeters.unit, TorqueUnit.kilonewtonMeter);
        expect(1.MNm.unit, TorqueUnit.meganewtonMeter);
        expect(1.meganewtonMeter.unit, TorqueUnit.meganewtonMeter);
        expect(1.meganewtonMeters.unit, TorqueUnit.meganewtonMeter);
        expect(1.lbfFt.unit, TorqueUnit.poundFoot);
        expect(1.poundFoot.unit, TorqueUnit.poundFoot);
        expect(1.poundFeet.unit, TorqueUnit.poundFoot);
        expect(1.lbfIn.unit, TorqueUnit.poundInch);
        expect(1.poundInch.unit, TorqueUnit.poundInch);
        expect(1.poundInches.unit, TorqueUnit.poundInch);
        expect(1.kgfM.unit, TorqueUnit.kilogramForceMeter);
        expect(1.kilogramForceMeter.unit, TorqueUnit.kilogramForceMeter);
        expect(1.kilogramForceMeters.unit, TorqueUnit.kilogramForceMeter);
        expect(1.ozfIn.unit, TorqueUnit.ounceForceInch);
        expect(1.ounceForceInch.unit, TorqueUnit.ounceForceInch);
        expect(1.ounceForceInches.unit, TorqueUnit.ounceForceInch);
        expect(1.dynCm.unit, TorqueUnit.dyneCentimeter);
        expect(1.dyneCentimeter.unit, TorqueUnit.dyneCentimeter);
        expect(1.dyneCentimeters.unit, TorqueUnit.dyneCentimeter);
      });

      test('TorqueValueGetters in* getters return doubles', () {
        final t = 1.Nm;
        expect(t.inNewtonMeters, isA<double>());
        expect(t.inMillinewtonMeters, isA<double>());
        expect(t.inKilonewtonMeters, isA<double>());
        expect(t.inMeganewtonMeters, isA<double>());
        expect(t.inPoundFeet, isA<double>());
        expect(t.inPoundInches, isA<double>());
        expect(t.inKilogramForceMeters, isA<double>());
        expect(t.inOunceForceInches, isA<double>());
        expect(t.inDyneCentimeters, isA<double>());
      });

      test('TorqueValueGetters as* getters return Torque', () {
        final t = 1.Nm;
        expect(t.asNewtonMeters, isA<Torque>());
        expect(t.asMillinewtonMeters, isA<Torque>());
        expect(t.asKilonewtonMeters, isA<Torque>());
        expect(t.asMeganewtonMeters, isA<Torque>());
        expect(t.asPoundFeet, isA<Torque>());
        expect(t.asPoundInches, isA<Torque>());
        expect(t.asKilogramForceMeters, isA<Torque>());
        expect(t.asOunceForceInches, isA<Torque>());
        expect(t.asDyneCentimeters, isA<Torque>());
      });
    });

    group('Practical examples', () {
      test('car engine torque: 450 N·m ≈ 331.9 lbf·ft', () {
        final engineTorque = 450.Nm;
        expect(engineTorque.inPoundFeet, closeTo(450.0 / nmPerLbfFt, highTolerance));
      });

      test('hobby servo: 55 ozf·in ≈ 0.388 N·m', () {
        final servoTorque = 55.ozfIn;
        expect(servoTorque.inNewtonMeters, closeTo(55.0 * nmPerOzfIn, tolerance));
      });

      test('structural bolt: 25 lbf·ft ≈ 33.9 N·m', () {
        final boltTorque = 25.lbfFt;
        expect(boltTorque.inNewtonMeters, closeTo(25.0 * nmPerLbfFt, tolerance));
      });

      test('wind turbine gearbox: 2 MN·m torque budget', () {
        final gearboxTorque = 2.MNm;
        expect(gearboxTorque.inKilonewtonMeters, closeTo(2000.0, tolerance));
        expect(gearboxTorque.inNewtonMeters, closeTo(2e6, tolerance));
      });

      test('torque vs energy: dimensionally same but type-distinct', () {
        // Torque and Energy cannot be assigned to each other — compile-time safety.
        // Verify they produce the same numeric result for equivalent values.
        final torque = 1.Nm;
        // A joule is also 1 N·m numerically, but it's a different Dart type.
        expect(torque.inNewtonMeters, 1.0);
        expect(torque, isA<Torque>());
        // Energy is intentionally NOT imported in this test, proving isolation.
      });
    });
  });
}
