import 'package:intl/intl.dart';
import 'package:quantify/quantify.dart';
import 'package:test/test.dart';

void main() {
  group('QuantityFormat Locale Handling and Fallbacks', () {
    test(
      'regression: invalid locale should still use locale-aware fallback for formatting',
      () {
        final originalLocale = Intl.defaultLocale;
        Intl.defaultLocale = 'en_US';

        try {
          const format = QuantityFormat(locale: 'bogus_LOCALE', fractionDigits: 2);
          const length = Length(1234.567, LengthUnit.meter);

          // Expected locale-aware fallback behavior:
          // grouped thousands + fixed fraction digits.
          // Current behavior may silently fall back to invariant formatting.
          expect(length.toString(format: format), '1,234.57\u00A0m');
        } finally {
          Intl.defaultLocale = originalLocale;
        }
      },
    );

    test(
      'regression: invalid locale should still parse locale-grouped numbers via fallback',
      () {
        final originalLocale = Intl.defaultLocale;
        Intl.defaultLocale = 'en_US';

        try {
          const format = QuantityFormat(locale: 'bogus_LOCALE');
          final parsed = Length.tryParse('1,234.5 m', formats: [format]);

          // Expected locale-aware fallback behavior:
          // grouped input should parse under the fallback locale.
          expect(parsed, isNotNull);
          expect(parsed!.inM, closeTo(1234.5, 1e-9));
        } finally {
          Intl.defaultLocale = originalLocale;
        }
      },
    );

    test('should fallback gracefully for completely invalid/bogus locale', () {
      // Bogus locale: intl usually falls back to 'en_US' or 'en' if data is missing
      const format = QuantityFormat(locale: 'bogus_LOCALE', fractionDigits: 2);
      const length = Length(1234.567, LengthUnit.meter);

      // We expect it NOT to throw.
      // Exact output depends on the environment's intl fallback, but typically '1,234.57 m'
      expect(() => length.toString(format: format), returnsNormally);

      final result = length.toString(format: format);
      expect(result, isNotEmpty);
      expect(result, contains('m'));
    });

    test('should handle un-initialized locales by defaulting gracefully', () {
      // Forcing a locale that definitely isn't initialized
      const format = QuantityFormat(locale: 'fr_CA', fractionDigits: 1);
      const mass = Mass(10.5, MassUnit.kilogram);

      expect(() => mass.toString(format: format), returnsNormally);
      final result = mass.toString(format: format);
      expect(result, isNotEmpty);
      // '10,5 kg' or '10.5 kg' depending on environment, but should be stable
    });

    test('QuantityFormat.invariant should ALWAYS use dot decimal and NO thousands separator', () {
      // Even if the global default locale is set to German (comma decimal)
      final originalLocale = Intl.defaultLocale;
      Intl.defaultLocale = 'de_DE';

      try {
        const length = Length(1234.5, LengthUnit.meter);
        final result = length.toString(format: QuantityFormat.invariant);

        // Invariant MUST be "1234.5 m" (dot decimal, NO thousands separator)
        // Note: NumberFormat.decimalPattern('de_DE').format(1234.5) is "1.234,5"
        expect(result, '1234.5\u00A0m');
      } finally {
        Intl.defaultLocale = originalLocale;
      }
    });

    test('QuantityFormat.compact should reflect current default locale', () {
      final originalLocale = Intl.defaultLocale;

      try {
        const length = Length(1500, LengthUnit.meter);

        // US locale compact: "1.5K"
        Intl.defaultLocale = 'en_US';
        expect(length.toString(format: QuantityFormat.compact), contains('1.5K'));

        // German locale compact: "1.500" or similar (German doesn't use K for thousands as much, it depends on the intl data version)
        // Actually, German compact is often "1,5 Tsd." or just "1.500"
        Intl.defaultLocale = 'de_DE';
        final germanCompact = length.toString(format: QuantityFormat.compact);
        expect(germanCompact, isNot(contains('1.5K')));
      } finally {
        Intl.defaultLocale = originalLocale;
      }
    });
  });
}
