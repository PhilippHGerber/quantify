import 'package:quantify/acceleration.dart';
import 'package:quantify/force.dart';
import 'package:quantify/mass.dart';
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
        expect(() => force / 0, throwsArgumentError);
      });
    });

    group('Dimensional Analysis', () {
      test('Mass * Acceleration = Force', () {
        final mass = 10.kg;
        final acc = 9.80665.mpsSquared; // 1 g
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
        expect(() => 100.N.accelerationOf(0.kg), throwsArgumentError);
      });

      test('Force / Acceleration = Mass', () {
        final force = 50.N;
        final acc = 10.mpsSquared;
        final mass = force.massFrom(acc);

        expect(mass, isA<Mass>());
        expect(mass.inKilograms, closeTo(5.0, tolerance));
        expect(() => 50.N.massFrom(0.mpsSquared), throwsArgumentError);
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
  });
}
