import '../angular_velocity/angular_velocity.dart';
import '../angular_velocity/angular_velocity_unit.dart';
import 'frequency.dart';
import 'frequency_unit.dart';

/// Provides interoperability extensions between [Frequency] and [AngularVelocity].
///
/// These methods allow for safe and explicit conversions between the general-purpose
/// [Frequency] type and the specialized [AngularVelocity] type.
extension AngularVelocityFrequencyInterop on AngularVelocity {
  /// Converts this [AngularVelocity] to its equivalent [Frequency] representation.
  ///
  /// Since every angular velocity is fundamentally a frequency (a rate of events
  /// over time), this conversion is always safe and direct. It creates a new
  /// [Frequency] object with the same numerical value and the corresponding
  /// frequency unit.
  ///
  /// Example:
  /// ```dart
  /// final motorSpeed = 3000.rpm; // An AngularVelocity object
  /// final motorFrequency = motorSpeed.asFrequency; // A Frequency object
  ///
  /// print(motorFrequency.inHertz); // Outputs 50.0
  /// ```
  Frequency get asFrequency {
    final correspondingUnit = switch (unit) {
      AngularVelocityUnit.radianPerSecond => FrequencyUnit.radianPerSecond,
      AngularVelocityUnit.degreePerSecond => FrequencyUnit.degreePerSecond,
      AngularVelocityUnit.revolutionPerMinute => FrequencyUnit.revolutionsPerMinute,
      // Note: 'rps' in AngularVelocity is covered by `revolutionPerSecond` in Frequency.
      // Assuming AngularVelocityUnit has 'revolutionPerSecond' for a complete mapping.
      // If AngularVelocityUnit uses 'rps', this would need to be mapped.
      // Based on the current files, `revolutionPerSecond` is the correct name.
      AngularVelocityUnit.revolutionPerSecond => FrequencyUnit.hertz,
    };
    return Frequency(value, correspondingUnit);
  }
}

/// Provides interoperability extensions between [Frequency] and [AngularVelocity].
extension FrequencyAngularVelocityInterop on Frequency {
  /// Converts this [Frequency] to its equivalent [AngularVelocity] representation.
  ///
  /// This conversion is only valid if the frequency unit has a direct rotational
  /// equivalent (e.g., `rpm`, `rad/s`, `deg/s`). It will throw an
  /// [UnsupportedError] if the conversion is not applicable, such as for
  /// units like `Hz` (when not representing revolutions per second) or `bpm`.
  ///
  /// This guarded approach ensures type safety and prevents logical errors in
  /// physics and engineering calculations where a true angular velocity is required.
  ///
  /// Example:
  /// ```dart
  /// // This is valid
  /// final rotationalFreq = 60.rpm; // A Frequency object
  /// final motorSpeed = rotationalFreq.asAngularVelocity; // An AngularVelocity object
  ///
  /// // This will throw an error
  /// final heartRate = 120.bpm;
  /// // final invalidSpeed = heartRate.asAngularVelocity; // throws UnsupportedError
  /// ```
  ///
  /// @throws [UnsupportedError] if the frequency unit is not rotational.
  AngularVelocity get asAngularVelocity {
    final correspondingUnit = switch (unit) {
      FrequencyUnit.radianPerSecond => AngularVelocityUnit.radianPerSecond,
      FrequencyUnit.degreePerSecond => AngularVelocityUnit.degreePerSecond,
      FrequencyUnit.revolutionsPerMinute => AngularVelocityUnit.revolutionPerMinute,
      // Hertz (Hz) is 1/s, which corresponds to RPS (revolutions per second)
      FrequencyUnit.hertz => AngularVelocityUnit.revolutionPerSecond,
      _ => null, // Any other unit is not convertible
    };

    if (correspondingUnit != null) {
      return AngularVelocity(value, correspondingUnit);
    } else {
      throw UnsupportedError(
        'Cannot convert a Frequency with unit "${unit.symbol}" to an AngularVelocity. '
        'This operation is only valid for rotational frequency units like rpm, rad/s, deg/s, or Hz (as rps).',
      );
    }
  }
}
