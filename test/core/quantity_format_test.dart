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

      // Regression: static final would permanently capture the locale at first
      // access. The getter must re-evaluate NumberFormat on every call.
      test('returns a new instance on each access (getter, not cached field)', () {
        expect(identical(QuantityFormat.compact, QuantityFormat.compact), isFalse);
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
    });
  });
}
