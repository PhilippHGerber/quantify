import 'package:quantify/quantify.dart';
import 'package:test/test.dart';

void main() {
  group('ElectricCharge parsing —', () {
    group('Basic parsing (invariant format)', () {
      test('parses coulomb with symbol', () {
        expect(ElectricCharge.parse('1 C'), const ElectricCharge(1, ElectricChargeUnit.coulomb));
      });

      test('parses millicoulomb', () {
        expect(
          ElectricCharge.parse('500 mC'),
          const ElectricCharge(500, ElectricChargeUnit.millicoulomb),
        );
      });

      test('parses microcoulomb', () {
        expect(
          ElectricCharge.parse('100 µC'),
          const ElectricCharge(100, ElectricChargeUnit.microcoulomb),
        );
      });

      test('parses nanocoulomb', () {
        expect(
          ElectricCharge.parse('50 nC'),
          const ElectricCharge(50, ElectricChargeUnit.nanocoulomb),
        );
      });

      test('parses elementary charge', () {
        expect(
          ElectricCharge.parse('1 e'),
          const ElectricCharge(1, ElectricChargeUnit.elementaryCharge),
        );
      });

      test('parses ampere-hour', () {
        expect(
          ElectricCharge.parse('2.5 Ah'),
          const ElectricCharge(2.5, ElectricChargeUnit.ampereHour),
        );
      });

      test('parses milliampere-hour', () {
        expect(
          ElectricCharge.parse('3000 mAh'),
          const ElectricCharge(3000, ElectricChargeUnit.milliampereHour),
        );
      });
    });

    group('CGS units', () {
      test('parses statcoulomb', () {
        expect(
          ElectricCharge.parse('1 statC'),
          const ElectricCharge(1, ElectricChargeUnit.statcoulomb),
        );
      });

      test('parses franklin', () {
        expect(ElectricCharge.parse('1 Fr'), const ElectricCharge(1, ElectricChargeUnit.franklin));
      });

      test('parses abcoulomb', () {
        expect(
          ElectricCharge.parse('1 abC'),
          const ElectricCharge(1, ElectricChargeUnit.abcoulomb),
        );
      });
    });

    group('Spacing tolerance', () {
      test('parses with no space', () {
        expect(ElectricCharge.parse('1C'), const ElectricCharge(1, ElectricChargeUnit.coulomb));
      });

      test('parses with multiple spaces', () {
        expect(
          ElectricCharge.parse('500   mC'),
          const ElectricCharge(500, ElectricChargeUnit.millicoulomb),
        );
      });

      test('parses with leading/trailing whitespace', () {
        expect(
          ElectricCharge.parse('  2.5 Ah  '),
          const ElectricCharge(2.5, ElectricChargeUnit.ampereHour),
        );
      });
    });

    group('Case sensitivity', () {
      test('SI symbols are case-sensitive (C vs c)', () {
        expect(() => ElectricCharge.parse('1 c'), throwsA(isA<QuantityParseException>()));
      });

      test('SI symbols distinguish units (mC is millicoulomb)', () {
        expect(
          ElectricCharge.parse('500 mC'),
          const ElectricCharge(500, ElectricChargeUnit.millicoulomb),
        );
      });

      test('full names are case-insensitive', () {
        expect(
          ElectricCharge.parse('1 COULOMB'),
          const ElectricCharge(1, ElectricChargeUnit.coulomb),
        );
        expect(
          ElectricCharge.parse('1 Coulomb'),
          const ElectricCharge(1, ElectricChargeUnit.coulomb),
        );
        expect(
          ElectricCharge.parse('500 millicoulomb'),
          const ElectricCharge(500, ElectricChargeUnit.millicoulomb),
        );
      });

      test('non-SI abbreviations are case-insensitive', () {
        expect(
          ElectricCharge.parse('2.5 AH'),
          const ElectricCharge(2.5, ElectricChargeUnit.ampereHour),
        );
        expect(
          ElectricCharge.parse('3000 MAH'),
          const ElectricCharge(3000, ElectricChargeUnit.milliampereHour),
        );
        expect(
          ElectricCharge.parse('1 STATC'),
          const ElectricCharge(1, ElectricChargeUnit.statcoulomb),
        );
        expect(
          ElectricCharge.parse('1 FR'),
          const ElectricCharge(1, ElectricChargeUnit.statcoulomb),
        );
      });
    });

    group('Error handling', () {
      test('throws on invalid number', () {
        expect(() => ElectricCharge.parse('abc C'), throwsA(isA<QuantityParseException>()));
      });

      test('throws on missing unit', () {
        expect(() => ElectricCharge.parse('1'), throwsA(isA<QuantityParseException>()));
      });

      test('throws on unknown unit', () {
        expect(() => ElectricCharge.parse('1 xyz'), throwsA(isA<QuantityParseException>()));
      });

      test('returns null with tryParse on invalid input', () {
        expect(ElectricCharge.tryParse('invalid'), isNull);
      });

      test('returns null with tryParse on missing unit', () {
        expect(ElectricCharge.tryParse('1'), isNull);
      });
    });

    group('Round-trip', () {
      test('parse(toString()) preserves value and unit', () {
        const original = ElectricCharge(3000, ElectricChargeUnit.milliampereHour);
        final roundTrip = ElectricCharge.parse(original.toString());
        expect(roundTrip, equals(original));
      });

      test('parse(toString()) works for all units', () {
        for (final unit in ElectricChargeUnit.values) {
          final original = ElectricCharge(1, unit);
          final roundTrip = ElectricCharge.parse(original.toString());
          expect(roundTrip, equals(original));
        }
      });
    });
  });
}
