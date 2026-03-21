import 'package:intl/intl.dart';
import 'package:quantify/quantify.dart';
import 'package:test/test.dart';

void main() {
  const tolerance = 1e-9;

  group('Length Parsing', () {
    group('Basic parsing', () {
      test('parses standard valid inputs with invariant format', () {
        expect(Length.parse('10 m').inM, 10.0);
        expect(Length.parse('10.5 km').inKm, 10.5);
        expect(Length.parse('-5.2 cm').inCm, -5.2);
        expect(Length.parse('2e3 mm').inMm, 2000.0);
        expect(Length.parse('1.5E-2 km').inKm, 0.015);
      });

      test('parses by symbol', () {
        final l = Length.parse('10.5 km');
        expect(l.value, 10.5);
        expect(l.unit, LengthUnit.kilometer);
      });

      test('parses by full name', () {
        final l = Length.parse('100 meters');
        expect(l.value, 100.0);
        expect(l.unit, LengthUnit.meter);
      });

      test('parses by plural name', () {
        final l = Length.parse('5 kilometres');
        expect(l.value, 5.0);
        expect(l.unit, LengthUnit.kilometer);
      });

      test('parses scientific notation', () {
        final l = Length.parse('1.5e3 m');
        expect(l.value, 1500.0);
        expect(l.unit, LengthUnit.meter);
      });

      test('parses negative values', () {
        final l = Length.parse('-5 m');
        expect(l.value, -5.0);
        expect(l.unit, LengthUnit.meter);
      });

      test('parses leading decimal point', () {
        final l = Length.parse('.5 m');
        expect(l.value, 0.5);
        expect(l.unit, LengthUnit.meter);

        final neg = Length.parse('-.5 km');
        expect(neg.value, -0.5);
        expect(neg.unit, LengthUnit.kilometer);
      });
    });

    group('Spacing', () {
      test('parses correctly regardless of spacing', () {
        expect(Length.parse('10m').inM, 10.0);
        expect(Length.parse('10   m').inM, 10.0);
        expect(Length.parse('10\tm').inM, 10.0);
        expect(Length.parse('  10 m  ').inM, 10.0);
      });

      test('parses without space between value and unit', () {
        final l = Length.parse('10.5km');
        expect(l.value, 10.5);
        expect(l.unit, LengthUnit.kilometer);
      });

      test('whitespace normalization in multi-word units', () {
        expect(Length.tryParse('5 nautical  mile'), isNotNull);
        expect(Length.parse('5 nautical  mile').unit, LengthUnit.nauticalMile);
        expect(Length.parse('5 nautical  mile').value, 5.0);
        expect(Length.tryParse('4.2 light  years'), isNotNull);
        expect(Length.parse('4.2 light  years').unit, LengthUnit.lightYear);
        expect(Length.parse('4.2 light  years').value, 4.2);
      });
    });

    group('SI prefix case-sensitivity', () {
      test('strictly enforces case-sensitivity for SI prefixes', () {
        final milli = Length.parse('10 mm');
        final mega = Length.parse('10 Mm');

        expect(milli.unit, LengthUnit.millimeter);
        expect(mega.unit, LengthUnit.megameter);
        expect(milli.inM, 0.01);
        expect(mega.inM, 10000000.0);

        expect(Length.tryParse('10 mM'), isNull);
      });

      test('Mm = megameter, mm = millimeter', () {
        expect(Length.parse('10 Mm').unit, LengthUnit.megameter);
        expect(Length.parse('10 mm').unit, LengthUnit.millimeter);
      });

      test('Gm = gigameter', () {
        final giga = Length.parse('5 Gm');
        expect(giga.value, 5.0);
        expect(giga.unit, LengthUnit.gigameter);
      });

      test('wrong-case symbol returns null, not wrong unit', () {
        expect(Length.tryParse('10 MM'), isNull);
        expect(Length.tryParse('10 mM'), isNull);
        expect(Length.parse('10 Mm').unit, LengthUnit.megameter);
        expect(Length.parse('10 mm').unit, LengthUnit.millimeter);
        expect(Length.parse('10 megameters').unit, LengthUnit.megameter);
        expect(Length.parse('10 MILLIMETERS').unit, LengthUnit.millimeter);
      });
    });

    group('Case-insensitive names', () {
      test('full names and Imperial units are case-insensitive', () {
        expect(Length.parse('10 METER').unit, LengthUnit.meter);
        expect(Length.parse('10 Meters').unit, LengthUnit.meter);
        expect(Length.parse('10 kiloMeters').unit, LengthUnit.kilometer);

        expect(Length.parse('10 FT').unit, LengthUnit.foot);
        expect(Length.parse('10 ft').unit, LengthUnit.foot);
        expect(Length.parse('10 Feet').unit, LengthUnit.foot);

        expect(Length.parse('5 IN').unit, LengthUnit.inch);
        expect(Length.parse('5 inches').unit, LengthUnit.inch);

        expect(Length.parse('3 MI').unit, LengthUnit.mile);
        expect(Length.parse('3 Miles').unit, LengthUnit.mile);
      });

      test('word forms match case-insensitively; symbols require exact case', () {
        final l = Length.parse('10 KILOMETERS');
        expect(l.value, 10.0);
        expect(l.unit, LengthUnit.kilometer);

        expect(Length.tryParse('10 KM'), isNull);
        expect(Length.tryParse('10 Km'), isNull);
      });
    });

    group('Unit coverage', () {
      test('parses imperial units', () {
        final ft = Length.parse('6 ft');
        expect(ft.value, 6.0);
        expect(ft.unit, LengthUnit.foot);

        final inches = Length.parse('12 inches');
        expect(inches.value, 12.0);
        expect(inches.unit, LengthUnit.inch);

        final mi = Length.parse('3.5 miles');
        expect(mi.value, 3.5);
        expect(mi.unit, LengthUnit.mile);
      });

      test('parses nautical and astronomical units', () {
        final nmi = Length.parse('5 nmi');
        expect(nmi.value, 5.0);
        expect(nmi.unit, LengthUnit.nauticalMile);

        final au = Length.parse('1 AU');
        expect(au.value, 1.0);
        expect(au.unit, LengthUnit.astronomicalUnit);

        final ly = Length.parse('4.2 light-years');
        expect(ly.value, 4.2);
        expect(ly.unit, LengthUnit.lightYear);

        final pc = Length.parse('10 parsecs');
        expect(pc.value, 10.0);
        expect(pc.unit, LengthUnit.parsec);
      });

      test('parses small SI units', () {
        final um = Length.parse('500 um');
        expect(um.value, 500.0);
        expect(um.unit, LengthUnit.micrometer);

        final nm = Length.parse('632 nm');
        expect(nm.value, 632.0);
        expect(nm.unit, LengthUnit.nanometer);
      });

      test('parsed value should be usable in conversions', () {
        final l = Length.parse('1 km');
        expect(l.getValue(LengthUnit.meter), closeTo(1000.0, tolerance));
      });
    });

    group('Invariant format strictness', () {
      test('invariant format accepts visual grouping separators', () {
        expect(Length.parse('1 000 m').inM, 1000.0);
        expect(Length.parse('1\u00A0000 m').inM, 1000.0);
        expect(Length.parse('1\u202F000 m').inM, 1000.0);
        expect(Length.parse("1'000 m").inM, 1000.0);
      });

      test('invariant format still rejects locale decimal separators', () {
        expect(Length.tryParse('10,5 km'), isNull);
        expect(Length.tryParse('10\u066B5 km'), isNull);
      });

      test('rejects deferred composite quote notation instead of misparsing', () {
        // Composite feet+inches parsing is explicitly deferred in the roadmap.
        // These inputs must fail hard rather than silently becoming 62 inches.
        expect(Length.tryParse('6\'2"'), isNull);
        expect(Length.tryParse('6\' 2"'), isNull);
        expect(Length.tryParse('6’2"'), isNull);
        expect(Length.tryParse('6\'2.5"'), isNull);

        expect(
          () => Length.parse('6\'2"'),
          throwsA(isA<QuantityParseException>()),
        );

        // Single quote-based unit symbols still parse as before.
        expect(Length.parse("6'").unit, LengthUnit.foot);
        expect(Length.parse("6'").value, 6.0);
        expect(Length.parse('2"').unit, LengthUnit.inch);
        expect(Length.parse('2"').value, 2.0);

        // Valid CH
        expect(Length.parse('1000 "').unit, LengthUnit.inch);
        expect(Length.parse('1000 "').value, 1000.0);
        expect(Length.parse('1\'000 "').unit, LengthUnit.inch);
        expect(Length.parse('1\'000 "').value, 1000.0);
      });
    });

    group('Extended i18n separators', () {
      test('parses Arabic decimal/group separators with Arabic NumberFormat', () {
        final arFormat = QuantityFormat.withNumberFormat(
          NumberFormat.decimalPattern('ar_EG'),
        );

        final parsed = Length.parse('١\u066C٢٣٤\u066B٥٦ km', formats: [arFormat]);
        expect(parsed.inKm, closeTo(1234.56, 1e-9));
      });

      test('rejects Arabic decimal marker with non-Arabic locale format', () {
        expect(
          Length.tryParse('١\u066C٢٣٤\u066B٥٦ km', formats: [QuantityFormat.enUs]),
          isNull,
        );
      });
    });

    group('QuantityFormat locale parsing', () {
      test('parses with explicit QuantityFormat locale constants', () {
        final lengthDe = Length.parse(
          '1.234,56 km',
          formats: [QuantityFormat.de],
        );
        expect(lengthDe.inKm, closeTo(1234.56, 1e-9));

        final lengthUs = Length.parse(
          '1,234.56 km',
          formats: [QuantityFormat.enUs],
        );
        expect(lengthUs.inKm, closeTo(1234.56, 1e-9));
      });

      test('parses with QuantityFormat.withNumberFormat', () {
        final deFormat = QuantityFormat.withNumberFormat(
          NumberFormat.decimalPattern('de_DE'),
        );
        final lengthDe = Length.parse('1.234,56 km', formats: [deFormat]);
        expect(lengthDe.inKm, closeTo(1234.56, 1e-9));

        final chFormat = QuantityFormat.withNumberFormat(
          NumberFormat.decimalPattern('de_CH'),
        );
        final lengthCh = Length.parse('1\u2019234.56 km', formats: [chFormat]);
        expect(lengthCh.inKm, closeTo(1234.56, 1e-9));

        final usFormat = QuantityFormat.withNumberFormat(
          NumberFormat.decimalPattern('en_US'),
        );
        final lengthUs = Length.parse('1,234.56 km', formats: [usFormat]);
        expect(lengthUs.inKm, closeTo(1234.56, 1e-9));
      });

      test('de_CH apostrophe grouping still parses while composite quotes reject', () {
        final chFormat = QuantityFormat.withNumberFormat(
          NumberFormat.decimalPattern('de_CH'),
        );

        // Apostrophe as a grouping separator remains valid for locale numbers.
        final grouped = Length.parse('1\u2019234.56 km', formats: [chFormat]);
        expect(grouped.inKm, closeTo(1234.56, 1e-9));

        // Deferred composite notation should fail, even with the same locale format.
        expect(Length.tryParse('6\'2"', formats: [chFormat]), isNull);
      });
    });

    group('Composite/Ambiguity Regressions', () {
      test('should reject composite feet-inch notation to avoid misparsing', () {
        // Without the 3-digit strictness on apostrophes, these would parse
        // as 62 inches and 62 inches respectively.
        expect(Length.tryParse("6'2\""), isNull);
        expect(Length.tryParse("6' 2\""), isNull);
        expect(Length.tryParse("6' 2 in"), isNull);

        // This is valid: 6,000 inches using an apostrophe separator
        expect(Length.tryParse("6'000\""), isNotNull);
      });
    });

    group('Locale Specific Grouping (hi_IN, de_CH, de_LI)', () {
      test('accepts variable digit grouping for standard separators (hi_IN)', () {
        // Indian locale groups by 2s after the first 3 (e.g. 12,34,567)
        final hiInFormat = QuantityFormat.withNumberFormat(
          NumberFormat.decimalPattern('hi_IN'),
        );

        final parsed = Length.parse('12,34,567 m', formats: [hiInFormat]);
        expect(parsed.inM, 1234567.0);
      });

      test('accepts exact 3-digit grouping for apostrophes (de_CH / de_LI)', () {
        // Swiss/Liechtenstein formatting uses apostrophes for thousands
        final chFormat = QuantityFormat.withNumberFormat(
          NumberFormat.decimalPattern('de_CH'),
        );

        final parsed1 = Length.parse("1'000 m", formats: [chFormat]);
        expect(parsed1.inM, 1000.0);

        final parsed2 = Length.parse("1'000'000 m", formats: [chFormat]);
        expect(parsed2.inM, 1000000.0);

        final parsedWithDec = Length.parse("1'234.56 km", formats: [chFormat]);
        expect(parsedWithDec.inKm, 1234.56);
      });

      test('rejects variable grouping with apostrophes', () {
        // Apostrophes MUST be 3 digits
        expect(Length.tryParse("12'34'567 m"), isNull);
      });
    });


    group('Multi-format fallback', () {
      test('tries formats in order', () {
        // "1.234,56 m" fails with invariant (double.tryParse rejects commas),
        // then succeeds with de.
        final result = Length.parse(
          '1.234,56 m',
          formats: [QuantityFormat.invariant, QuantityFormat.de],
        );
        expect(result.inM, closeTo(1234.56, 1e-9));
      });

      test('rejects malformed mixed separators for a single locale format', () {
        // de-formatted number; en_US must not accept this token anymore.
        expect(
          Length.tryParse('1.234,56 m', formats: [QuantityFormat.enUs]),
          isNull,
        );

        // With fallback order, second format should parse it deterministically.
        final parsed = Length.parse(
          '1.234,56 m',
          formats: [QuantityFormat.enUs, QuantityFormat.de],
        );
        expect(parsed.inM, closeTo(1234.56, 1e-9));
      });

      test('first-format-wins semantics for ambiguous input', () {
        // "1,234 m" — enUs interprets comma as thousands separator → 1234
        final resultUsFirst = Length.parse(
          '1,234 m',
          formats: [QuantityFormat.enUs, QuantityFormat.de],
        );
        expect(resultUsFirst.inM, closeTo(1234.0, 1e-9));

        // "1,234 m" — de interprets comma as decimal separator → 1.234
        final resultDeFirst = Length.parse(
          '1,234 m',
          formats: [QuantityFormat.de, QuantityFormat.enUs],
        );
        expect(resultDeFirst.inM, closeTo(1.234, 1e-9));
      });
    });

    group('Round-trip symmetry', () {
      test('toString then parse with invariant', () {
        const original = Length(1234.56, LengthUnit.meter);
        final invariantStr = original.toString();
        final parsed = Length.parse(invariantStr);
        expect(parsed.inM, closeTo(1234.56, 1e-9));
      });

      test('toString then parse with German locale', () {
        const original = Length(1234.56, LengthUnit.meter);
        const deFormat = QuantityFormat.forLocale('de_DE', fractionDigits: 2);
        final deStr = original.toString(format: deFormat);
        final parsedDe = Length.parse(deStr, formats: [deFormat]);
        expect(parsedDe.inM, closeTo(1234.56, 1e-2));
      });
    });

    group('Custom aliases', () {
      test('copyWithAliases creates an isolated parser with extra aliases', () {
        final parser = Length.parser.copyWithAliases(
          extraNameAliases: {
            'pulgada': LengthUnit.inch,
            'pulgadas': LengthUnit.inch,
          },
          extraSymbolAliases: {'myKM': LengthUnit.kilometer},
        );

        expect(parser.parse('50 pulgada').unit, LengthUnit.inch);
        expect(parser.tryParse('50 PULDAGAS '), isNull);
        expect(parser.parse('50 PULGADAS').unit, LengthUnit.inch);

        expect(parser.parse('10 myKM').unit, LengthUnit.kilometer);
        expect(parser.tryParse('10 MYKM'), isNull); // symbol is strict case

        // The global parser is unaffected
        expect(Length.tryParse('50 pulgada'), isNull);
        expect(Length.tryParse('10 myKM'), isNull);
      });

      test('copyWithAliases does not modify the original parser', () {
        final original = Length.parser;
        final derived = original.copyWithAliases(
          extraNameAliases: {'pie': LengthUnit.foot},
        );

        expect(derived.parse('99 pie').unit, LengthUnit.foot);
        expect(derived.parse('99 PIE').unit, LengthUnit.foot);
        expect(Length.tryParse('99 pie'), isNull);
      });

      test('symbol aliases in copyWithAliases enforce strict case', () {
        final parser = Length.parser.copyWithAliases(
          extraSymbolAliases: {'myKM': LengthUnit.kilometer},
        );

        expect(parser.parse('10 myKM').unit, LengthUnit.kilometer);
        expect(parser.tryParse('10 MYKM'), isNull);
        expect(parser.tryParse('10 mykm'), isNull);
      });
    });

    group('Error handling', () {
      test('tryParse returns null for invalid inputs', () {
        expect(Length.tryParse(''), isNull);
        expect(Length.tryParse('   '), isNull);
        expect(Length.tryParse('10'), isNull);
        expect(Length.tryParse('km'), isNull);
        expect(Length.tryParse('not a length'), isNull);
        expect(Length.tryParse('10.5.2 km'), isNull);
        expect(Length.tryParse('10 unknownUnit'), isNull);
        expect(Length.tryParse('10 xyz'), isNull);
      });

      test('tryParse returns Length for valid input', () {
        final l = Length.tryParse('10.5 km');
        expect(l, isNotNull);
        expect(l!.value, 10.5);
        expect(l.unit, LengthUnit.kilometer);
      });

      test('parse throws QuantityParseException for invalid inputs', () {
        expect(
          () => Length.parse('   '),
          throwsA(
            isA<QuantityParseException>().having((e) => e.formatsAttempted, 'formatsAttempted', 1),
          ),
        );

        expect(
          () => Length.parse('10 xyz'),
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
          () => Length.parse('bad input'),
          throwsA(isA<FormatException>()),
        );
      });

      test('parse throws FormatException for invalid input', () {
        expect(() => Length.parse('not a length'), throwsFormatException);
        expect(() => Length.parse(''), throwsFormatException);
        expect(() => Length.parse('10 xyz'), throwsFormatException);
      });

      test('parse throws with correct formatsAttempted count', () {
        expect(
          () => Length.parse(
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
