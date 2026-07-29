import 'package:meta/meta.dart';

import '../../core/linear_quantity.dart';
import '../../core/quantity_format.dart';
import '../../core/quantity_parser.dart';
import '../time/time.dart';
import '../time/time_extensions.dart';
import '../time/time_unit.dart';
import '../volume/volume.dart';
import '../volume/volume_extensions.dart';
import '../volume/volume_unit.dart';
import 'volumetric_flow_rate_unit.dart';

/// Represents a quantity of volumetric flow rate.
///
/// Volumetric flow rate is a derived quantity representing the volume of
/// fluid which passes per unit of time (Q = V / t). The SI derived unit is
/// Cubic Meter per Second (m³/s).
@immutable
final class VolumetricFlowRate extends LinearQuantity<VolumetricFlowRateUnit, VolumetricFlowRate> {
  /// Creates a new `VolumetricFlowRate` with a given [value] and [unit].
  const VolumetricFlowRate(super._value, super._unit);

  /// Creates a `VolumetricFlowRate` from [volume] and [time] (Q = V / t).
  ///
  /// If the combination of [volume]'s unit and [time]'s unit matches a
  /// standard flow rate unit (e.g. L + min → L/min, m³ + h → m³/h), the
  /// result uses that unit. Otherwise the result is in
  /// [VolumetricFlowRateUnit.cubicMeterPerSecond].
  /// If [time] is zero, the result follows IEEE 754 semantics.
  ///
  /// ```dart
  /// VolumetricFlowRate.from(10.L, 1.s);      // 10.0 L/s
  /// VolumetricFlowRate.from(120.L, 1.minutes); // 120.0 L/min
  /// VolumetricFlowRate.from(36.cubicMeters, 1.hours); // 36.0 m³/h
  /// ```
  factory VolumetricFlowRate.from(Volume volume, Time time) {
    final target = _correspondingFlowRateUnit(volume.unit, time.unit);
    if (target != null) return VolumetricFlowRate(volume.value / time.value, target);
    return VolumetricFlowRate(
      volume.inCubicMeters / time.inSeconds,
      VolumetricFlowRateUnit.cubicMeterPerSecond,
    );
  }

  /// Returns the natural [VolumetricFlowRateUnit] for a given volume/time
  /// combination, or `null` if no standard unit matches.
  static VolumetricFlowRateUnit? _correspondingFlowRateUnit(VolumeUnit v, TimeUnit t) =>
      switch ((v, t)) {
        (VolumeUnit.cubicMeter, TimeUnit.second) => VolumetricFlowRateUnit.cubicMeterPerSecond,
        (VolumeUnit.cubicMeter, TimeUnit.minute) => VolumetricFlowRateUnit.cubicMeterPerMinute,
        (VolumeUnit.cubicMeter, TimeUnit.hour) => VolumetricFlowRateUnit.cubicMeterPerHour,
        (VolumeUnit.litre, TimeUnit.second) => VolumetricFlowRateUnit.literPerSecond,
        (VolumeUnit.litre, TimeUnit.minute) => VolumetricFlowRateUnit.literPerMinute,
        (VolumeUnit.litre, TimeUnit.hour) => VolumetricFlowRateUnit.literPerHour,
        (VolumeUnit.milliliter, TimeUnit.minute) => VolumetricFlowRateUnit.milliliterPerMinute,
        (VolumeUnit.cubicFoot, TimeUnit.second) => VolumetricFlowRateUnit.cubicFootPerSecond,
        (VolumeUnit.cubicFoot, TimeUnit.minute) => VolumetricFlowRateUnit.cubicFootPerMinute,
        (VolumeUnit.gallon, TimeUnit.minute) => VolumetricFlowRateUnit.gallonPerMinute,
        (VolumeUnit.gallon, TimeUnit.hour) => VolumetricFlowRateUnit.gallonPerHour,
        _ => null,
      };

  @override
  @protected
  VolumetricFlowRate create(double value, VolumetricFlowRateUnit unit) =>
      VolumetricFlowRate(value, unit);

  /// Shared parser instance for [parse] and [tryParse].
  ///
  /// Resolves case-sensitive SI/compound symbols (like `L/s` vs `m³/h`)
  /// and case-insensitive unit names.
  ///
  /// Create isolated parser variants to support custom or localized aliases:
  /// ```dart
  /// final customParser = VolumetricFlowRate.parser.copyWithAliases(
  ///   extraNameAliases: {'caudal': VolumetricFlowRateUnit.literPerSecond},
  /// );
  /// ```
  static final QuantityParser<VolumetricFlowRateUnit, VolumetricFlowRate> parser =
      QuantityParser<VolumetricFlowRateUnit, VolumetricFlowRate>(
    symbolAliases: VolumetricFlowRateUnit.symbolAliases,
    nameAliases: VolumetricFlowRateUnit.nameAliases,
    factory: VolumetricFlowRate.new,
  );

