// test/units/volumetric_flow_rate_test.dart

import 'package:quantify/time.dart';
import 'package:quantify/volume.dart';
import 'package:quantify/volumetric_flow_rate.dart';
import 'package:test/test.dart';

void main() {
  group('VolumetricFlowRate', () {
    const tolerance = 1e-12;

    group('Constructors and Getters', () {
      test('should create from num extensions and retrieve values', () {
        final flow = 100.0.litersPerMinute;
        expect(flow.value, 100.0);
        expect(flow.unit, VolumetricFlowRateUnit.literPerMinute);
        // 100 L/min = 100 * 0.001 / 60 m³/s
        expect(flow.inCubicMetersPerSecond, closeTo(100 * 0.001 / 60, tolerance));
      });
    });

    group('Conversions', () {
      test('Liter per second to others', () {
        final flow = 10.0.litersPerSecond; // 10 L/s
        expect(flow.inLitersPerMinute, closeTo(600.0, tolerance));
        expect(flow.inLitersPerHour, closeTo(36000.0, 1e-9));
        expect(flow.inCubicMetersPerSecond, closeTo(0.01, tolerance));
        expect(flow.inGallonsPerMinute, closeTo(158.503, 1e-3));
      });

      test('Cubic meter per hour to others', () {
        final flow = 3600.0.cubicMetersPerHour;
        expect(flow.inCubicMetersPerSecond, closeTo(1.0, tolerance));
      });

      test('Gallon per minute to m³/s', () {
        final flow = 1.0.gallonsPerMinute;
        expect(flow.inCubicMetersPerSecond, closeTo(0.003785411784 / 60.0, tolerance));
      });
    });

    group('Comparison', () {
      test('should correctly compare different units', () {
        final f1 = 1000.0.litersPerSecond; // 1 m³/s
        final f2 = 1.0.cubicMetersPerSecond;
        final f3 = 0.5.cubicMetersPerSecond;

        expect(f1.compareTo(f2), 0);
        expect(f1.compareTo(f3), greaterThan(0));
        expect(f3.compareTo(f1), lessThan(0));
      });
    });

    group('Arithmetic', () {
      test('should perform addition and subtraction', () {
        final sum = 1.cubicMetersPerSecond + 1.litersPerSecond; // 1 m³/s + 0.001 m³/s
        expect(sum.inCubicMetersPerSecond, closeTo(1.001, tolerance));
        expect(sum.unit, VolumetricFlowRateUnit.cubicMeterPerSecond);
      });

      test('should perform scalar multiplication and division', () {
        final flow = 50.0.litersPerMinute;
        expect((flow * 2.0).inLitersPerMinute, closeTo(100.0, tolerance));
        expect((flow / 5.0).inLitersPerMinute, closeTo(10.0, tolerance));
        expect((flow / 0).value, double.infinity);
      });
    });

    group('Dimensional Analysis', () {
      test('Volume / Time = VolumetricFlowRate', () {
        final volume = 10.0.L;
        final time = 1.0.s;
        final flow = VolumetricFlowRate.from(volume, time);
        expect(flow, isA<VolumetricFlowRate>());
        expect(flow.unit, VolumetricFlowRateUnit.literPerSecond);
        expect(flow.value, closeTo(10.0, tolerance));

        final volumeM3 = 36.0.cubicMeters;
        final timeHours = 1.0.hours;
        final flow2 = VolumetricFlowRate.from(volumeM3, timeHours);
        expect(flow2.unit, VolumetricFlowRateUnit.cubicMeterPerHour);
        expect(flow2.value, closeTo(36.0, tolerance));

        expect(
          VolumetricFlowRate.from(100.0.L, 0.0.s).inLitersPerSecond,
          double.infinity,
        );
        expect(
          VolumetricFlowRate.from(0.0.L, 0.0.s).inLitersPerSecond,
          isNaN,
        );
      });

      test('VolumetricFlowRate * Time = Volume', () {
        final flow = 10.0.litersPerSecond;
        final time = 30.0.s;
        final volume = flow.volumeOver(time);
        expect(volume, isA<Volume>());
        expect(volume.unit, VolumeUnit.litre);
        expect(volume.inLiters, closeTo(300.0, tolerance));

        final flow2 = 36.0.cubicMetersPerHour;
        final time2 = 2.0.hours;
        final volume2 = flow2.volumeOver(time2);
        expect(volume2.inCubicMeters, closeTo(72.0, tolerance));
      });

      test('Volume / VolumetricFlowRate = Time', () {
        final volume = 300.0.L;
        final flow = 10.0.litersPerSecond;
        final time = flow.timeFor(volume);
        expect(time, isA<Time>());
        expect(time.unit, TimeUnit.second);
        expect(time.inSeconds, closeTo(30.0, tolerance));

        final volume2 = 72.0.cubicMeters;
        final flow2 = 36.0.cubicMetersPerHour;
        final time2 = flow2.timeFor(volume2);
        expect(time2.inHours, closeTo(2.0, tolerance));

        expect(0.0.litersPerSecond.timeFor(100.0.L).inSeconds, double.infinity);
        expect(0.0.litersPerSecond.timeFor(0.0.L).inSeconds, isNaN);
      });

      // --- Unit-preserving behaviour ---
      test('VolumetricFlowRate.from: L + s → L/s', () {
        final f = VolumetricFlowRate.from(10.0.L, 1.0.s);
        expect(f.unit, VolumetricFlowRateUnit.literPerSecond);
        expect(f.value, closeTo(10.0, tolerance));
      });

      test('VolumetricFlowRate.from: L + min → L/min', () {
        final f = VolumetricFlowRate.from(120.0.L, 1.0.minutes);
        expect(f.unit, VolumetricFlowRateUnit.literPerMinute);
        expect(f.value, closeTo(120.0, tolerance));
      });

      test('VolumetricFlowRate.from: gal + min → gal/min', () {
        final f = VolumetricFlowRate.from(60.0.gal, 1.0.minutes);
        expect(f.unit, VolumetricFlowRateUnit.gallonPerMinute);
        expect(f.value, closeTo(60.0, tolerance));
      });

      test('VolumetricFlowRate.from: unmatched units → SI fallback m³/s', () {
        expect(
          VolumetricFlowRate.from(1.0.gal, 1.0.days).unit,
          VolumetricFlowRateUnit.cubicMeterPerSecond,
        );
      });

      test('volumeOver: 10 L/s for 30 s → 300 L', () {
        final v = 10.0.litersPerSecond.volumeOver(30.0.s);
        expect(v.unit, VolumeUnit.litre);
        expect(v.value, closeTo(300.0, tolerance));
      });

      test('timeFor: 10 L/s for 300 L → 30 s', () {
        final t = 10.0.litersPerSecond.timeFor(300.0.L);
        expect(t.unit, TimeUnit.second);
        expect(t.value, closeTo(30.0, tolerance));
      });
    });

    group('Round Trip Conversions', () {
      for (final unit in VolumetricFlowRateUnit.values) {
        test('Round trip ${unit.symbol} <-> m³/s', () {
          const initialValue = 123.456;
          final flow = VolumetricFlowRate(initialValue, unit);
          final roundTripFlow = flow.asCubicMetersPerSecond.convertTo(unit);
          expect(roundTripFlow.value, closeTo(initialValue, 1e-9));
        });
      }
    });

    group('Comprehensive Extension Coverage', () {
      test('all creation extensions', () {
        expect(10.cubicMetersPerSecond.unit, VolumetricFlowRateUnit.cubicMeterPerSecond);
        expect(10.cubicMetersPerMinute.unit, VolumetricFlowRateUnit.cubicMeterPerMinute);
        expect(10.cubicMetersPerHour.unit, VolumetricFlowRateUnit.cubicMeterPerHour);
        expect(10.litersPerSecond.unit, VolumetricFlowRateUnit.literPerSecond);
        expect(10.litersPerMinute.unit, VolumetricFlowRateUnit.literPerMinute);
        expect(10.litersPerHour.unit, VolumetricFlowRateUnit.literPerHour);
        expect(10.millilitersPerMinute.unit, VolumetricFlowRateUnit.milliliterPerMinute);
        expect(10.cubicFeetPerSecond.unit, VolumetricFlowRateUnit.cubicFootPerSecond);
        expect(10.cubicFeetPerMinute.unit, VolumetricFlowRateUnit.cubicFootPerMinute);
        expect(10.gallonsPerMinute.unit, VolumetricFlowRateUnit.gallonPerMinute);
        expect(10.gallonsPerHour.unit, VolumetricFlowRateUnit.gallonPerHour);
      });

      test('all in* value getter aliases', () {
        final f = 1.0.cubicMetersPerSecond;
        expect(f.inCubicMetersPerSecond, closeTo(1.0, tolerance));
        expect(f.inCubicMetersPerMinute, closeTo(60.0, tolerance));
        expect(f.inCubicMetersPerHour, closeTo(3600.0, tolerance));
        expect(f.inLitersPerSecond, closeTo(1000.0, tolerance));
        expect(f.inLitersPerMinute, closeTo(60000.0, tolerance));
        expect(f.inLitersPerHour, closeTo(3600000.0, 1e-9));
        expect(f.inMillilitersPerMinute, closeTo(60000000.0, 1e-9));
        expect(f.inCubicFeetPerSecond, closeTo(35.3147, 1e-4));
        expect(f.inCubicFeetPerMinute, closeTo(2118.88, 1e-2));
        expect(f.inGallonsPerMinute, closeTo(15850.3, 1e-1));
        expect(f.inGallonsPerHour, closeTo(951019.4, 1e-1));
      });

      test('all as* conversion getters', () {
        final f = 1.0.cubicMetersPerSecond;

        expect(f.asCubicMetersPerSecond.unit, VolumetricFlowRateUnit.cubicMeterPerSecond);
        expect(f.asCubicMetersPerMinute.unit, VolumetricFlowRateUnit.cubicMeterPerMinute);
        expect(f.asCubicMetersPerHour.unit, VolumetricFlowRateUnit.cubicMeterPerHour);
        expect(f.asLitersPerSecond.unit, VolumetricFlowRateUnit.literPerSecond);
        expect(f.asLitersPerMinute.unit, VolumetricFlowRateUnit.literPerMinute);
        expect(f.asLitersPerHour.unit, VolumetricFlowRateUnit.literPerHour);
        expect(f.asMillilitersPerMinute.unit, VolumetricFlowRateUnit.milliliterPerMinute);
        expect(f.asCubicFeetPerSecond.unit, VolumetricFlowRateUnit.cubicFootPerSecond);
        expect(f.asCubicFeetPerMinute.unit, VolumetricFlowRateUnit.cubicFootPerMinute);
        expect(f.asGallonsPerMinute.unit, VolumetricFlowRateUnit.gallonPerMinute);
        expect(f.asGallonsPerHour.unit, VolumetricFlowRateUnit.gallonPerHour);
      });
    });

    group('Practical Examples', () {
      test('Water pump flow rate', () {
        final pumpFlow = 120.0.litersPerMinute;
        final showerFlow = 10.0.litersPerMinute;

        // Compare flow rates
        expect(pumpFlow.compareTo(showerFlow), greaterThan(0));

        // Calculate volume delivered
        final fillTime = 5.0.minutes;
        final volume = pumpFlow.volumeOver(fillTime);
        expect(volume.inLiters, closeTo(600.0, tolerance));
      });
    });
  });
}
