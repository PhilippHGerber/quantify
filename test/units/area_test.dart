import 'package:quantify/quantify.dart';
import 'package:test/test.dart';

void main() {
  const tolerance = 1e-9; // Tolerance for double comparisons
  const highTolerance = 1e-6; // For conversions involving many decimal places

  group('Area', () {
    // Helper for round trip tests
    void testRoundTrip(
      AreaUnit initialUnit,
      AreaUnit intermediateUnit,
      double initialValue, {
      double tolerance = 1e-9,
    }) {
      final a1 = Area(initialValue, initialUnit);
      final a2 = a1.convertTo(intermediateUnit);
      final a3 = a2.convertTo(initialUnit);
      expect(
        a3.value,
        closeTo(initialValue, tolerance),
        reason:
            '${initialUnit.symbol} -> ${intermediateUnit.symbol} -> ${initialUnit.symbol} failed for $initialValue',
      );
    }

    group('Constructors and Getters', () {
      test('should create Area from num extensions and retrieve values', () {
        final a1 = 100.0.m2;
        expect(a1.value, 100.0);
        expect(a1.unit, AreaUnit.squareMeter);
        expect(a1.inSquareKilometers, closeTo(0.0001, tolerance));

        final a2 = 5.0.ft2;
        expect(a2.value, 5.0);
        expect(a2.unit, AreaUnit.squareFoot);
        expect(a2.inSquareInches, closeTo(720.0, tolerance)); // 5 * 144

        final a3 = 1.ha;
        expect(a3.value, 1.0);
        expect(a3.unit, AreaUnit.hectare);
        expect(a3.inSquareMeters, closeTo(10000.0, tolerance));

        final a4 = 1.0.squareMegameter;
        expect(a4.value, 1.0);
        expect(a4.unit, AreaUnit.squareMegameter);
        expect(a4.inSquareKilometers, closeTo(1000000.0, tolerance));
      });

      test('getValue should return correct value for same unit', () {
        const a = Area(25, AreaUnit.squareCentimeter);
        expect(a.getValue(AreaUnit.squareCentimeter), 25.0);
      });

      test('getValue for all units from Square Meter base', () {
        final a = 10000.0.m2; // 1 hectare
        expect(a.inSquareMeters, 10000.0);
        expect(a.inHectares, closeTo(1.0, tolerance));
        expect(a.inSquareCentimeters, closeTo(10000 * 10000, tolerance));
        expect(a.inSquareMillimeters, closeTo(10000 * 1000000, tolerance));
        expect(a.inSquareInches, closeTo(10000 / 0.00064516, highTolerance));
        expect(a.inSquareFeet, closeTo(10000 / 0.09290304, highTolerance));
        expect(a.inAcres, closeTo(10000 / 4046.8564224, highTolerance));
        expect(a.inSquareMegameters, closeTo(10000 / 1e12, highTolerance));
      });
    });

    group('Conversions', () {
      final oneSquareMeter = 1.0.m2;

      test('1 square meter to various units', () {
        expect(oneSquareMeter.inSquareKilometers, closeTo(1e-6, tolerance));
        expect(oneSquareMeter.inSquareCentimeters, closeTo(10000.0, tolerance));
        expect(oneSquareMeter.inSquareMillimeters, closeTo(1000000.0, tolerance));
        expect(oneSquareMeter.inSquareInches, closeTo(1 / 0.00064516, highTolerance));
        expect(oneSquareMeter.inSquareFeet, closeTo(1 / 0.09290304, highTolerance));
        expect(oneSquareMeter.inAcres, closeTo(1 / 4046.8564224, highTolerance));
        expect(oneSquareMeter.inSquareMegameters, closeTo(1 / 1e12, highTolerance));
      });

      final oneAcre = 1.0.ac;
      test('1 acre to various units', () {
        expect(oneAcre.inSquareMeters, closeTo(4046.8564224, tolerance));
        expect(oneAcre.inHectares, closeTo(0.40468564224, tolerance));
        expect(oneAcre.inSquareFeet, closeTo(43560.0, tolerance));
        expect(oneAcre.inSquareMiles, closeTo(1 / 640.0, tolerance));
      });

      final oneSquareMile = 1.0.mi2;
      test('1 square mile to various units', () {
        expect(oneSquareMile.inSquareMeters, closeTo(2589988.110336, tolerance));
        expect(oneSquareMile.inAcres, closeTo(640.0, tolerance));
        expect(oneSquareMile.inSquareKilometers, closeTo(2.589988110336, tolerance));
      });

      test('1 square megameter to various units', () {
        final oneSquareMegameter = 1.0.squareMegameter;
        expect(oneSquareMegameter.inSquareMeters, closeTo(1e12, tolerance));
        expect(oneSquareMegameter.inSquareKilometers, closeTo(1e6, tolerance));
      });

      final oneSquareYard = 1.0.yd2;
      test('1 square yard to various units', () {
        expect(oneSquareYard.inSquareMeters, closeTo(0.83612736, tolerance));
        expect(oneSquareYard.inSquareFeet, closeTo(9.0, tolerance));
        expect(oneSquareYard.inSquareInches, closeTo(1296.0, tolerance));
      });
    });

    group('convertTo method', () {
      test('should return new Area object with converted value and unit', () {
        final aMeters = 10.0.m2;
        final aFeet = aMeters.convertTo(AreaUnit.squareFoot);
        expect(aFeet.unit, AreaUnit.squareFoot);
        expect(aFeet.value, closeTo(aMeters.inSquareFeet, tolerance));
        expect(aMeters.unit, AreaUnit.squareMeter); // Original should be unchanged
      });

      test('convertTo same unit should return same instance (or equal if optimized)', () {
        final a1 = 10.0.m2;
        final a2 = a1.convertTo(AreaUnit.squareMeter);
        expect(identical(a1, a2), isTrue);
      });
    });

    group('Comparison (compareTo)', () {
      final aMeter = 1.0.m2;
      final aSlightlyLessCm = 9999.0.cm2; // 0.9999 m2
      final aSlightlyMoreCm = 10001.0.cm2; // 1.0001 m2
      final aFoot = 10.0.ft2; // ~0.929 m2

      test('should correctly compare areas of different units', () {
        expect(aMeter.compareTo(aSlightlyLessCm), greaterThan(0));
        expect(aSlightlyLessCm.compareTo(aMeter), lessThan(0));
        expect(aMeter.compareTo(aSlightlyMoreCm), lessThan(0));
        expect(aMeter.compareTo(aFoot), greaterThan(0)); // 1m2 > 10ft2
      });

      test('should return 0 for equal areas in different units', () {
        final aCm = 10000.0.cm2; // 1 m2
        final aInches = (1.0 / 0.00064516).in2; // 1 m2 in inches
        expect(aMeter.compareTo(aCm), 0);
        expect(aCm.compareTo(aMeter), 0);
        expect(aMeter.compareTo(aInches), 0);
      });
    });

    group('Equality and HashCode', () {
      test('should be equal for same value and unit', () {
        const a1 = Area(10, AreaUnit.squareMeter);
        const a2 = Area(10, AreaUnit.squareMeter);
        expect(a1 == a2, isTrue);
        expect(a1.hashCode == a2.hashCode, isTrue);
      });

      test('should not be equal for different values or units', () {
        const a1 = Area(10, AreaUnit.squareMeter);
        const a2 = Area(10.1, AreaUnit.squareMeter);
        const a3 = Area(10, AreaUnit.squareFoot);
        expect(a1 == a2, isFalse);
        expect(a1 == a3, isFalse);
        expect(a1.hashCode == a2.hashCode, isFalse);
        expect(a1.hashCode == a3.hashCode, isFalse);
      });
    });

    group('toString()', () {
      test('should return formatted string', () {
        expect(10.5.m2.toString(), '10.5 m²');
        expect(12.0.in2.toString(), '12.0 in²');
        expect(1.6.km2.toString(), '1.6 km²');
        expect(1.ha.toString(), '1.0 ha');
        expect(10.5.yd2.toString(), '10.5 yd²');
        expect(1.0.squareMegameter.toString(), '1.0 Mm²');
      });
    });

    group('Round Trip Conversions', () {
      const testValue = 789.123;

      for (final unit in AreaUnit.values) {
        test('Round trip ${unit.symbol} <-> m²', () {
          testRoundTrip(
            unit,
            AreaUnit.squareMeter,
            testValue,
            tolerance: (unit == AreaUnit.squareMeter) ? tolerance : highTolerance,
          );
        });
      }

      test('Round trip ac <-> km²', () {
        testRoundTrip(AreaUnit.acre, AreaUnit.squareKilometer, 500, tolerance: highTolerance);
      });
      test('Round trip cm² <-> mm²', () {
        testRoundTrip(AreaUnit.squareCentimeter, AreaUnit.squareMillimeter, 250000);
      });

      test('Round trip Mm² <-> km²', () {
        testRoundTrip(
          AreaUnit.squareMegameter,
          AreaUnit.squareKilometer,
          testValue,
          tolerance: highTolerance,
        );
      });

      test('Round trip yd² <-> ft²', () {
        testRoundTrip(AreaUnit.squareYard, AreaUnit.squareFoot, 5);
      });
    });

    group('Edge Cases', () {
      test('Conversion with zero value', () {
        final aZero = 0.0.m2;
        for (final unit in AreaUnit.values) {
          expect(aZero.getValue(unit), 0.0, reason: '0 m² to ${unit.symbol} should be 0');
        }
      });

      test('Division by zero', () {
        final a = 10.m2;
        expect(() => a / 0.0, throwsArgumentError);
      });
    });

    group('Arithmetic Operators for Area', () {
      final a1Meter = 1.0.m2;
      final a2Meters = 2.0.m2;
      final a5000Cm = 5000.cm2; // 0.5 m2

      // Operator +
      test('operator + combines areas', () {
        final sum1 = a2Meters + a1Meter;
        expect(sum1.value, closeTo(3.0, tolerance));
        expect(sum1.unit, AreaUnit.squareMeter);

        final sum2 = a1Meter + a5000Cm; // 1m2 + 0.5m2 = 1.5m2
        expect(sum2.value, closeTo(1.5, tolerance));
        expect(sum2.unit, AreaUnit.squareMeter);

        final sum3 = a5000Cm + a1Meter; // 5000cm2 + 10000cm2 = 15000cm2
        expect(sum3.value, closeTo(15000.0, tolerance));
        expect(sum3.unit, AreaUnit.squareCentimeter);
      });

      // Operator -
      test('operator - subtracts areas', () {
        final diff1 = a2Meters - a1Meter;
        expect(diff1.value, closeTo(1.0, tolerance));
        expect(diff1.unit, AreaUnit.squareMeter);

        final diff2 = a1Meter - a5000Cm; // 1m2 - 0.5m2 = 0.5m2
        expect(diff2.value, closeTo(0.5, tolerance));
        expect(diff2.unit, AreaUnit.squareMeter);

        final diff3 = a2Meters - a5000Cm.convertTo(AreaUnit.squareMeter); // 2m2 - 0.5m2 = 1.5m2
        expect(diff3.value, closeTo(1.5, tolerance));
        expect(diff3.unit, AreaUnit.squareMeter);
      });

      // Operator * (scalar)
      test('operator * scales area by a scalar', () {
        final scaled = a2Meters * 3.0;
        expect(scaled.value, closeTo(6.0, tolerance));
        expect(scaled.unit, AreaUnit.squareMeter);

        final scaledCm = a5000Cm * 2.5;
        expect(scaledCm.value, closeTo(12500.0, tolerance));
        expect(scaledCm.unit, AreaUnit.squareCentimeter);
      });

      // Operator / (scalar)
      test('operator / scales area by a scalar', () {
        final scaled = a2Meters / 2.0;
        expect(scaled.value, closeTo(1.0, tolerance));
        expect(scaled.unit, AreaUnit.squareMeter);

        expect(() => a1Meter / 0.0, throwsArgumentError);
      });

      test('operator chaining preserves immutability', () {
        final initialArea = 10.m2;
        final a1 = initialArea + 5.m2; // 15m2
        final a2 = a1 * 2.0; // 30m2
        final a3 = a2 - 10000.cm2; // 30m2 - 1m2 = 29m2

        expect(initialArea.value, 10.0); // Original unchanged
        expect(a1.value, closeTo(15.0, tolerance));
        expect(a2.value, closeTo(30.0, tolerance));
        expect(a3.value, closeTo(29.0, tolerance));
        expect(a3.unit, AreaUnit.squareMeter);
      });

      test('operator arithmetic with square yards', () {
        final carpetArea = 10.yd2; // about 8.36 m²
        final roomArea = 12.m2;

        // Addition
        final totalArea = roomArea + carpetArea; // 12 m² + ~8.36 m²
        expect(totalArea.unit, AreaUnit.squareMeter);
        expect(totalArea.inSquareMeters, closeTo(12.0 + 0.83612736 * 10, tolerance));

        // Subtraction
        final remainingArea = roomArea - carpetArea;
        expect(remainingArea.inSquareMeters, closeTo(12.0 - 0.83612736 * 10, tolerance));

        // Comparison
        expect(roomArea.compareTo(carpetArea), greaterThan(0));
      });
    });

    group('Comprehensive Extension Coverage - All Area Units', () {
      test('SI square unit extensions (dm², cm², mm², μm²)', () {
        final dm2 = 100.dm2;
        expect(dm2.inSquareMeters, closeTo(1.0, tolerance));
        expect(dm2.asSquareMeter.unit, AreaUnit.squareMeter);

        final cm2 = 10000.cm2;
        expect(cm2.inSquareMeters, closeTo(1.0, tolerance));
        expect(cm2.asSquareMeter.unit, AreaUnit.squareMeter);

        final mm2 = 1000000.mm2;
        expect(mm2.inSquareMeters, closeTo(1.0, tolerance));
        expect(mm2.asSquareMeter.unit, AreaUnit.squareMeter);

        final um2 = 1e12.um2;
        expect(um2.inSquareMeters, closeTo(1.0, tolerance));
        expect(um2.asSquareMeter.unit, AreaUnit.squareMeter);
      });

      test('Large SI square unit extensions (dam², hm², km², Mm²)', () {
        final dam2 = 1.dam2;
        expect(dam2.inSquareMeters, closeTo(100.0, tolerance));
        expect(dam2.asSquareMeter.unit, AreaUnit.squareMeter);

        final hm2 = 1.hm2;
        expect(hm2.inSquareMeters, closeTo(10000.0, tolerance));
        expect(hm2.asSquareMeter.unit, AreaUnit.squareMeter);

        final km2 = 1.km2;
        expect(km2.inSquareMeters, closeTo(1000000.0, tolerance));
        expect(km2.asSquareMeter.unit, AreaUnit.squareMeter);

        final squareMegaM = 1.squareMegameter;
        expect(squareMegaM.inSquareKilometers, closeTo(1000000.0, tolerance));
        expect(squareMegaM.asSquareKilometer.unit, AreaUnit.squareKilometer);
      });

      test('Hectare extensions', () {
        final hectares = 5.ha;
        expect(hectares.value, 5.0);
        expect(hectares.unit, AreaUnit.hectare);
        expect(hectares.inSquareMeters, closeTo(50000.0, tolerance));
        expect(hectares.asSquareMeter.unit, AreaUnit.squareMeter);
      });

      test('Imperial square unit extensions (in², ft², yd², mi²)', () {
        final in2 = 144.in2;
        expect(in2.inSquareFeet, closeTo(1.0, tolerance));
        expect(in2.asSquareFoot.unit, AreaUnit.squareFoot);

        final ft2 = 9.ft2;
        expect(ft2.inSquareYards, closeTo(1.0, tolerance));
        expect(ft2.asSquareYard.unit, AreaUnit.squareYard);

        final yd2 = 4840.yd2;
        expect(yd2.inAcres, closeTo(1.0, tolerance));
        expect(yd2.asAcre.unit, AreaUnit.acre);

        final mi2 = 1.mi2;
        expect(mi2.inAcres, closeTo(640.0, tolerance));
        expect(mi2.asAcre.unit, AreaUnit.acre);
      });

      test('Acre extensions', () {
        final acres = 10.ac;
        expect(acres.value, 10.0);
        expect(acres.unit, AreaUnit.acre);
        expect(acres.inSquareYards, closeTo(48400.0, tolerance));
        expect(acres.asSquareYard.unit, AreaUnit.squareYard);
      });

      test('All area conversion getters work correctly', () {
        final base = 1000.m2;

        expect(base.asSquareMeter.unit, AreaUnit.squareMeter);
        expect(base.asSquareDecimeter.unit, AreaUnit.squareDecimeter);
        expect(base.asSquareCentimeter.unit, AreaUnit.squareCentimeter);
        expect(base.asSquareMillimeter.unit, AreaUnit.squareMillimeter);
        expect(base.asSquareMicrometer.unit, AreaUnit.squareMicrometer);
        expect(base.asSquareDecameter.unit, AreaUnit.squareDecameter);
        expect(base.asSquareHectometer.unit, AreaUnit.squareHectometer);
        expect(base.asHectare.unit, AreaUnit.hectare);
        expect(base.asSquareKilometer.unit, AreaUnit.squareKilometer);
        expect(base.asSquareMegameter.unit, AreaUnit.squareMegameter);
        expect(base.asSquareInch.unit, AreaUnit.squareInch);
        expect(base.asSquareFoot.unit, AreaUnit.squareFoot);
        expect(base.asSquareYard.unit, AreaUnit.squareYard);
        expect(base.asSquareMile.unit, AreaUnit.squareMile);
        expect(base.asAcre.unit, AreaUnit.acre);
      });
    });
  });
}
