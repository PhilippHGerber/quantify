import 'package:quantify/quantify.dart';
import 'package:test/test.dart';

void main() {
  group('Volume Parsing', () {
    test('parses common volume units', () {
      expect(Volume.parse('1 L').inLiters, 1.0);
      expect(Volume.parse('500 mL').inMilliliters, 500.0);
      expect(Volume.parse('1 gal').inGallons, 1.0);
      expect(Volume.parse('1 gal(UK)').inImperialGallons, 1.0);
      expect(Volume.parse('2.5 m³').inCubicMeters, 2.5);
    });

    test('case-insensitive names', () {
      expect(Volume.parse('1 LITER').unit, VolumeUnit.litre);
      expect(Volume.parse('1 Liters').unit, VolumeUnit.litre);
      expect(Volume.parse('5 GALLON').unit, VolumeUnit.gallon);
      expect(Volume.parse('2 Imperial Gallons').unit, VolumeUnit.imperialGallon);
    });

    test('error handling', () {
      expect(Volume.tryParse('invalid'), isNull);
      expect(() => Volume.parse('invalid'), throwsA(isA<QuantityParseException>()));
    });

    test('round-trip', () {
      const original = Volume(5, VolumeUnit.litre);
      final parsed = Volume.parse(original.toString(format: QuantityFormat.invariant));
      expect(parsed.value, closeTo(original.value, 1e-9));
      expect(parsed.unit, original.unit);
    });
  });
}
