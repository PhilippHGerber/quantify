import 'package:quantify/area.dart';
import 'package:quantify/length.dart';
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

        final v2 = 500.mL;
        expect(v2.inLiters, closeTo(0.5, tolerance));
        expect(v2.inCubicCentimeters, closeTo(500.0, tolerance));

        final v3 = 1.gal;
        expect(v3.inQuarts, closeTo(4.0, tolerance));
        expect(v3.inPints, closeTo(8.0, tolerance));
        expect(v3.inFluidOunces, closeTo(128.0, tolerance));

        final v4 = 10.cL;
        expect(v4.inMilliliters, closeTo(100.0, tolerance));
        expect(v4.inLiters, closeTo(0.1, tolerance));

        final v5 = 1.ukGal;
        expect(v5.unit, VolumeUnit.imperialGallon);
        expect(v5.inLiters, closeTo(4.54609, tolerance));
      });
    });

    group('Conversions', () {
      test('SI and Litre equivalences', () {
        expect(1.m3.inKiloliters, closeTo(1.0, tolerance));
        expect(1.dm3.inLiters, closeTo(1.0, tolerance));
        expect(1.cm3.inMilliliters, closeTo(1.0, tolerance));
        expect(10.mL.inCentiliters, closeTo(1.0, tolerance));
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
        final oneLiter = 1.L;
        const expectedGallonsInOneLiter = 1 / expectedLitersInOneGallon;
        const expectedFlOzInOneLiter = expectedGallonsInOneLiter * 128.0;
        const expectedCubicInchesInOneLiter = cubicCmPerLiter / cubicCmPerCubicInch;

        expect(oneLiter.inGallons, closeTo(expectedGallonsInOneLiter, highTolerance));
        expect(oneLiter.inFluidOunces, closeTo(expectedFlOzInOneLiter, highTolerance));
        expect(oneLiter.inCubicInches, closeTo(expectedCubicInchesInOneLiter, highTolerance));
      });

      test('Imperial gallon conversions', () {
        final oneImperialGallon = 1.ukGal;
        expect(oneImperialGallon.inLiters, closeTo(4.54609, tolerance));
        expect(oneImperialGallon.inGallons, closeTo(1.2009499255, 1e-9));

        final oneLiter = 1.L;
        expect(oneLiter.inImperialGallons, closeTo(1 / 4.54609, 1e-12));
      });
    });

    group('Comparison', () {
      test('should correctly compare volumes of different units', () {
        // Test GREATER THAN: 1 cubic meter (1000 L) is greater than 999 liters.
        expect(1.m3.compareTo(999.L), greaterThan(0));

        // Test EQUAL: 1 US Gallon is EXACTLY 4 US Quarts.
        expect(1.gal.compareTo(4.qt), 0, reason: '1 gallon should be exactly equal to 4 quarts');

        // Test LESS THAN: 1 US Gallon is less than 5 US Quarts.
        expect(1.gal.compareTo(5.qt), lessThan(0));

        // Test GREATER THAN: 1 Imperial gallon is larger than 1 US gallon.
        expect(1.ukGal.compareTo(1.gal), greaterThan(0));

        // Test EQUAL: 1 Liter is EXACTLY 1000 Cubic Centimeters.
        expect(1.L.compareTo(1000.cm3), 0);

        // Test EQUAL: 1 Centiliter is EXACTLY 10 Milliliters.
        expect(1.cL.compareTo(10.mL), 0);
      });
    });

    group('Arithmetic', () {
      test('should correctly perform arithmetic operations', () {
        final v1 = 1.gal;
        final v2 = 1.L;
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
        expect(250.mL.toString(), '250.0\u00A0mL');
        expect(1.gal.toString(), '1.0\u00A0gal');
        expect(1.ukGal.toString(), '1.0\u00A0gal(UK)');
        expect(8.flOz.toString(), '8.0\u00A0fl-oz');
        expect(5.cL.toString(), '5.0\u00A0cl');
        expect(1.tsp.toString(), '1.0\u00A0tsp');
      });
    });

    group('Comprehensive Extension Coverage', () {
      test('all creation extension aliases', () {
        expect(1.kl.unit, VolumeUnit.kiloliter);
        expect(1.liters.unit, VolumeUnit.litre);
        expect(5.milliliters.unit, VolumeUnit.milliliter);
        expect(2.centiliters.unit, VolumeUnit.centiliter);
        expect(1.dam3.unit, VolumeUnit.cubicDecameter);
        expect(1.megaliters.unit, VolumeUnit.megaliter);
        expect(1.hm3.unit, VolumeUnit.cubicHectometer);
        expect(1.gigaliters.unit, VolumeUnit.gigaliter);
        expect(1.km3.unit, VolumeUnit.cubicKilometer);
        expect(1.teraliters.unit, VolumeUnit.teraliter);
        expect(1.mi3.unit, VolumeUnit.cubicMile);
        expect(2.gallons.unit, VolumeUnit.gallon);
        expect(2.ukGal.unit, VolumeUnit.imperialGallon);
        expect(2.imperialGallons.unit, VolumeUnit.imperialGallon);
        expect(4.quarts.unit, VolumeUnit.quart);
        expect(2.pt.unit, VolumeUnit.pint);
        expect(2.tablespoons.unit, VolumeUnit.tablespoon);
        expect(6.teaspoons.unit, VolumeUnit.teaspoon);
      });

      test('all remaining as* conversion getters', () {
        final v = 1.m3;

        expect(v.asCubicDecameters.unit, VolumeUnit.cubicDecameter);
        expect(v.asCubicHectometers.unit, VolumeUnit.cubicHectometer);
        expect(v.asCubicKilometers.unit, VolumeUnit.cubicKilometer);
        expect(v.asCubicDecimeters.unit, VolumeUnit.cubicDecimeter);
        expect(v.asCubicCentimeters.unit, VolumeUnit.cubicCentimeter);
        expect(v.asCubicMillimeters.unit, VolumeUnit.cubicMillimeter);
        expect(v.asKiloliters.unit, VolumeUnit.kiloliter);
        expect(v.asMegaliters.unit, VolumeUnit.megaliter);
        expect(v.asGigaliters.unit, VolumeUnit.gigaliter);
        expect(v.asTeraliters.unit, VolumeUnit.teraliter);
        expect(v.asCentiliters.unit, VolumeUnit.centiliter);
        expect(v.asMicroliters.unit, VolumeUnit.microliter);
        expect(v.asCubicMiles.unit, VolumeUnit.cubicMile);
        expect(v.asImperialGallons.unit, VolumeUnit.imperialGallon);
        expect(v.asTablespoons.unit, VolumeUnit.tablespoon);
        expect(v.asTeaspoons.unit, VolumeUnit.teaspoon);

        // Spot-check a value
        expect(v.asLiters.value, closeTo(1000.0, tolerance));
        expect(v.asCubicCentimeters.value, closeTo(1e6, tolerance));
      });
    });

    group('US Customary Volume Extensions', () {
      test('should create and convert cubic feet', () {
        // 1 cubic foot = 28316.8466 cm³ = 28.3168466 liters
        final vol = 2.ft3;
        expect(vol.value, 2.0);
        expect(vol.unit, VolumeUnit.cubicFoot);
        expect(vol.inLiters, closeTo(56.6336932, highTolerance));
        expect(vol.inCubicMeters, closeTo(0.0566336932, highTolerance));

        final volAsLiters = vol.asLiters;
        expect(volAsLiters.value, closeTo(56.6336932, highTolerance));
        expect(volAsLiters.unit, VolumeUnit.litre);
      });

      test('should create and convert cubic inches', () {
        // 1 cubic inch = 16.387064 cm³
        final vol = 100.in3;
        expect(vol.value, 100.0);
        expect(vol.unit, VolumeUnit.cubicInch);
        expect(vol.inCubicCentimeters, closeTo(1638.7064, tolerance));
        expect(vol.inMilliliters, closeTo(1638.7064, tolerance)); // 1 cm³ = 1 mL

        final volAsMl = vol.asMilliliters;
        expect(volAsMl.value, closeTo(1638.7064, tolerance));
        expect(volAsMl.unit, VolumeUnit.milliliter);
      });

      test('should create and convert fluid ounces', () {
        // 1 US fluid ounce = 29.5735296 mL
        final vol = 8.flOz; // Half a cup
        expect(vol.value, 8.0);
        expect(vol.unit, VolumeUnit.fluidOunce);
        expect(vol.inMilliliters, closeTo(236.588237, highTolerance));
        expect(vol.inGallons, closeTo(0.0625, tolerance)); // 8 fl oz = 1/16 gallon

        final volAsGal = vol.asGallons;
        expect(volAsGal.value, closeTo(0.0625, tolerance));
        expect(volAsGal.unit, VolumeUnit.gallon);
      });

      test('should create and convert pints', () {
        // 1 US pint = 473.176473 mL = 16 fl oz
        final vol = 2.pints;
        expect(vol.value, 2.0);
        expect(vol.unit, VolumeUnit.pint);
        expect(vol.inMilliliters, closeTo(946.352946, tolerance));
        expect(vol.inFluidOunces, closeTo(32.0, tolerance)); // 2 pints = 32 fl oz
        expect(vol.inQuarts, closeTo(1.0, tolerance)); // 2 pints = 1 quart

        final volAsQt = vol.asQuarts;
        expect(volAsQt.value, closeTo(1.0, tolerance));
        expect(volAsQt.unit, VolumeUnit.quart);
      });

      test('practical cooking volume conversions', () {
        // 1 tablespoon = 3 teaspoons
        final vol = 2.tablespoons;
        expect(vol.inTeaspoons, closeTo(6.0, tolerance));
        expect(vol.inFluidOunces, closeTo(1.0, tolerance)); // 2 tbsp = 1 fl oz

        // Recipe conversion: 1 cup = 16 tablespoons = 48 teaspoons
        final cup = 16.tablespoons;
        expect(cup.inFluidOunces, closeTo(8.0, tolerance)); // 1 cup = 8 fl oz
        expect(cup.inTeaspoons, closeTo(48.0, tolerance));
      });

      test('round trip conversions for US customary units', () {
        const testValue = 5.5;

        final ftOrig = testValue.ft3;
        final ftRoundTrip = ftOrig.asCubicMeters.asCubicFeet;
        expect(ftRoundTrip.value, closeTo(testValue, highTolerance));

        final inOrig = testValue.in3;
        final inRoundTrip = inOrig.asCubicCentimeters.asCubicInches;
        expect(inRoundTrip.value, closeTo(testValue, tolerance));

        final flOzOrig = testValue.flOz;
        final flOzRoundTrip = flOzOrig.asMilliliters.asFluidOunces;
        expect(flOzRoundTrip.value, closeTo(testValue, tolerance));

        final pintOrig = testValue.pints;
        final pintRoundTrip = pintOrig.asQuarts.asPints;
        expect(pintRoundTrip.value, closeTo(testValue, tolerance));
      });
    });
  });

  group('Dimensional Analysis', () {
    group('Volume.from (l × w × h)', () {
      test('integer dimensions', () {
        expect(Volume.from(2.m, 3.m, 4.m).inCubicMeters, closeTo(24.0, tolerance));
      });

      test('meter inputs → cubicMeter', () {
        expect(Volume.from(1.m, 1.m, 1.m).unit, VolumeUnit.cubicMeter);
      });

      // --- Unit-preserving behaviour ---
      test('foot inputs → cubicFoot', () {
        expect(Volume.from(2.ft, 3.ft, 4.ft).unit, VolumeUnit.cubicFoot);
        expect(Volume.from(2.ft, 3.ft, 4.ft).value, closeTo(24.0, tolerance));
      });

      test('km × m × m → cubicKilometer (mixed-unit, primary wins)', () {
        final vol = Volume.from(1.km, 1.m, 1.m);
        expect(vol.unit, VolumeUnit.cubicKilometer);
        expect(vol.inCubicMeters, closeTo(1000.0, tolerance));
      });

      test('nautical miles → SI fallback', () {
        expect(
          Volume.from(1.nauticalMiles, 1.nauticalMiles, 1.nauticalMiles).unit,
          VolumeUnit.cubicMeter,
        );
      });

      test('physical correctness round-trip: 2 ft × 3 ft × 4 ft ≈ 0.679604 m³', () {
        expect(Volume.from(2.ft, 3.ft, 4.ft).inCubicMeters, closeTo(0.679604, 1e-5));
      });

      test('mixed units: 1 km × 1 m × 1 m = 1000 m³', () {
        expect(Volume.from(1.km, 1.m, 1.m).inCubicMeters, closeTo(1000.0, tolerance));
      });

      test('pool example: 25 m × 10 m × 2 m = 500 m³', () {
        expect(Volume.from(25.m, 10.m, 2.m).inCubicMeters, closeTo(500.0, tolerance));
      });
    });

    group('Volume.fromArea (area × depth)', () {
      test('floor 5 m × 4 m extruded 2.5 m = 50 m³', () {
        final floor = Area.from(5.m, 4.m);
        expect(Volume.fromArea(floor, 2.5.m).inCubicMeters, closeTo(50.0, tolerance));
      });

      test('squareMeter area → cubicMeter', () {
        expect(Volume.fromArea(Area.from(1.m, 1.m), 1.m).unit, VolumeUnit.cubicMeter);
      });

      // --- Unit-preserving behaviour ---
      test('squareFoot area → cubicFoot', () {
        final area = Area.from(5.ft, 4.ft);
        final vol = Volume.fromArea(area, 3.ft);
        expect(vol.unit, VolumeUnit.cubicFoot);
        expect(vol.value, closeTo(60.0, tolerance));
      });

      test('squareInch area, mixed depth → cubicInch', () {
        final area = Area.from(12.inch, 12.inch); // 144 in²
        final vol = Volume.fromArea(area, 3.inch);
        expect(vol.unit, VolumeUnit.cubicInch);
        expect(vol.value, closeTo(432.0, tolerance));
      });

      test('hectare area → SI fallback cubicMeter', () {
        expect(Volume.fromArea(1.ha, 1.m).unit, VolumeUnit.cubicMeter);
      });

      test('physical correctness: 5 ft × 4 ft × 3 ft ≈ 1.699 m³', () {
        expect(Volume.fromArea(Area.from(5.ft, 4.ft), 3.ft).inCubicMeters, closeTo(1.699011, 1e-5));
      });

      test('consistent with Volume.from', () {
        final via3 = Volume.from(3.m, 4.m, 5.m);
        final viaArea = Volume.fromArea(Area.from(3.m, 4.m), 5.m);
        expect(via3.isEquivalentTo(viaArea), isTrue);
      });

      test('mixed units: area in cm², depth in m', () {
        // 10000 cm² = 1 m²; × 2 m = 2 m³
        expect(
          Volume.fromArea(const Area(10000, AreaUnit.squareCentimeter), 2.m).inCubicMeters,
          closeTo(2.0, highTolerance),
        );
      });
    });
  });

  group('Volume — Uncovered extension getters', () {
    // Value getters for cubic SI units not hit by main tests
    test('inCubicDecameters inCubicHectometers inCubicKilometers inCubicDecimeters', () {
      expect(1.dam3.inCubicDecameters, closeTo(1.0, tolerance));
      expect(1.hm3.inCubicHectometers, closeTo(1.0, tolerance));
      expect(1.km3.inCubicKilometers, closeTo(1.0, tolerance));
      expect(1.dm3.inCubicDecimeters, closeTo(1.0, tolerance));
    });

    test('inCubicFeet inCubicMiles', () {
      expect(1.ft3.inCubicFeet, closeTo(1.0, tolerance));
      expect(1.mi3.inCubicMiles, closeTo(1.0, tolerance));
    });

    // Creation aliases not hit
    test('cubicMeters uL Ml Gl Tl creation aliases', () {
      expect(2.0.cubicMeters.unit, VolumeUnit.cubicMeter);
      expect(5.0.uL.unit, VolumeUnit.microliter);
      expect(3.0.Ml.unit, VolumeUnit.megaliter);
      expect(3.0.megaliters.unit, VolumeUnit.megaliter);
      expect(2.0.Gl.unit, VolumeUnit.gigaliter);
      expect(2.0.gigaliters.unit, VolumeUnit.gigaliter);
      expect(1.0.Tl.unit, VolumeUnit.teraliter);
      expect(1.0.teraliters.unit, VolumeUnit.teraliter);
    });

    test('cubicInches cubicFeet imperial word aliases', () {
      expect(1.0.cubicInches.unit, VolumeUnit.cubicInch);
      expect(1.0.cubicFeet.unit, VolumeUnit.cubicFoot);
    });

    test('gallon quart pint fluidOunce singular aliases', () {
      expect(1.0.gallon.unit, VolumeUnit.gallon);
      expect(1.0.imperialGallon.unit, VolumeUnit.imperialGallon);
      expect(1.0.quart.unit, VolumeUnit.quart);
      expect(1.0.pint.unit, VolumeUnit.pint);
      expect(1.0.fluidOunce.unit, VolumeUnit.fluidOunce);
    });

    test('tbsp tablespoons aliases', () {
      expect(1.0.tbsp.unit, VolumeUnit.tablespoon);
      expect(1.0.tablespoons.unit, VolumeUnit.tablespoon);
    });
  });
}
