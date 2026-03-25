import 'package:meta/meta.dart';

import '../../core/linear_quantity.dart';
import '../../core/quantity_format.dart';
import '../../core/quantity_parser.dart';
import '../angle/angle.dart';
import '../angle/angle_unit.dart';
import '../time/time.dart';
import '../time/time_unit.dart';
import 'angular_velocity_unit.dart';

/// Represents a quantity of angular velocity (or rotational speed).
///
/// Angular velocity is a derived quantity representing the rate of change of
/// an angle over time. The SI unit is radians per second (rad/s).
@immutable
class AngularVelocity extends LinearQuantity<AngularVelocityUnit, AngularVelocity> {
  /// Creates a new `AngularVelocity` with a given [value] and [unit].
  const AngularVelocity(super._value, super._unit);

  /// Creates an [AngularVelocity] from [angle] traversed over [time]
  /// (ω = θ / t).
  ///
  /// If the combination of [angle]'s unit and [time]'s unit matches a standard
  /// angular velocity unit (rad + s → rad/s, ° + s → °/s,
  /// rev + min → rpm, rev + s → rev/s), the result uses that unit.
  /// Otherwise the result is in [AngularVelocityUnit.radianPerSecond].
  /// If [time] is zero, the result follows IEEE 754 semantics.
  ///
  /// ```dart
  /// AngularVelocity.from(1.0.revolutions, 1.0.minutes); // 1.0 rpm
  /// AngularVelocity.from(180.0.degrees, 1.0.s);         // 180.0 °/s
  /// ```
  factory AngularVelocity.from(Angle angle, Time time) {
    final target = _correspondingAngVelUnit(angle.unit, time.unit);
    if (target != null) return AngularVelocity(angle.value / time.value, target);
    return AngularVelocity(
      angle.getValue(AngleUnit.radian) / time.getValue(TimeUnit.second),
      AngularVelocityUnit.radianPerSecond,
    );
  }

  /// Maps an [AngleUnit] × [TimeUnit] pair to its natural [AngularVelocityUnit].
  static AngularVelocityUnit? _correspondingAngVelUnit(AngleUnit a, TimeUnit t) => switch ((a, t)) {
        (AngleUnit.radian, TimeUnit.second) => AngularVelocityUnit.radianPerSecond,
        (AngleUnit.degree, TimeUnit.second) => AngularVelocityUnit.degreePerSecond,
        (AngleUnit.revolution, TimeUnit.minute) => AngularVelocityUnit.revolutionPerMinute,
        (AngleUnit.revolution, TimeUnit.second) => AngularVelocityUnit.revolutionPerSecond,
        _ => null,
      };

  @override
  @protected
  AngularVelocity create(double value, AngularVelocityUnit unit) => AngularVelocity(value, unit);

  /// The parser instance used to convert strings into [AngularVelocity]
  /// objects.
  ///
  /// The parser supports both strict symbol aliases and case-insensitive name
  /// aliases configured in [AngularVelocityUnit].
  static final QuantityParser<AngularVelocityUnit, AngularVelocity> parser =
      QuantityParser<AngularVelocityUnit, AngularVelocity>(
    symbolAliases: AngularVelocityUnit.symbolAliases,
    nameAliases: AngularVelocityUnit.nameAliases,
    factory: AngularVelocity.new,
  );

  /// Parses a string representation of angular velocity into an
  /// [AngularVelocity] object.
  ///
  /// The [formats] list controls how the numeric portion is interpreted.
  static AngularVelocity parse(
    String input, {
    List<QuantityFormat> formats = const [QuantityFormat.invariant],
  }) {
    return parser.parse(input, formats: formats);
  }

  /// Parses a string representation of angular velocity into an
  /// [AngularVelocity] object, returning `null` when parsing fails.
  ///
  /// See [parse] for formatting and matching behavior.
  static AngularVelocity? tryParse(
    String input, {
    List<QuantityFormat> formats = const [QuantityFormat.invariant],
  }) {
    return parser.tryParse(input, formats: formats);
  }

  // --- Dimensional Analysis ---

  /// Calculates the total [Angle] of rotation over a given [Time] duration.
  ///
  /// `Angle = Angular Velocity × Time`
  ///
  /// The result's unit matches the angle component of this angular velocity's
  /// unit: `rad/s` → radians, `°/s` → degrees, `rpm`/`rev/s` → revolutions.
  ///
  /// ```dart
  /// 3000.rpm.totalAngleOver(2.minutes); // 6000.0 rev
  /// 180.degPerSecond.totalAngleOver(2.s); // 360.0 °
  /// ```
  Angle totalAngleOver(Time time) {
    final angleUnit = _correspondingAngleUnit(unit);
    final timeUnit = _correspondingTimeUnitForAngle(unit);
    return Angle(value * time.getValue(timeUnit), angleUnit);
  }

  /// Maps an [AngularVelocityUnit] to its angle component unit.
  static AngleUnit _correspondingAngleUnit(AngularVelocityUnit u) => switch (u) {
        AngularVelocityUnit.radianPerSecond => AngleUnit.radian,
        AngularVelocityUnit.degreePerSecond => AngleUnit.degree,
        AngularVelocityUnit.revolutionPerMinute => AngleUnit.revolution,
        AngularVelocityUnit.revolutionPerSecond => AngleUnit.revolution,
      };

  /// Maps an [AngularVelocityUnit] to its time component unit.
  static TimeUnit _correspondingTimeUnitForAngle(AngularVelocityUnit u) => switch (u) {
        AngularVelocityUnit.radianPerSecond => TimeUnit.second,
        AngularVelocityUnit.degreePerSecond => TimeUnit.second,
        AngularVelocityUnit.revolutionPerMinute => TimeUnit.minute,
        AngularVelocityUnit.revolutionPerSecond => TimeUnit.second,
      };
}
