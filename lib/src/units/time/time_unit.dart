// ignore_for_file: prefer_int_literals : all constants are doubles.

import 'package:meta/meta.dart';

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

  /// Microsecond (μs), equal to 1e-6 seconds.
  microsecond(TimeFactors.secondsPerMicrosecond, 'μs'),

  /// Nanosecond (ns), equal to 1e-9 seconds.
  nanosecond(TimeFactors.secondsPerNanosecond, 'ns'),

  /// Picosecond (ps), equal to 1e-12 seconds.
  picosecond(TimeFactors.secondsPerPicosecond, 'ps'),

  /// Millisecond (ms), equal to 0.001 seconds.
  millisecond(TimeFactors.secondsPerMillisecond, 'ms'),

  /// Minute (min), equal to 60 seconds.
  minute(TimeFactors.secondsPerMinute, 'min'),

  /// Hour (h), equal to 3600 seconds.
  hour(TimeFactors.secondsPerHour, 'h'),

  /// Day (d), equal to 86400 seconds.
  day(TimeFactors.secondsPerDay, 'd'),

  /// Week (wk), equal to 604800 seconds (7 days).
  week(TimeFactors.secondsPerWeek, 'wk'),

  /// Month (mo), equal to approximately 2629746 seconds.
  /// Based on average month length (365.25 days / 12).
  month(TimeFactors.secondsPerMonth, 'mo'),

  /// Year (yr), equal to 31557600 seconds.
  /// Based on Julian year (365.25 days).
  year(TimeFactors.secondsPerYear, 'yr');

  /// Constant constructor for enum members.
  ///
  /// [_toSecondFactor] is the factor to convert from this unit to the base unit (Second).
  /// [symbol] is the display symbol for the unit.
  ///
  /// The constructor pre-calculates all direct conversion factors
  /// from this unit to every other `TimeUnit`.
  const TimeUnit(this._toSecondFactor, this.symbol)
      : _factorToSecond = _toSecondFactor / 1.0, // Second's _toSecondFactor is 1.0
        _factorToMicrosecond = _toSecondFactor / TimeFactors.secondsPerMicrosecond,
        _factorToNanosecond = _toSecondFactor / TimeFactors.secondsPerNanosecond,
        _factorToPicosecond = _toSecondFactor / TimeFactors.secondsPerPicosecond,
        _factorToMillisecond = _toSecondFactor / TimeFactors.secondsPerMillisecond,
        _factorToMinute = _toSecondFactor / TimeFactors.secondsPerMinute,
        _factorToHour = _toSecondFactor / TimeFactors.secondsPerHour,
        _factorToDay = _toSecondFactor / TimeFactors.secondsPerDay,
        _factorToWeek = _toSecondFactor / TimeFactors.secondsPerWeek,
        _factorToMonth = _toSecondFactor / TimeFactors.secondsPerMonth,
        _factorToYear = _toSecondFactor / TimeFactors.secondsPerYear;

  /// The factor to convert a value from this unit to the base unit (Second).
  /// After constructor initialization, its value is primarily baked into
  /// the specific _factorToXxx fields for direct inter-unit conversions.
  /// It's generally not accessed directly by methods outside this enum's constructor
  /// but is crucial for deriving the pre-calculated factors.
  // ignore: unused_field
  final double _toSecondFactor;

  @override
  final String symbol;

  // --- Pre-calculated direct conversion factors from this unit to all others ---
  final double _factorToSecond;
  final double _factorToMicrosecond;
  final double _factorToNanosecond;
  final double _factorToPicosecond;
  final double _factorToMillisecond;
  final double _factorToMinute;
  final double _factorToHour;
  final double _factorToDay;
  final double _factorToWeek;
  final double _factorToMonth;
  final double _factorToYear;

  /// Returns the direct conversion factor to convert a value from this [TimeUnit]
  /// to the [targetUnit].
  @override
  @internal
  double factorTo(TimeUnit targetUnit) {
    switch (targetUnit) {
      case TimeUnit.second:
        return _factorToSecond;
      case TimeUnit.microsecond:
        return _factorToMicrosecond;
      case TimeUnit.nanosecond:
        return _factorToNanosecond;
      case TimeUnit.picosecond:
        return _factorToPicosecond;
      case TimeUnit.millisecond:
        return _factorToMillisecond;
      case TimeUnit.minute:
        return _factorToMinute;
      case TimeUnit.hour:
        return _factorToHour;
      case TimeUnit.day:
        return _factorToDay;
      case TimeUnit.week:
        return _factorToWeek;
      case TimeUnit.month:
        return _factorToMonth;
      case TimeUnit.year:
        return _factorToYear;
    }
  }
}
