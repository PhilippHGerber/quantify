import 'package:quantify/quantify.dart';
import 'package:test/test.dart';

void main() {
  group('Quantity.isEquivalentTo', () {
    // -------------------------------------------------------------------------
    // Basic magnitude comparison
    // -------------------------------------------------------------------------
    group('Basic magnitude comparison', () {
      test('same unit, same value → true', () {
        expect(1.m.isEquivalentTo(1.m), isTrue);
      });

      test('different units, same physical magnitude → true', () {
        expect(1.m.isEquivalentTo(100.cm), isTrue);
        expect(1.km.isEquivalentTo(1000.m), isTrue);
        expect(1.kg.isEquivalentTo(1000.g), isTrue);
      });

      test('different physical magnitudes → false', () {
        expect(1.m.isEquivalentTo(2.m), isFalse);
        expect(1.m.isEquivalentTo(99.cm), isFalse);
      });
    });

    // -------------------------------------------------------------------------
    // Floating-point drift (the primary motivation)
    // -------------------------------------------------------------------------
    group('IEEE 754 floating-point drift', () {
      test('0.1 + 0.2 == 0.3 is absorbed by default tolerance', () {
        // Raw double: 0.1 + 0.2 != 0.3 in IEEE 754.
        expect(0.1 + 0.2, isNot(equals(0.3)));
        expect((0.1.m + 0.2.m).isEquivalentTo(0.3.m), isTrue);
      });

      test('repeated addition drift is absorbed', () {
        var sum = 0.0.m;
        for (var i = 0; i < 10; i++) {
          sum = sum + 0.1.m;
        }
        // Accumulated drift over 10 additions — still within 1e-9 relative.
        expect(sum.isEquivalentTo(1.0.m), isTrue);
      });

      test('round-trip conversion is equivalent', () {
        // m → km → m incurs two multiplications; result should still match.
        final original = 1.m;
        final roundTrip = original.asKm.asM;
        expect(original.isEquivalentTo(roundTrip), isTrue);
      });
    });

    // -------------------------------------------------------------------------
    // Scale invariance
    // -------------------------------------------------------------------------
    group('Scale invariance', () {
      test('works at very large magnitudes (astronomical scale)', () {
        // 1 km = 1000 m — at 1e12 scale the absolute diff would be huge,
        // but relative tolerance keeps it correct.
        const large = Length(1000000000000, LengthUnit.meter);
        const largeKm = Length(1000000000, LengthUnit.kilometer);
        expect(large.isEquivalentTo(largeKm), isTrue);
      });

      test('works at very small magnitudes (subatomic scale)', () {
        const tiny = Length(1e-12, LengthUnit.meter);
        const tinyCm = Length(1e-10, LengthUnit.centimeter);
        expect(tiny.isEquivalentTo(tinyCm), isTrue);
      });
    });

    // -------------------------------------------------------------------------
    // Custom tolerance
    // -------------------------------------------------------------------------
    group('Custom tolerance', () {
      test('values within custom tight tolerance → true', () {
        const a = Length(1, LengthUnit.meter);
        const b = Length(1.0 + 1e-13, LengthUnit.meter);
        expect(a.isEquivalentTo(b, tolerance: 1e-12), isTrue);
      });

      test('values outside custom tight tolerance → false', () {
        const a = Length(1, LengthUnit.meter);
        const b = Length(1.0 + 1e-11, LengthUnit.meter);
        expect(a.isEquivalentTo(b, tolerance: 1e-12), isFalse);
      });

      test('looser tolerance accepts larger difference', () {
        final a = 1.0.m;
        const b = Length(1.0 + 1e-5, LengthUnit.meter);
        expect(a.isEquivalentTo(b, tolerance: 1e-4), isTrue);
        expect(a.isEquivalentTo(b, tolerance: 1e-6), isFalse);
      });

      test(
        'assert fires for negative tolerance in debug mode',
        () {
          expect(
            () => 1.m.isEquivalentTo(1.m, tolerance: -0.1),
            throwsA(isA<AssertionError>()),
          );
        },
        skip: !!const bool.fromEnvironment('dart.vm.product'),
      );
    });

    // -------------------------------------------------------------------------
    // Zero operand — absolute fallback
    // -------------------------------------------------------------------------
    group('Zero operand (absolute threshold fallback)', () {
      test('both zero → true', () {
        expect(0.0.m.isEquivalentTo(0.0.m), isTrue);
      });

      test('zero vs small value within tolerance → true', () {
        expect(0.0.m.isEquivalentTo(const Length(1e-10, LengthUnit.meter)), isTrue);
      });

      test('zero vs value outside tolerance → false', () {
        expect(0.0.m.isEquivalentTo(const Length(1e-8, LengthUnit.meter)), isFalse);
      });

      test('zero in different units: 0 m vs 0 km → true', () {
        expect(0.0.m.isEquivalentTo(const Length(0, LengthUnit.kilometer)), isTrue);
      });
    });

    // -------------------------------------------------------------------------
    // Infinity handling
    // -------------------------------------------------------------------------
    group('Infinity handling', () {
      test('+∞ == +∞ → true', () {
        const inf = Length(double.infinity, LengthUnit.meter);
        expect(inf.isEquivalentTo(const Length(double.infinity, LengthUnit.meter)), isTrue);
      });

      test('-∞ == -∞ → true', () {
        const negInf = Length(double.negativeInfinity, LengthUnit.meter);
        expect(
          negInf.isEquivalentTo(const Length(double.negativeInfinity, LengthUnit.meter)),
          isTrue,
        );
      });

      test('+∞ vs -∞ → false', () {
        const posInf = Length(double.infinity, LengthUnit.meter);
        const negInf = Length(double.negativeInfinity, LengthUnit.meter);
        expect(posInf.isEquivalentTo(negInf), isFalse);
      });

      test('finite value vs +∞ → false', () {
        const large = Length(1e300, LengthUnit.meter);
        const inf = Length(double.infinity, LengthUnit.meter);
        expect(large.isEquivalentTo(inf), isFalse);
        expect(inf.isEquivalentTo(large), isFalse);
      });

      test('zero vs +∞ → false', () {
        expect(
          0.0.m.isEquivalentTo(const Length(double.infinity, LengthUnit.meter)),
          isFalse,
        );
      });
    });

    // -------------------------------------------------------------------------
    // NaN handling
    // -------------------------------------------------------------------------
    group('NaN handling', () {
      test('NaN vs finite → false', () {
        const nan = Length(double.nan, LengthUnit.meter);
        expect(nan.isEquivalentTo(1.m), isFalse);
        expect(1.m.isEquivalentTo(nan), isFalse);
      });

      test('NaN vs NaN → false (IEEE 754: NaN ≠ NaN)', () {
        const nan = Length(double.nan, LengthUnit.meter);
        expect(nan.isEquivalentTo(const Length(double.nan, LengthUnit.meter)), isFalse);
      });

      test('NaN vs zero → false', () {
        const nan = Length(double.nan, LengthUnit.meter);
        expect(nan.isEquivalentTo(0.0.m), isFalse);
        expect(0.0.m.isEquivalentTo(nan), isFalse);
      });
    });

    // -------------------------------------------------------------------------
    // Works across quantity types (not just Length)
    // -------------------------------------------------------------------------
    group('Works across other quantity types', () {
      test('Mass: 1 kg == 1000 g', () {
        expect(1.kg.isEquivalentTo(1000.g), isTrue);
      });

      test('Temperature: 0°C == 273.15 K (via getValue)', () {
        expect(
          const Temperature(0, TemperatureUnit.celsius)
              .isEquivalentTo(const Temperature(273.15, TemperatureUnit.kelvin)),
          isTrue,
        );
      });

      test('TemperatureDelta: floating-point drift absorbed', () {
        const a = TemperatureDelta(0.1, TemperatureDeltaUnit.celsiusDelta);
        const b = TemperatureDelta(0.2, TemperatureDeltaUnit.celsiusDelta);
        final sum = a + b;
        expect(
          sum.isEquivalentTo(const TemperatureDelta(0.3, TemperatureDeltaUnit.celsiusDelta)),
          isTrue,
        );
      });
    });
  });
}
