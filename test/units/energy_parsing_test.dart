import 'package:quantify/quantify.dart';
import 'package:test/test.dart';

void main() {
  group('Energy Parsing', () {
    test('parses common energy units', () {
      expect(Energy.parse('100 J').inJoules, 100.0);
      expect(Energy.parse('5 kJ').inKilojoules, 5.0);
      expect(Energy.parse('200 kcal').inKilocalories, 200.0);
      expect(Energy.parse('1.5 kWh').inKilowattHours, 1.5);
    });

    test('case-insensitive names', () {
      expect(Energy.parse('100 JOULE').unit, EnergyUnit.joule);
      expect(Energy.parse('100 Joules').unit, EnergyUnit.joule);
      expect(Energy.parse('50 CALORIE').unit, EnergyUnit.calorie);
    });

    test('error handling', () {
      expect(Energy.tryParse('invalid'), isNull);
      expect(() => Energy.parse('invalid'), throwsA(isA<QuantityParseException>()));
    });

    test('round-trip', () {
      const original = Energy(100, EnergyUnit.joule);
      final parsed = Energy.parse(original.toString(format: QuantityFormat.invariant));
      expect(parsed.value, closeTo(original.value, 1e-9));
      expect(parsed.unit, original.unit);
    });
  });
}
