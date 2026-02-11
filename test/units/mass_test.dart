// ignore_for_file: prefer_int_literals // All constants are doubles for precision.

import 'package:quantify/quantify.dart'; // Assuming Mass and MassUnit are exported via quantify.dart
import 'package:quantify/src/units/mass/mass_factors.dart';
import 'package:test/test.dart';

void main() {
  const highPrecisiontolerance = 1e-12; // High precision for mass
  const highTolerance = 1e-7; // Higher tolerance for chained conversions or inexact factors
  const tolerance = 1e-9; // Tolerance for double comparisons
  const atomicTolerance = 1e-30; // For atomic mass units

  group('Mass', () {
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

  group('Extended Mass Units', () {
    group('SI Prefix Units', () {
      test('hectogram conversions', () {
        final oneHectogram = 1.0.hg;
        expect(oneHectogram.inKilograms, closeTo(0.1, highPrecisiontolerance));
        expect(oneHectogram.inGrams, closeTo(100.0, highPrecisiontolerance));
        expect(oneHectogram.inDecagrams, closeTo(10.0, highPrecisiontolerance));
      });

      test('decagram conversions', () {
        final oneDecagram = 1.0.dag;
        expect(oneDecagram.inKilograms, closeTo(0.01, highPrecisiontolerance));
        expect(oneDecagram.inGrams, closeTo(10.0, highPrecisiontolerance));
        expect(oneDecagram.inHectograms, closeTo(0.1, highPrecisiontolerance));
      });

      test('decigram conversions', () {
        final oneDecigram = 1.0.dg;
        expect(oneDecigram.inGrams, closeTo(0.1, highPrecisiontolerance));
        expect(oneDecigram.inCentigrams, closeTo(10.0, highPrecisiontolerance));
        expect(oneDecigram.inMilligrams, closeTo(100.0, highPrecisiontolerance));
      });

      test('centigram conversions', () {
        final oneCentigram = 1.0.cg;
        expect(oneCentigram.inGrams, closeTo(0.01, highPrecisiontolerance));
        expect(oneCentigram.inDecigrams, closeTo(0.1, highPrecisiontolerance));
        expect(oneCentigram.inMilligrams, closeTo(10.0, highPrecisiontolerance));
      });

      test('microgram conversions', () {
        final oneMicrogram = 1.0.ug;
        expect(oneMicrogram.inGrams, closeTo(1e-6, highPrecisiontolerance));
        expect(oneMicrogram.inMilligrams, closeTo(0.001, highPrecisiontolerance));
        expect(oneMicrogram.inNanograms, closeTo(1000.0, highPrecisiontolerance));
      });

      test('nanogram conversions', () {
        final oneNanogram = 1.0.ng;
        expect(oneNanogram.inGrams, closeTo(1e-9, highPrecisiontolerance));
        expect(oneNanogram.inMicrograms, closeTo(0.001, highPrecisiontolerance));
        expect(oneNanogram.inKilograms, closeTo(1e-12, highPrecisiontolerance));
      });
    });

    group('Imperial Ton Units', () {
      test('short ton (US) conversions', () {
        final oneShortTon = 1.0.shortTons;
        expect(oneShortTon.inPounds, closeTo(2000.0, highPrecisiontolerance));
        expect(oneShortTon.inKilograms, closeTo(907.18474, tolerance));
        expect(oneShortTon.inTonnes, closeTo(0.90718474, tolerance));
      });

      test('long ton (UK) conversions', () {
        final oneLongTon = 1.0.longTons;
        expect(oneLongTon.inPounds, closeTo(2240.0, highPrecisiontolerance));
        expect(oneLongTon.inKilograms, closeTo(1016.0469088, tolerance));
        expect(oneLongTon.inTonnes, closeTo(1.0160469088, tolerance));
      });

      test('ton comparisons', () {
        final shortTon = 1.0.shortTons;
        final longTon = 1.0.longTons;
        final metricTon = 1.0.tonnes;

        // Long ton > Metric ton > Short ton
        expect(longTon.compareTo(metricTon), greaterThan(0));
        expect(metricTon.compareTo(shortTon), greaterThan(0));
        expect(longTon.compareTo(shortTon), greaterThan(0));
      });
    });

    group('Special Units', () {
      test('atomic mass unit conversions', () {
        final oneAMU = 1.0.u;
        expect(oneAMU.inKilograms, closeTo(1.66053906660e-27, atomicTolerance));
        expect(oneAMU.inGrams, closeTo(1.66053906660e-24, atomicTolerance));

        // Carbon-12 has exactly 12 u
        final carbon12 = 12.0.u;
        expect(carbon12.inKilograms, closeTo(12.0 * 1.66053906660e-27, atomicTolerance));

        // Test Avogadro's number relationship
        // 1 mole of carbon-12 = 12 g = 12 u × N_A
        const avogadroNumber = 6.02214076e23;
        const oneMoleCarbon12InKg = 0.012; // 12 g
        final oneAtomCarbon12InKg = carbon12.inKilograms;
        final calculatedAvogadro = oneMoleCarbon12InKg / oneAtomCarbon12InKg;
        expect(calculatedAvogadro, closeTo(avogadroNumber, avogadroNumber * 1e-6));
      });

      test('carat conversions', () {
        final oneCarat = 1.0.ct;
        expect(oneCarat.inGrams, closeTo(0.2, highPrecisiontolerance));
        expect(oneCarat.inKilograms, closeTo(0.0002, highPrecisiontolerance));
        expect(oneCarat.inMilligrams, closeTo(200.0, highPrecisiontolerance));

        // Typical diamond weights
        final halfCarat = 0.5.ct;
        final twoCarats = 2.0.ct;
        expect(halfCarat.inGrams, closeTo(0.1, highPrecisiontolerance));
        expect(twoCarats.inGrams, closeTo(0.4, highPrecisiontolerance));
      });

      test('atomic scale examples', () {
        // Hydrogen atom mass ≈ 1.008 u
        final hydrogenMass = 1.008.u;
        const expectedHydrogenInKg = 1.008 * MassFactors.kilogramsPerAtomicMassUnit;
        expect(hydrogenMass.inKilograms, closeTo(expectedHydrogenInKg, 1e-30));

        // Electron mass ≈ 0.000549 u
        final electronMassInU = 0.000549.u;
        const expectedElectronInKg = 0.000549 * MassFactors.kilogramsPerAtomicMassUnit;
        // Test the conversion, not the standard value of electron mass in kg
        expect(electronMassInU.inKilograms, closeTo(expectedElectronInKg, 1e-34));

        // Compare electron to proton (≈ 1.007 u)
        final protonMass = 1.007.u;
        expect(protonMass.compareTo(electronMassInU), greaterThan(0));
      });

      group('Practical measurement examples', () {
        test('pharmaceutical dosages', () {
          // Common drug dosages are in milligrams
          final aspirinTablet = 325.mg;
          final vitaminC = 1000.mg;

          expect(aspirinTablet.inGrams, closeTo(0.325, highPrecisiontolerance));
          expect(vitaminC.inGrams, closeTo(1.0, highPrecisiontolerance));

          // Microgram dosages for potent drugs
          final folicAcid = 400.ug;
          expect(folicAcid.inMilligrams, closeTo(0.4, highPrecisiontolerance));
        });

        test('jewelry and precious materials', () {
          // Gold jewelry - typical weights
          final goldRing = 3.5.g;
          final goldNecklace = 15.2.g;

          expect(goldRing.inOunces, closeTo(0.1235, 1e-4));
          expect(goldNecklace.inOunces, closeTo(0.53616, 1e-4));

          // Diamond weights in carats
          final engagementRing = 1.5.ct;
          final earrings = 0.75.ct; // Total for both

          expect(engagementRing.inGrams, closeTo(0.3, highPrecisiontolerance));
          expect(earrings.inGrams, closeTo(0.15, highPrecisiontolerance));
        });

        test('shipping and cargo', () {
          // Freight shipping weights
          final containerLimit = 30.tonnes;
          final truckLoad = 40000.pounds;

          expect(containerLimit.inKilograms, closeTo(30000.0, highPrecisiontolerance));
          expect(truckLoad.inTonnes, closeTo(18.1436948, tolerance));

          // Compare different ton types for cargo
          final usShipping = 20.shortTons;
          final ukShipping = 20.longTons;
          final metricShipping = 20.tonnes;

          expect(ukShipping.compareTo(metricShipping), greaterThan(0));
          expect(metricShipping.compareTo(usShipping), greaterThan(0));
        });
      });

      group('Round trip conversions for new units', () {
        const testValue = 567.89;

        test('SI prefix round trips', () {
          final units = [
            MassUnit.hectogram,
            MassUnit.decagram,
            MassUnit.decigram,
            MassUnit.centigram,
            MassUnit.microgram,
            MassUnit.nanogram,
          ];

          for (final unit in units) {
            final original = Mass(testValue, unit);
            final converted = original.convertTo(MassUnit.kilogram).convertTo(unit);
            expect(
              converted.value,
              closeTo(testValue, tolerance),
              reason: 'Round trip failed for ${unit.symbol}',
            );
          }
        });

        test('special unit round trips', () {
          // Test atomic mass unit with smaller value due to extreme scale
          const amuOriginal = Mass(12.011, MassUnit.atomicMassUnit); // Carbon average
          final amuConverted =
              amuOriginal.convertTo(MassUnit.kilogram).convertTo(MassUnit.atomicMassUnit);
          expect(amuConverted.value, closeTo(12.011, tolerance));

          // Test carat
          const caratOriginal = Mass(testValue, MassUnit.carat);
          final caratConverted =
              caratOriginal.convertTo(MassUnit.kilogram).convertTo(MassUnit.carat);
          expect(caratConverted.value, closeTo(testValue, highPrecisiontolerance));

          // Test tons
          const shortTonOriginal = Mass(testValue, MassUnit.shortTon);
          final shortTonConverted =
              shortTonOriginal.convertTo(MassUnit.kilogram).convertTo(MassUnit.shortTon);
          expect(shortTonConverted.value, closeTo(testValue, tolerance));
        });
      });

      group('toString formatting for new units', () {
        test('should display correct symbols', () {
          expect(1.0.hg.toString(), '1.0\u00A0hg');
          expect(1.0.dag.toString(), '1.0\u00A0dag');
          expect(1.0.dg.toString(), '1.0\u00A0dg');
          expect(1.0.cg.toString(), '1.0\u00A0cg');
          expect(1.0.ug.toString(), '1.0\u00A0μg');
          expect(1.0.ng.toString(), '1.0\u00A0ng');
          expect(1.0.shortTons.toString(), '1.0\u00A0short ton');
          expect(1.0.longTons.toString(), '1.0\u00A0long ton');
          expect(1.0.u.toString(), '1.0\u00A0u');
          expect(1.0.ct.toString(), '1.0\u00A0ct');
        });
      });

      group('Mixed unit arithmetic', () {
        test('adding very different scales', () {
          final bigMass = 1.0.tonnes;
          final smallMass = 1.0.mg;
          final combined = bigMass + smallMass;

          // Milligram should be negligible compared to tonne
          expect(combined.inTonnes, closeTo(1.0, highTolerance));
          expect(combined.unit, MassUnit.tonne);
        });

        test('precision in small scale arithmetic', () {
          final drug1 = 250.ug; // micrograms
          final drug2 = 750.ug;
          final totalDose = drug1 + drug2;

          expect(totalDose.inMicrograms, closeTo(1000.0, highPrecisiontolerance));
          expect(totalDose.inMilligrams, closeTo(1.0, highPrecisiontolerance));
        });

        test('atomic mass arithmetic', () {
          // Water molecule: 2 H + 1 O
          final hydrogen = 1.008.u;
          final oxygen = 15.999.u;
          final waterMass = (hydrogen * 2) + oxygen;

          expect(waterMass.inAtomicMassUnits, closeTo(18.015, highPrecisiontolerance));
        });
      });
    });

    group('Mega and Giga Units', () {
      const tolerance = 1e-9;

      test('megagram conversions and equivalence with tonne', () {
        // Use the new explicit extension `megaG`
        final oneMegagram = 1.0.megaG;
        expect(oneMegagram.inKilograms, closeTo(1000.0, tolerance));
        expect(oneMegagram.inGrams, closeTo(1e6, tolerance));

        // Megagram should be equivalent to tonne
        final oneTonne = 1.0.t;
        expect(oneMegagram.compareTo(oneTonne), 0);
        expect(oneMegagram.inTonnes, closeTo(1.0, tolerance));
      });

      test('gigagram conversions', () {
        // Use the new explicit extension `gigaG`
        final oneGigagram = 1.0.gigaG;
        expect(oneGigagram.inKilograms, closeTo(1e6, tolerance));
        // Use the new explicit getter `inMegaG`
        expect(oneGigagram.inMegaG, closeTo(1000.0, tolerance));
        expect(oneGigagram.inTonnes, closeTo(1000.0, tolerance));
      });

      test('large scale mass examples', () {
        // Mass of a large bridge might be in gigagrams
        final bridgeMass = 50.0.gigaG; // 50,000 tonnes
        expect(bridgeMass.inTonnes, closeTo(50000.0, tolerance));

        // Compare with a space shuttle mass (~2 Gg)
        final shuttleMass = 2.0.gigaG;
        expect(bridgeMass.compareTo(shuttleMass), greaterThan(0));
      });

      test('round trip conversions for mega and giga', () {
        const testValue = 123.456;
        // Test round trip via kilograms
        final originalMega = testValue.megaG;
        final roundTripMega = originalMega.asKilograms.asMegaG;
        expect(roundTripMega.value, closeTo(testValue, tolerance));

        final originalGiga = testValue.gigaG;
        final roundTripGiga = originalGiga.asKilograms.asGigaG;
        expect(roundTripGiga.value, closeTo(testValue, tolerance));
      });
    });

    group('US/UK Ton Units and Carats', () {
      test('should create and convert using short tons (US)', () {
        // 1 short ton = 2000 pounds = 907.18474 kg
        final mass = 2.0.shortTons;
        expect(mass.value, 2.0);
        expect(mass.unit, MassUnit.shortTon);
        expect(mass.inPounds, closeTo(4000.0, tolerance)); // 2 * 2000
        expect(mass.inKilograms, closeTo(1814.36948, highTolerance)); // 2 * 907.18474

        // Test "as" conversion getter
        final massInPounds = mass.asPounds;
        expect(massInPounds.value, closeTo(4000.0, tolerance));
        expect(massInPounds.unit, MassUnit.pound);
      });

      test('should create and convert using long tons (UK)', () {
        // 1 long ton = 2240 pounds = 1016.0469088 kg
        final mass = 1.5.longTons;
        expect(mass.value, 1.5);
        expect(mass.unit, MassUnit.longTon);
        expect(mass.inPounds, closeTo(3360.0, tolerance)); // 1.5 * 2240
        expect(mass.inKilograms, closeTo(1524.0703632, highTolerance)); // 1.5 * 1016.0469088

        // Test "as" conversion getter
        final massInKg = mass.asKilograms;
        expect(massInKg.value, closeTo(1524.0703632, highTolerance));
        expect(massInKg.unit, MassUnit.kilogram);
      });

      test('should differentiate between short and long tons', () {
        final shortTon = 1.0.shortTons;
        final longTon = 1.0.longTons;

        // Long ton is heavier than short ton
        expect(longTon.inKilograms, greaterThan(shortTon.inKilograms));
        expect(longTon.inPounds, closeTo(2240.0, tolerance));
        expect(shortTon.inPounds, closeTo(2000.0, tolerance));
      });

      test('should create and convert using carats', () {
        // 1 carat = 200 mg = 0.2 g
        final diamond = 5.0.ct;
        expect(diamond.value, 5.0);
        expect(diamond.unit, MassUnit.carat);
        expect(diamond.inGrams, closeTo(1.0, tolerance)); // 5 * 0.2
        expect(diamond.inMilligrams, closeTo(1000.0, tolerance)); // 5 * 200

        // Test using alias
        final ruby = 10.0.carats;
        expect(ruby.value, 10.0);
        expect(ruby.unit, MassUnit.carat);
        expect(ruby.inGrams, closeTo(2.0, tolerance));

        // Test "as" conversion getter
        final rubyInMg = ruby.asMilligrams;
        expect(rubyInMg.value, closeTo(2000.0, tolerance));
        expect(rubyInMg.unit, MassUnit.milligram);
      });

      test('practical examples with tons and carats', () {
        // A typical car weighs about 1.5 short tons
        final car = 1.5.shortTons;
        expect(car.inKilograms, closeTo(1360.77711, highTolerance));

        // Hope Diamond is 45.52 carats
        final hopeDiamond = 45.52.carats;
        expect(hopeDiamond.inGrams, closeTo(9.104, tolerance));

        // UK freight might use long tons
        final freight = 50.0.longTons;
        expect(freight.inKilograms, closeTo(50802.34544, highTolerance));
      });

      test('round trip conversions for tons and carats', () {
        const testValue = 5.5;

        // Short tons
        final shortTonOrig = testValue.shortTons;
        final shortTonRoundTrip = shortTonOrig.asKilograms.asShortTons;
        expect(shortTonRoundTrip.value, closeTo(testValue, highTolerance));

        // Long tons
        final longTonOrig = testValue.longTons;
        final longTonRoundTrip = longTonOrig.asKilograms.asLongTons;
        expect(longTonRoundTrip.value, closeTo(testValue, highTolerance));

        // Carats
        final caratOrig = testValue.carats;
        final caratRoundTrip = caratOrig.asGrams.asCarats;
        expect(caratRoundTrip.value, closeTo(testValue, tolerance));
      });
    });

    group('Comprehensive Extension Coverage', () {
      test('creation aliases not previously covered', () {
        expect(1.0.mg.unit, MassUnit.milligram);
        expect(1.0.milligrams.unit, MassUnit.milligram);
        expect(1.0.micrograms.unit, MassUnit.microgram);
        expect(1.0.nanograms.unit, MassUnit.nanogram);
        expect(1.0.ounces.unit, MassUnit.ounce);
        expect(1.0.stones.unit, MassUnit.stone);
        expect(1.0.slugs.unit, MassUnit.slug);
        expect(1.0.atomicMassUnits.unit, MassUnit.atomicMassUnit);
        expect(1.0.t.unit, MassUnit.tonne);
        expect(1.0.pounds.unit, MassUnit.pound);
        expect(1.0.grams.unit, MassUnit.gram);
        // Spot-check values
        expect(1.0.mg.inGrams, closeTo(0.001, highPrecisiontolerance));
        expect(1.0.ounces.inPounds, closeTo(1.0 / 16.0, highPrecisiontolerance));
      });

      test('all as* conversion getters', () {
        final oneKg = 1.0.kg;

        final asHg = oneKg.asHectograms;
        expect(asHg.unit, MassUnit.hectogram);
        expect(asHg.value, closeTo(10.0, highPrecisiontolerance));

        final asDag = oneKg.asDecagrams;
        expect(asDag.unit, MassUnit.decagram);
        expect(asDag.value, closeTo(100.0, highPrecisiontolerance));

        final asDg = oneKg.asDecigrams;
        expect(asDg.unit, MassUnit.decigram);
        expect(asDg.value, closeTo(10000.0, highPrecisiontolerance));

        final asCg = oneKg.asCentigrams;
        expect(asCg.unit, MassUnit.centigram);
        expect(asCg.value, closeTo(100000.0, tolerance));

        final asUg = oneKg.asMicrograms;
        expect(asUg.unit, MassUnit.microgram);
        expect(asUg.value, closeTo(1e9, 1)); // tolerance accounts for float scale

        final asNg = oneKg.asNanograms;
        expect(asNg.unit, MassUnit.nanogram);
        expect(asNg.value, closeTo(1e12, 1e3)); // tolerance accounts for float scale

        final asMegaG = oneKg.asMegaG;
        expect(asMegaG.unit, MassUnit.megagram);
        expect(asMegaG.value, closeTo(0.001, highPrecisiontolerance));

        final asGigaG = 1e6.kg.asGigaG;
        expect(asGigaG.unit, MassUnit.gigagram);
        expect(asGigaG.value, closeTo(1.0, highPrecisiontolerance));

        final asTonnes = oneKg.asTonnes;
        expect(asTonnes.unit, MassUnit.tonne);
        expect(asTonnes.value, closeTo(0.001, highPrecisiontolerance));

        final asOz = oneKg.asOunces;
        expect(asOz.unit, MassUnit.ounce);
        expect(asOz.value, closeTo(16.0 / 0.45359237, highTolerance));

        final asSt = oneKg.asStones;
        expect(asSt.unit, MassUnit.stone);
        expect(asSt.value, closeTo(1.0 / (14.0 * 0.45359237), highTolerance));

        final asSlugs = oneKg.asSlugs;
        expect(asSlugs.unit, MassUnit.slug);
        expect(asSlugs.value, closeTo(1.0 / 14.5939029372, highTolerance));

        final asAmu = 1.0.u.asAtomicMassUnits;
        expect(asAmu.unit, MassUnit.atomicMassUnit);
        expect(asAmu.value, closeTo(1.0, highPrecisiontolerance));
      });
    });
  });
}
