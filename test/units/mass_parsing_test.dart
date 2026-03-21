import 'package:intl/intl.dart';
import 'package:quantify/quantify.dart';
import 'package:test/test.dart';

void main() {
  const tolerance = 1e-9;

  group('Mass Parsing', () {
    group('Basic parsing', () {
      test('parses standard valid inputs with invariant format', () {
        expect(Mass.parse('70 kg').inKilograms, 70.0);
        expect(Mass.parse('10.5 g').inGrams, 10.5);
        expect(Mass.parse('-5.2 mg').inMilligrams, -5.2);
        expect(Mass.parse('2e3 g').inGrams, 2000.0);
        expect(Mass.parse('1.5E-2 kg').inKilograms, 0.015);
      });

      test('parses by symbol', () {
        final m = Mass.parse('70 kg');
        expect(m.value, 70.0);
        expect(m.unit, MassUnit.kilogram);
      });

      test('parses by full name', () {
        final m = Mass.parse('500 grams');
        expect(m.value, 500.0);
        expect(m.unit, MassUnit.gram);
      });

      test('parses by common abbreviations', () {
        final m = Mass.parse('180 lbs');
        expect(m.value, 180.0);
        expect(m.unit, MassUnit.pound);
      });

      test('parses by plural name', () {
        final m = Mass.parse('5 kilograms');
        expect(m.value, 5.0);
        expect(m.unit, MassUnit.kilogram);
      });

      test('parses scientific notation', () {
        final m = Mass.parse('1.5e3 g');
        expect(m.value, 1500.0);
        expect(m.unit, MassUnit.gram);
      });

      test('parses negative values', () {
        final m = Mass.parse('-5 kg');
        expect(m.value, -5.0);
        expect(m.unit, MassUnit.kilogram);
      });

      test('parses leading decimal point', () {
        final m = Mass.parse('.5 kg');
        expect(m.value, 0.5);
        expect(m.unit, MassUnit.kilogram);

        final neg = Mass.parse('-.25 g');
        expect(neg.value, -0.25);
        expect(neg.unit, MassUnit.gram);
      });
    });

    group('Spacing', () {
      test('parses correctly regardless of spacing', () {
        expect(Mass.parse('70kg').inKilograms, 70.0);
        expect(Mass.parse('70   kg').inKilograms, 70.0);
        expect(Mass.parse('70\tkg').inKilograms, 70.0);
        expect(Mass.parse('  70 kg  ').inKilograms, 70.0);
      });

      test('parses without space between value and unit', () {
        final m = Mass.parse('500g');
        expect(m.value, 500.0);
        expect(m.unit, MassUnit.gram);
      });

      test('whitespace normalization in multi-word units', () {
        expect(Mass.tryParse('2 short  ton'), isNotNull);
        expect(Mass.parse('2 short  ton').unit, MassUnit.shortTon);
        expect(Mass.tryParse('3 long  tons'), isNotNull);
        expect(Mass.parse('3 long  tons').unit, MassUnit.longTon);
        expect(Mass.tryParse('1 metric  ton'), isNotNull);
        expect(Mass.parse('1 metric  ton').unit, MassUnit.tonne);
      });
    });

    group('SI prefix case-sensitivity', () {
      test('strictly enforces case-sensitivity for SI prefixes', () {
        final milli = Mass.parse('5 mg');
        final mega = Mass.parse('5 Mg');

        expect(milli.unit, MassUnit.milligram);
        expect(mega.unit, MassUnit.megagram);
        expect(milli.inGrams, closeTo(0.005, tolerance));
        expect(mega.inGrams, closeTo(5000000.0, tolerance));

        expect(Mass.tryParse('5 mG'), isNull);
      });

      test('Mg = megagram, mg = milligram', () {
        expect(Mass.parse('5 Mg').unit, MassUnit.megagram);
        expect(Mass.parse('5 mg').unit, MassUnit.milligram);
      });

      test('Gg = gigagram', () {
        final giga = Mass.parse('2 Gg');
        expect(giga.value, 2.0);
        expect(giga.unit, MassUnit.gigagram);
      });

      test('wrong-case symbol returns null, not wrong unit', () {
        expect(Mass.tryParse('5 MG'), isNull);
        expect(Mass.tryParse('5 mG'), isNull);
        expect(Mass.parse('5 Mg').unit, MassUnit.megagram);
        expect(Mass.parse('5 mg').unit, MassUnit.milligram);
        expect(Mass.parse('5 megagrams').unit, MassUnit.megagram);
        expect(Mass.parse('5 MILLIGRAMS').unit, MassUnit.milligram);
      });
    });

    group('Case-insensitive names', () {
      test('full names are case-insensitive', () {
        expect(Mass.parse('10 KILOGRAM').unit, MassUnit.kilogram);
        expect(Mass.parse('10 Kilograms').unit, MassUnit.kilogram);
        expect(Mass.parse('5 Grams').unit, MassUnit.gram);
      });

      test('word forms match case-insensitively; symbols require exact case', () {
        final m = Mass.parse('10 KILOGRAMS');
        expect(m.value, 10.0);
        expect(m.unit, MassUnit.kilogram);

        expect(Mass.tryParse('10 KG'), isNull);
        expect(Mass.tryParse('10 Kg'), isNull);
      });
    });

    group('Unit coverage', () {
      test('parses imperial and special units', () {
        final oz = Mass.parse('16 oz');
        expect(oz.value, 16.0);
        expect(oz.unit, MassUnit.ounce);

        final st = Mass.parse('10 stone');
        expect(st.value, 10.0);
        expect(st.unit, MassUnit.stone);

        final ct = Mass.parse('2 carats');
        expect(ct.value, 2.0);
        expect(ct.unit, MassUnit.carat);
      });

      test('parses tonne and ton variants', () {
        final tonne = Mass.parse('5 tonnes');
        expect(tonne.value, 5.0);
        expect(tonne.unit, MassUnit.tonne);

        final shortTon = Mass.parse('2 short tons');
        expect(shortTon.value, 2.0);
        expect(shortTon.unit, MassUnit.shortTon);

        final longTon = Mass.parse('3 long tons');
        expect(longTon.value, 3.0);
        expect(longTon.unit, MassUnit.longTon);
      });

      test('parses small SI units', () {
        final mg = Mass.parse('250 mg');
        expect(mg.value, 250.0);
        expect(mg.unit, MassUnit.milligram);

        final mcg = Mass.parse('100 mcg');
        expect(mcg.value, 100.0);
        expect(mcg.unit, MassUnit.microgram);
      });

      test('parsed value should be usable in conversions', () {
        final m = Mass.parse('1 kg');
        expect(m.getValue(MassUnit.gram), closeTo(1000.0, tolerance));
      });
    });

    group('Invariant format strictness', () {
      test('invariant format accepts visual grouping separators', () {
        expect(Mass.parse('1 000 g').inGrams, 1000.0);
        expect(Mass.parse('1\u00A0000 g').inGrams, 1000.0);
        expect(Mass.parse('1\u202F000 g').inGrams, 1000.0);
        expect(Mass.parse("1'000 g").inGrams, 1000.0);
      });

      test('invariant format still rejects locale decimal separators', () {
        expect(Mass.tryParse('10,5 kg'), isNull);
        expect(Mass.tryParse('10\u066B5 kg'), isNull);
      });
    });

    group('Extended i18n separators', () {
      test('parses Arabic decimal/group separators with Arabic NumberFormat', () {
        final arFormat = QuantityFormat.withNumberFormat(
          NumberFormat.decimalPattern('ar_EG'),
        );

        final parsed = Mass.parse('١\u066C٢٣٤\u066B٥٦ kg', formats: [arFormat]);
        expect(parsed.inKilograms, closeTo(1234.56, 1e-9));
      });

      test('rejects Arabic decimal marker with non-Arabic locale format', () {
        expect(
          Mass.tryParse('١\u066C٢٣٤\u066B٥٦ kg', formats: [QuantityFormat.enUs]),
          isNull,
        );
      });
    });

    group('QuantityFormat locale parsing', () {
      test('parses with explicit QuantityFormat locale constants', () {
        final massDe = Mass.parse(
          '1.234,56 kg',
          formats: [QuantityFormat.de],
        );
        expect(massDe.inKilograms, closeTo(1234.56, 1e-9));

        final massUs = Mass.parse(
          '1,234.56 kg',
          formats: [QuantityFormat.enUs],
        );
        expect(massUs.inKilograms, closeTo(1234.56, 1e-9));
      });

      test('parses with QuantityFormat.withNumberFormat', () {
        final deFormat = QuantityFormat.withNumberFormat(
          NumberFormat.decimalPattern('de_DE'),
        );
        final massDe = Mass.parse('1.234,56 kg', formats: [deFormat]);
        expect(massDe.inKilograms, closeTo(1234.56, 1e-9));

        final usFormat = QuantityFormat.withNumberFormat(
          NumberFormat.decimalPattern('en_US'),
        );
        final massUs = Mass.parse('1,234.56 kg', formats: [usFormat]);
        expect(massUs.inKilograms, closeTo(1234.56, 1e-9));
      });
    });

    group('Multi-format fallback', () {
      test('tries formats in order', () {
        final result = Mass.parse(
          '1.234,56 kg',
          formats: [QuantityFormat.invariant, QuantityFormat.de],
        );
        expect(result.inKilograms, closeTo(1234.56, 1e-9));
      });

      test('first-format-wins semantics for ambiguous input', () {
        final resultUsFirst = Mass.parse(
          '1,234 kg',
          formats: [QuantityFormat.enUs, QuantityFormat.de],
        );
        expect(resultUsFirst.inKilograms, closeTo(1234.0, 1e-9));

        final resultDeFirst = Mass.parse(
          '1,234 kg',
          formats: [QuantityFormat.de, QuantityFormat.enUs],
        );
        expect(resultDeFirst.inKilograms, closeTo(1.234, 1e-9));
      });
    });

    group('Round-trip symmetry', () {
      test('toString then parse with invariant', () {
        const original = Mass(1234.56, MassUnit.kilogram);
        final invariantStr = original.toString();
        final parsed = Mass.parse(invariantStr);
        expect(parsed.inKilograms, closeTo(1234.56, 1e-9));
      });

      test('toString then parse with German locale', () {
        const original = Mass(1234.56, MassUnit.kilogram);
        const deFormat = QuantityFormat.forLocale('de_DE', fractionDigits: 2);
        final deStr = original.toString(format: deFormat);
        final parsedDe = Mass.parse(deStr, formats: [deFormat]);
        expect(parsedDe.inKilograms, closeTo(1234.56, 1e-2));
      });
    });

    group('Error handling', () {
      test('tryParse returns null for invalid inputs', () {
        expect(Mass.tryParse(''), isNull);
        expect(Mass.tryParse('   '), isNull);
        expect(Mass.tryParse('10'), isNull);
        expect(Mass.tryParse('kg'), isNull);
        expect(Mass.tryParse('not a mass'), isNull);
        expect(Mass.tryParse('10.5.2 kg'), isNull);
        expect(Mass.tryParse('10 unknownUnit'), isNull);
        expect(Mass.tryParse('10 xyz'), isNull);
      });

      test('tryParse returns Mass for valid input', () {
        final m = Mass.tryParse('70 kg');
        expect(m, isNotNull);
        expect(m!.value, 70.0);
        expect(m.unit, MassUnit.kilogram);
      });

      test('parse throws QuantityParseException for invalid inputs', () {
        expect(
          () => Mass.parse('   '),
          throwsA(
            isA<QuantityParseException>().having((e) => e.formatsAttempted, 'formatsAttempted', 1),
          ),
        );

        expect(
          () => Mass.parse('10 xyz'),
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
          () => Mass.parse('bad input'),
          throwsA(isA<FormatException>()),
        );
      });

      test('parse throws FormatException for invalid input', () {
        expect(() => Mass.parse('not a mass'), throwsFormatException);
        expect(() => Mass.parse(''), throwsFormatException);
        expect(() => Mass.parse('10 xyz'), throwsFormatException);
      });

      test('parse throws with correct formatsAttempted count', () {
        expect(
          () => Mass.parse(
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
