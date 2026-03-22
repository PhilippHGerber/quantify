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
        final result = const Length(1500, LengthUnit.meter).toString(
          format: QuantityFormat.compact,
        );
        // NumberFormat.compact() renders 1500 as "1.5K"
        expect(result, contains('1.5K'));
        expect(result, contains('m'));
      });

      test('formats millions compactly', () {
        final result = const Length(3400000, LengthUnit.meter).toString(
          format: QuantityFormat.compact,
        );
        expect(result, contains('3.4M'));
      });

      test('same instance returned each time (stable reference)', () {
        expect(identical(QuantityFormat.compact, QuantityFormat.compact), isTrue);
      });
    });
  });
}
