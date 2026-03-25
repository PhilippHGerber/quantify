// ignore_for_file: prefer_int_literals // All constants are doubles for precision.

import 'package:quantify/quantify.dart';
import 'package:test/test.dart';

void main() {
  group('Resistance', () {
    const strictTolerance = 1e-12;
    const defaultTolerance = 1e-9;
    const looseTolerance = 1e-6;

    // Helper for round trip tests
    void testRoundTrip(
      ResistanceUnit initialUnit,
      ResistanceUnit intermediateUnit,
      double initialValue, {
      double tol = defaultTolerance,
    }) {
      final r1 = Resistance(initialValue, initialUnit);
      final r2 = r1.convertTo(intermediateUnit);
      final r3 = r2.convertTo(initialUnit);
      expect(
        r3.value,
        closeTo(initialValue, tol),
        reason: '${initialUnit.symbol} -> ${intermediateUnit.symbol} -> ${initialUnit.symbol} '
            'failed for $initialValue. Expected $initialValue, got ${r3.value}',
      );
    }

    group('Constructors and Getters (from num extensions)', () {
      test('should create Resistance from num extensions and retrieve values correctly', () {
        final rOhm = 470.0.ohms;
        expect(rOhm.value, 470.0);
        expect(rOhm.unit, ResistanceUnit.ohm);
        expect(rOhm.inMilliohms, closeTo(470000.0, defaultTolerance));
        expect(rOhm.asMilliohms.value, closeTo(470000.0, defaultTolerance));
        expect(rOhm.asMilliohms.unit, ResistanceUnit.milliohm);

        final rKOhm = 4.7.kiloohms;
        expect(rKOhm.value, 4.7);
        expect(rKOhm.unit, ResistanceUnit.kiloohm);
        expect(rKOhm.inOhms, closeTo(4700.0, defaultTolerance));

        final rMicroOhm = 100.0.microohms;
        expect(rMicroOhm.value, 100.0);
        expect(rMicroOhm.unit, ResistanceUnit.microohm);
        expect(rMicroOhm.inOhms, closeTo(0.0001, strictTolerance));
        expect(rMicroOhm.inNanoohms, closeTo(100000.0, defaultTolerance));

        final rGOhm = 2.0.gigaohms;
        expect(rGOhm.inOhms, closeTo(2e9, defaultTolerance));
        expect(rGOhm.inMegaohms, closeTo(2000.0, strictTolerance));

        final rNanoOhm = 500.0.nanoohms;
        expect(rNanoOhm.inOhms, closeTo(5e-7, defaultTolerance));
        expect(rNanoOhm.inMicroohms, closeTo(0.5, strictTolerance));
      });

      test('getValue should return correct value for same unit', () {
        const r = Resistance(100.0, ResistanceUnit.ohm);
        expect(r.getValue(ResistanceUnit.ohm), 100.0);
      });
    });

    group('Conversions between various resistance units', () {
      final oneOhm = 1.0.ohms;
      test('1 Ohm to other units', () {
        expect(oneOhm.inKiloohms, closeTo(0.001, strictTolerance));
        expect(oneOhm.inMilliohms, closeTo(1000.0, strictTolerance));
        expect(oneOhm.inMicroohms, closeTo(1.0e6, strictTolerance));
        expect(oneOhm.inNanoohms, closeTo(1.0e9, looseTolerance));
      });

      final oneKiloohm = 1.0.kiloohms;
      test('1 Kiloohm to ohms', () {
        expect(oneKiloohm.inOhms, closeTo(1000.0, strictTolerance));
      });

      final oneMilliohm = 1.0.milliohms;
      test('1 Milliohm to microohms and ohms', () {
        expect(oneMilliohm.inMicroohms, closeTo(1000.0, strictTolerance));
        expect(oneMilliohm.inOhms, closeTo(0.001, strictTolerance));
      });

      final fiftyMicroohms = 50.0.microohms;
      test('50 Microohms to nanoohms and milliohms', () {
        expect(fiftyMicroohms.inNanoohms, closeTo(50000.0, defaultTolerance));
        expect(fiftyMicroohms.inMilliohms, closeTo(0.05, strictTolerance));
      });
    });

    group('convertTo method', () {
      test('should return new Resistance object with converted value and unit', () {
        final rMilliohm = 4700.0.milliohms;
        final rOhm = rMilliohm.convertTo(ResistanceUnit.ohm);
        expect(rOhm.value, closeTo(4.7, strictTolerance));
        expect(rOhm.unit, ResistanceUnit.ohm);
      });

      test('convertTo same unit returns same instance', () {
        final r = 100.0.ohms;
        expect(identical(r, r.convertTo(ResistanceUnit.ohm)), isTrue);
      });
    });

    group('Comparisons', () {
      test('greater than', () {
        expect(1.0.kiloohms > 999.0.ohms, isTrue);
        expect(1.0.ohms > 1.0.kiloohms, isFalse);
      });

      test('less than', () {
        expect(1.0.ohms < 1.0.kiloohms, isTrue);
        expect(1.0.kiloohms < 1.0.ohms, isFalse);
      });

      test('greater than or equal', () {
        expect(1000.0.ohms >= 1.0.kiloohms, isTrue);
        expect(1.0.kiloohms >= 1000.0.ohms, isTrue);
      });

      test('less than or equal', () {
        expect(1000.0.ohms <= 1.0.kiloohms, isTrue);
        expect(1.0.ohms <= 1.0.kiloohms, isTrue);
      });

      test('isEquivalentTo across units', () {
        expect(1.0.kiloohms.isEquivalentTo(1000.0.ohms), isTrue);
        expect(1000.0.milliohms.isEquivalentTo(1.0.ohms), isTrue);
      });
    });

    group('Equality', () {
      test('strict equality requires same unit and value', () {
        expect(
          const Resistance(100.0, ResistanceUnit.ohm) ==
              const Resistance(100.0, ResistanceUnit.ohm),
          isTrue,
        );
        expect(
          const Resistance(1.0, ResistanceUnit.ohm) ==
              const Resistance(1000.0, ResistanceUnit.milliohm),
          isFalse,
        );
      });

      test('hashCode consistency', () {
        const r1 = Resistance(470.0, ResistanceUnit.ohm);
        const r2 = Resistance(470.0, ResistanceUnit.ohm);
        expect(r1.hashCode, equals(r2.hashCode));
      });
    });

    group('Arithmetic', () {
      test('addition', () {
        final result = 100.0.ohms + 50.0.ohms;
        expect(result.value, closeTo(150.0, strictTolerance));
        expect(result.unit, ResistanceUnit.ohm);
      });

      test('addition with unit conversion', () {
        final result = 1.0.ohms + 500.0.milliohms;
        expect(result.inOhms, closeTo(1.5, strictTolerance));
      });

      test('subtraction', () {
        final result = 470.0.ohms - 100.0.ohms;
        expect(result.value, closeTo(370.0, strictTolerance));
      });

      test('multiplication by scalar', () {
        final result = 100.0.ohms * 3.0;
        expect(result.value, closeTo(300.0, strictTolerance));
      });

      test('division by scalar', () {
        final result = 1000.0.ohms / 4.0;
        expect(result.value, closeTo(250.0, strictTolerance));
      });

      test('negation', () {
        final result = -100.0.ohms;
        expect(result.value, closeTo(-100.0, strictTolerance));
      });
    });

    group('toString', () {
      test('default invariant format', () {
        const r = Resistance(470.0, ResistanceUnit.ohm);
        expect(r.toString(), '470.0\u00A0Ω');
      });

      test('kiloohm symbol', () {
        const r = Resistance(4.7, ResistanceUnit.kiloohm);
        expect(r.toString(), '4.7\u00A0kΩ');
      });

      test('megaohm symbol', () {
        const r = Resistance(10.0, ResistanceUnit.megaohm);
        expect(r.toString(), '10.0\u00A0MΩ');
      });
    });

    group('Interop factories', () {
      test('Resistance.fromOhmsLaw (R = V / I)', () {
        final voltage = 12.0.V;
        final current = 0.5.A;
        final resistance = Resistance.fromOhmsLaw(voltage, current);
        expect(resistance.inOhms, closeTo(24.0, strictTolerance));
      });

      test('Resistance.fromOhmsLaw with different units', () {
        final voltage = 3.3.kV;
        final current = 100.0.mA;
        final resistance = Resistance.fromOhmsLaw(voltage, current);
        expect(resistance.inOhms, closeTo(33000.0, defaultTolerance));
      });

      test('voltageAt (V = I × R)', () {
        final resistor = 100.0.ohms;
        final current = 0.5.A;
        final voltage = resistor.voltageAt(current);
        expect(voltage.inVolts, closeTo(50.0, strictTolerance));
      });

      test('currentAt (I = V / R)', () {
        final resistor = 100.0.ohms;
        final voltage = 12.0.V;
        final current = resistor.currentAt(voltage);
        expect(current.inAmperes, closeTo(0.12, strictTolerance));
      });

      test('Ohm law round trip: V = I * R, then R = V / I', () {
        final r = 220.0.ohms;
        final i = 0.1.A;
        final v = r.voltageAt(i); // V = I × R = 22 V
        final rBack = Resistance.fromOhmsLaw(v, i); // R = V / I = 220 Ω
        expect(rBack.inOhms, closeTo(220.0, strictTolerance));
      });
    });

    group('Parsing', () {
      test('parse basic resistance strings', () {
        expect(Resistance.parse('470 Ω').inOhms, closeTo(470.0, strictTolerance));
        expect(Resistance.parse('4.7 kΩ').inOhms, closeTo(4700.0, defaultTolerance));
        expect(Resistance.parse('10 MΩ').inOhms, closeTo(10000000.0, defaultTolerance));
      });

      test('parse Ohm symbol alias', () {
        expect(Resistance.parse('100 Ohm').inOhms, closeTo(100.0, strictTolerance));
      });

      test('parse full word names', () {
        expect(Resistance.parse('470 ohms').inOhms, closeTo(470.0, strictTolerance));
        expect(Resistance.parse('4.7 kiloohms').inOhms, closeTo(4700.0, defaultTolerance));
      });

      test('tryParse returns null for invalid input', () {
        expect(Resistance.tryParse('invalid'), isNull);
        expect(Resistance.tryParse('12 meters'), isNull);
      });

      test('tryParse returns Resistance for valid input', () {
        final result = Resistance.tryParse('100 Ω');
        expect(result, isNotNull);
        expect(result!.inOhms, closeTo(100.0, strictTolerance));
      });
    });

    group('Round trips', () {
      test('Ω -> mΩ -> Ω', () => testRoundTrip(ResistanceUnit.ohm, ResistanceUnit.milliohm, 470.0));
      test('Ω -> kΩ -> Ω', () => testRoundTrip(ResistanceUnit.ohm, ResistanceUnit.kiloohm, 4700.0));
      test(
        'Ω -> MΩ -> Ω',
        () => testRoundTrip(ResistanceUnit.ohm, ResistanceUnit.megaohm, 1000000.0),
      );
      test(
        'mΩ -> µΩ -> mΩ',
        () => testRoundTrip(ResistanceUnit.milliohm, ResistanceUnit.microohm, 3.3),
      );
      test(
        'kΩ -> Ω -> kΩ',
        () => testRoundTrip(ResistanceUnit.kiloohm, ResistanceUnit.ohm, 4.7),
      );
      test(
        'nΩ -> Ω -> nΩ',
        () => testRoundTrip(
          ResistanceUnit.nanoohm,
          ResistanceUnit.ohm,
          500.0,
          tol: looseTolerance,
        ),
      );
      test(
        'GΩ -> kΩ -> GΩ',
        () => testRoundTrip(ResistanceUnit.gigaohm, ResistanceUnit.kiloohm, 1.5),
      );
    });
  });
}
