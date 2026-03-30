// For expect matches:
// ignore_for_file: use_named_constants

import 'package:intl/intl.dart';
import 'package:quantify/quantify.dart';
import 'package:test/test.dart';

void main() {
  group('QuantityFormat presets', () {
    test('invariant is non-null and shows unit symbol by default', () {
      expect(QuantityFormat.invariant, isNotNull);
      expect(QuantityFormat.invariant.showUnitSymbol, isTrue);
      expect(QuantityFormat.invariant.numberFormat, isNull);
      expect(QuantityFormat.invariant.locale, isNull);
    });

    test('valueOnly omits unit symbol', () {
      expect(QuantityFormat.valueOnly.showUnitSymbol, isFalse);
      final result = const Length(1.5, LengthUnit.meter).toString(
        format: QuantityFormat.valueOnly,
      );
      expect(result, equals('1.5'));
    });

    test('enUs uses en_US locale', () {
      expect(QuantityFormat.enUs.locale, equals('en_US'));
      expect(QuantityFormat.enUs.showUnitSymbol, isTrue);
    });

    test('de uses de_DE locale', () {
      expect(QuantityFormat.de.locale, equals('de_DE'));
    });

    group('compact', () {
      String? savedLocale;

      setUp(() => savedLocale = Intl.defaultLocale);
      tearDown(() => Intl.defaultLocale = savedLocale);

      test('is non-null', () {
        expect(QuantityFormat.compact, isNotNull);
      });

      test('has a non-null numberFormat', () {
        expect(QuantityFormat.compact.numberFormat, isNotNull);
      });

      test('showUnitSymbol defaults to true', () {
        expect(QuantityFormat.compact.showUnitSymbol, isTrue);
      });

      test('formats large length value in compact notation', () {
        Intl.defaultLocale = 'en_US';
        final result = const Length(1500, LengthUnit.meter).toString(
          format: QuantityFormat.compact,
        );
        // NumberFormat.compact() renders 1500 as "1.5K"
        expect(result, contains('1.5K'));
        expect(result, contains('m'));
      });

      test('formats millions compactly', () {
        Intl.defaultLocale = 'en_US';
        final result = const Length(3400000, LengthUnit.meter).toString(
          format: QuantityFormat.compact,
        );
        expect(result, contains('3.4M'));
      });

      test('returns the cached instance within the same locale', () {
        Intl.defaultLocale = 'en_US';
        expect(identical(QuantityFormat.compact, QuantityFormat.compact), isTrue);
      });

      test('returns a new instance after locale change', () {
        Intl.defaultLocale = 'en_US';
        final first = QuantityFormat.compact;
        Intl.defaultLocale = 'de_DE';
        final second = QuantityFormat.compact;
        expect(identical(first, second), isFalse);
      });

      test('reflects Intl.defaultLocale at time of access', () {
        Intl.defaultLocale = 'en_US';
        final enLocale = QuantityFormat.compact.numberFormat!.locale;

        Intl.defaultLocale = 'de_DE';
        final deLocale = QuantityFormat.compact.numberFormat!.locale;

        // intl may normalize locale tags (e.g. 'de_DE' → 'de'), so check
        // that the two locales differ rather than asserting exact strings.
        expect(enLocale, isNot(equals(deLocale)));
        expect(enLocale, startsWith('en'));
        expect(deLocale, startsWith('de'));
      });

      test('locale change after first access is reflected in subsequent calls', () {
        // Regression: static final would have permanently captured the locale
        // at first access. Verify that a locale change is visible to the next
        // call without needing to restart the process.
        Intl.defaultLocale = 'en_US';
        final localeAtFirst = QuantityFormat.compact.numberFormat!.locale;

        Intl.defaultLocale = 'fr_FR';
        final localeAtSecond = QuantityFormat.compact.numberFormat!.locale;

        expect(localeAtFirst, startsWith('en'));
        expect(localeAtSecond, startsWith('fr'));
        expect(localeAtFirst, isNot(equals(localeAtSecond)));
      });

      test('compactFor reuses the cached instance for the same locale', () {
        final first = QuantityFormat.compactFor('en_US');
        final second = QuantityFormat.compactFor('en_US');

        expect(identical(first, second), isTrue);
      });

      test('compactFor is deterministic regardless of Intl.defaultLocale', () {
        Intl.defaultLocale = 'de_DE';

        final explicit = const Length(1500, LengthUnit.meter).toString(
          format: QuantityFormat.compactFor('en_US'),
        );

        expect(explicit, contains('1.5K'));
      });

      test('compact delegates to compactFor for the effective locale', () {
        Intl.defaultLocale = 'en_US';
        expect(identical(QuantityFormat.compact, QuantityFormat.compactFor('en_US')), isTrue);
      });
    });
  });

  group('QuantityFormat equality', () {
    test('equal configurations compare equal and have matching hash codes', () {
      const first = QuantityFormat(
        locale: 'en_US',
        fractionDigits: 2,
        unitSymbolSeparator: ' ',
        showUnitSymbol: false,
      );
      const second = QuantityFormat(
        locale: 'en_US',
        fractionDigits: 2,
        unitSymbolSeparator: ' ',
        showUnitSymbol: false,
      );

      expect(first, equals(second));
      expect(first.hashCode, equals(second.hashCode));
    });

    test('preset constants compare equal to matching configurations', () {
      expect(QuantityFormat.invariant, equals(const QuantityFormat()));
      expect(
        QuantityFormat.valueOnly,
        equals(const QuantityFormat(showUnitSymbol: false)),
      );
      expect(QuantityFormat.enUs, equals(const QuantityFormat(locale: 'en_US')));
      expect(QuantityFormat.de, equals(const QuantityFormat(locale: 'de_DE')));
    });

    test('different field values are not equal', () {
      const baseline = QuantityFormat(locale: 'en_US', fractionDigits: 2);

      expect(
        baseline,
        isNot(equals(const QuantityFormat(locale: 'de_DE', fractionDigits: 2))),
      );
      expect(
        baseline,
        isNot(equals(const QuantityFormat(locale: 'en_US', fractionDigits: 3))),
      );
      expect(
        baseline,
        isNot(
          equals(
            const QuantityFormat(locale: 'en_US', fractionDigits: 2, showUnitSymbol: false),
          ),
        ),
      );
    });

    test('works as a Set element and Map key', () {
      final formats = <QuantityFormat>{}
        ..add(const QuantityFormat(locale: 'en_US', fractionDigits: 2))
        ..add(const QuantityFormat(locale: 'en_US', fractionDigits: 2));
      final labels = <QuantityFormat, String>{
        const QuantityFormat(locale: 'de_DE'): 'de',
      };

      expect(formats, hasLength(1));
      expect(labels[const QuantityFormat(locale: 'de_DE')], equals('de'));
    });

    test('withNumberFormat compares wrapped NumberFormat by identity', () {
      final shared = NumberFormat.decimalPattern('de_DE');
      final first = QuantityFormat.withNumberFormat(shared);
      final second = QuantityFormat.withNumberFormat(shared);
      final third = QuantityFormat.withNumberFormat(NumberFormat.decimalPattern('de_DE'));

      expect(first, equals(second));
      expect(first.hashCode, equals(second.hashCode));
      expect(third, isNot(equals(first)));
    });

    test('compact remains identical within the same locale', () {
      final savedLocale = Intl.defaultLocale;
      addTearDown(() => Intl.defaultLocale = savedLocale);

      Intl.defaultLocale = 'en_US';

      expect(QuantityFormat.compact, equals(QuantityFormat.compact));
      expect(identical(QuantityFormat.compact, QuantityFormat.compact), isTrue);
    });
  });
}
