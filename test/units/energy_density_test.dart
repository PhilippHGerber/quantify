import 'package:quantify/energy.dart';
import 'package:quantify/energy_density.dart';
import 'package:quantify/volume.dart';
import 'package:test/test.dart';

void main() {
  group('EnergyDensity', () {
    const tolerance = 1e-9;

    group('Constructors and Getters', () {
      test('should create from num extensions and retrieve values', () {
        final density = 500.joulesPerCubicMeter;
        expect(density.value, 500.0);
        expect(density.unit, EnergyDensityUnit.joulePerCubicMeter);
        expect(density.inJoulesPerCubicMeter, closeTo(500.0, tolerance));

        final wh = 1.5.wattHoursPerLiter;
        expect(wh.inWattHoursPerLiter, closeTo(1.5, tolerance));
      });
    });

    group('Conversions', () {
      test('J/m³ to J/L', () {
        // 1000 J/m³ = 1 J/L
        final d = 1000.joulesPerCubicMeter;
        expect(d.inJoulesPerLiter, closeTo(1.0, tolerance));
      });

      test('J/L to J/m³', () {
        final d = 1.joulesPerLiter;
        expect(d.inJoulesPerCubicMeter, closeTo(1000.0, tolerance));
      });

      test('Wh/L to J/m³', () {
        // 1 Wh/L = 3,600,000 J/m³
        final d = 1.wattHoursPerLiter;
        expect(d.inJoulesPerCubicMeter, closeTo(3600000.0, tolerance));
      });

      test('Wh/L to J/L', () {
        // 1 Wh/L = 3600 J/L
        final d = 1.wattHoursPerLiter;
        expect(d.inJoulesPerLiter, closeTo(3600.0, tolerance));
      });
    });

    group('convertTo', () {
      test('convertTo same unit returns identical instance', () {
        final d = 1000.joulesPerCubicMeter;
        expect(identical(d, d.convertTo(EnergyDensityUnit.joulePerCubicMeter)), isTrue);
      });

      test('convertTo different unit returns correct value and unit', () {
        final d = 1000.joulesPerCubicMeter;
        final converted = d.convertTo(EnergyDensityUnit.joulePerLiter);
        expect(converted.unit, EnergyDensityUnit.joulePerLiter);
        expect(converted.value, closeTo(1.0, tolerance));
      });
    });

    group('Comparison', () {
      test('should correctly compare different units', () {
        final d1 = 1000.joulesPerCubicMeter;
        final d2 = 1.joulesPerLiter;
        expect(d1.compareTo(d2), 0);
        expect(d1.compareTo(0.5.joulesPerLiter), greaterThan(0));
      });
    });

    group('Arithmetic', () {
      test('operator + with same unit', () {
        final sum = 1.joulesPerLiter + 1000.joulesPerCubicMeter; // 1 + 1 (in J/L)
        expect(sum.inJoulesPerLiter, closeTo(2.0, tolerance));
      });

      test('operator - subtracts energy density (same unit)', () {
        final diff = 2.joulesPerLiter - 1.joulesPerLiter;
        expect(diff.inJoulesPerLiter, closeTo(1.0, tolerance));
        expect(diff.unit, EnergyDensityUnit.joulePerLiter);
      });

      test('operator - subtracts energy density (mixed units, result in lhs unit)', () {
        // 2000 J/m³ − 1 J/L = 2000 − 1000 = 1000 J/m³
        final diff = 2000.joulesPerCubicMeter - 1.joulesPerLiter;
        expect(diff.inJoulesPerCubicMeter, closeTo(1000.0, tolerance));
        expect(diff.unit, EnergyDensityUnit.joulePerCubicMeter);
      });

      test('operator * scales energy density by a scalar', () {
        final scaled = 500.joulesPerCubicMeter * 3.0;
        expect(scaled.inJoulesPerCubicMeter, closeTo(1500.0, tolerance));
        expect(scaled.unit, EnergyDensityUnit.joulePerCubicMeter);
      });

      test('operator / scales energy density by a scalar', () {
        final scaled = 4.joulesPerLiter / 2.0;
        expect(scaled.inJoulesPerLiter, closeTo(2.0, tolerance));
        expect(scaled.unit, EnergyDensityUnit.joulePerLiter);
      });

      test('operator / by zero returns infinity', () {
        expect((1000.joulesPerCubicMeter / 0.0).value, double.infinity);
      });
    });

    group('Equality and HashCode', () {
      test('same value and unit are equal', () {
        final d1 = 1000.joulesPerCubicMeter;
        final d2 = 1000.joulesPerCubicMeter;
        expect(d1, equals(d2));
        expect(d1.hashCode, equals(d2.hashCode));
      });

      test('different units are not equal even if equivalent', () {
        final d1 = 1000.joulesPerCubicMeter;
        final d2 = 1.joulesPerLiter;
        expect(d1, isNot(equals(d2)));
        expect(d1.compareTo(d2), 0);
      });
    });

    group('toString', () {
      test('displays value with symbol', () {
        expect(1000.joulesPerCubicMeter.toString(), '1000.0\u00A0J/m³');
        expect(1.joulesPerLiter.toString(), '1.0\u00A0J/L');
        expect(1.wattHoursPerLiter.toString(), '1.0\u00A0Wh/L');
      });
    });

    group('Round Trip Conversions', () {
      for (final unit in EnergyDensityUnit.values) {
        test('Round trip ${unit.symbol} <-> J/m³', () {
          const initialValue = 1234.5;
          final d = EnergyDensity(initialValue, unit);
          final roundTrip = d.asJoulesPerCubicMeter.convertTo(unit);
          expect(roundTrip.value, closeTo(initialValue, 1e-6));
        });
      }
    });

    group('Comprehensive Extension Coverage', () {
      test('all creation extensions', () {
        expect(1.wattHoursPerLiter.unit, EnergyDensityUnit.wattHourPerLiter);
        expect(1.wattHoursPerLiter.inWattHoursPerLiter, closeTo(1.0, tolerance));
      });

      test('all as* conversion getters', () {
        final d = 1000.joulesPerCubicMeter;

        final asJm3 = d.asJoulesPerCubicMeter;
        expect(asJm3.unit, EnergyDensityUnit.joulePerCubicMeter);
        expect(asJm3.value, closeTo(1000.0, tolerance));

        final asJl = d.asJoulesPerLiter;
        expect(asJl.unit, EnergyDensityUnit.joulePerLiter);
        expect(asJl.value, closeTo(1.0, tolerance));

        final asWhl = d.asWattHoursPerLiter;
        expect(asWhl.unit, EnergyDensityUnit.wattHourPerLiter);
        expect(asWhl.value, closeTo(1000.0 / 3600000.0, tolerance));
      });
    });

    group('Dimensional Analysis', () {
      test('EnergyDensity = Energy / Volume', () {
        final energy = 1000.J;
        final volume = 2.m3;
        final density = EnergyDensity.from(energy, volume);
        expect(density.inJoulesPerCubicMeter, closeTo(500.0, tolerance));

        expect(EnergyDensity.from(10.J, 0.m3).inJoulesPerCubicMeter, double.infinity);
        expect(EnergyDensity.from(0.J, 0.m3).inJoulesPerCubicMeter, isNaN);
      });

      test('Energy = EnergyDensity * Volume', () {
        final density = 500.joulesPerCubicMeter;
        final volume = 5.m3;
        final energy = density.energyOf(volume);
        expect(energy.inJoules, closeTo(2500.0, tolerance));
      });

      test('Energy / EnergyDensity = Volume', () {
        final density = 500.joulesPerCubicMeter;
        final energy = 2500.J;
        final volume = density.volumeFor(energy);
        expect(volume, isA<Volume>());
        expect(volume.inCubicMeters, closeTo(5.0, tolerance));

        expect(0.joulesPerCubicMeter.volumeFor(10.J).inCubicMeters, double.infinity);
        expect(0.joulesPerCubicMeter.volumeFor(0.J).inCubicMeters, isNaN);
      });

      // --- Unit-preserving behaviour ---
      test('EnergyDensity.from: J + m³ → J/m³', () {
        final d = EnergyDensity.from(1000.J, 2.m3);
        expect(d.unit, EnergyDensityUnit.joulePerCubicMeter);
        expect(d.value, closeTo(500.0, tolerance));
      });

      test('EnergyDensity.from: J + L → J/L', () {
        final d = EnergyDensity.from(500.J, 1.0.L);
        expect(d.unit, EnergyDensityUnit.joulePerLiter);
        expect(d.value, closeTo(500.0, tolerance));
      });

      test('EnergyDensity.from: Wh + L → Wh/L', () {
        final d = EnergyDensity.from(2.Wh, 1.0.L);
        expect(d.unit, EnergyDensityUnit.wattHourPerLiter);
        expect(d.value, closeTo(2.0, tolerance));
      });

      test('EnergyDensity.from: unmatched → SI fallback', () {
        expect(EnergyDensity.from(1.Wh, 1.m3).unit, EnergyDensityUnit.joulePerCubicMeter);
      });

      test('energyOf: J/L → result in joules', () {
        final d = 500.joulesPerLiter;
        final e = d.energyOf(2.L);
        expect(e.unit, EnergyUnit.joule);
        expect(e.value, closeTo(1000.0, tolerance));
      });

      test('energyOf: Wh/L → result in watt-hours', () {
        final d = 2.wattHoursPerLiter;
        final e = d.energyOf(3.L);
        expect(e.unit, EnergyUnit.wattHour);
        expect(e.value, closeTo(6.0, tolerance));
      });

      test('volumeFor: J/L → result in liters', () {
        final v = 500.joulesPerLiter.volumeFor(1000.J);
        expect(v.unit, VolumeUnit.litre);
        expect(v.value, closeTo(2.0, tolerance));
      });

      test('physical correctness: energyOf round-trip', () {
        expect(2.wattHoursPerLiter.energyOf(3.L).inWattHours, closeTo(6.0, tolerance));
      });
    });
  });
}
