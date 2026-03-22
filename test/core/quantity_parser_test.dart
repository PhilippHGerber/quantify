// Tests pass `formats: const [QuantityFormat.invariant]` explicitly to
// document intent even though it matches the default — clarity over brevity.
// ignore_for_file: avoid_redundant_argument_values

import 'package:intl/intl.dart';
import 'package:quantify/quantify.dart';
import 'package:test/test.dart';

/// Comprehensive tests for [QuantityParser] and [QuantityParseException].
///
/// Uses [Length] and [Temperature] as concrete types because they exercise
/// the widest variety of symbols, SI-prefix case sensitivity, and (for
/// Temperature) non-linear conversion — ensuring the parser is quantity-agnostic.
void main() {
  // ─────────────────────────────────────────────────────────────────────────
  // Helper shortcuts
  // ─────────────────────────────────────────────────────────────────────────

  const tolerance = 1e-9;

  // ─────────────────────────────────────────────────────────────────────────
  // 1. NUMERIC FORMATS — what the parser accepts as a number
  // ─────────────────────────────────────────────────────────────────────────

  group('Numeric formats', () {
    group('Integers', () {
      test('plain integer', () {
        expect(Length.parse('42 m').value, 42.0);
      });

      test('zero', () {
        expect(Length.parse('0 m').value, 0.0);
      });

      test('large integer', () {
        expect(Length.parse('1000000 m').value, 1000000.0);
      });

      test('positive sign prefix', () {
        expect(Length.parse('+10 m').value, 10.0);
      });

      test('negative sign prefix', () {
        expect(Length.parse('-10 m').value, -10.0);
      });
    });

    group('Decimals', () {
      test('decimal fraction', () {
        expect(Length.parse('3.14 m').value, closeTo(3.14, tolerance));
      });

      test('negative decimal', () {
        expect(Length.parse('-3.14 m').value, closeTo(-3.14, tolerance));
      });

      test('leading decimal point (.5)', () {
        expect(Length.parse('.5 m').value, 0.5);
      });

      test('negative leading decimal (-.5)', () {
        expect(Length.parse('-.5 m').value, -0.5);
      });

      test('positive leading decimal (+.5)', () {
        expect(Length.parse('+.5 m').value, 0.5);
      });

      test('zero decimal (.0)', () {
        expect(Length.parse('.0 m').value, 0.0);
      });

      test('trailing decimal separator (1.)', () {
        // "1." is valid for double.tryParse — parser must not block it.
        expect(Length.parse('1. m').value, 1.0);
      });
    });

    group('Scientific notation', () {
      test('lowercase e', () {
        expect(Length.parse('1e3 m').value, 1000.0);
      });

      test('uppercase E', () {
        expect(Length.parse('1E3 m').value, 1000.0);
      });

      test('negative exponent', () {
        expect(Length.parse('1.5e-3 m').value, 0.0015);
      });

      test('positive explicit sign on exponent', () {
        expect(Length.parse('2.5E+2 m').value, 250.0);
      });

      test('zero exponent', () {
        expect(Length.parse('9e0 m').value, 9.0);
      });

      test('negative value + scientific', () {
        expect(Length.parse('-2e3 m').value, -2000.0);
      });
    });

    group('Special float literals', () {
      test('NaN', () {
        expect(Length.parse('NaN m').value, isNaN);
      });

      test('Infinity', () {
        expect(Length.parse('Infinity m').value, double.infinity);
      });

      test('+Infinity', () {
        expect(Length.parse('+Infinity m').value, double.infinity);
      });

      test('-Infinity', () {
        expect(Length.parse('-Infinity m').value, double.negativeInfinity);
      });

      test('special values preserve unit', () {
        expect(Length.parse('NaN km').unit, LengthUnit.kilometer);
        expect(Length.parse('Infinity km').unit, LengthUnit.kilometer);
      });

      test('lowercase "infinity" is NOT a special literal — rejected', () {
        // Only the exact Dart spelling is recognised.
        expect(Length.tryParse('infinity m'), isNull);
        expect(Length.tryParse('nan m'), isNull);
      });
    });

    group('Visual grouping separators (invariant mode)', () {
      // These chars are stripped before numeric parsing — all should succeed.

      test('ASCII space grouping (SI 1 000)', () {
        expect(Length.parse('1 000 m').value, 1000.0);
      });

      test('non-breaking space (U+00A0)', () {
        expect(Length.parse('1\u00A0000 m').value, 1000.0);
      });

      test('narrow no-break space (U+202F)', () {
        expect(Length.parse('1\u202F000 m').value, 1000.0);
      });

      test("straight apostrophe grouping (de_CH 1'000)", () {
        expect(Length.parse("1'000 m").value, 1000.0);
      });

      test('left single quotation mark (U+2018)', () {
        expect(Length.parse('1\u2018000 m').value, 1000.0);
      });

      test('right single quotation mark (U+2019)', () {
        expect(Length.parse('1\u2019000 m').value, 1000.0);
      });

      test('Arabic thousands separator (U+066C)', () {
        // Strip-only path — invariant does not interpret it as a group sep.
        expect(Length.parse('1\u066C000 m').value, 1000.0);
      });

      test('multi-group: 1 000 000', () {
        expect(Length.parse('1 000 000 m').value, 1000000.0);
      });

      test('grouped integer with decimal (1 000.5)', () {
        expect(Length.parse('1 000.5 m').value, 1000.5);
      });
    });

    group('Apostrophe grouping — 3-digit strictness', () {
      test("1'000 (3 digits) accepted", () {
        expect(Length.tryParse("1'000 m"), isNotNull);
      });

      test("1'000'000 (two 3-digit groups) accepted", () {
        expect(Length.tryParse("1'000'000 m"), isNotNull);
      });

      test("1'23 (2-digit group) rejected", () {
        // Protects against composite imperial feet-inch notation like 6'2".
        expect(Length.tryParse("1'23 m"), isNull);
      });

      test("12'34'567 (variable grouping) rejected for apostrophes", () {
        expect(Length.tryParse("12'34'567 m"), isNull);
      });
    });

    group('Comma as decimal — invariant mode rejects', () {
      test('comma decimal rejected in invariant mode', () {
        expect(Length.tryParse('10,5 km'), isNull);
      });

      test('Arabic decimal separator rejected in invariant mode', () {
        expect(Length.tryParse('10\u066B5 km'), isNull);
      });
    });

    group('Arabic-Indic digits', () {
      test('Arabic-Indic digits parsed via Arabic locale format', () {
        final arFormat = QuantityFormat.withNumberFormat(
          NumberFormat.decimalPattern('ar_EG'),
        );
        // ١٢٣٤٫٥٦ (1234.56 in Arabic)
        final parsed = Length.parse('١٢٣٤\u066B٥٦ km', formats: [arFormat]);
        expect(parsed.inKm, closeTo(1234.56, tolerance));
      });

      test('Arabic digits with Arabic group separator', () {
        final arFormat = QuantityFormat.withNumberFormat(
          NumberFormat.decimalPattern('ar_EG'),
        );
        // ١٬٢٣٤٫٥٦  (1,234.56 using Arabic group/decimal separators)
        final parsed = Length.parse('١\u066C٢٣٤\u066B٥٦ km', formats: [arFormat]);
        expect(parsed.inKm, closeTo(1234.56, tolerance));
      });

      test('Arabic decimal marker rejected in non-Arabic locale', () {
        expect(
          Length.tryParse('١\u066C٢٣٤\u066B٥٦ km', formats: [QuantityFormat.enUs]),
          isNull,
        );
      });
    });

    group('Invalid numeric forms', () {
      test('double decimal point (10.5.2)', () {
        expect(Length.tryParse('10.5.2 m'), isNull);
      });

      test('letter-only input', () {
        expect(Length.tryParse('abc m'), isNull);
      });

      test('no numeric part — only a unit', () {
        expect(Length.tryParse('km'), isNull);
      });

      test('no unit part — only a number', () {
        expect(Length.tryParse('10'), isNull);
      });

      test('empty string', () {
        expect(Length.tryParse(''), isNull);
      });

      test('whitespace-only string', () {
        expect(Length.tryParse('   '), isNull);
        expect(Length.tryParse('\t\n'), isNull);
      });

      test('completely random text', () {
        expect(Length.tryParse('not a length'), isNull);
      });
    });
  });

  // ─────────────────────────────────────────────────────────────────────────
  // 2. UNIT LOOKUP — symbol vs. name, case rules
  // ─────────────────────────────────────────────────────────────────────────

  group('Unit lookup', () {
    group('Symbol lookup is case-sensitive', () {
      test('lowercase mm → millimeter', () {
        expect(Length.parse('10 mm').unit, LengthUnit.millimeter);
      });

      test('uppercase Mm → megameter', () {
        expect(Length.parse('10 Mm').unit, LengthUnit.megameter);
      });

      test('wrong case MM → null', () {
        expect(Length.tryParse('10 MM'), isNull);
      });

      test('wrong case mM → null', () {
        expect(Length.tryParse('10 mM'), isNull);
      });

      test('km symbol (exact case)', () {
        expect(Length.parse('5 km').unit, LengthUnit.kilometer);
      });

      test('KM (wrong case) → null', () {
        expect(Length.tryParse('5 KM'), isNull);
      });

      test('Gm → gigameter', () {
        expect(Length.parse('1 Gm').unit, LengthUnit.gigameter);
      });

      test('gM (wrong case) → null', () {
        expect(Length.tryParse('1 gM'), isNull);
      });

      test('AU (exact) → astronomical unit', () {
        expect(Length.parse('1 AU').unit, LengthUnit.astronomicalUnit);
      });

      test('au (wrong case for symbol) resolves via name alias', () {
        // 'au' is a registered name alias for astronomicalUnit,
        // so it succeeds via case-insensitive name lookup even though
        // the symbol 'AU' is case-sensitive.
        expect(Length.parse('1 au').unit, LengthUnit.astronomicalUnit);
      });
    });

    group('Name lookup is case-insensitive', () {
      test('lowercase name', () {
        expect(Length.parse('5 meters').unit, LengthUnit.meter);
      });

      test('UPPERCASE name', () {
        expect(Length.parse('5 METERS').unit, LengthUnit.meter);
      });

      test('mixed-case name', () {
        expect(Length.parse('5 Meters').unit, LengthUnit.meter);
      });

      test('crazy mixed case', () {
        expect(Length.parse('5 kIlOmEtErS').unit, LengthUnit.kilometer);
      });

      test('plural name', () {
        expect(Length.parse('5 kilometres').unit, LengthUnit.kilometer);
      });

      test('Temperature full names', () {
        expect(Temperature.parse('100 celsius').unit, TemperatureUnit.celsius);
        expect(Temperature.parse('100 CELSIUS').unit, TemperatureUnit.celsius);
        expect(Temperature.parse('100 Kelvin').unit, TemperatureUnit.kelvin);
        expect(Temperature.parse('100 FAHRENHEIT').unit, TemperatureUnit.fahrenheit);
        expect(Temperature.parse('100 Rankine').unit, TemperatureUnit.rankine);
      });
    });

    group('Multi-word unit names', () {
      test('nautical mile (single space)', () {
        expect(Length.parse('5 nautical mile').unit, LengthUnit.nauticalMile);
      });

      test('nautical mile (multiple spaces) — whitespace normalised', () {
        expect(Length.parse('5 nautical  mile').unit, LengthUnit.nauticalMile);
        expect(Length.parse('5 nautical   mile').unit, LengthUnit.nauticalMile);
      });

      test('light-years hyphenated symbol', () {
        expect(Length.parse('1 light-years').unit, LengthUnit.lightYear);
      });

      test('light years name', () {
        expect(Length.parse('1 light years').unit, LengthUnit.lightYear);
      });

      test('light  years (extra spaces)', () {
        expect(Length.parse('1 light  years').unit, LengthUnit.lightYear);
      });
    });

    group('Unknown units', () {
      test('completely unknown symbol → null', () {
        expect(Length.tryParse('10 xyz'), isNull);
      });

      test('unknown multi-word unit → null', () {
        expect(Length.tryParse('10 unknown unit'), isNull);
      });

      test('empty unit after number → null', () {
        // "10 " has trailing space but after trimming no unit.
        expect(Length.tryParse('10 '), isNull);
      });
    });
  });

  // ─────────────────────────────────────────────────────────────────────────
  // 3. SPACING BETWEEN NUMBER AND UNIT
  // ─────────────────────────────────────────────────────────────────────────

  group('Spacing between number and unit', () {
    test('no space', () {
      expect(Length.parse('10m').value, 10.0);
      expect(Length.parse('10m').unit, LengthUnit.meter);
    });

    test('single space', () {
      expect(Length.parse('10 m').value, 10.0);
    });

    test('multiple spaces', () {
      expect(Length.parse('10   m').value, 10.0);
    });

    test('tab character', () {
      expect(Length.parse('10\tm').value, 10.0);
    });

    test('leading/trailing whitespace around the whole string', () {
      expect(Length.parse('  10 m  ').value, 10.0);
    });

    test('no space for decimal value', () {
      expect(Length.parse('10.5km').value, 10.5);
      expect(Length.parse('10.5km').unit, LengthUnit.kilometer);
    });
  });

  // ─────────────────────────────────────────────────────────────────────────
  // 4. LOCALE FORMATS
  // ─────────────────────────────────────────────────────────────────────────

  group('Locale formats', () {
    group('Invariant (default)', () {
      test('dot decimal accepted', () {
        expect(Length.parse('1234.56 m').value, closeTo(1234.56, tolerance));
      });

      test('comma decimal rejected', () {
        expect(Length.tryParse('1234,56 m'), isNull);
      });

      test('explicit invariant format same as default', () {
        expect(
          Length.parse('10 m', formats: const [QuantityFormat.invariant]).value,
          10.0,
        );
      });

      test('empty formats list falls back to invariant', () {
        expect(Length.parse('10 m', formats: const []).value, 10.0);
      });
    });

    group('en_US (dot decimal, comma thousands)', () {
      test('comma as thousands separator', () {
        final result = Length.parse('1,234.56 m', formats: [QuantityFormat.enUs]);
        expect(result.value, closeTo(1234.56, tolerance));
      });

      test('rejects comma as decimal', () {
        expect(
          Length.tryParse('1,234 m', formats: [QuantityFormat.de, QuantityFormat.enUs]),
          isNotNull, // de interprets it as decimal → 1.234
        );
        // en_US sees "1,234" as 1234 (thousands), not 1.234:
        final usFirst = Length.parse('1,234 m', formats: [QuantityFormat.enUs]);
        expect(usFirst.value, closeTo(1234.0, tolerance));
      });

      test('rejects German-style number under en_US', () {
        expect(
          Length.tryParse('1.234,56 m', formats: [QuantityFormat.enUs]),
          isNull,
        );
      });

      test('dot as decimal in en_US', () {
        final result = Length.parse('3.14 m', formats: [QuantityFormat.enUs]);
        expect(result.value, closeTo(3.14, tolerance));
      });
    });

    group('de_DE (comma decimal, dot thousands)', () {
      test('dot as thousands, comma as decimal', () {
        final result = Length.parse('1.234,56 m', formats: [QuantityFormat.de]);
        expect(result.value, closeTo(1234.56, tolerance));
      });

      test('rejects dot-decimal under de_DE', () {
        expect(
          Length.tryParse('1,234.56 m', formats: [QuantityFormat.de]),
          isNull,
        );
      });

      test('simple comma decimal', () {
        final result = Length.parse('3,14 m', formats: [QuantityFormat.de]);
        expect(result.value, closeTo(3.14, tolerance));
      });
    });

    group('de_CH (apostrophe thousands, dot decimal)', () {
      late QuantityFormat chFormat;
      setUp(() {
        chFormat = QuantityFormat.withNumberFormat(
          NumberFormat.decimalPattern('de_CH'),
        );
      });

      test('right single quote grouping: 1\u2019234.56', () {
        final result = Length.parse('1\u2019234.56 km', formats: [chFormat]);
        expect(result.inKm, closeTo(1234.56, tolerance));
      });

      test("1'000 apostrophe grouping", () {
        final result = Length.parse("1'000 m", formats: [chFormat]);
        expect(result.value, closeTo(1000.0, tolerance));
      });

      test("1'000'000 double group", () {
        final result = Length.parse("1'000'000 m", formats: [chFormat]);
        expect(result.value, closeTo(1000000.0, tolerance));
      });

      test("1'234.56 grouped with decimal", () {
        final result = Length.parse("1'234.56 km", formats: [chFormat]);
        expect(result.inKm, closeTo(1234.56, tolerance));
      });

      test('composite quote notation still rejected under de_CH', () {
        expect(Length.tryParse('6\'2"', formats: [chFormat]), isNull);
      });
    });

    group('hi_IN (variable digit grouping)', () {
      test('Indian 2-2-3 grouping (12,34,567)', () {
        final hiFormat = QuantityFormat.withNumberFormat(
          NumberFormat.decimalPattern('hi_IN'),
        );
        final result = Length.parse('12,34,567 m', formats: [hiFormat]);
        expect(result.value, closeTo(1234567.0, tolerance));
      });
    });

    group('QuantityFormat.withNumberFormat factory', () {
      test('explicit de_DE NumberFormat instance', () {
        final fmt = QuantityFormat.withNumberFormat(
          NumberFormat.decimalPattern('de_DE'),
        );
        final result = Length.parse('1.234,56 m', formats: [fmt]);
        expect(result.value, closeTo(1234.56, tolerance));
      });

      test('explicit en_US NumberFormat instance', () {
        final fmt = QuantityFormat.withNumberFormat(
          NumberFormat.decimalPattern('en_US'),
        );
        final result = Length.parse('1,234.56 m', formats: [fmt]);
        expect(result.value, closeTo(1234.56, tolerance));
      });
    });

    group('QuantityFormat.forLocale constructor', () {
      test('parses with forLocale de_DE with fractionDigits', () {
        const fmt = QuantityFormat.forLocale('de_DE', fractionDigits: 2);
        final result = Length.parse('1.234,56 m', formats: [fmt]);
        expect(result.value, closeTo(1234.56, tolerance));
      });

      test('parses with forLocale en_US with custom separator', () {
        const fmt = QuantityFormat.forLocale('en_US', unitSymbolSeparator: ' ');
        final result = Length.parse('1,234.56 m', formats: [fmt]);
        expect(result.value, closeTo(1234.56, tolerance));
      });
    });
  });

  // ─────────────────────────────────────────────────────────────────────────
  // 5. _isStrictlyValidForNumberFormat EDGE CASES
  // ─────────────────────────────────────────────────────────────────────────

  group('Format validation edge cases', () {
    group('Alien character rejection', () {
      test('dot in de_DE (decimal=comma, group=dot) is the group sep — allowed', () {
        // "1.234" under de_DE: dot is group sep, so it is NOT alien.
        final result = Length.parse('1.234 m', formats: [QuantityFormat.de]);
        expect(result.value, closeTo(1234.0, tolerance));
      });

      test('comma in de_DE is the decimal sep — allowed', () {
        final result = Length.parse('1,5 m', formats: [QuantityFormat.de]);
        expect(result.value, closeTo(1.5, tolerance));
      });

      test('dot in en_US is the decimal sep — allowed', () {
        final result = Length.parse('1.5 m', formats: [QuantityFormat.enUs]);
        expect(result.value, closeTo(1.5, tolerance));
      });

      test('comma in en_US is the group sep — allowed', () {
        final result = Length.parse('1,234 m', formats: [QuantityFormat.enUs]);
        expect(result.value, closeTo(1234.0, tolerance));
      });
    });

    group('Multiple decimal separators', () {
      test('two dots under en_US → rejected', () {
        expect(
          Length.tryParse('1.2.3 m', formats: [QuantityFormat.enUs]),
          isNull,
        );
      });

      test('two commas under de_DE → rejected', () {
        expect(
          Length.tryParse('1,2,3 m', formats: [QuantityFormat.de]),
          isNull,
        );
      });
    });

    group('Group separator after decimal separator', () {
      test('comma after dot in en_US (1.234,5) → rejected', () {
        // "1.234,5" under en_US: comma (group) appears after dot (decimal).
        expect(
          Length.tryParse('1.234,5 m', formats: [QuantityFormat.enUs]),
          isNull,
        );
      });

      test('dot after comma in de_DE (1,234.5) → rejected', () {
        // "1,234.5" under de_DE: dot (group) appears after comma (decimal).
        expect(
          Length.tryParse('1,234.5 m', formats: [QuantityFormat.de]),
          isNull,
        );
      });
    });

    group('Inverted dot/comma placement', () {
      test('de-style number rejected by en_US format', () {
        // "1.234,56": under en_US last dot < last comma — structurally wrong.
        expect(
          Length.tryParse('1.234,56 m', formats: [QuantityFormat.enUs]),
          isNull,
        );
      });

      test('en-style number rejected by de_DE format', () {
        // "1,234.56": under de_DE last comma < last dot — structurally wrong.
        expect(
          Length.tryParse('1,234.56 m', formats: [QuantityFormat.de]),
          isNull,
        );
      });
    });
  });

  // ─────────────────────────────────────────────────────────────────────────
  // 6. MULTI-FORMAT FALLBACK
  // ─────────────────────────────────────────────────────────────────────────

  group('Multi-format fallback', () {
    test('first format wins on success', () {
      // "1,234 m": en_US succeeds first (→ 1234), de would give 1.234
      final result = Length.parse(
        '1,234 m',
        formats: [QuantityFormat.enUs, QuantityFormat.de],
      );
      expect(result.value, closeTo(1234.0, tolerance));
    });

    test('falls through to second format when first fails', () {
      // "1.234,56 m": invariant fails, de succeeds.
      final result = Length.parse(
        '1.234,56 m',
        formats: [QuantityFormat.invariant, QuantityFormat.de],
      );
      expect(result.value, closeTo(1234.56, tolerance));
    });

    test('en_US then de: ambiguous "1.234,56" falls through to de', () {
      final result = Length.parse(
        '1.234,56 m',
        formats: [QuantityFormat.enUs, QuantityFormat.de],
      );
      expect(result.value, closeTo(1234.56, tolerance));
    });

    test('de then en_US: "1.234,56" succeeds on first (de)', () {
      final result = Length.parse(
        '1.234,56 m',
        formats: [QuantityFormat.de, QuantityFormat.enUs],
      );
      expect(result.value, closeTo(1234.56, tolerance));
    });

    test('all formats fail → tryParse returns null', () {
      expect(
        Length.tryParse(
          'garbage m',
          formats: [QuantityFormat.invariant, QuantityFormat.enUs, QuantityFormat.de],
        ),
        isNull,
      );
    });

    test('all formats fail → parse throws with correct formatsAttempted', () {
      expect(
        () => Length.parse(
          'bad value m',
          formats: [QuantityFormat.enUs, QuantityFormat.de],
        ),
        throwsA(
          isA<QuantityParseException>().having((e) => e.formatsAttempted, 'formatsAttempted', 2),
        ),
      );
    });

    test('three formats: formatsAttempted equals list length on failure', () {
      const fmt3 = QuantityFormat.forLocale('fr_FR');
      expect(
        () => Length.parse(
          'bad m',
          formats: [QuantityFormat.invariant, QuantityFormat.enUs, fmt3],
        ),
        throwsA(
          isA<QuantityParseException>().having((e) => e.formatsAttempted, 'formatsAttempted', 3),
        ),
      );
    });
  });

  // ─────────────────────────────────────────────────────────────────────────
  // 7. COMPOSITE / AMBIGUITY — feet-inch notation rejection
  // ─────────────────────────────────────────────────────────────────────────

  group('Composite notation rejection', () {
    test("6'2\" rejected (apostrophe group not 3 digits)", () {
      expect(Length.tryParse('6\'2"'), isNull);
    });

    test("6' 2\" rejected", () {
      expect(Length.tryParse("6' 2\""), isNull);
    });

    test('6\u20182" rejected (left-quote)', () {
      expect(Length.tryParse('6\u20182"'), isNull);
    });

    test("6'2.5\" rejected", () {
      expect(Length.tryParse("6'2.5\""), isNull);
    });

    test("6' 2 in rejected", () {
      expect(Length.tryParse("6' 2 in"), isNull);
    });

    test("single-quote foot symbol still parses (6')", () {
      expect(Length.parse("6'").unit, LengthUnit.foot);
      expect(Length.parse("6'").value, 6.0);
    });

    test('inch symbol (") still parses (2")', () {
      expect(Length.parse('2"').unit, LengthUnit.inch);
      expect(Length.parse('2"').value, 2.0);
    });

    test("6'000\" is valid (3-digit apostrophe grouping)", () {
      // 6000 inches — apostrophe is a valid thousands separator here.
      expect(Length.tryParse("6'000\""), isNotNull);
      expect(Length.parse("6'000\"").value, 6000.0);
      expect(Length.parse("6'000\"").unit, LengthUnit.inch);
    });
  });

  // ─────────────────────────────────────────────────────────────────────────
  // 8. parse vs. tryParse SEMANTICS
  // ─────────────────────────────────────────────────────────────────────────

  group('parse vs. tryParse', () {
    test('tryParse returns null for unparseable input', () {
      expect(Length.tryParse('garbage'), isNull);
      expect(Length.tryParse(''), isNull);
      expect(Length.tryParse('10'), isNull);
    });

    test('tryParse returns the quantity for valid input', () {
      final result = Length.tryParse('10.5 km');
      expect(result, isNotNull);
      expect(result!.value, 10.5);
      expect(result.unit, LengthUnit.kilometer);
    });

    test('parse throws FormatException for unparseable input', () {
      expect(() => Length.parse('garbage'), throwsFormatException);
    });

    test('parse returns the quantity for valid input', () {
      final result = Length.parse('10.5 km');
      expect(result.value, 10.5);
      expect(result.unit, LengthUnit.kilometer);
    });
  });

  // ─────────────────────────────────────────────────────────────────────────
  // 9. QuantityParseException PROPERTIES
  // ─────────────────────────────────────────────────────────────────────────

  group('QuantityParseException', () {
    QuantityParseException captureException(void Function() fn) {
      try {
        fn();
        fail('Expected QuantityParseException to be thrown');
      } on QuantityParseException catch (e) {
        return e;
      }
    }

    test('is a FormatException', () {
      expect(
        () => Length.parse('bad input'),
        throwsA(isA<FormatException>()),
      );
    });

    test('is a QuantityParseException', () {
      expect(
        () => Length.parse('bad input'),
        throwsA(isA<QuantityParseException>()),
      );
    });

    test('input property preserves the original string', () {
      final e = captureException(() => Length.parse('garbage xyz'));
      expect(e.input, 'garbage xyz');
    });

    test('input property on empty string', () {
      final e = captureException(() => Length.parse(''));
      expect(e.input, '');
    });

    test('targetType property contains quantity type name', () {
      final e = captureException(() => Length.parse('bad'));
      expect(e.targetType, contains('Length'));
    });

    test('targetType property for Temperature', () {
      final e = captureException(() => Temperature.parse('bad'));
      expect(e.targetType, contains('Temperature'));
    });

    test('formatsAttempted is 1 for default single-format parse', () {
      final e = captureException(() => Length.parse('bad'));
      expect(e.formatsAttempted, 1);
    });

    test('formatsAttempted matches number of formats supplied', () {
      final e = captureException(
        () => Length.parse(
          'bad',
          formats: [QuantityFormat.invariant, QuantityFormat.enUs, QuantityFormat.de],
        ),
      );
      expect(e.formatsAttempted, 3);
    });

    test('message contains "Failed to parse"', () {
      final e = captureException(() => Length.parse('10 xyz'));
      expect(e.message, contains('Failed to parse'));
    });

    test('message contains the input string', () {
      final e = captureException(() => Length.parse('10 xyz'));
      expect(e.message, contains('10 xyz'));
    });

    test('formatsAttempted is 1 when empty list supplied (fallback to invariant)', () {
      final e = captureException(
        () => Length.parse('bad', formats: const []),
      );
      expect(e.formatsAttempted, 1);
    });
  });

  // ─────────────────────────────────────────────────────────────────────────
  // 10. copyWithAliases
  // ─────────────────────────────────────────────────────────────────────────

  group('copyWithAliases', () {
    group('Extra name aliases', () {
      test('custom name alias parsed case-insensitively', () {
        final parser = Length.parser.copyWithAliases(
          extraNameAliases: {'pulgada': LengthUnit.inch},
        );
        expect(parser.parse('5 pulgada').unit, LengthUnit.inch);
        expect(parser.parse('5 PULGADA').unit, LengthUnit.inch);
        expect(parser.parse('5 Pulgada').unit, LengthUnit.inch);
      });

      test('original parser unaffected by extra name alias', () {
        Length.parser.copyWithAliases(
          extraNameAliases: {'pulgada': LengthUnit.inch},
        );
        expect(Length.tryParse('5 pulgada'), isNull);
      });

      test('extra name with leading/trailing whitespace normalised', () {
        final parser = Length.parser.copyWithAliases(
          extraNameAliases: {'  pulgada  ': LengthUnit.inch},
        );
        expect(parser.tryParse('5 pulgada'), isNotNull);
      });

      test('extra name with internal double space normalised', () {
        final parser = Length.parser.copyWithAliases(
          extraNameAliases: {'nautical  mile': LengthUnit.nauticalMile},
        );
        // Already a name alias, but the normalisation must be idempotent.
        expect(parser.tryParse('5 nautical mile'), isNotNull);
      });
    });

    group('Extra symbol aliases', () {
      test('custom symbol alias is case-sensitive', () {
        final parser = Length.parser.copyWithAliases(
          extraSymbolAliases: {'myKM': LengthUnit.kilometer},
        );
        expect(parser.parse('10 myKM').unit, LengthUnit.kilometer);
        expect(parser.tryParse('10 MYKM'), isNull); // wrong case
        expect(parser.tryParse('10 mykm'), isNull); // wrong case
      });

      test('symbol alias with surrounding whitespace stripped', () {
        final parser = Length.parser.copyWithAliases(
          extraSymbolAliases: {' myKM ': LengthUnit.kilometer},
        );
        expect(parser.tryParse('10 myKM'), isNotNull);
      });

      test('original parser unaffected by extra symbol alias', () {
        Length.parser.copyWithAliases(
          extraSymbolAliases: {'myKM': LengthUnit.kilometer},
        );
        expect(Length.tryParse('10 myKM'), isNull);
      });
    });

    group('Multiple copyWithAliases calls', () {
      test('chained copies accumulate aliases independently', () {
        final step1 = Length.parser.copyWithAliases(
          extraNameAliases: {'pie': LengthUnit.foot},
        );
        final step2 = step1.copyWithAliases(
          extraNameAliases: {'pulgada': LengthUnit.inch},
        );

        expect(step2.parse('6 pie').unit, LengthUnit.foot);
        expect(step2.parse('12 pulgada').unit, LengthUnit.inch);

        // step1 does not have pulgada
        expect(step1.tryParse('12 pulgada'), isNull);
      });
    });

    group('Overriding built-in aliases', () {
      test('extra alias can remap an existing symbol to a different unit', () {
        // Normally "in" maps to LengthUnit.inch; remap it.
        final parser = Length.parser.copyWithAliases(
          extraSymbolAliases: {'in': LengthUnit.meter},
        );
        // Symbol lookup hits the merged map: "in" → meter (override wins).
        expect(parser.parse('1 in').unit, LengthUnit.meter);
      });
    });
  });

  // ─────────────────────────────────────────────────────────────────────────
  // 11. ROUND-TRIP SYMMETRY
  // ─────────────────────────────────────────────────────────────────────────

  group('Round-trip toString → parse', () {
    test('invariant toString → parse', () {
      const original = Length(1234.56, LengthUnit.meter);
      final str = original.toString();
      final parsed = Length.parse(str);
      expect(parsed.value, closeTo(1234.56, tolerance));
      expect(parsed.unit, LengthUnit.meter);
    });

    test('de_DE format round-trip', () {
      const original = Length(1234.56, LengthUnit.kilometer);
      const fmt = QuantityFormat.forLocale('de_DE', fractionDigits: 2);
      final str = original.toString(format: fmt);
      final parsed = Length.parse(str, formats: [fmt]);
      expect(parsed.value, closeTo(1234.56, 1e-2));
      expect(parsed.unit, LengthUnit.kilometer);
    });

    test('en_US format round-trip', () {
      const original = Length(9876.5, LengthUnit.meter);
      const fmt = QuantityFormat.forLocale('en_US', fractionDigits: 1);
      final str = original.toString(format: fmt);
      final parsed = Length.parse(str, formats: [fmt]);
      expect(parsed.value, closeTo(9876.5, 1e-1));
      expect(parsed.unit, LengthUnit.meter);
    });

    test('Temperature round-trip', () {
      const original = Temperature(37, TemperatureUnit.celsius);
      final str = original.toString();
      final parsed = Temperature.parse(str);
      expect(parsed.value, closeTo(37.0, tolerance));
      expect(parsed.unit, TemperatureUnit.celsius);
    });
  });

  // ─────────────────────────────────────────────────────────────────────────
  // 12. UNIT COVERAGE SMOKE TESTS
  // ─────────────────────────────────────────────────────────────────────────

  group('Unit coverage — all Length units parse', () {
    final cases = <String, LengthUnit>{
      'm': LengthUnit.meter,
      'km': LengthUnit.kilometer,
      'cm': LengthUnit.centimeter,
      'mm': LengthUnit.millimeter,
      'um': LengthUnit.micrometer,
      'nm': LengthUnit.nanometer,
      'pm': LengthUnit.picometer,
      'Mm': LengthUnit.megameter,
      'Gm': LengthUnit.gigameter,
      'ft': LengthUnit.foot,
      'in': LengthUnit.inch,
      'yd': LengthUnit.yard,
      'mi': LengthUnit.mile,
      'nmi': LengthUnit.nauticalMile,
      'AU': LengthUnit.astronomicalUnit,
      'ly': LengthUnit.lightYear,
      'pc': LengthUnit.parsec,
    };

    for (final entry in cases.entries) {
      test('symbol "${entry.key}" → ${entry.value}', () {
        final result = Length.tryParse('1 ${entry.key}');
        expect(result, isNotNull, reason: 'Should parse "1 ${entry.key}"');
        expect(result!.unit, entry.value);
      });
    }
  });

  group('Unit coverage — Temperature symbols', () {
    test('°C', () => expect(Temperature.parse('25 °C').unit, TemperatureUnit.celsius));
    test('°F', () => expect(Temperature.parse('77 °F').unit, TemperatureUnit.fahrenheit));
    test('K', () => expect(Temperature.parse('300 K').unit, TemperatureUnit.kelvin));
    test('°R', () => expect(Temperature.parse('500 °R').unit, TemperatureUnit.rankine));
  });

  // ─────────────────────────────────────────────────────────────────────────
  // 13. PARSED VALUE CONVERSIONS
  // ─────────────────────────────────────────────────────────────────────────

  group('Parsed value usable for conversions', () {
    test('1 km → 1000 m', () {
      final l = Length.parse('1 km');
      expect(l.getValue(LengthUnit.meter), closeTo(1000.0, tolerance));
    });

    test('1 mile → ~1609.344 m', () {
      final l = Length.parse('1 mi');
      expect(l.getValue(LengthUnit.meter), closeTo(1609.344, 1e-3));
    });

    test('100 °C → 373.15 K', () {
      final t = Temperature.parse('100 °C');
      expect(t.getValue(TemperatureUnit.kelvin), closeTo(373.15, 1e-6));
    });
  });

  // ─────────────────────────────────────────────────────────────────────────
  // 14. TEMPERATURE SPECIFIC (non-linear conversion type)
  // ─────────────────────────────────────────────────────────────────────────

  group('Temperature parsing (non-linear quantity)', () {
    test('parses without space between value and symbol', () {
      expect(Temperature.parse('25°C').unit, TemperatureUnit.celsius);
      expect(Temperature.parse('300K').unit, TemperatureUnit.kelvin);
      expect(Temperature.parse('77°F').unit, TemperatureUnit.fahrenheit);
    });

    test('parses negative temperature', () {
      final t = Temperature.parse('-40 °C');
      expect(t.value, -40.0);
      expect(t.unit, TemperatureUnit.celsius);
    });

    test('invariant rejects comma decimal for Temperature', () {
      expect(Temperature.tryParse('36,6 °C'), isNull);
    });

    test('de_DE format for Temperature', () {
      final t = Temperature.parse('36,6 °C', formats: [QuantityFormat.de]);
      expect(t.value, closeTo(36.6, tolerance));
    });

    test('empty formats list falls back to invariant for Temperature', () {
      final t = Temperature.parse('25 °C', formats: const []);
      expect(t.value, 25.0);
    });
  });
}
