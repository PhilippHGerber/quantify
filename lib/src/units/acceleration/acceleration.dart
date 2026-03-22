import 'package:meta/meta.dart';

import '../../core/linear_quantity.dart';
import '../../core/quantity_format.dart';
import '../../core/quantity_parser.dart';
import '../speed/speed.dart';
import '../speed/speed_extensions.dart';
import '../speed/speed_unit.dart';
import '../time/time.dart';
import '../time/time_extensions.dart';
import 'acceleration_unit.dart';

/// Represents a quantity of acceleration.
///
/// Acceleration is a derived quantity representing the rate of change of
/// velocity over time. The SI derived unit is Meter per Second Squared (m/s²).
@immutable
class Acceleration extends LinearQuantity<AccelerationUnit, Acceleration> {
  /// Creates a new `Acceleration` with a given [value] and [unit].
  const Acceleration(super._value, super._unit);

  /// Creates an `Acceleration` instance from a change in `Speed` over a `Time` duration.
  ///
  /// This factory performs the dimensional calculation `Acceleration = ΔSpeed / Time`.
  /// It converts the inputs to their base SI units for correctness.
  /// Throws an [ArgumentError] if the `time` is zero.
  ///
  /// Example:
  /// ```dart
  /// final speedChange = 27.8.mps; // approx 100 km/h
  /// final duration = 5.s;
  /// final carAcceleration = Acceleration.from(speedChange, duration);
  /// print(carAcceleration.inMetersPerSecondSquared); // Output: 5.56
  /// ```
  factory Acceleration.from(Speed speed, Time time) {
    final mps = speed.inMps;
    final seconds = time.inSeconds;
    if (seconds == 0) {
      throw ArgumentError('Time cannot be zero when calculating acceleration.');
    }
    return Acceleration(mps / seconds, AccelerationUnit.meterPerSecondSquared);
  }

  @override
  @protected
  Acceleration create(double value, AccelerationUnit unit) => Acceleration(value, unit);

  /// The parser instance used to convert strings into [Acceleration] objects.
  ///
  /// The parser supports both strict symbol aliases and case-insensitive name
  /// aliases configured in [AccelerationUnit].
  static final QuantityParser<AccelerationUnit, Acceleration> parser =
      QuantityParser<AccelerationUnit, Acceleration>(
    symbolAliases: AccelerationUnit.symbolAliases,
    nameAliases: AccelerationUnit.nameAliases,
    factory: Acceleration.new,
  );

  /// Parses a string representation of an acceleration into an [Acceleration]
  /// object.
  ///
  /// The [formats] list controls how the numeric portion is interpreted.
  /// Formats are tried in order; the first successful parse is returned.
  static Acceleration parse(
    String input, {
    List<QuantityFormat> formats = const [QuantityFormat.invariant],
  }) {
    return parser.parse(input, formats: formats);
  }

  /// Parses a string representation of an acceleration into an [Acceleration]
  /// object, returning `null` when parsing fails.
  ///
  /// See [parse] for formatting and matching behavior.
  static Acceleration? tryParse(
    String input, {
    List<QuantityFormat> formats = const [QuantityFormat.invariant],
  }) {
    return parser.tryParse(input, formats: formats);
  }

  // --- Dimensional Analysis ---

  /// Calculates the change in [Speed] over a given [Time] duration.
  ///
  /// This method performs the dimensional calculation `ΔSpeed = Acceleration × Time`.
  /// The calculation is performed in the base units (m/s² and s) to ensure
  /// correctness, and the result is returned as a `Speed` in m/s.
  ///
  /// Example:
  /// ```dart
  /// final gravity = 1.gravity; // 9.80665 m/s²
  /// final fallTime = 3.s;
  /// final finalSpeed = gravity.speedGainedOver(fallTime);
  /// print(finalSpeed.inMps); // Output: ~29.42
  /// ```
  Speed speedGainedOver(Time duration) {
    final valueInMpss = getValue(AccelerationUnit.meterPerSecondSquared);
    final timeInSeconds = duration.inSeconds;
    final resultingSpeedInMps = valueInMpss * timeInSeconds;
    return Speed(resultingSpeedInMps, SpeedUnit.meterPerSecond);
  }
}
