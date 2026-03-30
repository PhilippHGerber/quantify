import 'package:quantify/quantify.dart';
import 'package:test/test.dart';

void main() {
  const tolerance = 1e-9;
  const litersPerUsGallon = 3.785411784;
  const litersPerUkGallon = 4.54609;
  const kilometersPerMile = 1.609344;

  group('FuelConsumption', () {
    group('Constructors and Getters', () {
      test('creates from constructor and num extensions', () {
        const fromConstructor = FuelConsumption(5.6, FuelConsumptionUnit.litersPer100Km);
        expect(fromConstructor.value, 5.6);
        expect(fromConstructor.unit, FuelConsumptionUnit.litersPer100Km);

        final fromExtension = 42.mpg;
        expect(fromExtension.value, 42.0);
        expect(fromExtension.unit, FuelConsumptionUnit.mpgUs);
      });
    });

    group('Conversions', () {
      test('5 L/100km equals 20 km/L', () {
        expect(5.LPer100Km.inKmPerL, closeTo(20.0, tolerance));
      });

      test('5 L/100km converts to mpg US accurately', () {
        const expected = 20.0 / (kilometersPerMile / litersPerUsGallon);
        expect(5.LPer100Km.inMpgUs, closeTo(expected, tolerance));
      });

      test('5 L/100km converts to mpg UK accurately', () {
        const expected = 20.0 / (kilometersPerMile / litersPerUkGallon);
        expect(5.LPer100Km.inMpgUk, closeTo(expected, tolerance));
      });

      test('round trips between reciprocal units', () {
        final original = 8.5.LPer100Km;
        expect(original.asKmPerL.asLPer100Km.value, closeTo(original.value, tolerance));
        expect(original.asMpgUs.asLPer100Km.value, closeTo(original.value, tolerance));
        expect(original.asMpgUk.asLPer100Km.value, closeTo(original.value, tolerance));
      });
    });

    group('Operator safety', () {
      test('FuelConsumption + FuelConsumption is not available generically', () {
        final dynamic lhs = 5.LPer100Km;
        final dynamic rhs = 6.LPer100Km;
        // This intentionally uses dynamic to assert unsupported operations fail.
        // ignore: avoid_dynamic_calls
        expect(() => lhs + rhs, throwsA(anyOf(isA<NoSuchMethodError>(), isA<TypeError>())));
      });
    });

    group('IEEE 754 edge cases', () {
      test('0 L/100km becomes infinity km/L', () {
        expect(0.LPer100Km.inKmPerL, double.infinity);
      });

      test('infinite mpg US becomes 0 L/100km', () {
        expect(double.infinity.mpgUs.inLPer100Km, 0.0);
      });

      test('0 km/L becomes infinity L/100km', () {
        expect(0.kmPerL.inLPer100Km, double.infinity);
      });
    });

    group('toString and equality consistency', () {
      test('formats with unit symbol', () {
        expect(5.LPer100Km.toString(), '5.0 L/100km');
        expect(42.mpgUk.toString(), '42.0 mpg(UK)');
      });

      test('compareTo compares physical magnitude across units', () {
        expect(5.LPer100Km.compareTo(20.kmPerL), 0);
      });

      test('compareTo stays antisymmetric across reciprocal unit families', () {
        final betterEconomy = 50.mpg;
        final worseEconomy = 10.LPer100Km;

        expect(betterEconomy.compareTo(worseEconomy), lessThan(0));
        expect(worseEconomy.compareTo(betterEconomy), greaterThan(0));
        expect(
          betterEconomy.compareTo(worseEconomy),
          equals(-worseEconomy.compareTo(betterEconomy)),
        );
      });

      test('sorting mixed inverse units uses canonical fuel-consumption ordering', () {
        final values = <FuelConsumption>[50.mpg, 10.LPer100Km, 5.LPer100Km, 30.mpg]..sort();

        expect(values, orderedEquals([50.mpg, 5.LPer100Km, 30.mpg, 10.LPer100Km]));
      });
    });
  });
}
