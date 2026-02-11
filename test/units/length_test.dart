// ignore_for_file: prefer_int_literals : all constants are doubles.

import 'package:intl/intl.dart';
import 'package:quantify/quantify.dart';
import 'package:quantify/src/units/length/length_factors.dart';
import 'package:test/test.dart';

void main() {
  const tolerance = 1e-9; // Tolerance for double comparisons
  const highTolerance = 1e-6; // For very large/small conversions
  const astronomicalTolerance = 1e-4; // For astronomical distances

  group('Length', () {
    // Helper for round trip tests
    void testRoundTrip(
      LengthUnit initialUnit,
      LengthUnit intermediateUnit,
      double initialValue, {
      double tolerance = 1e-9,
    }) {
      final l1 = Length(initialValue, initialUnit);
      final l2 = l1.convertTo(intermediateUnit);
      final l3 = l2.convertTo(initialUnit);
      expect(
        l3.value,
        closeTo(initialValue, tolerance),
        reason:
            '${initialUnit.symbol} -> ${intermediateUnit.symbol} -> ${initialUnit.symbol} failed for $initialValue',
      );
    }

    group('Constructors and Getters', () {
      test('should create Length from num extensions and retrieve values', () {
        final l1 = 100.0.m;
        expect(l1.value, 100.0);
        expect(l1.unit, LengthUnit.meter);
        expect(l1.inKm, closeTo(0.1, tolerance));

        final l2 = 5.0.ft;
        expect(l2.value, 5.0);
        expect(l2.unit, LengthUnit.foot);
        expect(l2.inInch, closeTo(60.0, tolerance));

        final l3 = 12.inch;
        expect(l3.inFt, closeTo(1.0, tolerance));
      });

      test('getValue should return correct value for same unit', () {
        const l = Length(25.0, LengthUnit.centimeter);
        expect(l.getValue(LengthUnit.centimeter), 25.0);
      });

      test('getValue for all units from Meter base', () {
        final l = 1000.0.m; // 1 km
        expect(l.inM, 1000.0);
        expect(l.inKm, closeTo(1.0, tolerance));
        expect(l.inCm, closeTo(100000.0, tolerance));
        expect(l.inMm, closeTo(1000000.0, tolerance));
        expect(l.inInch, closeTo(1000.0 / 0.0254, 1e-7));
        expect(l.inFt, closeTo(1000.0 / 0.3048, 1e-7));
        expect(l.inYd, closeTo(1000.0 / 0.9144, 1e-7));
        expect(l.inMi, closeTo(1000.0 / 1609.344, 1e-7));
        expect(l.inNmi, closeTo(1000.0 / 1852.0, 1e-7));
      });
    });

    group('Conversions', () {
      final oneMeter = 1.0.m;

      test('1 meter to various units', () {
        expect(oneMeter.inKm, closeTo(0.001, tolerance));
        expect(oneMeter.inCm, closeTo(100.0, tolerance));
        expect(oneMeter.inMm, closeTo(1000.0, tolerance));
        expect(oneMeter.inInch, closeTo(1 / 0.0254, 1e-7)); // 39.3700787...
        expect(oneMeter.inFt, closeTo(1 / 0.3048, 1e-7)); // 3.2808398...
        expect(oneMeter.inYd, closeTo(1 / 0.9144, 1e-7)); // 1.0936132...
      });

      final oneFoot = 1.0.ft;
      test('1 foot to various units', () {
        expect(oneFoot.inM, closeTo(0.3048, tolerance));
        expect(oneFoot.inInch, closeTo(12.0, tolerance));
        expect(oneFoot.inYd, closeTo(1.0 / 3.0, tolerance));
      });

      final oneMile = 1.0.mi;
      test('1 mile to various units', () {
        expect(oneMile.inM, closeTo(1609.344, tolerance));
        expect(oneMile.inFt, closeTo(5280.0, tolerance));
        expect(oneMile.inYd, closeTo(1760.0, tolerance));
        expect(oneMile.inKm, closeTo(1.609344, tolerance));
      });
    });

    group('convertTo method', () {
      test('should return new Length object with converted value and unit', () {
        final lMeters = 10.0.m;
        final lFeet = lMeters.convertTo(LengthUnit.foot);
        expect(lFeet.unit, LengthUnit.foot);
        expect(lFeet.value, closeTo(lMeters.inFt, tolerance));
        expect(lMeters.unit, LengthUnit.meter); // Original should be unchanged
      });

      test('convertTo same unit should return same instance (or equal if optimized)', () {
        final l1 = 10.0.m;
        final l2 = l1.convertTo(LengthUnit.meter);
        expect(identical(l1, l2), isTrue);
      });
    });

    group('Comparison (compareTo)', () {
      final lMeter = 1.0.m;
      final lSlightlyLessCm = 99.0.cm;
      final lSlightlyMoreCm = 101.0.cm;
      final lFoot = 3.0.ft; // 0.9144 meters

      test('should correctly compare lengths of different units', () {
        expect(lMeter.compareTo(lSlightlyLessCm), greaterThan(0));
        expect(lSlightlyLessCm.compareTo(lMeter), lessThan(0));
        expect(lMeter.compareTo(lSlightlyMoreCm), lessThan(0));
        expect(lMeter.compareTo(lFoot), greaterThan(0)); // 1m > 3ft
      });

      test('should return 0 for equal lengths in different units', () {
        final lCm = 100.0.cm;
        final lInches = (1.0 / 0.0254).inch; // 1 meter in inches
        expect(lMeter.compareTo(lCm), 0);
        expect(lCm.compareTo(lMeter), 0);
        expect(lMeter.compareTo(lInches), 0);
      });
    });

    group('Equality and HashCode', () {
      test('should be equal for same value and unit', () {
        const l1 = Length(10.0, LengthUnit.meter);
        const l2 = Length(10.0, LengthUnit.meter);
        expect(l1 == l2, isTrue);
        expect(l1.hashCode == l2.hashCode, isTrue);
      });

      test('should not be equal for different values or units', () {
        const l1 = Length(10.0, LengthUnit.meter);
        const l2 = Length(10.1, LengthUnit.meter);
        const l3 = Length(10.0, LengthUnit.foot);
        expect(l1 == l2, isFalse);
        expect(l1 == l3, isFalse);
        expect(l1.hashCode == l2.hashCode, isFalse);
        expect(l1.hashCode == l3.hashCode, isFalse);
      });
    });

    group('toString()', () {
      test('should return formatted string', () {
        expect(10.5.m.toString(), '10.5 m');
        expect(12.0.inch.toString(), '12.0 in');
        expect(1.6.km.toString(), '1.6 km');
      });
    });

    group('Round Trip Conversions', () {
      const testValue = 789.123;
      const highTolerance = 1e-7; // For chains of conversions

      for (final unit in LengthUnit.values) {
        test('Round trip ${unit.symbol} <-> m', () {
          testRoundTrip(
            unit,
            LengthUnit.meter,
            testValue,
            tolerance: (unit == LengthUnit.meter) ? tolerance : highTolerance,
          );
        });
      }

      test('Round trip ft <-> in', () {
        testRoundTrip(LengthUnit.foot, LengthUnit.inch, testValue);
      });
      test('Round trip yd <-> mi', () {
        testRoundTrip(LengthUnit.yard, LengthUnit.mile, 5000.0, tolerance: highTolerance);
      });
      test('Round trip cm <-> km', () {
        testRoundTrip(
          LengthUnit.centimeter,
          LengthUnit.kilometer,
          250000.0,
          tolerance: highTolerance,
        );
      });
    });

    group('Edge Cases', () {
      test('Conversion with zero value', () {
        final lZero = 0.0.m;
        for (final unit in LengthUnit.values) {
          expect(lZero.getValue(unit), 0.0, reason: '0 m to ${unit.symbol} should be 0');
        }
      });
    });

    group('Arithmetic Operators for Length', () {
      final l1Meter = 1.0.m;
      final l2Meters = 2.0.m;
      final l50Cm = 50.cm; // 0.5 meters

      // Operator +
      test('operator + combines lengths', () {
        final sum1 = l2Meters + l1Meter;
        expect(sum1.value, closeTo(3.0, tolerance));
        expect(sum1.unit, LengthUnit.meter);

        final sum2 = l1Meter + l50Cm; // 1m + 0.5m = 1.5m
        expect(sum2.value, closeTo(1.5, tolerance));
        expect(sum2.unit, LengthUnit.meter);

        final sum3 = l50Cm + l1Meter; // 50cm + 100cm = 150cm
        expect(sum3.value, closeTo(150.0, tolerance));
        expect(sum3.unit, LengthUnit.centimeter);
      });

      // Operator -
      test('operator - subtracts lengths', () {
        final diff1 = l2Meters - l1Meter;
        expect(diff1.value, closeTo(1.0, tolerance));
        expect(diff1.unit, LengthUnit.meter);

        final diff2 = l1Meter - l50Cm; // 1m - 0.5m = 0.5m
        expect(diff2.value, closeTo(0.5, tolerance));
        expect(diff2.unit, LengthUnit.meter);

        final diff3 = l2Meters - l50Cm.convertTo(LengthUnit.meter); // 2m - 0.5m = 1.5m
        expect(diff3.value, closeTo(1.5, tolerance));
        expect(diff3.unit, LengthUnit.meter);
      });

      // Operator * (scalar)
      test('operator * scales length by a scalar', () {
        final scaled = l2Meters * 3.0;
        expect(scaled.value, closeTo(6.0, tolerance));
        expect(scaled.unit, LengthUnit.meter);

        final scaledCm = l50Cm * 2.5;
        expect(scaledCm.value, closeTo(125.0, tolerance));
        expect(scaledCm.unit, LengthUnit.centimeter);
      });

      // Operator / (scalar)
      test('operator / scales length by a scalar', () {
        final scaled = l2Meters / 2.0;
        expect(scaled.value, closeTo(1.0, tolerance));
        expect(scaled.unit, LengthUnit.meter);

        expect(() => l1Meter / 0.0, throwsArgumentError);
      });

      test('operator chaining preserves immutability', () {
        final initialLength = 10.m;
        final l1 = initialLength + 5.m; // 15m
        final l2 = l1 * 2.0; // 30m
        final l3 = l2 - 100.cm; // 30m - 1m = 29m

        expect(initialLength.value, 10.0); // Original unchanged
        expect(l1.value, closeTo(15.0, tolerance));
        expect(l2.value, closeTo(30.0, tolerance));
        expect(l3.value, closeTo(29.0, tolerance));
        expect(l3.unit, LengthUnit.meter);
      });
    });
  });

  group('Extended Length Units', () {
    group('SI Prefix Units', () {
      test('hectometer conversions', () {
        final oneHectometer = 1.0.hm;
        expect(oneHectometer.inM, closeTo(100.0, tolerance));
        expect(oneHectometer.inKm, closeTo(0.1, tolerance));
        expect(oneHectometer.inCm, closeTo(10000.0, tolerance));
      });

      test('decameter conversions', () {
        final oneDecameter = 1.0.dam;
        expect(oneDecameter.inM, closeTo(10.0, tolerance));
        expect(oneDecameter.inHm, closeTo(0.1, tolerance));
        expect(oneDecameter.inDm, closeTo(100.0, tolerance));
      });

      test('decimeter conversions', () {
        final oneDecimeter = 1.0.dm;
        expect(oneDecimeter.inM, closeTo(0.1, tolerance));
        expect(oneDecimeter.inCm, closeTo(10.0, tolerance));
        expect(oneDecimeter.inMm, closeTo(100.0, tolerance));
      });

      test('micrometer conversions', () {
        final oneMicrometer = 1.0.um;
        expect(oneMicrometer.inM, closeTo(1e-6, tolerance));
        expect(oneMicrometer.inMm, closeTo(0.001, tolerance));
        expect(oneMicrometer.inNm, closeTo(1000.0, tolerance));
      });

      test('nanometer conversions', () {
        final oneNanometer = 1.0.nm;
        expect(oneNanometer.inM, closeTo(1e-9, tolerance));
        expect(oneNanometer.inUm, closeTo(0.001, tolerance));
        expect(oneNanometer.inPm, closeTo(1000.0, tolerance));
      });

      test('picometer conversions', () {
        final onePicometer = 1.0.pm;
        expect(onePicometer.inM, closeTo(1e-12, tolerance));
        expect(onePicometer.inNm, closeTo(0.001, tolerance));
        expect(onePicometer.inFm, closeTo(1000.0, tolerance));
      });

      test('femtometer conversions', () {
        final oneFemtometer = 1.0.fm;
        expect(oneFemtometer.inM, closeTo(1e-15, tolerance));
        expect(oneFemtometer.inPm, closeTo(0.001, tolerance));
      });
    });

    group('Astronomical Units', () {
      test('astronomical unit conversions', () {
        final oneAU = 1.0.AU;
        expect(oneAU.inM, closeTo(149597870700.0, tolerance));
        expect(oneAU.inKm, closeTo(149597870.7, highTolerance));

        // Test practical astronomy example
        final marsDistance = 1.5.AU; // Mars at average distance
        expect(marsDistance.inKm, closeTo(224396806.05, highTolerance));
      });

      test('light year conversions', () {
        final oneLightYear = 1.0.ly;
        // Expected value calculated using the library's own factors
        const expectedAUperLY =
            LengthFactors.metersPerLightYear / LengthFactors.metersPerAstronomicalUnit;

        expect(oneLightYear.inAU, closeTo(expectedAUperLY, astronomicalTolerance));

        // Test nearby star distance
        final proximaCentauri = 4.24.ly;
        const expectedProximaInAU = 4.24 * expectedAUperLY; // Calculate expected value
        expect(proximaCentauri.inAU, closeTo(expectedProximaInAU, astronomicalTolerance));
      });

      test('parsec conversions', () {
        final oneParsec = 1.0.pc;
        const expectedAUperPC =
            LengthFactors.metersPerParsec / LengthFactors.metersPerAstronomicalUnit;

        expect(oneParsec.inLy, closeTo(3.26156, astronomicalTolerance));
        expect(oneParsec.inAU, closeTo(expectedAUperPC, astronomicalTolerance));
        expect(oneParsec.inM, closeTo(3.0856775814913673e16, astronomicalTolerance));
      });

      test('astronomical distance relationships', () {
        // Test the relationship: 1 pc ≈ 3.26 ly
        final oneParsec = 1.0.pc;
        final equivalentLy = oneParsec.inLy;
        expect(equivalentLy, closeTo(3.26156, astronomicalTolerance));

        // Test parallax relationship: distance in parsecs = 1 / parallax in arcseconds
        // For a star with 0.1 arcsecond parallax, distance should be 10 parsecs
        final starDistance = 10.0.pc;
        expect(starDistance.inLy, closeTo(32.6156, astronomicalTolerance));
      });
    });

    group('Ångström conversions', () {
      test('ångström basic conversions', () {
        final oneAngstrom = 1.0.angstrom;
        expect(oneAngstrom.inM, closeTo(1e-10, tolerance));
        expect(oneAngstrom.inNm, closeTo(0.1, tolerance));
        expect(oneAngstrom.inPm, closeTo(100.0, tolerance));
      });

      test('atomic scale measurements', () {
        // Hydrogen atom radius ≈ 0.529 Å (Bohr radius)
        final hydrogenRadius = 0.529.angstrom;
        expect(hydrogenRadius.inPm, closeTo(52.9, tolerance));
        expect(hydrogenRadius.inNm, closeTo(0.0529, tolerance));

        // X-ray wavelength ≈ 1-10 Å
        final xrayWavelength = 1.54.angstrom; // Cu Kα radiation
        expect(xrayWavelength.inNm, closeTo(0.154, tolerance));
      });
    });

    group('Mixed unit arithmetic and comparisons', () {
      test('very different scales addition', () {
        final bigDistance = 1.0.ly;
        final smallDistance = 1.0.m;
        final combined = bigDistance + smallDistance;

        // The meter should be insignificant compared to light year
        expect(combined.inLy, closeTo(1.0, astronomicalTolerance));
        expect(combined.unit, LengthUnit.lightYear);
      });

      test('practical scientific measurements', () {
        // DNA double helix diameter ≈ 20 Å
        final dnaDiameter = 20.0.angstrom;
        expect(dnaDiameter.inNm, closeTo(2.0, tolerance));

        // Wavelength of visible light: 400-700 nm
        final blueLight = 450.0.nm;
        final redLight = 650.0.nm;
        expect(blueLight.inAngstrom, closeTo(4500.0, tolerance));
        expect(redLight.inAngstrom, closeTo(6500.0, tolerance));

        // Compare with X-ray
        final xray = 1.0.angstrom;
        expect(blueLight.compareTo(xray), greaterThan(0)); // Visible light has longer wavelength
      });

      test('sorting astronomical distances', () {
        final distances = [
          1.pc, // ~3.26 ly
          10.ly, // 10 ly
          1000.AU, // ~0.016 ly
          1.ly, // 1 ly
          100000.AU, // ~1.58 ly
        ];

        // ignore: cascade_invocations // Sort by magnitude
        distances.sort();

        // Should be sorted by magnitude: 1000 AU < 100000 AU < 1 ly < 1 pc < 10 ly
        expect(distances[0].unit, LengthUnit.astronomicalUnit);
        expect(distances[0].value, 1000.0);
        expect(distances[4].value, 10.0);
        expect(distances[4].unit, LengthUnit.lightYear);
      });
    });

    group('Round trip conversions for new units', () {
      const testValue = 123.456;

      test('SI prefix round trips', () {
        final units = [
          LengthUnit.hectometer,
          LengthUnit.decameter,
          LengthUnit.decimeter,
          LengthUnit.micrometer,
          LengthUnit.nanometer,
          LengthUnit.picometer,
          LengthUnit.femtometer,
        ];

        for (final unit in units) {
          final original = Length(testValue, unit);
          final converted = original.convertTo(LengthUnit.meter).convertTo(unit);
          expect(
            converted.value,
            closeTo(testValue, highTolerance),
            reason: 'Round trip failed for ${unit.symbol}',
          );
        }
      });

      test('astronomical unit round trips', () {
        final astronomicalUnits = [
          LengthUnit.astronomicalUnit,
          LengthUnit.lightYear,
          LengthUnit.parsec,
        ];

        for (final unit in astronomicalUnits) {
          final original = Length(testValue, unit);
          final converted = original.convertTo(LengthUnit.meter).convertTo(unit);
          expect(
            converted.value,
            closeTo(testValue, astronomicalTolerance),
            reason: 'Round trip failed for ${unit.symbol}',
          );
        }
      });

      test('ångström round trip', () {
        const original = Length(testValue, LengthUnit.angstrom);
        final converted = original.convertTo(LengthUnit.meter).convertTo(LengthUnit.angstrom);
        expect(converted.value, closeTo(testValue, tolerance));
      });
    });

    group('toString formatting for new units', () {
      test('should display correct symbols', () {
        expect(1.0.hm.toString(), '1.0\u00A0hm');
        expect(1.0.dam.toString(), '1.0\u00A0dam');
        expect(1.0.dm.toString(), '1.0\u00A0dm');
        expect(1.0.um.toString(), '1.0\u00A0μm');
        expect(1.0.nm.toString(), '1.0\u00A0nm');
        expect(1.0.pm.toString(), '1.0\u00A0pm');
        expect(1.0.fm.toString(), '1.0\u00A0fm');
        expect(1.0.AU.toString(), '1.0\u00A0AU');
        expect(1.0.ly.toString(), '1.0\u00A0ly');
        expect(1.0.pc.toString(), '1.0\u00A0pc');
        expect(1.0.angstrom.toString(), '1.0\u00A0Å');
      });
    });
    group('Mega and Giga Units', () {
      const tolerance = 1e-9;

      test('megameter conversions', () {
        final oneMegameter = 1.0.megaM;
        expect(oneMegameter.inM, closeTo(1e6, tolerance));
        expect(oneMegameter.inKm, closeTo(1000.0, tolerance));
        expect(oneMegameter.inGigaM, closeTo(0.001, tolerance));
      });

      test('gigameter conversions', () {
        final oneGigameter = 1.0.gigaM;
        expect(oneGigameter.inM, closeTo(1e9, tolerance));
        expect(oneGigameter.inKm, closeTo(1e6, tolerance));
        expect(oneGigameter.inMegaM, closeTo(1000.0, tolerance));
      });

      test('astronomical scale examples', () {
        // Earth's diameter is about 12.742 Mm
        final earthDiameter = 12.742.megaM;
        expect(earthDiameter.inKm, closeTo(12742.0, tolerance));

        // Sun's diameter is about 1.3927 Gm
        final sunDiameter = 1.3927.gigaM;
        expect(sunDiameter.inMegaM, closeTo(1392.7, tolerance));
        expect(sunDiameter.inKm, closeTo(1392700.0, tolerance));

        // Compare Earth and Sun
        expect(sunDiameter.compareTo(earthDiameter), greaterThan(0));
      });
    });
  });

  group('Quantity Comparison Operators for Length', () {
    // --- Test Fixtures ---
    final oneMeter = 1.m;
    final oneMeterAgain = 1.m; // Different instance, same value/unit
    final twoMeters = 2.m;
    final hundredCm = 100.cm; // Equivalent to 1 meter
    final ninetyNineCm = 99.cm; // Less than 1 meter
    final oneHundredOneCm = 101.cm; // More than 1 meter
    final oneFoot = 1.ft; // Different unit, different magnitude

    group('Strict Equality (operator ==)', () {
      test('should return true for identical value and unit', () {
        expect(oneMeter == oneMeterAgain, isTrue);
      });

      test('should return false for different values, even with same unit', () {
        expect(oneMeter == twoMeters, isFalse);
      });

      test('should return false for different units, even with same magnitude', () {
        // This is the core distinction: == checks for strict, not magnitude, equality.
        expect(oneMeter == hundredCm, isFalse);
      });

      test('should return false for different units and different magnitudes', () {
        expect(oneMeter == oneFoot, isFalse);
      });

      test('should have consistent hashCode with strict equality', () {
        expect(oneMeter.hashCode, equals(oneMeterAgain.hashCode));
        expect(oneMeter.hashCode, isNot(equals(twoMeters.hashCode)));
        expect(oneMeter.hashCode, isNot(equals(hundredCm.hashCode)));
      });
    });

    group('Magnitude Equality (isEquivalentTo)', () {
      test('should return true for different units with the same magnitude', () {
        expect(oneMeter.isEquivalentTo(hundredCm), isTrue);
      });

      test('should return true for identical value and unit', () {
        expect(oneMeter.isEquivalentTo(oneMeterAgain), isTrue);
      });

      test('should return false for different magnitudes', () {
        expect(oneMeter.isEquivalentTo(ninetyNineCm), isFalse);
        expect(oneMeter.isEquivalentTo(twoMeters), isFalse);
      });

      test('floating point inaccuracy showcase', () {
        // As documented, direct float arithmetic can lead to non-equivalence.
        final l1 = 0.1.m;
        final l2 = 0.2.m;
        final sum = l1 + l2; // Internally, this is 0.1 + 0.2
        final l3 = 0.3.m;

        // 0.1 + 0.2 is famously not exactly 0.3 in binary floating point.
        expect(sum.value, isNot(equals(0.3)));
        expect(sum.isEquivalentTo(l3), isFalse);
      });
    });

    group('Relational Operators (>, <, >=, <=)', () {
      // --- Operator > (Greater Than) ---
      test('operator > should be true when left operand is larger', () {
        expect(twoMeters > oneMeter, isTrue);
        expect(oneMeter > ninetyNineCm, isTrue);
        expect(1.mi > 1.km, isTrue); // 1 mile > 1 kilometer
      });

      test('operator > should be false when left operand is smaller', () {
        expect(oneMeter > twoMeters, isFalse);
        expect(ninetyNineCm > oneMeter, isFalse);
      });

      test('operator > should be false for equivalent magnitudes', () {
        expect(oneMeter > hundredCm, isFalse);
      });

      // --- Operator < (Less Than) ---
      test('operator < should be true when left operand is smaller', () {
        expect(oneMeter < twoMeters, isTrue);
        expect(ninetyNineCm < oneMeter, isTrue);
        expect(1.km < 1.mi, isTrue);
      });

      test('operator < should be false when left operand is larger', () {
        expect(twoMeters < oneMeter, isFalse);
        expect(oneMeter < ninetyNineCm, isFalse);
      });

      test('operator < should be false for equivalent magnitudes', () {
        expect(oneMeter < hundredCm, isFalse);
      });

      // --- Operator >= (Greater Than or Equal) ---
      test('operator >= should be true for equivalent magnitudes', () {
        expect(oneMeter >= hundredCm, isTrue);
        expect(hundredCm >= oneMeter, isTrue);
      });

      test('operator >= should be true when left operand is larger', () {
        expect(twoMeters >= oneMeter, isTrue);
        expect(oneMeter >= ninetyNineCm, isTrue);
      });

      test('operator >= should be false when left operand is smaller', () {
        expect(oneMeter >= twoMeters, isFalse);
        expect(ninetyNineCm >= oneMeter, isFalse);
      });

      // --- Operator <= (Less Than or Equal) ---
      test('operator <= should be true for equivalent magnitudes', () {
        expect(oneMeter <= hundredCm, isTrue);
        expect(hundredCm <= oneMeter, isTrue);
      });

      test('operator <= should be true when left operand is smaller', () {
        expect(oneMeter <= twoMeters, isTrue);
        expect(ninetyNineCm <= oneMeter, isTrue);
      });

      test('operator <= should be false when left operand is larger', () {
        expect(twoMeters <= oneMeter, isFalse);
        expect(oneMeter <= ninetyNineCm, isFalse);
      });
    });

    group('Consistency between compareTo, isEquivalentTo, and operators', () {
      test('isEquivalentTo(b) should be consistent with a.compareTo(b) == 0', () {
        expect(oneMeter.isEquivalentTo(hundredCm), equals(oneMeter.compareTo(hundredCm) == 0));
        expect(
          oneMeter.isEquivalentTo(ninetyNineCm),
          equals(oneMeter.compareTo(ninetyNineCm) == 0),
        );
      });

      test('a > b should be consistent with a.compareTo(b) > 0', () {
        expect(oneMeter > ninetyNineCm, equals(oneMeter.compareTo(ninetyNineCm) > 0));
        expect(ninetyNineCm > oneMeter, equals(ninetyNineCm.compareTo(oneMeter) > 0));
      });

      test('a < b should be consistent with a.compareTo(b) < 0', () {
        expect(oneMeter < oneHundredOneCm, equals(oneMeter.compareTo(oneHundredOneCm) < 0));
        expect(oneHundredOneCm < oneMeter, equals(oneHundredOneCm.compareTo(oneMeter) < 0));
      });

      test('a >= b should be consistent with a.compareTo(b) >= 0', () {
        expect(oneMeter >= hundredCm, equals(oneMeter.compareTo(hundredCm) >= 0));
        expect(oneMeter >= ninetyNineCm, equals(oneMeter.compareTo(ninetyNineCm) >= 0));
        expect(ninetyNineCm >= oneMeter, equals(ninetyNineCm.compareTo(oneMeter) >= 0));
      });

      test('a <= b should be consistent with a.compareTo(b) <= 0', () {
        expect(oneMeter <= hundredCm, equals(oneMeter.compareTo(hundredCm) <= 0));
        expect(oneMeter <= oneHundredOneCm, equals(oneMeter.compareTo(oneHundredOneCm) <= 0));
        expect(oneHundredOneCm <= oneMeter, equals(oneHundredOneCm.compareTo(oneMeter) <= 0));
      });
    });

    group('toString() with Locale and NumberFormat', () {
      test('should use explicit NumberFormat when provided', () {
        final customFormat = NumberFormat('#,##0.00', 'en_US');
        const length = Length(1234.5, LengthUnit.meter);
        final result = length.toString(numberFormat: customFormat);
        expect(result, contains('1,234.50'));
        expect(result, contains('m'));
      });

      test('should format with locale and fixed fractionDigits (German)', () {
        const length = Length(1234.567, LengthUnit.meter);
        final result = length.toString(locale: 'de_DE', fractionDigits: 2);
        // German locale uses comma for decimal separator and dot for thousands
        expect(result, contains(',57')); // Should have ,57 or ,56 (rounded)
        expect(result, contains('m'));
      });

      test('should format with locale and fixed fractionDigits (US)', () {
        const length = Length(1234.567, LengthUnit.meter);
        final result = length.toString(locale: 'en_US', fractionDigits: 2);
        // US locale uses dot for decimal separator and comma for thousands
        expect(result, contains('.57')); // Should have .57 or .56 (rounded)
        expect(result, contains('1,234'));
        expect(result, contains('m'));
      });

      test('should format with locale-aware default pattern (US)', () {
        const length = Length(1234.5, LengthUnit.meter);
        final result = length.toString(locale: 'en_US');
        expect(result, contains('1,234'));
        expect(result, contains('m'));
      });

      test('should format with locale-aware default pattern (German)', () {
        const length = Length(1234.5, LengthUnit.meter);
        final result = length.toString(locale: 'de_DE');
        // German uses dot for thousands separator
        expect(result, contains('234'));
        expect(result, contains('m'));
      });

      test('should convert units and apply locale formatting', () {
        const length = Length(1.5, LengthUnit.kilometer);
        final result = length.toString(
          targetUnit: LengthUnit.meter,
          locale: 'en_US',
          fractionDigits: 1,
        );
        expect(result, contains('1,500.0'));
        expect(result, contains('m'));
      });

      test('numberFormat should take precedence over locale and fractionDigits', () {
        final customFormat = NumberFormat.decimalPattern('fr_FR');
        const length = Length(1234.567, LengthUnit.meter);
        final result = length.toString(
          numberFormat: customFormat,
          locale: 'en_US', // This should be ignored
          fractionDigits: 5, // This should be ignored
        );
        // French format should be applied, not US format
        expect(result, contains('234'));
        expect(result, contains('m'));
      });

      test('should handle fractionDigits without locale', () {
        const length = Length(1234.5678, LengthUnit.meter);
        final result = length.toString(fractionDigits: 2);
        expect(result, contains('1234.57')); // No thousands separator, dot decimal
        expect(result, contains('m'));
      });
    });

    group('Comprehensive Extension Coverage - All Units', () {
      test('SI large unit extensions (Mm, Gm)', () {
        final megaM = 5.megaM;
        expect(megaM.value, 5.0);
        expect(megaM.unit, LengthUnit.megameter);
        expect(megaM.inKm, closeTo(5000.0, tolerance));
        expect(megaM.asKm.unit, LengthUnit.kilometer);

        final gigaM = 2.gigaM;
        expect(gigaM.value, 2.0);
        expect(gigaM.unit, LengthUnit.gigameter);
        expect(gigaM.inMegaM, closeTo(2000.0, tolerance));
        expect(gigaM.asMegaM.unit, LengthUnit.megameter);
      });

      test('SI intermediate unit extensions (hm, dam, dm)', () {
        final hectoM = 10.hm;
        expect(hectoM.inM, closeTo(1000.0, tolerance));
        expect(hectoM.asM.unit, LengthUnit.meter);

        final decaM = 5.dam;
        expect(decaM.inM, closeTo(50.0, tolerance));
        expect(decaM.asM.unit, LengthUnit.meter);

        final deciM = 100.dm;
        expect(deciM.inM, closeTo(10.0, tolerance));
        expect(deciM.asM.unit, LengthUnit.meter);
      });

      test('Very small SI unit extensions (μm, nm, pm, fm)', () {
        final microM = 1000.um;
        expect(microM.inMm, closeTo(1.0, tolerance));
        expect(microM.asMm.unit, LengthUnit.millimeter);

        final nanoM = 1000.nm;
        expect(nanoM.inUm, closeTo(1.0, tolerance));
        expect(nanoM.asUm.unit, LengthUnit.micrometer);

        final picoM = 1000.pm;
        expect(picoM.inNm, closeTo(1.0, tolerance));
        expect(picoM.asNm.unit, LengthUnit.nanometer);

        final femtoM = 1000.fm;
        expect(femtoM.inPm, closeTo(1.0, tolerance));
        expect(femtoM.asPm.unit, LengthUnit.picometer);
      });

      test('Imperial/US unit extensions (yd, nmi)', () {
        final yards = 100.yd;
        expect(yards.inFt, closeTo(300.0, tolerance));
        expect(yards.asFt.unit, LengthUnit.foot);

        final nauticalMiles = 10.nmi;
        expect(nauticalMiles.inKm, closeTo(18.52, highTolerance));
        expect(nauticalMiles.asKm.unit, LengthUnit.kilometer);
      });

      test('Astronomical unit extensions (AU, ly, pc)', () {
        final au = 2.AU;
        expect(au.inAU, closeTo(2.0, tolerance));
        expect(au.asAU.unit, LengthUnit.astronomicalUnit);

        final lightYears = 1.ly;
        expect(lightYears.inLy, closeTo(1.0, tolerance));
        expect(lightYears.asLy.unit, LengthUnit.lightYear);

        final parsecs = 1.pc;
        expect(parsecs.inPc, closeTo(1.0, tolerance));
        expect(parsecs.asPc.unit, LengthUnit.parsec);
      });

      test('Angstrom extensions', () {
        final angstroms = 10.angstrom;
        expect(angstroms.inAngstrom, closeTo(10.0, tolerance));
        expect(angstroms.asAngstrom.unit, LengthUnit.angstrom);
        expect(angstroms.inNm, closeTo(1.0, tolerance));
      });

      test('All conversion getters work correctly', () {
        final base = 1000.m;

        // Test all "as" getters return correct unit type
        expect(base.asKm.unit, LengthUnit.kilometer);
        expect(base.asMegaM.unit, LengthUnit.megameter);
        expect(base.asGigaM.unit, LengthUnit.gigameter);
        expect(base.asHm.unit, LengthUnit.hectometer);
        expect(base.asDam.unit, LengthUnit.decameter);
        expect(base.asDm.unit, LengthUnit.decimeter);
        expect(base.asCm.unit, LengthUnit.centimeter);
        expect(base.asMm.unit, LengthUnit.millimeter);
        expect(base.asUm.unit, LengthUnit.micrometer);
        expect(base.asNm.unit, LengthUnit.nanometer);
        expect(base.asPm.unit, LengthUnit.picometer);
        expect(base.asFm.unit, LengthUnit.femtometer);
        expect(base.asInch.unit, LengthUnit.inch);
        expect(base.asFt.unit, LengthUnit.foot);
        expect(base.asYd.unit, LengthUnit.yard);
        expect(base.asMi.unit, LengthUnit.mile);
        expect(base.asNmi.unit, LengthUnit.nauticalMile);
        expect(base.asAU.unit, LengthUnit.astronomicalUnit);
        expect(base.asLy.unit, LengthUnit.lightYear);
        expect(base.asPc.unit, LengthUnit.parsec);
        expect(base.asAngstrom.unit, LengthUnit.angstrom);
      });
    });
  });
}
