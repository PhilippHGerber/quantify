import 'package:quantify/quantify.dart';
import 'package:test/test.dart';

void main() {
  group('Temperature Parsing', () {
    group('Basic parsing', () {
      test('parses symbols', () {
        expect(Temperature.parse('25 °C').unit, TemperatureUnit.celsius);
        expect(Temperature.parse('300 K').unit, TemperatureUnit.kelvin);
        expect(Temperature.parse('77 °F').unit, TemperatureUnit.fahrenheit);
        expect(Temperature.parse('500 °R').unit, TemperatureUnit.rankine);
      });

      test('parses names case-insensitively', () {
        expect(Temperature.parse('25 celsius').unit, TemperatureUnit.celsius);
        expect(Temperature.parse('25 CELSIUS').unit, TemperatureUnit.celsius);
        expect(Temperature.parse('300 kelvin').unit, TemperatureUnit.kelvin);
        expect(Temperature.parse('77 Fahrenheit').unit, TemperatureUnit.fahrenheit);
        expect(Temperature.parse('500 RANKINE').unit, TemperatureUnit.rankine);
      });

      test('parses without space between value and unit', () {
        expect(Temperature.parse('25°C').unit, TemperatureUnit.celsius);
        expect(Temperature.parse('300K').unit, TemperatureUnit.kelvin);
        expect(Temperature.parse('77°F').unit, TemperatureUnit.fahrenheit);
      });
    });

    group('Invariant and errors', () {
      test('invariant rejects locale decimal comma', () {
        expect(Temperature.tryParse('10,5 °C'), isNull);
      });

      test('tryParse null for invalid input', () {
        expect(Temperature.tryParse(''), isNull);
        expect(Temperature.tryParse('foo'), isNull);
        expect(Temperature.tryParse('10 xyz'), isNull);
      });

      test('parse throws QuantityParseException for invalid input', () {
        expect(
          () => Temperature.parse('foo'),
          throwsA(
            isA<QuantityParseException>().having((e) => e.formatsAttempted, 'formatsAttempted', 1),
          ),
        );
      });

      test('empty formats falls back to invariant', () {
        final t = Temperature.parse('25 °C', formats: const []);
        expect(t.value, 25.0);
        expect(t.unit, TemperatureUnit.celsius);
      });
    });
  });
}
