import 'package:meta/meta.dart';

import '../../core/linear_quantity.dart';
import '../../core/quantity_format.dart';
import '../../core/quantity_parser.dart';
import '../angle/angle.dart';
import '../angle/angle_unit.dart';
import '../time/time.dart';
import '../time/time_extensions.dart';
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

  /// Creates an [AngularVelocity] from an [Angle] traversed over a [Time].
  ///
  /// `Angular Velocity = Angle / Time`
  ///
  /// The inverse of [totalAngleOver]. If [time] is zero, the result follows
  /// IEEE 754 semantics: a non-zero angle yields [double.infinity] and a zero
  /// angle yields [double.nan].
  ///
  /// Example:
  /// ```dart
  /// final av = AngularVelocity.from(1.0.revolutions, 1.0.minutes);
  /// print(av.inRpm); // 1.0
  /// ```
  factory AngularVelocity.from(Angle angle, Time time) {
    final seconds = time.getValue(TimeUnit.second);
    return AngularVelocity(
      angle.getValue(AngleUnit.radian) / seconds,
      AngularVelocityUnit.radianPerSecond,
    );
  }

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
  /// The calculation is performed in the base units (rad/s and s) to ensure
  /// correctness, and the result is returned as an [Angle] in radians.
  ///
  /// Example:
  /// ```dart
  /// final speed = 3000.rpm;
  /// final duration = 2.0.seconds;
  /// final totalAngle = speed.totalAngleOver(duration);
  /// print(totalAngle.inRevolutions); // Output: 100.0
  /// ```
  Angle totalAngleOver(Time time) {
    final valueInRadPerSec = getValue(AngularVelocityUnit.radianPerSecond);
    final timeInSeconds = time.inSeconds;
    final resultingAngleInRadians = valueInRadPerSec * timeInSeconds;
    return Angle(resultingAngleInRadians, AngleUnit.radian);
  }
}
