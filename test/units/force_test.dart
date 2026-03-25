import 'package:quantify/acceleration.dart';
import 'package:quantify/area.dart';
import 'package:quantify/force.dart';
import 'package:quantify/mass.dart';
import 'package:quantify/pressure.dart';
import 'package:test/test.dart';

void main() {
  group('Force', () {
    const tolerance = 1e-12;
    const highTolerance = 1e-9;

    group('Constructors and Getters', () {
      test('should create from num extensions and retrieve values', () {
        final force = 100.N;
        expect(force.value, 100.0);
        expect(force.unit, ForceUnit.newton);
        expect(force.inKilonewtons, closeTo(0.1, tolerance));
      });
    });

    group('Conversions', () {
      test('Newton to other units', () {
        final force = 10.N;
        expect(force.inDynes, closeTo(1e6, highTolerance));
        expect(force.inPoundsForce, closeTo(2.24809, 1e-5));
        expect(force.inKilogramsForce, closeTo(1.01972, 1e-5));
      });

      test('Pound-force to Newtons', () {
        final force = 1.lbf;
        expect(force.inNewtons, closeTo(4.4482216152605, tolerance));
      });

      test('Kilogram-force to Newtons', () {
        final force = 1.kgf;
        expect(force.inNewtons, closeTo(9.80665, tolerance));
      });

      test('Gram-force and Poundal conversions', () {
        // 1 kgf should be 1000 gf
        final oneKgf = 1.kgf;
        expect(oneKgf.inGramsForce, closeTo(1000.0, 1e-12));

        // 1 lbf should be ~32.174 pdl (g_std in ft/s^2)
        final oneLbf = 1.lbf;
        expect(oneLbf.inPoundals, closeTo(32.174048556, 1e-8));

        // Test the base definition of poundal
        final onePdl = 1.pdl;
        expect(onePdl.inNewtons, closeTo(0.138254954376, 1e-12));
      });
    });

    group('Comparison', () {
      test('should correctly compare different units', () {
        final f1 = 10.N;
        final f2 = 1.kgf; // ~9.8 N
        final f3 = 3.lbf; // ~13.3 N

        expect(f1.compareTo(f2), greaterThan(0));
        expect(f1.compareTo(f3), lessThan(0));
        expect(f2.compareTo(f3), lessThan(0));
      });
    });

    group('Arithmetic', () {
      test('should perform addition and subtraction', () {
        final sum = 10.N + 1.kgf; // 10 N + ~9.8 N
        expect(sum.inNewtons, closeTo(19.80665, tolerance));
        expect(sum.unit, ForceUnit.newton);
      });

      test('should perform scalar multiplication and division', () {
        final force = 20.N;
        expect((force * 2.5).inNewtons, closeTo(50.0, tolerance));
        expect((force / 4.0).inNewtons, closeTo(5.0, tolerance));
        expect((force / 0).value, double.infinity);
      });
    });

    group('Dimensional Analysis', () {
      test('Mass * Acceleration = Force', () {
        final mass = 10.kg;
        final acc = 9.80665.mps2; // 1 g
        final force = Force.from(mass, acc);

        expect(force, isA<Force>());
        expect(force.inNewtons, closeTo(98.0665, tolerance));
        expect(force.inKilogramsForce, closeTo(10.0, 1e-5));
      });

      test('Force / Mass = Acceleration', () {
        final force = 100.N;
        final mass = 20.kg;
        final acc = force.accelerationOf(mass);

        expect(acc, isA<Acceleration>());
        expect(acc.inMetersPerSecondSquared, closeTo(5.0, tolerance));
        expect(100.N.accelerationOf(0.kg).inMetersPerSecondSquared, double.infinity);
        expect(0.N.accelerationOf(0.kg).inMetersPerSecondSquared, isNaN);
      });

      test('Force / Acceleration = Mass', () {
        final force = 50.N;
        final acc = 10.mps2;
        final mass = force.massFrom(acc);

        expect(mass, isA<Mass>());
        expect(mass.inKilograms, closeTo(5.0, tolerance));
        expect(50.N.massFrom(0.mps2).inKilograms, double.infinity);
        expect(0.N.massFrom(0.mps2).inKilograms, isNaN);
      });
    });

    group('Round Trip Conversions', () {
      for (final unit in ForceUnit.values) {
        test('Round trip ${unit.symbol} <-> N', () {
          const initialValue = 123.456;
          final force = Force(initialValue, unit);
          final roundTripForce = force.asNewtons.convertTo(unit);
          expect(roundTripForce.value, closeTo(initialValue, 1e-9));
        });
      }
    });

    group('Comprehensive Extension Coverage', () {
      test('all creation extension aliases', () {
        expect(5.kN.unit, ForceUnit.kilonewton);
        expect(5.kilonewtons.unit, ForceUnit.kilonewton);
        expect(5.kilonewtons.inNewtons, closeTo(5000.0, tolerance));
        expect(2.MN.unit, ForceUnit.meganewton);
        expect(2.meganewtons.unit, ForceUnit.meganewton);
        expect(500.mN.unit, ForceUnit.millinewton);
        expect(500.millinewtons.unit, ForceUnit.millinewton);
        expect(500.millinewtons.inNewtons, closeTo(0.5, tolerance));
        expect(10.dynes.unit, ForceUnit.dyne);
        expect(1.gf.unit, ForceUnit.gramForce);
        expect(1.newtons.unit, ForceUnit.newton);
      });

      test('all as* conversion getters', () {
        final f = 100.N;

        final asN = f.asNewtons;
        expect(asN.unit, ForceUnit.newton);
        expect(asN.value, closeTo(100.0, tolerance));

        final asKn = f.asKilonewtons;
        expect(asKn.unit, ForceUnit.kilonewton);
        expect(asKn.value, closeTo(0.1, tolerance));

        final asMn = f.asMeganewtons;
        expect(asMn.unit, ForceUnit.meganewton);
        expect(asMn.value, closeTo(1e-4, tolerance));

        final asMn2 = f.asMillinewtons;
        expect(asMn2.unit, ForceUnit.millinewton);
        expect(asMn2.value, closeTo(100000.0, tolerance));

        final asLbf = f.asPoundsForce;
        expect(asLbf.unit, ForceUnit.poundForce);
        expect(asLbf.value, closeTo(22.4809, 1e-4));

        final asDyn = f.asDynes;
        expect(asDyn.unit, ForceUnit.dyne);
        expect(asDyn.value, closeTo(1e7, 1e-6));

        final asKgf = f.asKilogramsForce;
        expect(asKgf.unit, ForceUnit.kilogramForce);
        expect(asKgf.value, closeTo(10.1972, 1e-4));

        final asGf = f.asGramsForce;
        expect(asGf.unit, ForceUnit.gramForce);
        expect(asGf.value, closeTo(10197.2, 1e-1));

        final asPdl = f.asPoundals;
        expect(asPdl.unit, ForceUnit.poundal);
        expect(asPdl.value, closeTo(723.301, 1e-3));
      });
    });

    group('Practical Examples', () {
      test('Weight on Earth', () {
        final personMass = 75.kg;
        final gravity = 1.gravity; // Use the specific extension for gravity
        // F = m * a
        final personWeight = Force.from(personMass, gravity);

        expect(personWeight.inNewtons, closeTo(735.5, 1e-1));
        expect(personWeight.inKilogramsForce, closeTo(75.0, 1e-5));
        expect(personWeight.inPoundsForce, closeTo(165.3, 1e-1));
      });
    });

    group('Force.fromPressure (F = P × A)', () {
      test('100 Pa × 10 m² = 1 000 N', () {
        expect(
          Force.fromPressure(const Pressure(100, PressureUnit.pascal), 10.m2).inNewtons,
          closeTo(1000.0, highTolerance),
        );
      });

      test('result unit is newton', () {
        expect(
          Force.fromPressure(const Pressure(100, PressureUnit.pascal), 1.m2).unit,
          ForceUnit.newton,
        );
      });

      test('meganewton/giganewton/micronewton/nanonewton extensions', () {
        const tol = 1e-9;
        // Creation
        expect(1.0.MN.unit, ForceUnit.meganewton);
        expect(1.0.meganewtons.unit, ForceUnit.meganewton);
        expect(1.0.GN.unit, ForceUnit.giganewton);
        expect(1.0.giganewtons.unit, ForceUnit.giganewton);
        expect(1.0.uN.unit, ForceUnit.micronewton);
        expect(1.0.micronewtons.unit, ForceUnit.micronewton);
        expect(1.0.nN.unit, ForceUnit.nanonewton);
        expect(1.0.nanonewtons.unit, ForceUnit.nanonewton);

        // inX getters
        expect(1e6.N.inMeganewtons, closeTo(1.0, tol));
        expect(1e9.N.inGiganewtons, closeTo(1.0, tol));
        expect(1.0.N.inMicronewtons, closeTo(1e6, tol));
        expect(1.0.N.inNanonewtons, closeTo(1e9, 1.0));

        // asX getters
        expect(1e6.N.asMeganewtons.unit, ForceUnit.meganewton);
        expect(1e6.N.asMeganewtons.value, closeTo(1.0, tol));
        expect(1e9.N.asGiganewtons.unit, ForceUnit.giganewton);
        expect(1e9.N.asGiganewtons.value, closeTo(1.0, tol));
        expect(1.0.N.asMicronewtons.unit, ForceUnit.micronewton);
        expect(1.0.N.asMicronewtons.value, closeTo(1e6, tol));
        expect(1.0.N.asNanonewtons.unit, ForceUnit.nanonewton);
        expect(1.0.N.asNanonewtons.value, closeTo(1e9, 1.0));
      });

      test('doubling area doubles force', () {
        const p = Pressure(50, PressureUnit.pascal);
        final f1 = Force.fromPressure(p, 2.m2);
        final f2 = Force.fromPressure(p, 4.m2);
        expect(f2.inNewtons, closeTo(f1.inNewtons * 2, highTolerance));
      });

      test('inverse of Pressure.from: Force.fromPressure(Pressure.from(f, a), a) ≈ f', () {
        const original = Force(800, ForceUnit.newton);
        final area = 4.m2;
        final pressure = Pressure.from(original, area);
        final recovered = Force.fromPressure(pressure, area);
        expect(recovered.inNewtons, closeTo(800.0, highTolerance));
      });

      // --- Unit-preserving behaviour ---
      test('Pa × m² → N', () {
        final f = Force.fromPressure(const Pressure(200, PressureUnit.pascal), 0.5.m2);
        expect(f.unit, ForceUnit.newton);
        expect(f.value, closeTo(100.0, highTolerance));
      });

      test('kPa × m² → kN', () {
        final f = Force.fromPressure(const Pressure(200, PressureUnit.kilopascal), 0.5.m2);
        expect(f.unit, ForceUnit.kilonewton);
        expect(f.value, closeTo(100.0, highTolerance));
      });

      test('psi × in² → lbf', () {
        final f = Force.fromPressure(
          const Pressure(30, PressureUnit.psi),
          const Area(2, AreaUnit.squareInch),
        );
        expect(f.unit, ForceUnit.poundForce);
        expect(f.value, closeTo(60.0, highTolerance));
      });

      test('atm × m² → SI fallback N', () {
        expect(
          Force.fromPressure(const Pressure(1, PressureUnit.atmosphere), 1.m2).unit,
          ForceUnit.newton,
        );
      });

      test('physical correctness: 200 kPa × 0.5 m² ≈ 100 000 N', () {
        expect(
          Force.fromPressure(const Pressure(200, PressureUnit.kilopascal), 0.5.m2).inNewtons,
          closeTo(100000.0, highTolerance),
        );
      });
    });

    group('Force.from unit-preserving', () {
      test('kg × m/s² → N', () {
        final f = Force.from(10.kg, 2.mps2);
        expect(f.unit, ForceUnit.newton);
        expect(f.value, closeTo(20.0, highTolerance));
      });

      test('g × cm/s² → dyn', () {
        final f =
            Force.from(5.g, const Acceleration(3, AccelerationUnit.centimeterPerSecondSquared));
        expect(f.unit, ForceUnit.dyne);
        expect(f.value, closeTo(15.0, highTolerance));
      });

      test('kg × cm/s² → SI fallback N', () {
        expect(
          Force.from(1.kg, const Acceleration(100, AccelerationUnit.centimeterPerSecondSquared))
              .unit,
          ForceUnit.newton,
        );
      });

      test('physical correctness: 5 g × 3 cm/s² ≈ 1.5e-4 N', () {
        expect(
          Force.from(5.g, const Acceleration(3, AccelerationUnit.centimeterPerSecondSquared))
              .inNewtons,
          closeTo(1.5e-4, 1e-8),
        );
      });
    });
  });
}
