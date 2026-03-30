import 'package:quantify/quantify.dart';
import 'package:test/test.dart';

void main() {
  group('SoundPressureLevel parsing —', () {
    group('Basic parsing', () {
      test('parses dB SPL symbol', () {
        expect(
          SoundPressureLevel.parse('94 dB SPL'),
          const SoundPressureLevel(94, SoundPressureLevelUnit.decibelSpl),
        );
      });

      test('parses dBSPL compact symbol', () {
        expect(
          SoundPressureLevel.parse('94 dBSPL'),
          const SoundPressureLevel(94, SoundPressureLevelUnit.decibelSpl),
        );
      });

      test('parses dB spl alias', () {
        expect(
          SoundPressureLevel.parse('94 dB spl'),
          const SoundPressureLevel(94, SoundPressureLevelUnit.decibelSpl),
        );
      });
    });

    group('Aliases and names', () {
      test('accepts lowercase normalized aliases', () {
        expect(
          SoundPressureLevel.parse('94 db spl'),
          const SoundPressureLevel(94, SoundPressureLevelUnit.decibelSpl),
        );
      });

      test('full names are case-insensitive', () {
        expect(
          SoundPressureLevel.parse('94 SOUND PRESSURE LEVEL'),
          const SoundPressureLevel(94, SoundPressureLevelUnit.decibelSpl),
        );
      });
    });

    group('Error handling', () {
      test('throws on invalid input', () {
        expect(() => SoundPressureLevel.parse('invalid'), throwsA(isA<QuantityParseException>()));
      });

      test('tryParse returns null on invalid input', () {
        expect(SoundPressureLevel.tryParse('invalid'), isNull);
      });
    });

    group('Round-trip', () {
      test('parse(toString()) preserves value and unit', () {
        const original = SoundPressureLevel(94, SoundPressureLevelUnit.decibelSpl);
        expect(SoundPressureLevel.parse(original.toString()), equals(original));
      });
    });
  });
}