  /// Parses a string representation of a volumetric flow rate into a
  /// [VolumetricFlowRate] object.
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
  /// final f = VolumetricFlowRate.parse('100 L/min');
  /// final de = VolumetricFlowRate.parse('1.234,56 m³/h', formats: [QuantityFormat.de]);
  /// ```
  static VolumetricFlowRate parse(
    String input, {
    List<QuantityFormat> formats = const [QuantityFormat.invariant],
  }) =>
      parser.parse(input, formats: formats);

  /// Parses a string representation of a volumetric flow rate into a
  /// [VolumetricFlowRate] object, returning `null` if the string cannot be parsed.
  ///
  /// The [input] string should follow the format `"<number> <unit>"`.
  /// See [parse] for details on [formats].
  ///
  /// Example:
  /// ```dart
  /// final f = VolumetricFlowRate.tryParse('100 L/min'); // VolumetricFlowRate(100.0, ...)
  /// final bad = VolumetricFlowRate.tryParse('not a flow rate'); // null
  /// ```
  static VolumetricFlowRate? tryParse(
    String input, {
    List<QuantityFormat> formats = const [QuantityFormat.invariant],
  }) =>
      parser.tryParse(input, formats: formats);

  // --- Dimensional Analysis ---

  /// Calculates the total [Volume] that passes over a given [Time] duration
  /// (V = Q × t).
  ///
  /// The result's unit matches the volume component of this flow rate's unit:
  /// `L/min` → liters, `m³/h` → cubic meters, `gal/min` → gallons.
  ///
  /// ```dart
  /// 10.literPerSecond.volumeOver(1.minutes);   // 600.0 L
  /// 36.cubicMetersPerHour.volumeOver(2.hours); // 72.0 m³
  /// ```
  Volume volumeOver(Time duration) {
    final volumeUnit = _correspondingVolumeUnit(unit);
    final timeUnit = _correspondingTimeUnit(unit);
    return Volume(value * duration.getValue(timeUnit), volumeUnit);
  }

  /// Calculates the [Time] required for a given [Volume] to pass (t = V / Q).
  ///
  /// The result's unit matches the time component of this flow rate's unit:
  /// `L/min` → minutes, `m³/h` → hours, `m³/s` → seconds.
  /// If the flow rate is zero, the result follows IEEE 754 semantics.
  ///
  /// ```dart
  /// 10.literPerSecond.timeFor(50.liters);       // 5.0 s
  /// 36.cubicMetersPerHour.timeFor(72.cubicMeters); // 2.0 h
  /// ```
  Time timeFor(Volume volume) {
    final volumeUnit = _correspondingVolumeUnit(unit);
    final timeUnit = _correspondingTimeUnit(unit);
    return Time(volume.getValue(volumeUnit) / value, timeUnit);
  }

  /// Maps a [VolumetricFlowRateUnit] to its volume component [VolumeUnit].
  static VolumeUnit _correspondingVolumeUnit(VolumetricFlowRateUnit u) => switch (u) {
        VolumetricFlowRateUnit.cubicMeterPerSecond => VolumeUnit.cubicMeter,
        VolumetricFlowRateUnit.cubicMeterPerMinute => VolumeUnit.cubicMeter,
        VolumetricFlowRateUnit.cubicMeterPerHour => VolumeUnit.cubicMeter,
        VolumetricFlowRateUnit.literPerSecond => VolumeUnit.litre,
        VolumetricFlowRateUnit.literPerMinute => VolumeUnit.litre,
        VolumetricFlowRateUnit.literPerHour => VolumeUnit.litre,
        VolumetricFlowRateUnit.milliliterPerMinute => VolumeUnit.milliliter,
        VolumetricFlowRateUnit.cubicFootPerSecond => VolumeUnit.cubicFoot,
        VolumetricFlowRateUnit.cubicFootPerMinute => VolumeUnit.cubicFoot,
        VolumetricFlowRateUnit.gallonPerMinute => VolumeUnit.gallon,
        VolumetricFlowRateUnit.gallonPerHour => VolumeUnit.gallon,
      };

  /// Maps a [VolumetricFlowRateUnit] to its time component [TimeUnit].
  static TimeUnit _correspondingTimeUnit(VolumetricFlowRateUnit u) => switch (u) {
        VolumetricFlowRateUnit.cubicMeterPerSecond => TimeUnit.second,
        VolumetricFlowRateUnit.cubicMeterPerMinute => TimeUnit.minute,
        VolumetricFlowRateUnit.cubicMeterPerHour => TimeUnit.hour,
        VolumetricFlowRateUnit.literPerSecond => TimeUnit.second,
        VolumetricFlowRateUnit.literPerMinute => TimeUnit.minute,
        VolumetricFlowRateUnit.literPerHour => TimeUnit.hour,
        VolumetricFlowRateUnit.milliliterPerMinute => TimeUnit.minute,
        VolumetricFlowRateUnit.cubicFootPerSecond => TimeUnit.second,
        VolumetricFlowRateUnit.cubicFootPerMinute => TimeUnit.minute,
        VolumetricFlowRateUnit.gallonPerMinute => TimeUnit.minute,
        VolumetricFlowRateUnit.gallonPerHour => TimeUnit.hour,
      };
}
