import 'package:quantify/volume.dart';
import 'package:test/test.dart';

void main() {
  const tolerance = 1e-9;
  const highTolerance = 1e-6;

  group('Volume', () {
    // Helper for round trip tests
    void testRoundTrip(
      VolumeUnit initialUnit,
      VolumeUnit intermediateUnit,
      double initialValue, {
      double tol = tolerance,
    }) {
      final v1 = Volume(initialValue, initialUnit);
      final v2 = v1.convertTo(intermediateUnit);
      final v3 = v2.convertTo(initialUnit);
      expect(
        v3.value,
        closeTo(initialValue, tol),
        reason:
            '${initialUnit.symbol} -> ${intermediateUnit.symbol} -> ${initialUnit.symbol} failed for $initialValue',
      );
    }

    group('Constructors and Getters', () {
      test('should create Volume from num extensions and retrieve values', () {
        final v1 = 1.5.m3;
        expect(v1.value, 1.5);
        expect(v1.unit, VolumeUnit.cubicMeter);
        expect(v1.inLiters, closeTo(1500.0, tolerance));

        final v2 = 500.ml;
        expect(v2.inLiters, closeTo(0.5, tolerance));
        expect(v2.inCubicCentimeters, closeTo(500.0, tolerance));

        final v3 = 1.gal;
        expect(v3.inQuarts, closeTo(4.0, tolerance));
        expect(v3.inPints, closeTo(8.0, tolerance));
        expect(v3.inFluidOunces, closeTo(128.0, tolerance));
      });
    });

    group('Conversions', () {
      test('SI and Litre equivalences', () {
        expect(1.m3.inKiloliters, closeTo(1.0, tolerance));
        expect(1.dm3.inLiters, closeTo(1.0, tolerance));
        expect(1.cm3.inMilliliters, closeTo(1.0, tolerance));
        expect(1.mm3.inMicroliters, closeTo(1.0, tolerance));
        expect(1.dam3.inMegaliters, closeTo(1.0, tolerance));
        expect(1.hm3.inGigaliters, closeTo(1.0, tolerance));
        expect(1.km3.inTeraliters, closeTo(1.0, tolerance));
      });

      test('US customary hierarchy', () {
        final oneGallon = 1.gal;
        expect(oneGallon.inQuarts, closeTo(4.0, tolerance));
        expect(oneGallon.inPints, closeTo(8.0, tolerance));
        expect(oneGallon.inFluidOunces, closeTo(128.0, tolerance));
        expect(oneGallon.inTablespoons, closeTo(256.0, tolerance));
        expect(oneGallon.inTeaspoons, closeTo(768.0, tolerance));
      });

      test('Cubic imperial/US hierarchy', () {
        final oneCubicFoot = 1.ft3;
        expect(oneCubicFoot.inCubicInches, closeTo(1728.0, tolerance));
      });

      test('Cross-system conversions', () {
        // Calculate expected values from fundamental definitions (1 gal = 231 in³, 1 in = 2.54 cm)
        const cubicInchesPerGallon = 231.0;
        const cmPerInch = 2.54;
        const cubicCmPerCubicInch = cmPerInch * cmPerInch * cmPerInch;
        const cubicCmPerLiter = 1000.0;

        const expectedLitersInOneGallon =
            (cubicInchesPerGallon * cubicCmPerCubicInch) / cubicCmPerLiter;

        // --- Test Gallon to Liter ---
        final oneGallon = 1.gal;
        expect(oneGallon.inLiters, closeTo(expectedLitersInOneGallon, highTolerance));

        // --- Test Liter to other units ---
        final oneLiter = 1.l;
        const expectedGallonsInOneLiter = 1 / expectedLitersInOneGallon;
        const expectedFlOzInOneLiter = expectedGallonsInOneLiter * 128.0;
        const expectedCubicInchesInOneLiter = cubicCmPerLiter / cubicCmPerCubicInch;

        expect(oneLiter.inGallons, closeTo(expectedGallonsInOneLiter, highTolerance));
        expect(oneLiter.inFluidOunces, closeTo(expectedFlOzInOneLiter, highTolerance));
        expect(oneLiter.inCubicInches, closeTo(expectedCubicInchesInOneLiter, highTolerance));
      });
    });

    group('Comparison', () {
      test('should correctly compare volumes of different units', () {
        // Test GREATER THAN: 1 cubic meter (1000 L) is greater than 999 liters.
        expect(1.m3.compareTo(999.l), greaterThan(0));

        // Test EQUAL: 1 US Gallon is EXACTLY 4 US Quarts.
        expect(1.gal.compareTo(4.qt), 0, reason: '1 gallon should be exactly equal to 4 quarts');

        // Test LESS THAN: 1 US Gallon is less than 5 US Quarts.
        expect(1.gal.compareTo(5.qt), lessThan(0));

        // Test EQUAL: 1 Liter is EXACTLY 1000 Cubic Centimeters.
        expect(1.l.compareTo(1000.cm3), 0);
      });
    });

    group('Arithmetic', () {
      test('should correctly perform arithmetic operations', () {
        final v1 = 1.gal;
        final v2 = 1.l;
        final sum = v1 + v2;
        final difference = v1 - v2;

        expect(sum.inGallons, closeTo(1.0 + 0.264172, highTolerance));
        expect(difference.inGallons, closeTo(1.0 - 0.264172, highTolerance));
        expect((v1 * 2.0).inGallons, closeTo(2.0, tolerance));
        expect((v1 / 2.0).inGallons, closeTo(0.5, tolerance));
      });
    });

    group('Round Trip Conversions', () {
      for (final unit in VolumeUnit.values) {
        test('Round trip ${unit.symbol} <-> m³', () {
          testRoundTrip(
            unit,
            VolumeUnit.cubicMeter,
            123.456,
            tol: highTolerance,
          );
        });
      }
    });

    group('toString()', () {
      test('should return formatted string for various units', () {
        expect(1.5.m3.toString(), '1.5\u00A0m³');
        expect(250.ml.toString(), '250.0\u00A0mL');
        expect(1.gal.toString(), '1.0\u00A0gal');
        expect(8.flOz.toString(), '8.0\u00A0fl-oz');
        expect(1.tsp.toString(), '1.0\u00A0tsp');
      });
    });
  });
}
