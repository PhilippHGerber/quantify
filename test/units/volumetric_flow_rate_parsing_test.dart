import 'package:quantify/quantify.dart';
import 'package:test/test.dart';

void main() {
  const tolerance = 1e-9;

  group('VolumetricFlowRate Parsing', () {
    group('Basic parsing', () {
      test('parses standard valid inputs with invariant format', () {
        expect(
          VolumetricFlowRate.parse('100 L/min').inLitersPerMinute,
          100.0,
        );
        expect(
          VolumetricFlowRate.parse('10.5 m³/s').inCubicMetersPerSecond,
          10.5,
        );
        expect(
          VolumetricFlowRate.parse('-5.2 gal/min').inGallonsPerMinute,
          -5.2,
        );
        expect(VolumetricFlowRate.parse('2e3 L/s').inLitersPerSecond, 2000.0);
        expect(VolumetricFlowRate.parse('1.5E-2 m³/h').inCubicMetersPerHour, 0.015);
      });

      test('parses by symbol', () {
        final f = VolumetricFlowRate.parse('100 L/min');
        expect(f.value, 100.0);
        expect(f.unit, VolumetricFlowRateUnit.literPerMinute);
      });

      test('parses by full name', () {
        final f = VolumetricFlowRate.parse('10 liters per second');
        expect(f.value, 10.0);
        expect(f.unit, VolumetricFlowRateUnit.literPerSecond);
      });

      test('parses by plural name', () {
        final f = VolumetricFlowRate.parse('5 cubic meters per hour');
        expect(f.value, 5.0);
        expect(f.unit, VolumetricFlowRateUnit.cubicMeterPerHour);
      });

      test('parses scientific notation', () {
        final f = VolumetricFlowRate.parse('1.5e3 L/s');
        expect(f.value, 1500.0);
        expect(f.unit, VolumetricFlowRateUnit.literPerSecond);
      });

      test('parses negative values', () {
        final f = VolumetricFlowRate.parse('-5 L/s');
        expect(f.value, -5.0);
        expect(f.unit, VolumetricFlowRateUnit.literPerSecond);
      });

      test('parses leading decimal point', () {
        final f = VolumetricFlowRate.parse('.5 L/s');
        expect(f.value, 0.5);
        expect(f.unit, VolumetricFlowRateUnit.literPerSecond);

        final neg = VolumetricFlowRate.parse('-.5 m³/h');
        expect(neg.value, -0.5);
        expect(neg.unit, VolumetricFlowRateUnit.cubicMeterPerHour);
      });
    });

    group('Spacing', () {
      test('parses correctly regardless of spacing', () {
        expect(VolumetricFlowRate.parse('100L/min').inLitersPerMinute, 100.0);
        expect(VolumetricFlowRate.parse('100   L/min').inLitersPerMinute, 100.0);
        expect(VolumetricFlowRate.parse('100\tL/min').inLitersPerMinute, 100.0);
        expect(VolumetricFlowRate.parse('  100 L/min  ').inLitersPerMinute, 100.0);
      });

      test('parses without space between value and unit', () {
        final f = VolumetricFlowRate.parse('10.5gpm');
        expect(f.value, 10.5);
        expect(f.unit, VolumetricFlowRateUnit.gallonPerMinute);
      });

      test('whitespace normalization in multi-word units', () {
        expect(VolumetricFlowRate.tryParse('5 liter  per  second'), isNotNull);
        expect(
          VolumetricFlowRate.parse('5 liter  per  second').unit,
          VolumetricFlowRateUnit.literPerSecond,
        );
        expect(VolumetricFlowRate.tryParse('10 gallons  per  minute'), isNotNull);
        expect(
          VolumetricFlowRate.parse('10 gallons  per  minute').unit,
          VolumetricFlowRateUnit.gallonPerMinute,
        );
      });
    });

    group('Case sensitivity', () {
      test('SI symbols stay case-sensitive', () {
        // SI slash symbols remain strict.
        expect(VolumetricFlowRate.parse('10 L/s').unit, VolumetricFlowRateUnit.literPerSecond);
        expect(VolumetricFlowRate.tryParse('10 l/S'), isNull);

        // Non-SI abbreviations are accepted case-insensitively via name aliases.
        expect(VolumetricFlowRate.parse('10 gpm').unit, VolumetricFlowRateUnit.gallonPerMinute);
        expect(VolumetricFlowRate.parse('10 cfm').unit, VolumetricFlowRateUnit.cubicFootPerMinute);
        expect(VolumetricFlowRate.parse('10 GPM').unit, VolumetricFlowRateUnit.gallonPerMinute);
        expect(VolumetricFlowRate.parse('10 CFM').unit, VolumetricFlowRateUnit.cubicFootPerMinute);
        expect(VolumetricFlowRate.parse('10 Gpm').unit, VolumetricFlowRateUnit.gallonPerMinute);
      });

      test('full names are case-insensitive', () {
        expect(
          VolumetricFlowRate.parse('10 LITERS PER SECOND').unit,
          VolumetricFlowRateUnit.literPerSecond,
        );
        expect(
          VolumetricFlowRate.parse('10 Cubic Meters Per Hour').unit,
          VolumetricFlowRateUnit.cubicMeterPerHour,
        );
        expect(
          VolumetricFlowRate.parse('5 GALLONS PER MINUTE').unit,
          VolumetricFlowRateUnit.gallonPerMinute,
        );
      });
    });

    group('Unit coverage', () {
      test('parses all volumetric flow rate units by symbol', () {
        expect(
          VolumetricFlowRate.parse('1 m³/s').unit,
          VolumetricFlowRateUnit.cubicMeterPerSecond,
        );
        expect(
          VolumetricFlowRate.parse('1 m³/min').unit,
          VolumetricFlowRateUnit.cubicMeterPerMinute,
        );
        expect(VolumetricFlowRate.parse('1 m³/h').unit, VolumetricFlowRateUnit.cubicMeterPerHour);
        expect(VolumetricFlowRate.parse('1 L/s').unit, VolumetricFlowRateUnit.literPerSecond);
        expect(VolumetricFlowRate.parse('1 L/min').unit, VolumetricFlowRateUnit.literPerMinute);
        expect(VolumetricFlowRate.parse('1 L/h').unit, VolumetricFlowRateUnit.literPerHour);
        expect(
          VolumetricFlowRate.parse('1 mL/min').unit,
          VolumetricFlowRateUnit.milliliterPerMinute,
        );
        expect(
          VolumetricFlowRate.parse('1 ft³/s').unit,
          VolumetricFlowRateUnit.cubicFootPerSecond,
        );
        expect(
          VolumetricFlowRate.parse('1 ft³/min').unit,
          VolumetricFlowRateUnit.cubicFootPerMinute,
        );
        expect(VolumetricFlowRate.parse('1 gal/min').unit, VolumetricFlowRateUnit.gallonPerMinute);
        expect(VolumetricFlowRate.parse('1 gal/h').unit, VolumetricFlowRateUnit.gallonPerHour);
      });

      test('parses alternative symbol aliases', () {
        expect(VolumetricFlowRate.parse('1 m3/s').unit, VolumetricFlowRateUnit.cubicMeterPerSecond);
        expect(
          VolumetricFlowRate.parse('1 ft3/min').unit,
          VolumetricFlowRateUnit.cubicFootPerMinute,
        );
        expect(VolumetricFlowRate.parse('1 cfs').unit, VolumetricFlowRateUnit.cubicFootPerSecond);
        expect(VolumetricFlowRate.parse('1 gpm').unit, VolumetricFlowRateUnit.gallonPerMinute);
        expect(VolumetricFlowRate.parse('1 gph').unit, VolumetricFlowRateUnit.gallonPerHour);
      });

      test('parses all volumetric flow rate units by name', () {
        expect(
          VolumetricFlowRate.parse('1 cubic meter per second').unit,
          VolumetricFlowRateUnit.cubicMeterPerSecond,
        );
        expect(
          VolumetricFlowRate.parse('1 liter per minute').unit,
          VolumetricFlowRateUnit.literPerMinute,
        );
        expect(
          VolumetricFlowRate.parse('1 milliliter per minute').unit,
          VolumetricFlowRateUnit.milliliterPerMinute,
        );
        expect(
          VolumetricFlowRate.parse('1 cubic foot per second').unit,
          VolumetricFlowRateUnit.cubicFootPerSecond,
        );
        expect(
          VolumetricFlowRate.parse('1 gallon per hour').unit,
          VolumetricFlowRateUnit.gallonPerHour,
        );
      });

      test('parses British spelling variants', () {
        expect(
          VolumetricFlowRate.parse('1 litre per second').unit,
          VolumetricFlowRateUnit.literPerSecond,
        );
        expect(
          VolumetricFlowRate.parse('1 cubic metres per hour').unit,
          VolumetricFlowRateUnit.cubicMeterPerHour,
        );
      });

      test('parses plural name variants', () {
        expect(
          VolumetricFlowRate.parse('5 liters per second').unit,
          VolumetricFlowRateUnit.literPerSecond,
        );
        expect(
          VolumetricFlowRate.parse('5 gallons per minute').unit,
          VolumetricFlowRateUnit.gallonPerMinute,
        );
        expect(
          VolumetricFlowRate.parse('5 cubic feet per minute').unit,
          VolumetricFlowRateUnit.cubicFootPerMinute,
        );
      });

      test('parsed value should be usable in conversions', () {
        final f = VolumetricFlowRate.parse('1 m³/h');
        expect(
          f.getValue(VolumetricFlowRateUnit.cubicMeterPerSecond),
          closeTo(1.0 / 3600.0, tolerance),
        );
      });
    });

    group('Error handling', () {
      test('empty formats list falls back to invariant format', () {
        final f = VolumetricFlowRate.parse('100 L/min', formats: const []);
        expect(f.inLitersPerMinute, 100.0);
      });

      test('tryParse returns null for invalid inputs', () {
        expect(VolumetricFlowRate.tryParse(''), isNull);
        expect(VolumetricFlowRate.tryParse('   '), isNull);
        expect(VolumetricFlowRate.tryParse('10'), isNull);
        expect(VolumetricFlowRate.tryParse('L/min'), isNull);
        expect(VolumetricFlowRate.tryParse('not a flow rate'), isNull);
        expect(VolumetricFlowRate.tryParse('10.5.2 L/min'), isNull);
        expect(VolumetricFlowRate.tryParse('10 unknownUnit'), isNull);
        expect(VolumetricFlowRate.tryParse('10 xyz'), isNull);
      });

      test('tryParse returns VolumetricFlowRate for valid input', () {
        final f = VolumetricFlowRate.tryParse('100 L/min');
        expect(f, isNotNull);
        expect(f!.value, 100.0);
        expect(f.unit, VolumetricFlowRateUnit.literPerMinute);
      });

      test('parse throws QuantityParseException for invalid inputs', () {
        expect(
          () => VolumetricFlowRate.parse('   '),
          throwsA(
            isA<QuantityParseException>().having((e) => e.formatsAttempted, 'formatsAttempted', 1),
          ),
        );

        expect(
          () => VolumetricFlowRate.parse('10 xyz'),
          throwsA(
            isA<QuantityParseException>().having(
              (e) => e.message,
              'message',
              contains('Failed to parse'),
            ),
          ),
        );

        // QuantityParseException is also a FormatException
        expect(
          () => VolumetricFlowRate.parse('bad input'),
          throwsA(isA<FormatException>()),
        );
      });

      test('parse throws FormatException for invalid input', () {
        expect(() => VolumetricFlowRate.parse('not a flow rate'), throwsFormatException);
        expect(() => VolumetricFlowRate.parse(''), throwsFormatException);
        expect(() => VolumetricFlowRate.parse('10 xyz'), throwsFormatException);
      });

      test('parse throws with correct formatsAttempted count', () {
        expect(
          () => VolumetricFlowRate.parse(
            'not valid',
            formats: [QuantityFormat.enUs, QuantityFormat.de],
          ),
          throwsA(
            isA<QuantityParseException>().having((e) => e.formatsAttempted, 'formatsAttempted', 2),
          ),
        );
      });
    });
  });
}
