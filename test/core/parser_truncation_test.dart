import 'package:quantify/quantify.dart';
import 'package:test/test.dart';

void main() {
  group('QuantityParser Truncation and Strictness', () {
    test('should reject multiple decimal points (US)', () {
      // In en_US, '1.2.3' is invalid.
      // intl's tryParse often returns '1.2' and stops.
      // We want our parser to return null.
      final result = Length.tryParse('1.2.3 m', formats: [QuantityFormat.enUs]);
      expect(result, isNull, reason: 'Multiple decimal points should be rejected');
    });

    test('should reject multiple decimal points (German)', () {
      // In de_DE, '1,2,3' is invalid.
      final result = Length.tryParse('1,2,3 m', formats: [QuantityFormat.de]);
      expect(result, isNull, reason: 'Multiple decimal commas should be rejected');
    });

    test('should reject misplaced thousands separators', () {
      // en_US expects commas every 3 digits. 1,23,45 is invalid for en_US (though valid for hi_IN).
      // Standard intl parser might just parse '1' or '123'.
      final result = Length.tryParse('1,23,45 m', formats: [QuantityFormat.enUs]);
      // Note: Current implementation uses _isStrictlyValidForNumberFormat which is quite good,
      // but let's see if it catches this.
      expect(result, isNull, reason: 'Misplaced thousands separators should be rejected');
    });

    test('should reject mixed separators from different locales', () {
      // en_US doesn't use dots for thousands.
      final result = Length.tryParse('1.234,56 m', formats: [QuantityFormat.enUs]);
      expect(result, isNull);
    });

    test('should reject alphabetic characters in numeric part', () {
      final result = Length.tryParse('12abc34 m');
      expect(result, isNull);
    });
  });
}
