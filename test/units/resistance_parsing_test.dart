import 'package:quantify/quantify.dart';
import 'package:test/test.dart';

void main() {
  group('Resistance parsing —', () {
    group('Basic parsing (invariant format)', () {
      test('parses ohm with symbol', () {
        expect(Resistance.parse('470 Ω'), const Resistance(470, ResistanceUnit.ohm));
      });

      test('parses nanoohm', () {
        expect(Resistance.parse('100 nΩ'), const Resistance(100, ResistanceUnit.nanoohm));
      });

      test('parses microohm', () {
        expect(Resistance.parse('500 µΩ'), const Resistance(500, ResistanceUnit.microohm));
      });

      test('parses milliohm', () {
        expect(Resistance.parse('20 mΩ'), const Resistance(20, ResistanceUnit.milliohm));
      });

      test('parses kiloohm', () {
        expect(Resistance.parse('4.7 kΩ'), const Resistance(4.7, ResistanceUnit.kiloohm));
      });

      test('parses megaohm', () {
        expect(Resistance.parse('10 MΩ'), const Resistance(10, ResistanceUnit.megaohm));
      });

      test('parses gigaohm', () {
        expect(Resistance.parse('1 GΩ'), const Resistance(1, ResistanceUnit.gigaohm));
      });

      test('parses Ohm symbol alias', () {
        expect(Resistance.parse('470 Ohm'), const Resistance(470, ResistanceUnit.ohm));
      });
    });

    group('Spacing tolerance', () {
      test('parses with no space', () {
        expect(Resistance.parse('470Ω'), const Resistance(470, ResistanceUnit.ohm));
      });

      test('parses with multiple spaces', () {
        expect(Resistance.parse('4.7   kΩ'), const Resistance(4.7, ResistanceUnit.kiloohm));
      });

      test('parses with leading/trailing whitespace', () {
        expect(Resistance.parse('  10 MΩ  '), const Resistance(10, ResistanceUnit.megaohm));
      });
    });

    group('Case sensitivity', () {
      test('SI symbols are case-sensitive (kΩ vs KΩ)', () {
        expect(() => Resistance.parse('4.7 KΩ'), throwsA(isA<QuantityParseException>()));
      });

      test('SI symbols distinguish prefixes (mΩ vs MΩ)', () {
        expect(Resistance.parse('20 mΩ'), const Resistance(20, ResistanceUnit.milliohm));
        expect(Resistance.parse('20 MΩ'), const Resistance(20, ResistanceUnit.megaohm));
      });

      test('full names are case-insensitive', () {
        expect(Resistance.parse('470 OHM'), const Resistance(470, ResistanceUnit.ohm));
        expect(Resistance.parse('470 Ohms'), const Resistance(470, ResistanceUnit.ohm));
        expect(Resistance.parse('4.7 kiloohm'), const Resistance(4.7, ResistanceUnit.kiloohm));
      });

      test('micro prefix uΩ works as alias for µΩ', () {
        expect(Resistance.parse('500 uΩ'), const Resistance(500, ResistanceUnit.microohm));
      });
    });

    group('Error handling', () {
      test('throws on invalid number', () {
        expect(() => Resistance.parse('abc Ω'), throwsA(isA<QuantityParseException>()));
      });

      test('throws on missing unit', () {
        expect(() => Resistance.parse('470'), throwsA(isA<QuantityParseException>()));
      });

      test('throws on unknown unit', () {
        expect(() => Resistance.parse('470 xyz'), throwsA(isA<QuantityParseException>()));
      });

      test('returns null with tryParse on invalid input', () {
        expect(Resistance.tryParse('invalid'), isNull);
      });

      test('returns null with tryParse on missing unit', () {
        expect(Resistance.tryParse('470'), isNull);
      });
    });

    group('Round-trip', () {
      test('parse(toString()) preserves value and unit', () {
        const original = Resistance(470, ResistanceUnit.ohm);
        final roundTrip = Resistance.parse(original.toString());
        expect(roundTrip, equals(original));
      });

      test('parse(toString()) works for all units', () {
        for (final unit in ResistanceUnit.values) {
          final original = Resistance(1, unit);
          final roundTrip = Resistance.parse(original.toString());
          expect(roundTrip, equals(original));
        }
      });
    });
  });
}
