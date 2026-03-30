import 'package:meta/meta.dart';

import '../../core/linear_quantity.dart';
import '../../core/quantity_format.dart';
import '../../core/quantity_parser.dart';
import 'temperature_delta_unit.dart';

/// A temperature change (interval), distinct from an absolute 'Temperature'.
///
/// ## Point vs. Vector (Affine vs. Linear)
///
/// An absolute temperature (e.g. 20 °C) is a *point* in affine space — it
/// names a position on the thermometer. A [TemperatureDelta] (e.g. a rise of
/// 20 °C) is a *vector* — it describes a displacement between two points.
///
/// Points and vectors obey different rules:
///
/// - **Point − Point = Vector:** `Temperature - Temperature` → `TemperatureDelta`
/// - **Point + Vector = Point:** `Temperature + TemperatureDelta` → `Temperature`
/// - **Vector + Vector = Vector:** `TemperatureDelta + TemperatureDelta` → `TemperatureDelta`
/// - **Scalar × Vector = Vector:** `TemperatureDelta * num` → `TemperatureDelta`
/// - **Point + Point** is *undefined* (adding two absolute temperatures is nonsensical).
///
/// ## Conversions
///
/// Unlike absolute temperatures, deltas convert by a *pure multiplicative
/// factor* — no offsets are involved. A 1-degree Celsius change equals a
/// 1-Kelvin change, and a 1-degree Fahrenheit change equals 5/9 of a Kelvin
/// change.
///
/// ## Example
///
/// ```dart
/// final t1 = 10.celsius;
/// final t2 = 30.celsius;
/// final rise = t2 - t1;         // TemperatureDelta(20.0, celsiusDelta)
/// final t3 = t1 + rise;         // Temperature(30.0, celsius)
/// final doubled = rise * 2.0;   // TemperatureDelta(40.0, celsiusDelta)
/// print(rise.inKelvinDelta);    // 20.0
/// print(rise.inFahrenheitDelta); // 36.0
/// ```
@immutable
final class TemperatureDelta extends LinearQuantity<TemperatureDeltaUnit, TemperatureDelta> {
  /// Creates a [TemperatureDelta] with the given [value] and [unit].
  ///
  /// Example:
  /// ```dart
  /// final rise = TemperatureDelta(20.0, TemperatureDeltaUnit.celsiusDelta);
  /// final drop = TemperatureDelta(-5.0, TemperatureDeltaUnit.kelvinDelta);
  /// ```
  const TemperatureDelta(super._value, super._unit);

  @override
  @protected
  TemperatureDelta create(double value, TemperatureDeltaUnit unit) => TemperatureDelta(value, unit);

  /// The parser instance used to convert strings into [TemperatureDelta]
  /// objects.
  ///
  /// The parser supports both strict symbol aliases and case-insensitive name
  /// aliases configured in [TemperatureDeltaUnit].
  static final QuantityParser<TemperatureDeltaUnit, TemperatureDelta> parser =
      QuantityParser<TemperatureDeltaUnit, TemperatureDelta>(
    symbolAliases: TemperatureDeltaUnit.symbolAliases,
    nameAliases: TemperatureDeltaUnit.nameAliases,
    factory: TemperatureDelta.new,
  );

  /// Parses a string representation of a temperature interval into a
  /// [TemperatureDelta] object.
  ///
  /// The [formats] list controls how the numeric portion is interpreted.
  static TemperatureDelta parse(
    String input, {
    List<QuantityFormat> formats = const [QuantityFormat.invariant],
  }) {
    return parser.parse(input, formats: formats);
  }

  /// Parses a string representation of a temperature interval into a
  /// [TemperatureDelta] object, returning `null` when parsing fails.
  ///
  /// See [parse] for formatting and matching behavior.
  static TemperatureDelta? tryParse(
    String input, {
    List<QuantityFormat> formats = const [QuantityFormat.invariant],
  }) {
    return parser.tryParse(input, formats: formats);
  }
}
