import 'package:meta/meta.dart';

import '../../../length.dart';
import '../../core/linear_quantity.dart';
import '../../core/quantity_format.dart';
import '../../core/quantity_parser.dart';
import '../acceleration/acceleration.dart';
import '../acceleration/acceleration_unit.dart';
import '../time/time.dart';
import '../time/time_extensions.dart';
import '../time/time_unit.dart';
import 'speed_unit.dart';

/// Represents a quantity of speed (or velocity).
///
/// Speed is a derived quantity representing the rate of change of position
/// over time. The SI derived unit is Meter per Second (m/s).
@immutable
class Speed extends LinearQuantity<SpeedUnit, Speed> {
  /// Creates a new `Speed` with a given [value] and [unit].
  const Speed(super._value, super._unit);

  /// Creates a `Speed` from [distance] and [time] (v = d / t).
  ///
  /// If the combination of [distance]'s unit and [time]'s unit matches a
  /// standard speed unit (e.g. km + h → km/h, mi + h → mph), the result uses
  /// that unit. Otherwise the result is in [SpeedUnit.meterPerSecond].
  /// If [time] is zero, the result follows IEEE 754 semantics.
  ///
  /// ```dart
  /// Speed.from(100.km, 1.hours);   // 100.0 km/h
  /// Speed.from(60.miles, 1.hours); // 60.0 mph
  /// Speed.from(100.m, 10.s);       // 10.0 m/s
  /// ```
  factory Speed.from(Length distance, Time time) {
    final target = _correspondingSpeedUnit(distance.unit, time.unit);
    if (target != null) return Speed(distance.value / time.value, target);
    return Speed(distance.inM / time.inSeconds, SpeedUnit.meterPerSecond);
  }

  /// Creates a `Speed` from [acceleration] and [time] (v = a × t).
  ///
  /// The result unit is determined by the acceleration unit's implicit speed
  /// component: `m/s²` → `m/s`, `ft/s²` → `ft/s`, `km/h/s` → `km/h`,
  /// `mph/s` → `mph`, `kn/s` → `kn`, `g` (standard gravity) → `m/s`.
  /// `cm/s²` has no matching speed unit and falls back to [SpeedUnit.meterPerSecond].
  ///
  /// The time can be in any unit; it is always converted to seconds for the
  /// calculation (the "/s" in the acceleration unit cancels with the elapsed
  /// time), so `Speed.from(10.mps2, 1.minutes)` correctly yields `600.0 m/s`.
  ///
  /// ```dart
  /// Speed.from(9.80665.mps2, 1.s);   // 9.80665 m/s
  /// Speed.from(1.gravity, 1.s);      // 9.80665 m/s
  /// Speed.from(10.kmPerHPerS, 6.s);  // 60.0 km/h
  /// Speed.from(32.2.fps2, 3.s);      // 96.6 ft/s
  /// ```
  factory Speed.fromAcceleration(Acceleration acceleration, Time time) {
    final speedUnit = _correspondingSpeedUnitFromAccel(acceleration.unit);
    final targetSpeed = speedUnit ?? SpeedUnit.meterPerSecond;
    final baseAccelUnit = _baseAccelUnitFor(targetSpeed);
    return Speed(
      acceleration.getValue(baseAccelUnit) * time.getValue(TimeUnit.second),
      targetSpeed,
    );
  }

  /// Maps an [AccelerationUnit] to the [SpeedUnit] it implies.
  static SpeedUnit? _correspondingSpeedUnitFromAccel(AccelerationUnit a) => switch (a) {
        AccelerationUnit.meterPerSecondSquared => SpeedUnit.meterPerSecond,
        AccelerationUnit.footPerSecondSquared => SpeedUnit.footPerSecond,
        AccelerationUnit.kilometerPerHourPerSecond => SpeedUnit.kilometerPerHour,
        AccelerationUnit.milePerHourPerSecond => SpeedUnit.milePerHour,
        AccelerationUnit.knotPerSecond => SpeedUnit.knot,
        AccelerationUnit.standardGravity => SpeedUnit.meterPerSecond,
        AccelerationUnit.centimeterPerSecondSquared => null, // no cm/s SpeedUnit
      };

