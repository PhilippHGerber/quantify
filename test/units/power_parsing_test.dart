import 'package:quantify/quantify.dart';
import 'package:test/test.dart';

void main() {
  group('Power Parsing', () {
    test('parses common power units', () {
      expect(Power.parse('100 W').inWatts, 100.0);
      expect(Power.parse('5 kW').inKilowatts, 5.0);
      expect(Power.parse('150 hp').inHorsepower, 150.0);
      expect(Power.parse('2.5 MW').inMegawatts, 2.5);
    });

    test('case-insensitive names', () {
      expect(Power.parse('100 WATT').unit, PowerUnit.watt);
      expect(Power.parse('100 Watts').unit, PowerUnit.watt);
      expect(Power.parse('50 HORSEPOWER').unit, PowerUnit.horsepower);
    });

    test('error handling', () {
      expect(Power.tryParse('invalid'), isNull);
      expect(() => Power.parse('invalid'), throwsA(isA<QuantityParseException>()));
    });

    test('round-trip', () {
      const original = Power(500, PowerUnit.watt);
      final parsed = Power.parse(original.toString(format: QuantityFormat.invariant));
      expect(parsed.value, closeTo(original.value, 1e-9));
      expect(parsed.unit, original.unit);
    });
  });
}
