import 'package:quantify/density.dart';
import 'package:quantify/mass.dart';
import 'package:quantify/volume.dart';
import 'package:test/test.dart';

void main() {
  group('Density', () {
    const tolerance = 1e-9;

    group('Constructors and Getters', () {
      test('should create from num extensions and retrieve values', () {
        final water = 1000.kgPerM3;
        expect(water.value, 1000.0);
        expect(water.unit, DensityUnit.kilogramPerCubicMeter);
        expect(water.inKilogramsPerCubicMeter, closeTo(1000.0, tolerance));

        final mercury = 13.6.gPerCm3;
        expect(mercury.inKilogramsPerCubicMeter, closeTo(13600.0, tolerance));
        expect(mercury.inGramsPerCubicCentimeter, closeTo(13.6, tolerance));
      });
    });

    group('Conversions', () {
      test('kg/m³ to g/cm³', () {
        // 1000 kg/m³ = 1 g/cm³
        final d = 1000.kgPerM3;
        expect(d.inGramsPerCubicCentimeter, closeTo(1.0, tolerance));
        expect(d.inGramsPerMilliliter, closeTo(1.0, tolerance));
      });

      test('g/cm³ to kg/m³', () {
        final d = 1.gPerCm3;
        expect(d.inKilogramsPerCubicMeter, closeTo(1000.0, tolerance));
      });
    });

    group('convertTo', () {
      test('convertTo same unit returns identical instance', () {
        final d = 1000.kgPerM3;
        expect(identical(d, d.convertTo(DensityUnit.kilogramPerCubicMeter)), isTrue);
      });

      test('convertTo different unit returns correct value and unit', () {
        final d = 1000.kgPerM3;
        final converted = d.convertTo(DensityUnit.gramPerCubicCentimeter);
        expect(converted.unit, DensityUnit.gramPerCubicCentimeter);
        expect(converted.value, closeTo(1.0, tolerance));
      });
    });

    group('Comparison', () {
      test('should correctly compare different units', () {
        final d1 = 1000.kgPerM3;
        final d2 = 1.gPerCm3;
        expect(d1.compareTo(d2), 0);
        expect(d1.compareTo(0.5.gPerCm3), greaterThan(0));
      });
    });

    group('Arithmetic', () {
      test('operator + with same unit', () {
        final sum = 1.gPerCm3 + 1000.kgPerM3; // 1 + 1 (in g/cm³)
        expect(sum.inGramsPerCubicCentimeter, closeTo(2.0, tolerance));
      });

      test('operator - subtracts density (same unit)', () {
        final diff = 2.gPerCm3 - 1.gPerCm3;
        expect(diff.inGramsPerCubicCentimeter, closeTo(1.0, tolerance));
        expect(diff.unit, DensityUnit.gramPerCubicCentimeter);
      });

      test('operator - subtracts density (mixed units, result in lhs unit)', () {
        // 2000 kg/m³ − 1 g/cm³ = 2000 − 1000 = 1000 kg/m³
        final diff = 2000.kgPerM3 - 1.gPerCm3;
        expect(diff.inKilogramsPerCubicMeter, closeTo(1000.0, tolerance));
        expect(diff.unit, DensityUnit.kilogramPerCubicMeter);
      });

      test('operator * scales density by a scalar', () {
        final scaled = 500.kgPerM3 * 3.0;
        expect(scaled.inKilogramsPerCubicMeter, closeTo(1500.0, tolerance));
        expect(scaled.unit, DensityUnit.kilogramPerCubicMeter);
      });

      test('operator / scales density by a scalar', () {
        final scaled = 4.gPerCm3 / 2.0;
        expect(scaled.inGramsPerCubicCentimeter, closeTo(2.0, tolerance));
        expect(scaled.unit, DensityUnit.gramPerCubicCentimeter);
      });

      test('operator / throws ArgumentError for zero divisor', () {
        expect(() => 1000.kgPerM3 / 0.0, throwsArgumentError);
      });
    });

    group('Equality and HashCode', () {
      test('same value and unit are equal', () {
        final d1 = 1000.kgPerM3;
        final d2 = 1000.kgPerM3;
        expect(d1, equals(d2));
        expect(d1.hashCode, equals(d2.hashCode));
      });

      test('different units are not equal even if equivalent', () {
        final d1 = 1000.kgPerM3;
        final d2 = 1.gPerCm3;
        expect(d1, isNot(equals(d2)));
        expect(d1.compareTo(d2), 0);
      });
    });

    group('toString', () {
      test('displays value with symbol', () {
        expect(1000.kgPerM3.toString(), '1000.0\u00A0kg/m³');
        expect(1.gPerCm3.toString(), '1.0\u00A0g/cm³');
        expect(1.gPerMl.toString(), '1.0\u00A0g/mL');
      });
    });

    group('Round Trip Conversions', () {
      for (final unit in DensityUnit.values) {
        test('Round trip ${unit.symbol} <-> kg/m³', () {
          const initialValue = 1234.5;
          final d = Density(initialValue, unit);
          final roundTrip = d.asKilogramsPerCubicMeter.convertTo(unit);
          expect(roundTrip.value, closeTo(initialValue, tolerance));
        });
      }
    });

    group('Comprehensive Extension Coverage', () {
      test('all creation extensions', () {
        expect(1.gPerMl.unit, DensityUnit.gramPerMilliliter);
        expect(1.gPerMl.inGramsPerMilliliter, closeTo(1.0, tolerance));
      });

      test('all as* conversion getters', () {
        final d = 1000.kgPerM3;

        final asKg = d.asKilogramsPerCubicMeter;
        expect(asKg.unit, DensityUnit.kilogramPerCubicMeter);
        expect(asKg.value, closeTo(1000.0, tolerance));

        final asCm3 = d.asGramsPerCubicCentimeter;
        expect(asCm3.unit, DensityUnit.gramPerCubicCentimeter);
        expect(asCm3.value, closeTo(1.0, tolerance));

        final asMl = d.asGramsPerMilliliter;
        expect(asMl.unit, DensityUnit.gramPerMilliliter);
        expect(asMl.value, closeTo(1.0, tolerance));
      });
    });

    group('Dimensional Analysis', () {
      test('Density = Mass / Volume', () {
        final mass = 2000.kg;
        final volume = 2.m3;
        final density = Density.from(mass, volume);
        expect(density.inKilogramsPerCubicMeter, closeTo(1000.0, tolerance));

        expect(() => Density.from(10.kg, 0.m3), throwsArgumentError);
      });

      test('Mass = Density * Volume', () {
        final density = 1000.kgPerM3;
        final volume = 5.m3;
        final mass = density.massOf(volume);
        expect(mass.inKilograms, closeTo(5000.0, tolerance));
      });
    });
  });
}
