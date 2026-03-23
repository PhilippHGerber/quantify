import 'package:meta/meta.dart';

import '../../../length.dart';
import '../../core/linear_quantity.dart';
import '../../core/quantity_format.dart';
import '../../core/quantity_parser.dart';
import '../time/time.dart';
import '../time/time_extensions.dart';
import 'speed_unit.dart';

/// Represents a quantity of speed (or velocity).
///
/// Speed is a derived quantity representing the rate of change of position
/// over time. The SI derived unit is Meter per Second (m/s).
@immutable
class Speed extends LinearQuantity<SpeedUnit, Speed> {
  /// Creates a new `Speed` with a given [value] and [unit].
  const Speed(super._value, super._unit);

  /// Creates a `Speed` instance from a `Length` and a `Time`.
  ///
  /// This factory method performs the dimensional calculation `Speed = Length / Time`.
  /// It converts the inputs to their base SI units (meters and seconds) for correctness.
  /// If [time] is zero, the result follows IEEE 754 semantics: a non-zero distance
  /// yields [double.infinity] and a zero distance yields [double.nan].
  ///
  /// Example:
  /// ```dart
  /// final distance = 100.m;
  /// final duration = 10.s;
  /// final speed = Speed.from(distance, duration); // Results in Speed(10.0, SpeedUnit.meterPerSecond)
  /// ```
  factory Speed.from(Length distance, Time time) {
    final meters = distance.inM;
    final seconds = time.inSeconds;
    return Speed(meters / seconds, SpeedUnit.meterPerSecond);
  }

  @override
  @protected
  Speed create(double value, SpeedUnit unit) => Speed(value, unit);

  /// Shared parser instance for [parse] and [tryParse].
  ///
  /// Resolves case-sensitive SI/compound symbols (like `m/s` vs `km/h`)
  /// and case-insensitive unit names.
  ///
  /// Create isolated parser variants to support custom or localized aliases:
  /// ```dart
  /// final customParser = Speed.parser.copyWithAliases(
  ///   extraNameAliases: {'velocidad': SpeedUnit.meterPerSecond},
  /// );
  /// ```
  static final QuantityParser<SpeedUnit, Speed> parser = QuantityParser<SpeedUnit, Speed>(
    symbolAliases: SpeedUnit.symbolAliases,
    nameAliases: SpeedUnit.nameAliases,
    factory: Speed.new,
  );

  /// Parses a string representation of a speed into a [Speed] object.
  ///
  /// The [input] string should follow the format `"<number> <unit>"`, where the
  /// space between the number and unit is optional.
  ///
  /// The [formats] list controls how the numeric portion is interpreted. Formats
  /// are tried in order; the first that successfully parses the number wins.
  /// Defaults to [QuantityFormat.invariant] (Dart-native dot-decimal parsing).
  ///
  /// Throws a [FormatException] if no format can parse the input.
  ///
  /// Example:
  /// ```dart
  /// final s = Speed.parse('100 km/h');
  /// final de = Speed.parse('1.234,56 m/s', formats: [QuantityFormat.de]);
  /// ```
  static Speed parse(
    String input, {
    List<QuantityFormat> formats = const [QuantityFormat.invariant],
  }) =>
      parser.parse(input, formats: formats);

  /// Parses a string representation of a speed into a [Speed] object,
  /// returning `null` if the string cannot be parsed.
  ///
  /// The [input] string should follow the format `"<number> <unit>"`.
  /// See [parse] for details on [formats].
  ///
  /// Example:
  /// ```dart
  /// final s = Speed.tryParse('100 km/h'); // Speed(100.0, ...)
  /// final bad = Speed.tryParse('not a speed'); // null
  /// ```
  static Speed? tryParse(
    String input, {
    List<QuantityFormat> formats = const [QuantityFormat.invariant],
  }) =>
      parser.tryParse(input, formats: formats);

  // --- Dimensional Analysis ---

  /// Calculates the total [Length] traveled over a given [Time] duration.
  ///
  /// This method performs the dimensional calculation `Length = Speed × Time`.
  /// The calculation is performed in the base units (m/s and s) to ensure
  /// correctness, and the result is returned as a `Length` in meters.
  ///
  /// Example:
  /// ```dart
  /// final carSpeed = 60.kmh;
  /// final travelTime = 2.h;
  /// final distance = carSpeed.distanceOver(travelTime);
  /// print(distance.inKm); // Output: 120.0
  /// ```
  Length distanceOver(Time duration) {
    final valueInMps = getValue(SpeedUnit.meterPerSecond);
    final timeInSeconds = duration.inSeconds;
    final resultingDistanceInMeters = valueInMps * timeInSeconds;
    return Length(resultingDistanceInMeters, LengthUnit.meter);
  }
}