  /// Maps a [SpeedUnit] back to the [AccelerationUnit] whose "/s" component it
  /// cancels — used to correctly convert the acceleration value before
  /// multiplying by elapsed time.
  static AccelerationUnit _baseAccelUnitFor(SpeedUnit s) => switch (s) {
        SpeedUnit.meterPerSecond => AccelerationUnit.meterPerSecondSquared,
        SpeedUnit.kilometerPerSecond => AccelerationUnit.meterPerSecondSquared,
        SpeedUnit.kilometerPerHour => AccelerationUnit.kilometerPerHourPerSecond,
        SpeedUnit.milePerHour => AccelerationUnit.milePerHourPerSecond,
        SpeedUnit.knot => AccelerationUnit.knotPerSecond,
        SpeedUnit.footPerSecond => AccelerationUnit.footPerSecondSquared,
      };

  /// Returns the natural [SpeedUnit] for a given length/time combination,
  /// or `null` if no standard unit matches.
  static SpeedUnit? _correspondingSpeedUnit(LengthUnit d, TimeUnit t) => switch ((d, t)) {
        (LengthUnit.meter, TimeUnit.second) => SpeedUnit.meterPerSecond,
        (LengthUnit.kilometer, TimeUnit.second) => SpeedUnit.kilometerPerSecond,
        (LengthUnit.kilometer, TimeUnit.hour) => SpeedUnit.kilometerPerHour,
        (LengthUnit.mile, TimeUnit.hour) => SpeedUnit.milePerHour,
        (LengthUnit.nauticalMile, TimeUnit.hour) => SpeedUnit.knot,
        (LengthUnit.foot, TimeUnit.second) => SpeedUnit.footPerSecond,
        _ => null,
      };

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
  /// The result's unit matches the distance component of this speed's unit:
  /// `km/h` → kilometers, `mph` → miles, `m/s` → meters, `kn` → nautical miles.
  ///
  /// ```dart
  /// 60.kmh.distanceOver(2.h);   // 120.0 km
  /// 60.mph.distanceOver(0.5.h); // 30.0 mi
  /// 10.mps.distanceOver(5.s);   // 50.0 m
  /// ```
  Length distanceOver(Time duration) {
    final lengthUnit = _correspondingLengthUnit(unit);
    final timeUnit = _correspondingTimeUnit(unit);
    return Length(value * duration.getValue(timeUnit), lengthUnit);
  }

  /// Calculates the [Time] required to travel a given [Length] distance.
  ///
  /// The result's unit matches the time component of this speed's unit:
  /// `km/h` → hours, `mph` → hours, `m/s` → seconds, `kn` → hours.
  /// If the speed is zero, the result follows IEEE 754 semantics.
  ///
  /// ```dart
  /// 60.kmh.timeFor(120.km);   // 2.0 h
  /// 60.mph.timeFor(30.miles); // 0.5 h
  /// 10.mps.timeFor(50.m);     // 5.0 s
  /// ```
  Time timeFor(Length distance) {
    final lengthUnit = _correspondingLengthUnit(unit);
    final timeUnit = _correspondingTimeUnit(unit);
    return Time(distance.getValue(lengthUnit) / value, timeUnit);
  }

  /// Maps a [SpeedUnit] to its distance component [LengthUnit].
  static LengthUnit _correspondingLengthUnit(SpeedUnit u) => switch (u) {
        SpeedUnit.meterPerSecond => LengthUnit.meter,
        SpeedUnit.kilometerPerSecond => LengthUnit.kilometer,
        SpeedUnit.kilometerPerHour => LengthUnit.kilometer,
        SpeedUnit.milePerHour => LengthUnit.mile,
        SpeedUnit.knot => LengthUnit.nauticalMile,
        SpeedUnit.footPerSecond => LengthUnit.foot,
      };

  /// Maps a [SpeedUnit] to its time component [TimeUnit].
  static TimeUnit _correspondingTimeUnit(SpeedUnit u) => switch (u) {
        SpeedUnit.meterPerSecond => TimeUnit.second,
        SpeedUnit.kilometerPerSecond => TimeUnit.second,
        SpeedUnit.kilometerPerHour => TimeUnit.hour,
        SpeedUnit.milePerHour => TimeUnit.hour,
        SpeedUnit.knot => TimeUnit.hour,
        SpeedUnit.footPerSecond => TimeUnit.second,
      };
}
