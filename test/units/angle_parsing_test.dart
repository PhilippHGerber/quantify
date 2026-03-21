import 'package:intl/intl.dart';
import 'package:quantify/quantify.dart';
import 'package:test/test.dart';

void main() {
  const tolerance = 1e-9;

  group('Angle Parsing', () {
    group('Basic parsing', () {
      test('parses standard valid inputs with invariant format', () {
        expect(Angle.parse('90 deg').inDegrees, 90.0);
        expect(Angle.parse('3.14159 rad').inRadians, closeTo(3.14159, tolerance));
        expect(Angle.parse('180°').inDegrees, 180.0);
        expect(Angle.parse('1 rev').inRevolutions, 1.0);
      });

      test('parses by symbol', () {
        final a = Angle.parse('45 deg');
        expect(a.value, 45.0);
        expect(a.unit, AngleUnit.degree);
      });

      test('parses by full name', () {
        final a = Angle.parse('90 degrees');
        expect(a.value, 90.0);
        expect(a.unit, AngleUnit.degree);
      });

      test('parses by plural name', () {
        final a = Angle.parse('2 radians');
        expect(a.value, 2.0);
        expect(a.unit, AngleUnit.radian);
      });

      test('parses scientific notation', () {
        final a = Angle.parse('1.5e2 deg');
        expect(a.value, 150.0);
        expect(a.unit, AngleUnit.degree);
      });

      test('parses negative values', () {
        final a = Angle.parse('-45 deg');
        expect(a.value, -45.0);
        expect(a.unit, AngleUnit.degree);
      });

      test('parses leading decimal point', () {
        final a = Angle.parse('.5 rev');
        expect(a.value, 0.5);
        expect(a.unit, AngleUnit.revolution);
      });
    });

    group('Spacing', () {
      test('parses correctly regardless of spacing', () {
        expect(Angle.parse('90deg').inDegrees, 90.0);
        expect(Angle.parse('90   deg').inDegrees, 90.0);
        expect(Angle.parse('90\tdeg').inDegrees, 90.0);
        expect(Angle.parse('  90 deg  ').inDegrees, 90.0);
      });

      test('parses without space between value and unit', () {
        final a = Angle.parse('180°');
        expect(a.value, 180.0);
        expect(a.unit, AngleUnit.degree);
      });
    });

    group('Case-insensitive names', () {
      test('full names are case-insensitive', () {
        expect(Angle.parse('90 DEGREE').unit, AngleUnit.degree);
        expect(Angle.parse('90 Degrees').unit, AngleUnit.degree);
        expect(Angle.parse('1 RADIAN').unit, AngleUnit.radian);
        expect(Angle.parse('1 Radians').unit, AngleUnit.radian);
      });

      test('abbreviations in nameAliases are case-insensitive', () {
        expect(Angle.parse('1 DEG').unit, AngleUnit.degree);
        expect(Angle.parse('1 Deg').unit, AngleUnit.degree);
        expect(Angle.parse('1 RAD').unit, AngleUnit.radian);
        expect(Angle.parse('1 Rad').unit, AngleUnit.radian);
      });
    });

    group('Unit coverage', () {
      test('parses degree symbol', () {
        final deg = Angle.parse('180°');
        expect(deg.value, 180.0);
        expect(deg.unit, AngleUnit.degree);
      });

      test('parses gradians', () {
        final grad = Angle.parse('100 grad');
        expect(grad.value, 100.0);
        expect(grad.unit, AngleUnit.gradian);

        final gon = Angle.parse('100 gon');
        expect(gon.value, 100.0);
        expect(gon.unit, AngleUnit.gradian);
      });

      test('parses revolution/turn', () {
        final rev = Angle.parse('2 rev');
        expect(rev.value, 2.0);
        expect(rev.unit, AngleUnit.revolution);

        final turn = Angle.parse('2 turn');
        expect(turn.value, 2.0);
        expect(turn.unit, AngleUnit.revolution);
      });

      test('parses arcminute and arcsecond', () {
        final arcmin = Angle.parse("30'");
        expect(arcmin.value, 30.0);
        expect(arcmin.unit, AngleUnit.arcminute);

        final arcsec = Angle.parse('15"');
        expect(arcsec.value, 15.0);
        expect(arcsec.unit, AngleUnit.arcsecond);

        final arcmin2 = Angle.parse('30 arcmin');
        expect(arcmin2.value, 30.0);
        expect(arcmin2.unit, AngleUnit.arcminute);

        final arcsec2 = Angle.parse('15 arcsec');
        expect(arcsec2.value, 15.0);
        expect(arcsec2.unit, AngleUnit.arcsecond);
      });

      test('parses milliradian', () {
        final mrad = Angle.parse('500 mrad');
        expect(mrad.value, 500.0);
        expect(mrad.unit, AngleUnit.milliradian);
      });

      test('parsed value should be usable in conversions', () {
        final deg = Angle.parse('180 deg');
        expect(deg.getValue(AngleUnit.radian), closeTo(3.141592653589793, tolerance));
      });
    });

    group('Invariant format strictness', () {
      test('invariant format accepts visual grouping separators', () {
        expect(Angle.parse('1 000 deg').inDegrees, 1000.0);
        expect(Angle.parse('1\u00A0000 deg').inDegrees, 1000.0);
        expect(Angle.parse('1\u202F000 deg').inDegrees, 1000.0);
        expect(Angle.parse("1'000 deg").inDegrees, 1000.0);
      });

      test('invariant format still rejects locale decimal separators', () {
        expect(Angle.tryParse('10,5 deg'), isNull);
        expect(Angle.tryParse('10;5 deg'), isNull);
      });

      test('rejects deferred composite quote notation instead of misparsing', () {
        // Composite prime+double-prime parsing is not supported yet.
        // Rejecting avoids silent coercion such as 1'30" -> 130".
        expect(Angle.tryParse('1\'30"'), isNull);
        expect(Angle.tryParse('1\' 30"'), isNull);
        expect(Angle.tryParse('1’30"'), isNull);

        expect(
          () => Angle.parse('1\'30"'),
          throwsA(isA<QuantityParseException>()),
        );

        // Direct quote-symbol units remain supported.
        expect(Angle.parse("30'").unit, AngleUnit.arcminute);
        expect(Angle.parse("30'").value, 30.0);
        expect(Angle.parse('15"').unit, AngleUnit.arcsecond);
        expect(Angle.parse('15"').value, 15.0);
      });

      test('de_CH apostrophe grouping still parses while composite quotes reject', () {
        final chFormat = QuantityFormat.withNumberFormat(
          NumberFormat.decimalPattern('de_CH'),
        );

        // Apostrophe as a grouping separator remains valid for locale numbers.
        final grouped = Angle.parse('1\u2019234.56 deg', formats: [chFormat]);
        expect(grouped.inDegrees, closeTo(1234.56, 1e-9));

        // Deferred composite notation should fail, even with the same locale format.
        expect(Angle.tryParse('1\'30"', formats: [chFormat]), isNull);
      });
    });

    group('Error handling', () {
      test('tryParse returns null for invalid input', () {
        expect(Angle.tryParse('invalid'), isNull);
        expect(Angle.tryParse('10'), isNull);
        expect(Angle.tryParse('nope deg'), isNull);
        expect(Angle.tryParse('10 xyz'), isNull);
      });

      test('parse throws QuantityParseException for invalid input', () {
        expect(
          () => Angle.parse('invalid'),
          throwsA(isA<QuantityParseException>()),
        );
        expect(
          () => Angle.parse('10'),
          throwsA(isA<QuantityParseException>()),
        );
        expect(
          () => Angle.parse('10 xyz'),
          throwsA(isA<QuantityParseException>()),
        );
      });
    });

    group('Round-trip', () {
      test('parse and format round-trip correctly', () {
        const original = Angle(90, AngleUnit.degree);
        final formatted = original.toString(format: QuantityFormat.invariant);
        final parsed = Angle.parse(formatted);

        expect(parsed.value, closeTo(original.value, tolerance));
        expect(parsed.unit, original.unit);
      });
    });
  });
}
