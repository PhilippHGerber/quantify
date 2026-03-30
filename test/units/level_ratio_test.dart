import 'package:quantify/quantify.dart';
import 'package:test/test.dart';

void main() {
  const tolerance = 1e-9;

  group('LevelRatio', () {
    group('Constructors and Getters', () {
      test('creates from constructor with value and unit', () {
        const ratio = LevelRatio(3, LevelRatioUnit.decibel);
        expect(ratio.value, 3.0);
        expect(ratio.unit, LevelRatioUnit.decibel);
      });

      test('creates from num extensions', () {
        final ratioDb = 3.dB;
        expect(ratioDb.value, 3.0);
        expect(ratioDb.unit, LevelRatioUnit.decibel);

        final ratioNp = 1.Np;
        expect(ratioNp.value, 1.0);
        expect(ratioNp.unit, LevelRatioUnit.neper);
      });

      test('factorTo returns valid conversion factors', () {
        expect(
          LevelRatioUnit.neper.factorTo(LevelRatioUnit.decibel),
          closeTo(8.685889638065035, tolerance),
        );
        expect(
          LevelRatioUnit.decibel.factorTo(LevelRatioUnit.neper),
          closeTo(0.11512925464970229, tolerance),
        );
      });
    });

    group('Conversions', () {
      test('1 neper equals 8.685889638 dB', () {
        expect(1.Np.inDecibel, closeTo(8.685889638065035, tolerance));
      });

      test('1 decibel equals 0.11512925465 Np', () {
        expect(1.dB.inNeper, closeTo(0.11512925464970229, tolerance));
      });

      test('zero converts cleanly between units', () {
        expect(0.dB.inNeper, closeTo(0.0, tolerance));
        expect(0.Np.inDecibel, closeTo(0.0, tolerance));
      });
    });

    group('convertTo method', () {
      test('returns new instance with converted value', () {
        final ratio = 2.Np;
        final converted = ratio.convertTo(LevelRatioUnit.decibel);
        expect(converted.unit, LevelRatioUnit.decibel);
        expect(converted.value, closeTo(17.37177927613007, tolerance));
      });

      test('returns same instance when converting to same unit', () {
        final ratio = 3.dB;
        final same = ratio.convertTo(LevelRatioUnit.decibel);
        expect(identical(ratio, same), isTrue);
      });

      test('as* getters return converted instances', () {
        final ratio = 6.dB;
        expect(ratio.asNeper.unit, LevelRatioUnit.neper);
        expect(ratio.asDecibel.unit, LevelRatioUnit.decibel);
      });
    });

    group('Arithmetic Operators', () {
      test('adds level ratios in same unit', () {
        final result = 3.dB + 2.dB;
        expect(result.unit, LevelRatioUnit.decibel);
        expect(result.value, closeTo(5.0, tolerance));
      });

      test('adds level ratios across units', () {
        final result = 3.dB + 1.Np;
        expect(result.unit, LevelRatioUnit.decibel);
        expect(result.value, closeTo(11.685889638065035, tolerance));
      });

      test('subtracts level ratios across units', () {
        final result = 2.Np - 3.dB;
        expect(result.unit, LevelRatioUnit.neper);
        expect(result.inDecibel, closeTo(14.37177927613007, tolerance));
      });

      test('multiplies by scalar', () {
        final result = 3.dB * 2.0;
        expect(result.unit, LevelRatioUnit.decibel);
        expect(result.value, closeTo(6.0, tolerance));
      });

      test('divides by scalar with IEEE 754 behavior', () {
        expect((3.dB / 0).value, equals(double.infinity));
      });

      test('unary negation preserves unit', () {
        final result = -1.Np;
        expect(result.unit, LevelRatioUnit.neper);
        expect(result.value, closeTo(-1.0, tolerance));
      });
    });

    group('Round Trips', () {
      void testRoundTrip(LevelRatioUnit from, LevelRatioUnit to, double value) {
        final original = LevelRatio(value, from);
        final roundTrip = original.convertTo(to).convertTo(from);
        expect(roundTrip.value, closeTo(value, tolerance));
      }

      test('round trips dB <-> Np', () {
        testRoundTrip(LevelRatioUnit.decibel, LevelRatioUnit.neper, 12.5);
        testRoundTrip(LevelRatioUnit.neper, LevelRatioUnit.decibel, 1.75);
      });
    });

    group('toString and equality consistency', () {
      test('formats with unit symbol', () {
        expect(3.dB.toString(), '3.0 dB');
        expect(1.Np.toString(), '1.0 Np');
      });

      test('equality is strict on stored unit and value', () {
        expect(
          const LevelRatio(3, LevelRatioUnit.decibel),
          const LevelRatio(3, LevelRatioUnit.decibel),
        );
        expect(1.Np == LevelRatio(1.Np.inDecibel, LevelRatioUnit.decibel), isFalse);
      });

      test('compareTo compares physical magnitude across units', () {
        expect(1.Np.compareTo(const LevelRatio(8.685889638065035, LevelRatioUnit.decibel)), 0);
      });
    });
  });
}
