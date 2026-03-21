import 'package:quantify/quantify.dart';
import 'package:test/test.dart';

void main() {
  group('Frequency parsing —', () {
    group('Basic parsing (invariant format)', () {
      test('parses hertz with symbol', () {
        expect(Frequency.parse('60 Hz'), const Frequency(60, FrequencyUnit.hertz));
      });

      test('parses gigahertz', () {
        expect(Frequency.parse('2.4 GHz'), const Frequency(2.4, FrequencyUnit.gigahertz));
      });

      test('parses megahertz', () {
        expect(Frequency.parse('100 MHz'), const Frequency(100, FrequencyUnit.megahertz));
      });

      test('parses kilohertz', () {
        expect(Frequency.parse('440 kHz'), const Frequency(440, FrequencyUnit.kilohertz));
      });

      test('parses revolutions per minute', () {
        expect(
          Frequency.parse('3000 rpm'),
          const Frequency(3000, FrequencyUnit.revolutionsPerMinute),
        );
      });

      test('parses beats per minute', () {
        expect(Frequency.parse('120 bpm'), const Frequency(120, FrequencyUnit.beatsPerMinute));
      });

      test('parses radians per second', () {
        expect(Frequency.parse('6.28 rad/s'), const Frequency(6.28, FrequencyUnit.radianPerSecond));
      });

      test('parses degrees per second', () {
        expect(Frequency.parse('360 °/s'), const Frequency(360, FrequencyUnit.degreePerSecond));
      });
    });

    group('SI prefixes', () {
      test('parses terahertz', () {
        expect(Frequency.parse('1 THz'), const Frequency(1, FrequencyUnit.terahertz));
      });

      test('parses gigahertz', () {
        expect(Frequency.parse('2.4 GHz'), const Frequency(2.4, FrequencyUnit.gigahertz));
      });

      test('distinguishes MHz vs mHz', () {
        expect(Frequency.parse('100 MHz'), const Frequency(100, FrequencyUnit.megahertz));
        expect(Frequency.parse('100 mHz'), const Frequency(100, FrequencyUnit.millihertz));
      });
    });

    group('Spacing tolerance', () {
      test('parses with no space', () {
        expect(Frequency.parse('60Hz'), const Frequency(60, FrequencyUnit.hertz));
      });

      test('parses with multiple spaces', () {
        expect(Frequency.parse('2.4   GHz'), const Frequency(2.4, FrequencyUnit.gigahertz));
      });

      test('parses with leading/trailing whitespace', () {
        expect(Frequency.parse('  440 kHz  '), const Frequency(440, FrequencyUnit.kilohertz));
      });
    });

    group('Case sensitivity', () {
      test('SI symbols are case-sensitive (Hz vs hz)', () {
        expect(() => Frequency.parse('60 hz'), throwsA(isA<QuantityParseException>()));
      });

      test('SI symbols distinguish prefixes (MHz vs mHz)', () {
        expect(Frequency.parse('100 MHz'), const Frequency(100, FrequencyUnit.megahertz));
        expect(Frequency.parse('100 mHz'), const Frequency(100, FrequencyUnit.millihertz));
      });

      test('full names are case-insensitive', () {
        expect(Frequency.parse('60 HERTZ'), const Frequency(60, FrequencyUnit.hertz));
        expect(Frequency.parse('60 Hertz'), const Frequency(60, FrequencyUnit.hertz));
      });

      test('non-SI abbreviations are case-insensitive', () {
        expect(
          Frequency.parse('3000 RPM'),
          const Frequency(3000, FrequencyUnit.revolutionsPerMinute),
        );
        expect(Frequency.parse('120 BPM'), const Frequency(120, FrequencyUnit.beatsPerMinute));
      });
    });

    group('Error handling', () {
      test('throws on invalid number', () {
        expect(() => Frequency.parse('abc Hz'), throwsA(isA<QuantityParseException>()));
      });

      test('throws on missing unit', () {
        expect(() => Frequency.parse('60'), throwsA(isA<QuantityParseException>()));
      });

      test('throws on unknown unit', () {
        expect(() => Frequency.parse('60 xyz'), throwsA(isA<QuantityParseException>()));
      });

      test('returns null with tryParse on invalid input', () {
        expect(Frequency.tryParse('invalid'), isNull);
      });

      test('returns null with tryParse on missing unit', () {
        expect(Frequency.tryParse('60'), isNull);
      });
    });

    group('Round-trip', () {
      test('parse(toString()) preserves value and unit', () {
        const original = Frequency(2.4, FrequencyUnit.gigahertz);
        final roundTrip = Frequency.parse(original.toString());
        expect(roundTrip, equals(original));
      });

      test('parse(toString()) works for all units', () {
        for (final unit in FrequencyUnit.values) {
          final original = Frequency(1, unit);
          final roundTrip = Frequency.parse(original.toString());
          expect(roundTrip, equals(original));
        }
      });
    });
  });
}
