import 'package:quantify/constants.dart';
import 'package:quantify/quantify.dart';
import 'package:test/test.dart';

void main() {
  const tolerance = 1e-9;

  group('TemperatureDelta', () {
    group('Constructors and Getters', () {
      test('creates from constructor with value and unit', () {
        const delta = TemperatureDelta(10, TemperatureDeltaUnit.celsiusDelta);
        expect(delta.value, 10.0);
        expect(delta.unit, TemperatureDeltaUnit.celsiusDelta);
      });

      test('creates from num extension', () {
        final delta = 10.celsiusDelta;
        expect(delta.value, 10.0);
        expect(delta.unit, TemperatureDeltaUnit.celsiusDelta);

        final deltaK = 5.kelvinDelta;
        expect(deltaK.value, 5.0);
        expect(deltaK.unit, TemperatureDeltaUnit.kelvinDelta);

        final deltaF = 18.fahrenheitDelta;
        expect(deltaF.value, 18.0);
        expect(deltaF.unit, TemperatureDeltaUnit.fahrenheitDelta);

        final deltaR = 9.rankineDelta;
        expect(deltaR.value, 9.0);
        expect(deltaR.unit, TemperatureDeltaUnit.rankineDelta);
      });

      test('factorTo returns valid conversion factors', () {
        expect(
          TemperatureDeltaUnit.kelvinDelta.factorTo(TemperatureDeltaUnit.celsiusDelta),
          closeTo(1.0, tolerance),
        );
        expect(
          TemperatureDeltaUnit.fahrenheitDelta.factorTo(TemperatureDeltaUnit.kelvinDelta),
          closeTo(5.0 / 9.0, tolerance),
        );
      });
    });

    group('Linear Conversions', () {
      test('10 celsiusDelta equals 10 kelvinDelta', () {
        final delta = 10.celsiusDelta;
        expect(delta.inKelvinDelta, closeTo(10.0, tolerance));
      });

      test('10 kelvinDelta equals 10 celsiusDelta', () {
        final delta = 10.kelvinDelta;
        expect(delta.inCelsiusDelta, closeTo(10.0, tolerance));
      });

      test('18 fahrenheitDelta equals 10 celsiusDelta', () {
        final delta = 18.fahrenheitDelta;
        expect(delta.inCelsiusDelta, closeTo(10.0, tolerance));
        expect(delta.inKelvinDelta, closeTo(10.0, tolerance));
      });

      test('10 celsiusDelta equals 18 fahrenheitDelta', () {
        final delta = 10.celsiusDelta;
        expect(delta.inFahrenheitDelta, closeTo(18.0, tolerance));
      });

      test('0 celsiusDelta equals 0 kelvinDelta (no offset applied)', () {
        expect(0.celsiusDelta.inKelvinDelta, closeTo(0.0, tolerance));
      });

      test('0 fahrenheitDelta equals 0 kelvinDelta (no offset applied)', () {
        expect(0.fahrenheitDelta.inKelvinDelta, closeTo(0.0, tolerance));
      });

      test('fahrenheitDelta and rankineDelta have same degree size', () {
        expect(
          1.fahrenheitDelta.inKelvinDelta,
          closeTo(1.rankineDelta.inKelvinDelta, tolerance),
        );
      });

      test('1 kelvinDelta equals 1.8 rankineDelta', () {
        expect(1.kelvinDelta.inRankineDelta, closeTo(1.8, tolerance));
      });

      test('1.8 rankineDelta equals 1 kelvinDelta', () {
        expect(1.8.rankineDelta.inKelvinDelta, closeTo(1.0, tolerance));
      });
    });

    group('convertTo method', () {
      test('returns new instance with converted value', () {
        final delta = 10.celsiusDelta;
        final converted = delta.convertTo(TemperatureDeltaUnit.fahrenheitDelta);
        expect(converted.unit, TemperatureDeltaUnit.fahrenheitDelta);
        expect(converted.value, closeTo(18.0, tolerance));
      });

      test('returns same instance when converting to same unit', () {
        final delta = 10.celsiusDelta;
        final same = delta.convertTo(TemperatureDeltaUnit.celsiusDelta);
        expect(identical(delta, same), isTrue);
      });

      test('as* getters return converted instances', () {
        final delta = 10.kelvinDelta;
        expect(delta.asCelsiusDelta.unit, TemperatureDeltaUnit.celsiusDelta);
        expect(
          delta.asFahrenheitDelta.unit,
          TemperatureDeltaUnit.fahrenheitDelta,
        );
        expect(
          delta.asRankineDelta.unit,
          TemperatureDeltaUnit.rankineDelta,
        );
        expect(delta.asKelvinDelta.unit, TemperatureDeltaUnit.kelvinDelta);
      });
    });

    group('Arithmetic Operators', () {
      test('TemperatureDelta + TemperatureDelta', () {
        final result = 10.celsiusDelta + 5.celsiusDelta;
        expect(result.value, closeTo(15.0, tolerance));
        expect(result.unit, TemperatureDeltaUnit.celsiusDelta);
      });

      test('TemperatureDelta + TemperatureDelta cross-unit', () {
        // 10 °C delta + 18 °F delta = 10 + 10 = 20 °C delta
        final result = 10.celsiusDelta + 18.fahrenheitDelta;
        expect(result.inCelsiusDelta, closeTo(20.0, tolerance));
        expect(result.unit, TemperatureDeltaUnit.celsiusDelta);
      });

      test('TemperatureDelta - TemperatureDelta', () {
        final result = 20.kelvinDelta - 5.kelvinDelta;
        expect(result.value, closeTo(15.0, tolerance));
        expect(result.unit, TemperatureDeltaUnit.kelvinDelta);
      });

      test('TemperatureDelta * scalar', () {
        final result = 10.celsiusDelta * 2.0;
        expect(result.inCelsiusDelta, closeTo(20.0, tolerance));
        expect(result.unit, TemperatureDeltaUnit.celsiusDelta);
      });

      test('TemperatureDelta * negative scalar', () {
        final result = 10.celsiusDelta * -1.0;
        expect(result.inCelsiusDelta, closeTo(-10.0, tolerance));
      });

      test('TemperatureDelta / scalar', () {
        final result = 20.kelvinDelta / 4.0;
        expect(result.inKelvinDelta, closeTo(5.0, tolerance));
        expect(result.unit, TemperatureDeltaUnit.kelvinDelta);
      });

      test('TemperatureDelta / zero throws ArgumentError', () {
        expect(() => 10.celsiusDelta / 0, throwsArgumentError);
      });
    });

    group('Cross-type operators (Temperature ↔ TemperatureDelta)', () {
      test('Temperature - Temperature returns TemperatureDelta', () {
        final delta = 30.celsius - 10.celsius;
        expect(delta, isA<TemperatureDelta>());
        expect(delta.unit, TemperatureDeltaUnit.celsiusDelta);
        expect(delta.value, closeTo(20.0, tolerance));
        expect(delta.inKelvinDelta, closeTo(20.0, tolerance));
      });

      test('Temperature - Temperature with Kelvin operands', () {
        final delta = 373.15.kelvin - 273.15.kelvin;
        expect(delta.unit, TemperatureDeltaUnit.kelvinDelta);
        expect(delta.inKelvinDelta, closeTo(100.0, tolerance));
      });

      test('Temperature - Temperature cross-unit', () {
        // 20°C - 50°F: 50°F = 10°C, so delta = 10 in celsius
        final delta = 20.celsius - 50.fahrenheit;
        expect(delta.unit, TemperatureDeltaUnit.celsiusDelta);
        expect(delta.inCelsiusDelta, closeTo(10.0, tolerance));
      });

      test('Temperature - Temperature with Fahrenheit operands', () {
        final delta = 212.fahrenheit - 32.fahrenheit;
        expect(delta.unit, TemperatureDeltaUnit.fahrenheitDelta);
        expect(delta.value, closeTo(180.0, tolerance));
        // 180 °F delta = 100 K delta
        expect(delta.inKelvinDelta, closeTo(100.0, tolerance));
      });

      test('Temperature - Temperature with Rankine operands', () {
        final delta = 671.67.rankine - 491.67.rankine;
        expect(delta.unit, TemperatureDeltaUnit.rankineDelta);
        expect(delta.value, closeTo(180.0, tolerance));
        expect(delta.inKelvinDelta, closeTo(100.0, tolerance));
      });

      test('Temperature + TemperatureDelta returns Temperature', () {
        final result = 10.celsius + 20.celsiusDelta;
        expect(result, isA<Temperature>());
        expect(result.unit, TemperatureUnit.celsius);
        expect(result.value, closeTo(30.0, tolerance));
      });

      test('Temperature + TemperatureDelta cross-unit', () {
        // 0°C + 18 °F delta (= 10 K delta) = 10°C
        final result = 0.celsius + 18.fahrenheitDelta;
        expect(result.unit, TemperatureUnit.celsius);
        expect(result.inCelsius, closeTo(10.0, tolerance));
      });

      test('Temperature + TemperatureDelta with Kelvin base', () {
        final result = 273.15.kelvin + 100.kelvinDelta;
        expect(result.unit, TemperatureUnit.kelvin);
        expect(result.value, closeTo(373.15, tolerance));
      });

      test('TemperatureDelta.addTo(Temperature) returns Temperature (commutative)', () {
        final result = 20.celsiusDelta.addTo(10.celsius);
        expect(result, isA<Temperature>());
        expect(result.unit, TemperatureUnit.celsius);
        expect(result.value, closeTo(30.0, tolerance));
      });

      test('Temperature.subtract(TemperatureDelta) returns Temperature', () {
        final result = 30.celsius.subtract(20.celsiusDelta);
        expect(result, isA<Temperature>());
        expect(result.unit, TemperatureUnit.celsius);
        expect(result.value, closeTo(10.0, tolerance));
      });

      test('Temperature.subtract cross-unit', () {
        // 100°C subtract 180 °F delta (= 100 K delta) = 0°C
        final result = 100.celsius.subtract(180.fahrenheitDelta);
        expect(result.unit, TemperatureUnit.celsius);
        expect(result.inCelsius, closeTo(0.0, tolerance));
      });

      test('Temperature + negative delta equals Temperature.subtract', () {
        final temp = 30.celsius;
        final delta = 20.celsiusDelta;
        final viaAdd = temp + (delta * -1.0);
        final viaSubtract = temp.subtract(delta);
        expect(viaAdd.inCelsius, closeTo(viaSubtract.inCelsius, tolerance));
      });
    });

    group('ratioTo on Temperature', () {
      test('ratioTo uses Kelvin for thermodynamically valid ratio', () {
        final t200K = 200.0.kelvin;
        final t100K = 100.0.kelvin;
        expect(t200K.ratioTo(t100K), closeTo(2.0, tolerance));
      });

      test('ratioTo with Celsius inputs converts to Kelvin', () {
        // 100°C = 373.15K, 0°C = 273.15K
        final ratio = 100.celsius.ratioTo(0.celsius);
        expect(ratio, closeTo(373.15 / 273.15, tolerance));
      });

      test('ratioTo throws on absolute zero divisor', () {
        expect(() => 300.kelvin.ratioTo(0.kelvin), throwsArgumentError);
      });

      test('Carnot efficiency via ratioTo', () {
        // η = 1 − T_cold/T_hot
        final coldReservoir = 300.0.kelvin;
        final hotReservoir = 600.0.kelvin;
        final efficiency = 1.0 - coldReservoir.ratioTo(hotReservoir);
        expect(efficiency, closeTo(0.5, tolerance));
      });
    });

    group('asDelta getter on Temperature', () {
      test('Kelvin temperature converts to kelvinDelta', () {
        expect(300.kelvin.asDelta.inKelvinDelta, closeTo(300.0, tolerance));
        expect(300.kelvin.asDelta.unit, TemperatureDeltaUnit.kelvinDelta);
      });

      test('Celsius temperature converts to kelvinDelta via absolute zero', () {
        // 100°C = 373.15K
        expect(100.celsius.asDelta.inKelvinDelta, closeTo(373.15, tolerance));
      });

      test('0 Kelvin converts to 0 kelvinDelta', () {
        expect(0.kelvin.asDelta.inKelvinDelta, closeTo(0.0, tolerance));
      });

      test('Fahrenheit temperature converts correctly', () {
        // 32°F = 0°C = 273.15K
        expect(
          32.fahrenheit.asDelta.inKelvinDelta,
          closeTo(273.15, tolerance),
        );
      });
    });

    group('Comparisons and Equality', () {
      test('equal deltas are equal', () {
        expect(10.kelvinDelta == 10.kelvinDelta, isTrue);
      });

      test('different values are not equal', () {
        expect(10.kelvinDelta == 20.kelvinDelta, isFalse);
      });

      test('same magnitude different units are not equal but equivalent', () {
        final a = 10.kelvinDelta;
        final b = 10.celsiusDelta;
        // Different unit enum values → not ==
        expect(a == b, isFalse);
        // But equivalent in magnitude
        expect(a.isEquivalentTo(b), isTrue);
      });

      test('compareTo works across units', () {
        expect(10.kelvinDelta.compareTo(18.fahrenheitDelta), 0);
        expect(20.kelvinDelta.compareTo(10.kelvinDelta), greaterThan(0));
        expect(5.celsiusDelta.compareTo(10.kelvinDelta), lessThan(0));
      });

      test('comparison operators work', () {
        expect(20.kelvinDelta > 10.kelvinDelta, isTrue);
        expect(5.celsiusDelta < 10.celsiusDelta, isTrue);
        expect(10.kelvinDelta >= 10.celsiusDelta, isTrue);
        expect(10.kelvinDelta <= 18.fahrenheitDelta, isTrue);
      });
    });

    group('Round Trip Conversions', () {
      test('kelvinDelta <-> celsiusDelta', () {
        final orig = 37.0.celsiusDelta;
        final roundTrip = orig.asKelvinDelta.asCelsiusDelta;
        expect(roundTrip.value, closeTo(37.0, tolerance));
      });

      test('celsiusDelta <-> fahrenheitDelta', () {
        final orig = 10.0.celsiusDelta;
        final roundTrip = orig.asFahrenheitDelta.asCelsiusDelta;
        expect(roundTrip.value, closeTo(10.0, tolerance));
      });

      test('kelvinDelta <-> rankineDelta', () {
        final orig = 100.0.kelvinDelta;
        final roundTrip = orig.asRankineDelta.asKelvinDelta;
        expect(roundTrip.value, closeTo(100.0, tolerance));
      });

      test('fahrenheitDelta <-> rankineDelta', () {
        final orig = 36.0.fahrenheitDelta;
        final roundTrip = orig.asRankineDelta.asFahrenheitDelta;
        expect(roundTrip.value, closeTo(36.0, tolerance));
      });

      test('full chain: C -> K -> F -> R -> C', () {
        final orig = 25.0.celsiusDelta;
        final roundTrip = orig.asKelvinDelta.asFahrenheitDelta.asRankineDelta.asCelsiusDelta;
        expect(roundTrip.value, closeTo(25.0, tolerance));
      });
    });

    group('toString', () {
      test('default format', () {
        expect(20.0.celsiusDelta.toString(), '20.0\u00A0°C');
        expect(10.0.kelvinDelta.toString(), '10.0\u00A0K');
        expect(36.0.fahrenheitDelta.toString(), '36.0\u00A0°F');
        expect(18.0.rankineDelta.toString(), '18.0\u00A0°R');
      });

      test('with targetUnit', () {
        expect(
          10.0.celsiusDelta.toString(
                targetUnit: TemperatureDeltaUnit.fahrenheitDelta,
              ),
          '18.0\u00A0°F',
        );
      });

      test('with fractionDigits', () {
        expect(
          10.0.celsiusDelta.toString(fractionDigits: 2),
          '10.00\u00A0°C',
        );
      });
    });

    group('Engineering Logic Verification', () {
      test(
          'thermalExpansion with celsiusDelta gives correct result '
          '(not 14x wrong)', () {
        // ΔL = L₀ × α × ΔT = 1.0m × 1e-3 × 20 = 0.02m
        final deltaLength = EngineeringConstants.thermalExpansion(
          1.0.m,
          1.0e-3,
          20.celsiusDelta,
        );
        expect(deltaLength.inM, closeTo(0.02, tolerance));
        // If the old bug were present (using 20.celsius = 293.15K),
        // result would be ~0.29315m — about 14x too large.
      });

      test('conductiveHeatTransfer with kelvinDelta', () {
        // q = k × A × ΔT / Δx = 0.5 × 1.0 × 10 / 0.1 = 50 W
        final heatRate = EngineeringConstants.conductiveHeatTransfer(
          0.5,
          1.m2,
          0.1.m,
          10.kelvinDelta,
        );
        expect(heatRate.inWatts, closeTo(50.0, tolerance));
      });

      test('thermalExpansion via Temperature subtraction', () {
        final t1 = 10.celsius;
        final t2 = 30.celsius;
        // t2 - t1 yields a TemperatureDelta of 20 celsiusDelta
        final deltaLength = EngineeringConstants.thermalExpansion(
          1.0.m,
          1.0e-3,
          t2 - t1,
        );
        expect(deltaLength.inM, closeTo(0.02, tolerance));
      });
    });
  });
}
