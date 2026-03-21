import 'package:quantify/quantify.dart';
import 'package:test/test.dart';

void main() {
  const tolerance = 1e-9;

  group('Time Parsing', () {
    group('Basic parsing', () {
      test('parses standard valid inputs with invariant format', () {
        expect(Time.parse('30 s').inSeconds, 30.0);
        expect(Time.parse('10.5 min').inMinutes, 10.5);
        expect(Time.parse('-5.2 ms').inMilliseconds, -5.2);
        expect(Time.parse('2e3 us').inMicroseconds, 2000.0);
        expect(Time.parse('1.5E-2 h').inHours, 0.015);
      });

      test('parses by symbol', () {
        final t = Time.parse('5 min');
        expect(t.value, 5.0);
        expect(t.unit, TimeUnit.minute);
      });

      test('parses by full name', () {
        final t = Time.parse('2 hours');
        expect(t.value, 2.0);
        expect(t.unit, TimeUnit.hour);
      });

      test('parses by plural name', () {
        final t = Time.parse('10 seconds');
        expect(t.value, 10.0);
        expect(t.unit, TimeUnit.second);
      });

      test('parses scientific notation', () {
        final t = Time.parse('1.5e2 s');
        expect(t.value, 150.0);
        expect(t.unit, TimeUnit.second);
      });

      test('parses negative values', () {
        final t = Time.parse('-10 min');
        expect(t.value, -10.0);
        expect(t.unit, TimeUnit.minute);
      });

      test('parses leading decimal point', () {
        final t = Time.parse('.5 h');
        expect(t.value, 0.5);
        expect(t.unit, TimeUnit.hour);
      });
    });

    group('Spacing', () {
      test('parses correctly regardless of spacing', () {
        expect(Time.parse('30s').inSeconds, 30.0);
        expect(Time.parse('30   s').inSeconds, 30.0);
        expect(Time.parse('30\ts').inSeconds, 30.0);
        expect(Time.parse('  30 s  ').inSeconds, 30.0);
      });

      test('parses without space between value and unit', () {
        final t = Time.parse('5min');
        expect(t.value, 5.0);
        expect(t.unit, TimeUnit.minute);
      });
    });

    group('SI prefix case-sensitivity', () {
      test('strictly enforces case-sensitivity for SI prefixes', () {
        final milli = Time.parse('100 ms');
        final mega = Time.parse('100 Ms');

        expect(milli.unit, TimeUnit.millisecond);
        expect(mega.unit, TimeUnit.megasecond);
        expect(milli.inSeconds, 0.1);
        expect(mega.inSeconds, 100000000.0);

        expect(Time.tryParse('100 mS'), isNull);
      });

      test('Ms = megasecond, ms = millisecond', () {
        expect(Time.parse('5 Ms').unit, TimeUnit.megasecond);
        expect(Time.parse('5 ms').unit, TimeUnit.millisecond);
      });

      test('Gs = gigasecond', () {
        final giga = Time.parse('2 Gs');
        expect(giga.value, 2.0);
        expect(giga.unit, TimeUnit.gigasecond);
      });

      test('wrong-case symbol returns null, not wrong unit', () {
        expect(Time.tryParse('10 MS'), isNull);
        expect(Time.tryParse('10 mS'), isNull);
        expect(Time.parse('10 Ms').unit, TimeUnit.megasecond);
        expect(Time.parse('10 ms').unit, TimeUnit.millisecond);
        expect(Time.parse('10 megaseconds').unit, TimeUnit.megasecond);
        expect(Time.parse('10 MILLISECONDS').unit, TimeUnit.millisecond);
      });
    });

    group('Case-insensitive names', () {
      test('full names are case-insensitive', () {
        expect(Time.parse('10 SECOND').unit, TimeUnit.second);
        expect(Time.parse('10 Seconds').unit, TimeUnit.second);
        expect(Time.parse('5 HOURS').unit, TimeUnit.hour);
        expect(Time.parse('5 Hour').unit, TimeUnit.hour);
      });

      test('abbreviations in nameAliases are case-insensitive', () {
        expect(Time.parse('10 MIN').unit, TimeUnit.minute);
        expect(Time.parse('10 Min').unit, TimeUnit.minute);
        expect(Time.parse('2 HR').unit, TimeUnit.hour);
        expect(Time.parse('2 Hr').unit, TimeUnit.hour);
      });

      test('word forms match case-insensitively; symbols require exact case', () {
        final t = Time.parse('5 MINUTES');
        expect(t.value, 5.0);
        expect(t.unit, TimeUnit.minute);

        expect(Time.tryParse('5 MIN'), isNotNull); // nameAlias
        expect(Time.parse('5 min').unit, TimeUnit.minute); // symbolAlias
      });
    });

    group('Unit coverage', () {
      test('parses small time units', () {
        final us = Time.parse('500 us');
        expect(us.value, 500.0);
        expect(us.unit, TimeUnit.microsecond);

        final ns = Time.parse('1000 ns');
        expect(ns.value, 1000.0);
        expect(ns.unit, TimeUnit.nanosecond);

        final ps = Time.parse('100 ps');
        expect(ps.value, 100.0);
        expect(ps.unit, TimeUnit.picosecond);
      });

      test('parses calendar units', () {
        final day = Time.parse('7 d');
        expect(day.value, 7.0);
        expect(day.unit, TimeUnit.day);

        final week = Time.parse('2 weeks');
        expect(week.value, 2.0);
        expect(week.unit, TimeUnit.week);

        final month = Time.parse('6 months');
        expect(month.value, 6.0);
        expect(month.unit, TimeUnit.month);

        final year = Time.parse('5 years');
        expect(year.value, 5.0);
        expect(year.unit, TimeUnit.year);
      });

      test('parses fortnight, decade, century', () {
        final fn = Time.parse('1 fortnight');
        expect(fn.value, 1.0);
        expect(fn.unit, TimeUnit.fortnight);

        final dec = Time.parse('2 decades');
        expect(dec.value, 2.0);
        expect(dec.unit, TimeUnit.decade);

        final c = Time.parse('3 centuries');
        expect(c.value, 3.0);
        expect(c.unit, TimeUnit.century);
      });

      test('parsed value should be usable in conversions', () {
        final t = Time.parse('1 min');
        expect(t.getValue(TimeUnit.second), closeTo(60.0, tolerance));
      });
    });

    group('Invariant format strictness', () {
      test('invariant format accepts visual grouping separators', () {
        expect(Time.parse('1 000 s').inSeconds, 1000.0);
        expect(Time.parse('1\u00A0000 s').inSeconds, 1000.0);
        expect(Time.parse('1\u202F000 s').inSeconds, 1000.0);
        expect(Time.parse("1'000 s").inSeconds, 1000.0);
      });

      test('invariant format still rejects locale decimal separators', () {
        expect(Time.tryParse('10,5 s'), isNull);
        expect(Time.tryParse('10;5 s'), isNull);
      });
    });

    group('Error handling', () {
      test('tryParse returns null for invalid input', () {
        expect(Time.tryParse('invalid'), isNull);
        expect(Time.tryParse('10'), isNull);
        expect(Time.tryParse('nope seconds'), isNull);
        expect(Time.tryParse('10 xyz'), isNull);
      });

      test('parse throws QuantityParseException for invalid input', () {
        expect(
          () => Time.parse('invalid'),
          throwsA(isA<QuantityParseException>()),
        );
        expect(
          () => Time.parse('10'),
          throwsA(isA<QuantityParseException>()),
        );
        expect(
          () => Time.parse('10 xyz'),
          throwsA(isA<QuantityParseException>()),
        );
      });
    });

    group('Round-trip', () {
      test('parse and format round-trip correctly', () {
        const original = Time(42.5, TimeUnit.minute);
        final formatted = original.toString(format: QuantityFormat.invariant);
        final parsed = Time.parse(formatted);

        expect(parsed.value, closeTo(original.value, tolerance));
        expect(parsed.unit, original.unit);
      });
    });
  });
}
