// ignore_for_file: prefer_int_literals : all constants are doubles.

import '../../core/unit.dart';
import 'time_factors.dart';

/// Represents units of time.
///
/// This enum implements the [Unit] interface to provide conversion capabilities
/// and a display [symbol] for each time unit.
/// All conversion factors are pre-calculated in the constructor relative to Second (s).
enum TimeUnit implements Unit<TimeUnit> {
  /// Second (s), the SI base unit of time.
  second(1.0, 's'),

  /// Millisecond (ms), equal to 0.001 seconds.
  millisecond(TimeFactors.secondsPerMillisecond, 'ms'),

  /// Minute (min), equal to 60 seconds.
  minute(TimeFactors.secondsPerMinute, 'min'),

  /// Hour (h), equal to 3600 seconds.
  hour(TimeFactors.secondsPerHour, 'h'),

  /// Day (d), equal to 86400 seconds.
  day(TimeFactors.secondsPerDay, 'd');

  /// Constant constructor for enum members.
  ///
  /// [_toSecondFactor] is the factor to convert from this unit to the base unit (Second).
  /// [symbol] is the display symbol for the unit.
  ///
  /// The constructor pre-calculates all direct conversion factors
  /// from this unit to every other `TimeUnit`.
  const TimeUnit(this._toSecondFactor, this.symbol)
      : _factorToSecond = _toSecondFactor / 1.0, // Second's _toSecondFactor is 1.0
        _factorToMillisecond = _toSecondFactor / TimeFactors.secondsPerMillisecond,
        _factorToMinute = _toSecondFactor / TimeFactors.secondsPerMinute,
        _factorToHour = _toSecondFactor / TimeFactors.secondsPerHour,
        _factorToDay = _toSecondFactor / TimeFactors.secondsPerDay;

  /// The factor to convert a value from this unit to the base unit (Second).
  // ignore: unused_field
  final double _toSecondFactor;

  @override
  final String symbol;

  // --- Pre-calculated direct conversion factors from this unit to all others ---
  final double _factorToSecond;
  final double _factorToMillisecond;
  final double _factorToMinute;
  final double _factorToHour;
  final double _factorToDay;

  /// Returns the direct conversion factor to convert a value from this [TimeUnit]
  /// to the [targetUnit].
  @override
  double factorTo(TimeUnit targetUnit) {
    switch (targetUnit) {
      case TimeUnit.second:
        return _factorToSecond;
      case TimeUnit.millisecond:
        return _factorToMillisecond;
      case TimeUnit.minute:
        return _factorToMinute;
      case TimeUnit.hour:
        return _factorToHour;
      case TimeUnit.day:
        return _factorToDay;
    }
  }
}
