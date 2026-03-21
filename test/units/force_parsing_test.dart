import 'package:quantify/quantify.dart';
import 'package:test/test.dart';

void main() {
  group('Force Parsing', () {
    test('parses common force units', () {
      expect(Force.parse('100 N').inNewtons, 100.0);
      expect(Force.parse('5 kN').inKilonewtons, 5.0);
      expect(Force.parse('10 lbf').inPoundsForce, 10.0);
      expect(Force.parse('500 dyn').inDynes, 500.0);
    });

    test('case-insensitive names', () {
      expect(Force.parse('100 NEWTON').unit, ForceUnit.newton);
      expect(Force.parse('100 Newtons').unit, ForceUnit.newton);
    });

    test('error handling', () {
      expect(Force.tryParse('invalid'), isNull);
      expect(() => Force.parse('invalid'), throwsA(isA<QuantityParseException>()));
    });

    test('round-trip', () {
      const original = Force(50, ForceUnit.newton);
      final parsed = Force.parse(original.toString(format: QuantityFormat.invariant));
      expect(parsed.value, closeTo(original.value, 1e-9));
      expect(parsed.unit, original.unit);
    });
  });
}
