import 'package:quantify/src/core/math_utils.dart';
import 'package:test/test.dart';

void main() {
  group('log10', () {
    test('returns exact powers of ten', () {
      expect(log10(1), closeTo(0.0, 1e-12));
      expect(log10(10), closeTo(1.0, 1e-12));
      expect(log10(1000), closeTo(3.0, 1e-12));
    });

    test('preserves IEEE 754 behavior for zero and negative inputs', () {
      expect(log10(0), equals(double.negativeInfinity));
      expect(log10(-1).isNaN, isTrue);
    });
  });
}
