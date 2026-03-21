import 'package:intl/intl.dart';
import 'package:quantify/quantify.dart';
import 'package:test/test.dart';

void main() {
  const tolerance = 1e-9;

  group('Speed Parsing', () {
    group('Basic parsing', () {
      test('parses standard valid inputs with invariant format', () {
        expect(
          Speed.parse('100 km/h').inKmh,
          100.0,
        );
        expect(
          Speed.parse('10.5 m/s').inMps,
          10.5,
        );
        expect(
          Speed.parse('-5.2 mph').inMph,
          -5.2,
        );
        expect(Speed.parse('2e3 m/s').inMps, 2000.0);
        expect(Speed.parse('1.5E-2 km/h').inKmh, 0.015);
      });

      test('parses by symbol', () {
        final s = Speed.parse('100 km/h');
        expect(s.value, 100.0);
        expect(s.unit, SpeedUnit.kilometerPerHour);
      });

      test('parses by full name', () {
        final s = Speed.parse('10 meters per second');
        expect(s.value, 10.0);
        expect(s.unit, SpeedUnit.meterPerSecond);
      });

      test('parses by plural name', () {
        final s = Speed.parse('5 kilometers per hour');
        expect(s.value, 5.0);
        expect(s.unit, SpeedUnit.kilometerPerHour);
      });

      test('parses scientific notation', () {
        final s = Speed.parse('1.5e3 m/s');
        expect(s.value, 1500.0);
        expect(s.unit, SpeedUnit.meterPerSecond);
      });

      test('parses negative values', () {
        final s = Speed.parse('-5 m/s');
        expect(s.value, -5.0);
        expect(s.unit, SpeedUnit.meterPerSecond);
      });

      test('parses leading decimal point', () {
        final s = Speed.parse('.5 m/s');
        expect(s.value, 0.5);
        expect(s.unit, SpeedUnit.meterPerSecond);

        final neg = Speed.parse('-.5 km/h');
        expect(neg.value, -0.5);
        expect(neg.unit, SpeedUnit.kilometerPerHour);
      });
    });

    group('Spacing', () {
      test('parses correctly regardless of spacing', () {
        expect(Speed.parse('100km/h').inKmh, 100.0);
        expect(Speed.parse('100   km/h').inKmh, 100.0);
        expect(Speed.parse('100\tkm/h').inKmh, 100.0);
        expect(Speed.parse('  100 km/h  ').inKmh, 100.0);
      });

      test('parses without space between value and unit', () {
        final s = Speed.parse('10.5mph');
        expect(s.value, 10.5);
        expect(s.unit, SpeedUnit.milePerHour);
      });

      test('whitespace normalization in multi-word units', () {
        expect(Speed.tryParse('5 meter  per  second'), isNotNull);
        expect(
          Speed.parse('5 meter  per  second').unit,
          SpeedUnit.meterPerSecond,
        );
        expect(Speed.tryParse('10 miles  per  hour'), isNotNull);
        expect(
          Speed.parse('10 miles  per  hour').unit,
          SpeedUnit.milePerHour,
        );
      });
    });

    group('Case sensitivity', () {
      test('SI symbols stay case-sensitive', () {
        // SI slash symbols remain strict.
        expect(Speed.parse('10 m/s').unit, SpeedUnit.meterPerSecond);
        expect(Speed.tryParse('10 M/S'), isNull);

        // Non-SI abbreviations are accepted case-insensitively via name aliases.
        expect(Speed.parse('10 mph').unit, SpeedUnit.milePerHour);
        expect(Speed.parse('10 kn').unit, SpeedUnit.knot);
        expect(Speed.parse('10 kt').unit, SpeedUnit.knot);
        expect(Speed.parse('10 MPH').unit, SpeedUnit.milePerHour);
        expect(Speed.parse('10 KN').unit, SpeedUnit.knot);
        expect(Speed.parse('10 Mph').unit, SpeedUnit.milePerHour);
      });

      test('full names are case-insensitive', () {
        expect(
          Speed.parse('10 METERS PER SECOND').unit,
          SpeedUnit.meterPerSecond,
        );
        expect(
          Speed.parse('10 Kilometers Per Hour').unit,
          SpeedUnit.kilometerPerHour,
        );
        expect(Speed.parse('5 KNOTS').unit, SpeedUnit.knot);
        expect(Speed.parse('5 Miles Per Hour').unit, SpeedUnit.milePerHour);
      });

      test(
        'word forms and non-SI abbreviations match case-insensitively',
        () {
          final s = Speed.parse('10 KILOMETERS PER HOUR');
          expect(s.value, 10.0);
          expect(s.unit, SpeedUnit.kilometerPerHour);

          // kph is a name alias (case-insensitive)
          expect(Speed.parse('10 KPH').unit, SpeedUnit.kilometerPerHour);

          // kmh/mph/kn/kt/fps are mirrored into case-insensitive name aliases.
          expect(Speed.parse('10 KMH').unit, SpeedUnit.kilometerPerHour);
          expect(Speed.parse('10 MPH').unit, SpeedUnit.milePerHour);
          expect(Speed.parse('10 KN').unit, SpeedUnit.knot);
          expect(Speed.parse('10 KT').unit, SpeedUnit.knot);
          expect(Speed.parse('10 FPS').unit, SpeedUnit.footPerSecond);
        },
      );
    });

    group('Unit coverage', () {
      test('parses all speed units by symbol', () {
        expect(Speed.parse('1 m/s').unit, SpeedUnit.meterPerSecond);
        expect(Speed.parse('1 km/s').unit, SpeedUnit.kilometerPerSecond);
        expect(Speed.parse('1 km/h').unit, SpeedUnit.kilometerPerHour);
        expect(Speed.parse('1 mph').unit, SpeedUnit.milePerHour);
        expect(Speed.parse('1 kn').unit, SpeedUnit.knot);
        expect(Speed.parse('1 ft/s').unit, SpeedUnit.footPerSecond);
      });

      test('parses alternative symbol aliases', () {
        expect(Speed.parse('1 kmh').unit, SpeedUnit.kilometerPerHour);
        expect(Speed.parse('1 kt').unit, SpeedUnit.knot);
        expect(Speed.parse('1 fps').unit, SpeedUnit.footPerSecond);
      });

      test('parses all speed units by name', () {
        expect(
          Speed.parse('1 meter per second').unit,
          SpeedUnit.meterPerSecond,
        );
        expect(
          Speed.parse('1 kilometer per second').unit,
          SpeedUnit.kilometerPerSecond,
        );
        expect(
          Speed.parse('1 kilometer per hour').unit,
          SpeedUnit.kilometerPerHour,
        );
        expect(Speed.parse('1 mile per hour').unit, SpeedUnit.milePerHour);
        expect(Speed.parse('1 knot').unit, SpeedUnit.knot);
        expect(
          Speed.parse('1 foot per second').unit,
          SpeedUnit.footPerSecond,
        );
      });

      test('parses British spelling variants', () {
        expect(
          Speed.parse('1 metre per second').unit,
          SpeedUnit.meterPerSecond,
        );
        expect(
          Speed.parse('1 kilometres per hour').unit,
          SpeedUnit.kilometerPerHour,
        );
      });

      test('parses plural name variants', () {
        expect(
          Speed.parse('5 meters per second').unit,
          SpeedUnit.meterPerSecond,
        );
        expect(
          Speed.parse('5 miles per hour').unit,
          SpeedUnit.milePerHour,
        );
        expect(Speed.parse('5 knots').unit, SpeedUnit.knot);
        expect(
          Speed.parse('5 feet per second').unit,
          SpeedUnit.footPerSecond,
        );
      });

      test('parsed value should be usable in conversions', () {
        final s = Speed.parse('1 km/s');
        expect(
          s.getValue(SpeedUnit.meterPerSecond),
          closeTo(1000.0, tolerance),
        );
      });
    });

    group('Invariant format strictness', () {
      test('invariant format accepts visual grouping separators', () {
        expect(Speed.parse('1 000 m/s').inMps, 1000.0);
        expect(Speed.parse('1\u00A0000 m/s').inMps, 1000.0);
        expect(Speed.parse('1\u202F000 m/s').inMps, 1000.0);
        expect(Speed.parse("1'000 m/s").inMps, 1000.0);
      });

      test('invariant format still rejects locale decimal separators', () {
        expect(Speed.tryParse('10,5 km/h'), isNull);
        expect(Speed.tryParse('10\u066B5 km/h'), isNull);
      });
    });

    group('Extended i18n separators', () {
      test('parses Arabic decimal/group separators with Arabic NumberFormat', () {
        final arFormat = QuantityFormat.withNumberFormat(
          NumberFormat.decimalPattern('ar_EG'),
        );

        final parsed = Speed.parse('١\u066C٢٣٤\u066B٥٦ m/s', formats: [arFormat]);
        expect(parsed.inMps, closeTo(1234.56, 1e-9));
      });

      test('rejects Arabic decimal marker with non-Arabic locale format', () {
        expect(
          Speed.tryParse('١\u066C٢٣٤\u066B٥٦ m/s', formats: [QuantityFormat.enUs]),
          isNull,
        );
      });
    });

    group('Error handling', () {
      test('empty formats list falls back to invariant format', () {
        final s = Speed.parse('100 km/h', formats: const []);
        expect(s.inKmh, 100.0);
      });

      test('tryParse returns null for invalid inputs', () {
        expect(Speed.tryParse(''), isNull);
        expect(Speed.tryParse('   '), isNull);
        expect(Speed.tryParse('10'), isNull);
        expect(Speed.tryParse('km/h'), isNull);
        expect(Speed.tryParse('not a speed'), isNull);
        expect(Speed.tryParse('10.5.2 km/h'), isNull);
        expect(Speed.tryParse('10 unknownUnit'), isNull);
        expect(Speed.tryParse('10 xyz'), isNull);
      });

      test('tryParse returns Speed for valid input', () {
        final s = Speed.tryParse('100 km/h');
        expect(s, isNotNull);
        expect(s!.value, 100.0);
        expect(s.unit, SpeedUnit.kilometerPerHour);
      });

      test('parse throws QuantityParseException for invalid inputs', () {
        expect(
          () => Speed.parse('   '),
          throwsA(
            isA<QuantityParseException>().having((e) => e.formatsAttempted, 'formatsAttempted', 1),
          ),
        );

        expect(
          () => Speed.parse('10 xyz'),
          throwsA(
            isA<QuantityParseException>().having(
              (e) => e.message,
              'message',
              contains('Failed to parse'),
            ),
          ),
        );

        // QuantityParseException is also a FormatException
        expect(
          () => Speed.parse('bad input'),
          throwsA(isA<FormatException>()),
        );
      });

      test('parse throws FormatException for invalid input', () {
        expect(() => Speed.parse('not a speed'), throwsFormatException);
        expect(() => Speed.parse(''), throwsFormatException);
        expect(() => Speed.parse('10 xyz'), throwsFormatException);
      });

      test('parse throws with correct formatsAttempted count', () {
        expect(
          () => Speed.parse(
            'not valid',
            formats: [QuantityFormat.enUs, QuantityFormat.de],
          ),
          throwsA(
            isA<QuantityParseException>().having((e) => e.formatsAttempted, 'formatsAttempted', 2),
          ),
        );
      });
    });
  });
}
