// BEGIN FILE: test/units/mass_test.dart
// ignore_for_file: prefer_int_literals // All constants are doubles for precision.

import 'package:quantify/quantify.dart'; // Assuming Mass and MassUnit are exported via quantify.dart
import 'package:test/test.dart';

void main() {
  group('Mass', () {
    const tolerance = 1e-9; // Tolerance for double comparisons
    const highTolerance = 1e-7; // Higher tolerance for chained conversions or inexact factors

    // Helper for round trip tests
    void testRoundTrip(
      MassUnit initialUnit,
      MassUnit intermediateUnit,
      double initialValue, {
      double tol = highTolerance, // Use highTolerance as default for round trips
    }) {
      final m1 = Mass(initialValue, initialUnit);
      final m2 = m1.convertTo(intermediateUnit);
      final m3 = m2.convertTo(initialUnit);
      expect(
        m3.value,
        closeTo(initialValue, tol),
        reason:
            '${initialUnit.symbol} -> ${intermediateUnit.symbol} -> ${initialUnit.symbol} failed for $initialValue. Expected $initialValue, got ${m3.value}',
      );
    }

    group('Constructors and Getters (from num extensions)', () {
      test('should create Mass from num extensions and retrieve values correctly', () {
        final mKg = 10.0.kg;
        expect(mKg.value, 10.0);
        expect(mKg.unit, MassUnit.kilogram);
        expect(mKg.inGrams, closeTo(10000.0, tolerance));
        expect(mKg.asGrams.value, closeTo(10000.0, tolerance));
        expect(mKg.asGrams.unit, MassUnit.gram);

        final mGrams = 500.0.grams; // Using alias
        expect(mGrams.value, 500.0);
        expect(mGrams.unit, MassUnit.gram);
        expect(mGrams.inKilograms, closeTo(0.5, tolerance));

        final mLbs = 2.0.pounds; // Using alias
        expect(mLbs.value, 2.0);
        expect(mLbs.unit, MassUnit.pound);
        // 2 lb * 0.45359237 kg/lb = 0.90718474 kg
        expect(mLbs.inKilograms, closeTo(0.90718474, highTolerance));

        final mOz = 16.0.oz; // 1 pound
        expect(mOz.value, 16.0);
        expect(mOz.unit, MassUnit.ounce);
        expect(mOz.inPounds, closeTo(1.0, tolerance));
      });

      test('getValue should return correct value for same unit', () {
        const mass = Mass(25.0, MassUnit.gram);
        expect(mass.getValue(MassUnit.gram), 25.0);
      });
    });

    group('Conversions between various units', () {
      final oneKg = 1.0.kg;
      test('1 Kilogram to other units', () {
        expect(oneKg.inGrams, closeTo(1000.0, tolerance));
        expect(oneKg.inMilligrams, closeTo(1000000.0, tolerance));
        expect(oneKg.inTonnes, closeTo(0.001, tolerance));
        expect(oneKg.inPounds, closeTo(1.0 / 0.45359237, highTolerance)); // ~2.20462 lbs
        expect(oneKg.inOunces, closeTo(16.0 / 0.45359237, highTolerance)); // ~35.27396 oz
        expect(oneKg.inStones, closeTo(1.0 / (14.0 * 0.45359237), highTolerance)); // ~0.15747 st
        expect(oneKg.inSlugs, closeTo(1.0 / 14.5939029372, highTolerance)); // ~0.06852 slugs
      });

      final onePound = 1.0.lb;
      test('1 Pound to other units', () {
        expect(onePound.inKilograms, closeTo(0.45359237, tolerance));
        expect(onePound.inGrams, closeTo(453.59237, tolerance));
        expect(onePound.inOunces, closeTo(16.0, tolerance));
        expect(onePound.inStones, closeTo(1.0 / 14.0, highTolerance));
      });

      final oneOunce = 1.0.oz;
      test('1 Ounce to grams', () {
        expect(oneOunce.inGrams, closeTo(0.45359237 * 1000.0 / 16.0, highTolerance)); // ~28.3495 g
      });

      final oneTonne = 1.0.t;
      test('1 Tonne to kilograms and pounds', () {
        expect(oneTonne.inKilograms, closeTo(1000.0, tolerance));
        expect(oneTonne.inPounds, closeTo(1000.0 / 0.45359237, highTolerance));
      });

      final oneSlug = 1.0.slugs;
      test('1 Slug to kilograms and pounds', () {
        expect(oneSlug.inKilograms, closeTo(14.5939029372, tolerance));
        expect(oneSlug.inPounds, closeTo(14.5939029372 / 0.45359237, highTolerance)); // ~32.174 lbs
      });
    });

    group('convertTo method', () {
      test('should return new Mass object with converted value and unit', () {
        final massGrams = 1500.0.g;
        final massKilograms = massGrams.convertTo(MassUnit.kilogram);

        expect(massKilograms.unit, MassUnit.kilogram);
        expect(massKilograms.value, closeTo(1.5, tolerance));
        expect(massGrams.unit, MassUnit.gram); // Original should be unchanged
        expect(massGrams.value, 1500.0);
      });

      test('convertTo same unit should return same instance (immutable optimization)', () {
        final m1 = 10.0.kg;
        final m2 = m1.convertTo(MassUnit.kilogram);
        expect(identical(m1, m2), isTrue);
      });
    });

    group('Comparison (compareTo)', () {
      final m1Kg = 1.0.kg;
      final m1000g = 1000.0.g;
      final m999g = 999.0.g;
      final m2lb = 2.0.lb; // approx 0.907 kg
      final m3lb = 3.0.lb; // approx 1.360 kg

      test('should correctly compare masses of different units', () {
        expect(m1Kg.compareTo(m999g), greaterThan(0)); // 1kg > 999g
        expect(m999g.compareTo(m1Kg), lessThan(0)); // 999g < 1kg
        expect(m1Kg.compareTo(m1000g), 0); // 1kg == 1000g

        expect(m1Kg.compareTo(m2lb), greaterThan(0)); // 1kg > 2lb
        expect(m1Kg.compareTo(m3lb), lessThan(0)); // 1kg < 3lb
      });

      test('should return 0 for equal masses in different units', () {
        final mInLbs = (1.0 / 0.45359237).pounds; // 1 kg in pounds
        expect(m1Kg.compareTo(mInLbs), 0);
      });
    });

    group('Equality (operator ==) and HashCode', () {
      test('should be equal for same value and unit', () {
        const m1 = Mass(10.0, MassUnit.kilogram);
        const m2 = Mass(10.0, MassUnit.kilogram);
        expect(m1 == m2, isTrue);
        expect(m1.hashCode == m2.hashCode, isTrue);
      });

      test('should not be equal for different values or units', () {
        const m1 = Mass(10.0, MassUnit.kilogram);
        const m2Diffval = Mass(10.1, MassUnit.kilogram);
        const m3Diffunit = Mass(10.0, MassUnit.gram);
        const m4Diffvalandunit = Mass(1.0, MassUnit.pound);

        expect(m1 == m2Diffval, isFalse);
        expect(m1 == m3Diffunit, isFalse);
        expect(m1 == m4Diffvalandunit, isFalse);

        expect(m1.hashCode == m2Diffval.hashCode, isFalse);
        // Hash collisions are possible but unlikely for these simple diffs
        expect(m1.hashCode == m3Diffunit.hashCode, isFalse);
      });

      test('equality is strict, 1.kg is not equal to 1000.g', () {
        // This confirms that `==` checks unit, not just magnitude.
        // For magnitude, `compareTo` is used.
        final oneKg = 1.kg;
        final thousandGrams = 1000.g;
        expect(oneKg == thousandGrams, isFalse);
        expect(oneKg.compareTo(thousandGrams), 0);
      });
    });

    group('toString() (basic check, formatting is in Quantity class)', () {
      test('should return formatted string with default non-breaking space', () {
        expect(10.5.kg.toString(), '10.5\u00A0kg'); // \u00A0 is non-breaking space
        expect(500.grams.toString(), '500.0\u00A0g');
        expect(2.2.pounds.toString(), '2.2\u00A0lb');
      });
    });

    group('Round Trip Conversions (thorough)', () {
      const testValue = 123.456;

      // Test all units via Kilogram (the base for MassUnit)
      for (final unit in MassUnit.values) {
        test('Round trip ${unit.symbol} <-> kg', () {
          testRoundTrip(
            unit,
            MassUnit.kilogram,
            testValue,
            tol: (unit == MassUnit.kilogram) ? tolerance : highTolerance,
          );
        });
      }

      // Test some other common pairs
      test('Round trip g <-> mg', () {
        testRoundTrip(MassUnit.gram, MassUnit.milligram, testValue);
      });
      test('Round trip lb <-> oz', () {
        testRoundTrip(MassUnit.pound, MassUnit.ounce, testValue);
      });
      test('Round trip lb <-> st', () {
        testRoundTrip(
          MassUnit.pound,
          MassUnit.stone,
          28.0,
        ); // Test with a value that easily converts
      });
      test('Round trip kg <-> tonne', () {
        testRoundTrip(MassUnit.kilogram, MassUnit.tonne, 5000.0);
      });
      test('Round trip kg <-> slug', () {
        testRoundTrip(MassUnit.kilogram, MassUnit.slug, testValue);
      });
    });

    group('Edge Cases', () {
      test('Conversion with zero value', () {
        final mZeroKg = 0.0.kg;
        for (final unit in MassUnit.values) {
          expect(mZeroKg.getValue(unit), 0.0, reason: '0 kg to ${unit.symbol} should be 0');
        }

        final mZeroLb = 0.0.lb;
        for (final unit in MassUnit.values) {
          expect(mZeroLb.getValue(unit), 0.0, reason: '0 lb to ${unit.symbol} should be 0');
        }
      });

      test('Conversion with negative value (mass is typically positive, but math should work)', () {
        final mNegativeKg = (-10.0).kg;
        expect(mNegativeKg.inGrams, closeTo(-10000.0, tolerance));
        expect(mNegativeKg.inPounds, closeTo(-10.0 / 0.45359237, highTolerance));
      });
    });

    group('Arithmetic Operators for Mass', () {
      final m1kg = 1.0.kg;
      final m2kg = 2.0.kg;
      final m500g = 500.g; // 0.5 kg
      final m1lb = 1.lb; // 0.45359237 kg

      // Operator +
      test('operator + combines masses, result in unit of left operand', () {
        final sum1 = m2kg + m1kg;
        expect(sum1.value, closeTo(3.0, tolerance));
        expect(sum1.unit, MassUnit.kilogram);

        final sum2 = m1kg + m500g; // 1kg + 0.5kg = 1.5kg
        expect(sum2.value, closeTo(1.5, tolerance));
        expect(sum2.unit, MassUnit.kilogram);

        final sum3 = m500g + m1kg; // 500g + 1000g = 1500g
        expect(sum3.value, closeTo(1500.0, tolerance));
        expect(sum3.unit, MassUnit.gram);

        final sum4 = m1kg + m1lb; // 1kg + 0.45359237kg
        expect(sum4.value, closeTo(1.0 + 0.45359237, highTolerance));
        expect(sum4.unit, MassUnit.kilogram);
      });

      // Operator -
      test('operator - subtracts masses, result in unit of left operand', () {
        final diff1 = m2kg - m1kg;
        expect(diff1.value, closeTo(1.0, tolerance));
        expect(diff1.unit, MassUnit.kilogram);

        final diff2 = m1kg - m500g; // 1kg - 0.5kg = 0.5kg
        expect(diff2.value, closeTo(0.5, tolerance));
        expect(diff2.unit, MassUnit.kilogram);

        final diff3 = m1kg - m1lb; // 1kg - 0.45359237kg
        expect(diff3.value, closeTo(1.0 - 0.45359237, highTolerance));
        expect(diff3.unit, MassUnit.kilogram);
      });

      // Operator * (scalar)
      test('operator * scales mass by a scalar', () {
        final scaled1 = m2kg * 3.5;
        expect(scaled1.value, closeTo(7.0, tolerance));
        expect(scaled1.unit, MassUnit.kilogram);

        final scaled2 = m500g * 0.5;
        expect(scaled2.value, closeTo(250.0, tolerance));
        expect(scaled2.unit, MassUnit.gram);
      });

      // Operator / (scalar)
      test('operator / scales mass by a scalar', () {
        final scaled1 = m2kg / 4.0;
        expect(scaled1.value, closeTo(0.5, tolerance));
        expect(scaled1.unit, MassUnit.kilogram);

        final scaled2 = m1kg / 0.1;
        expect(scaled2.value, closeTo(10.0, tolerance));
        expect(scaled2.unit, MassUnit.kilogram);

        expect(() => m1kg / 0.0, throwsArgumentError, reason: 'Division by zero should throw');
      });

      test('operator chaining preserves immutability', () {
        final initialMass = 10.kg;
        final mAdd = initialMass + 500.g; // 10kg + 0.5kg = 10.5kg
        final mMul = mAdd * 2.0; // 10.5kg * 2 = 21kg
        final mSub = mMul - 1.lb; // 21kg - ~0.45kg

        expect(initialMass.value, 10.0); // Original unchanged
        expect(initialMass.unit, MassUnit.kilogram);

        expect(mAdd.value, closeTo(10.5, tolerance));
        expect(mAdd.unit, MassUnit.kilogram);

        expect(mMul.value, closeTo(21.0, tolerance));
        expect(mMul.unit, MassUnit.kilogram);

        final expectedMSubVal = 21.0 - 1.0.lb.getValue(MassUnit.kilogram);
        expect(mSub.value, closeTo(expectedMSubVal, highTolerance));
        expect(mSub.unit, MassUnit.kilogram);
      });
    });
  });
}
// END FILE: test/units/mass_test.dart
