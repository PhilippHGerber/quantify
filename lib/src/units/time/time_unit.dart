// ignore_for_file: prefer_int_literals : all constants are doubles.

import 'package:meta/meta.dart';

import '../../core/unit.dart';
import 'time_factors.dart';

/// Represents units of time.
///
/// This enum implements the [LinearUnit] interface to provide conversion capabilities
/// and a display [symbol] for each time unit.
/// All conversion factors are pre-calculated in the constructor relative to Second (s).
enum TimeUnit implements LinearUnit<TimeUnit> {
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

  /// Centisecond (cs), equal to 0.01 seconds.
  centisecond(TimeFactors.secondsPerCentisecond, 'cs'),

  /// Decisecond (ds), equal to 0.1 seconds.
  decisecond(TimeFactors.secondsPerDecisecond, 'ds'),

  /// Decasecond (das), equal to 10 seconds.
  decasecond(TimeFactors.secondsPerDecasecond, 'das'),

  /// Hectosecond (hs), equal to 100 seconds.
  hectosecond(TimeFactors.secondsPerHectosecond, 'hs'),

  /// Kilosecond (ks), equal to 1000 seconds.
  kilosecond(TimeFactors.secondsPerKilosecond, 'ks'),

  /// Megasecond (Ms), equal to 1e6 seconds.
  megasecond(TimeFactors.secondsPerMegasecond, 'Ms'),

  /// Gigasecond (Gs), equal to 1e9 seconds.
  gigasecond(TimeFactors.secondsPerGigasecond, 'Gs'),

  /// Minute (min), equal to 60 seconds.
  minute(TimeFactors.secondsPerMinute, 'min'),

  /// Hour (h), equal to 3600 seconds.
  hour(TimeFactors.secondsPerHour, 'h'),

  /// Day (d), equal to 86400 seconds.
  day(TimeFactors.secondsPerDay, 'd'),

  /// Week (wk), equal to 604800 seconds (7 days).
  week(TimeFactors.secondsPerWeek, 'wk'),

  /// Fortnight (fn), equal to 2 weeks or 14 days.
  fortnight(TimeFactors.secondsPerFortnight, 'fn'),

  /// Month (mo), equal to approximately 2629746 seconds.
  /// Based on average month length (365.25 days / 12).
  month(TimeFactors.secondsPerMonth, 'mo'),

  /// Year (yr), equal to 31557600 seconds.
  /// Based on Julian year (365.25 days).
  year(TimeFactors.secondsPerYear, 'yr'),

  /// Decade (dec), equal to 10 Julian years.
  decade(TimeFactors.secondsPerDecade, 'dec'),

  /// Century (c), equal to 100 Julian years.
  century(TimeFactors.secondsPerCentury, 'c');

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
        _factorToCentisecond = _toSecondFactor / TimeFactors.secondsPerCentisecond,
        _factorToDecisecond = _toSecondFactor / TimeFactors.secondsPerDecisecond,
        _factorToDecasecond = _toSecondFactor / TimeFactors.secondsPerDecasecond,
        _factorToHectosecond = _toSecondFactor / TimeFactors.secondsPerHectosecond,
        _factorToKilosecond = _toSecondFactor / TimeFactors.secondsPerKilosecond,
        _factorToMegasecond = _toSecondFactor / TimeFactors.secondsPerMegasecond,
        _factorToGigasecond = _toSecondFactor / TimeFactors.secondsPerGigasecond,
        _factorToMinute = _toSecondFactor / TimeFactors.secondsPerMinute,
        _factorToHour = _toSecondFactor / TimeFactors.secondsPerHour,
        _factorToDay = _toSecondFactor / TimeFactors.secondsPerDay,
        _factorToWeek = _toSecondFactor / TimeFactors.secondsPerWeek,
        _factorToFortnight = _toSecondFactor / TimeFactors.secondsPerFortnight,
        _factorToMonth = _toSecondFactor / TimeFactors.secondsPerMonth,
        _factorToYear = _toSecondFactor / TimeFactors.secondsPerYear,
        _factorToDecade = _toSecondFactor / TimeFactors.secondsPerDecade,
        _factorToCentury = _toSecondFactor / TimeFactors.secondsPerCentury;

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
  final double _factorToCentisecond;
  final double _factorToDecisecond;
  final double _factorToDecasecond;
  final double _factorToHectosecond;
  final double _factorToKilosecond;
  final double _factorToMegasecond;
  final double _factorToGigasecond;
  final double _factorToMinute;
  final double _factorToHour;
  final double _factorToDay;
  final double _factorToWeek;
  final double _factorToFortnight;
  final double _factorToMonth;
  final double _factorToYear;
  final double _factorToDecade;
  final double _factorToCentury;

  /// SI and unit symbols matched **strictly case-sensitive**.
  ///
  /// Keys must be the exact symbol string (e.g. `'Ms'` for megasecond, `'ms'`
  /// for millisecond). No case folding is applied during lookup.
  ///
  /// Used by `Time.parser`.
  @internal
  static const Map<String, TimeUnit> symbolAliases = {
    // second
    's': TimeUnit.second,
    // microsecond
    'μs': TimeUnit.microsecond,
    'us': TimeUnit.microsecond, // ASCII fallback for μs
    // nanosecond
    'ns': TimeUnit.nanosecond,
    // picosecond
    'ps': TimeUnit.picosecond,
    // millisecond — lowercase m distinguishes milli from mega
    'ms': TimeUnit.millisecond,
    // centisecond
    'cs': TimeUnit.centisecond,
    // decisecond
    'ds': TimeUnit.decisecond,
    // decasecond
    'das': TimeUnit.decasecond,
    // hectosecond
    'hs': TimeUnit.hectosecond,
    // kilosecond
    'ks': TimeUnit.kilosecond,
    // megasecond — capital M distinguishes mega from milli
    'Ms': TimeUnit.megasecond,
    // gigasecond
    'Gs': TimeUnit.gigasecond,
    // minute
    'min': TimeUnit.minute,
    // hour
    'h': TimeUnit.hour,
    'hr': TimeUnit.hour,
    // day
    'd': TimeUnit.day,
    // week
    'wk': TimeUnit.week,
    // fortnight
    'fn': TimeUnit.fortnight,
    // month
    'mo': TimeUnit.month,
    // year
    'yr': TimeUnit.year,
    'y': TimeUnit.year,
    // decade
    'dec': TimeUnit.decade,
    // century
    'c': TimeUnit.century,
  };

  /// Full word-form names and non-colliding abbreviations matched
  /// **case-insensitively** (after `.toLowerCase()` and whitespace normalization).
  ///
  /// Used by `Time.parser`.
  @internal
  static const Map<String, TimeUnit> nameAliases = {
    // second
    'second': TimeUnit.second,
    'seconds': TimeUnit.second,
    'sec': TimeUnit.second,
    'secs': TimeUnit.second,
    // microsecond
    'microsecond': TimeUnit.microsecond,
    'microseconds': TimeUnit.microsecond,
    // nanosecond
    'nanosecond': TimeUnit.nanosecond,
    'nanoseconds': TimeUnit.nanosecond,
    // picosecond
    'picosecond': TimeUnit.picosecond,
    'picoseconds': TimeUnit.picosecond,
    // millisecond
    'millisecond': TimeUnit.millisecond,
    'milliseconds': TimeUnit.millisecond,
    // centisecond
    'centisecond': TimeUnit.centisecond,
    'centiseconds': TimeUnit.centisecond,
    // decisecond
    'decisecond': TimeUnit.decisecond,
    'deciseconds': TimeUnit.decisecond,
    // decasecond
    'decasecond': TimeUnit.decasecond,
    'decaseconds': TimeUnit.decasecond,
    // hectosecond
    'hectosecond': TimeUnit.hectosecond,
    'hectoseconds': TimeUnit.hectosecond,
    // kilosecond
    'kilosecond': TimeUnit.kilosecond,
    'kiloseconds': TimeUnit.kilosecond,
    // megasecond
    'megasecond': TimeUnit.megasecond,
    'megaseconds': TimeUnit.megasecond,
    // gigasecond
    'gigasecond': TimeUnit.gigasecond,
    'gigaseconds': TimeUnit.gigasecond,
    // minute
    'minute': TimeUnit.minute,
    'minutes': TimeUnit.minute,
    'min': TimeUnit.minute,
    // hour
    'hour': TimeUnit.hour,
    'hours': TimeUnit.hour,
    'hr': TimeUnit.hour,
    // day
    'day': TimeUnit.day,
    'days': TimeUnit.day,
    // week
    'week': TimeUnit.week,
    'weeks': TimeUnit.week,
    'wk': TimeUnit.week,
    // fortnight
    'fortnight': TimeUnit.fortnight,
    'fortnights': TimeUnit.fortnight,
    // month
    'month': TimeUnit.month,
    'months': TimeUnit.month,
    'mo': TimeUnit.month,
    // year
    'year': TimeUnit.year,
    'years': TimeUnit.year,
    // decade
    'decade': TimeUnit.decade,
    'decades': TimeUnit.decade,
    // century
    'century': TimeUnit.century,
    'centuries': TimeUnit.century,
  };

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
      case TimeUnit.centisecond:
        return _factorToCentisecond;
      case TimeUnit.decisecond:
        return _factorToDecisecond;
      case TimeUnit.decasecond:
        return _factorToDecasecond;
      case TimeUnit.hectosecond:
        return _factorToHectosecond;
      case TimeUnit.kilosecond:
        return _factorToKilosecond;
      case TimeUnit.megasecond:
        return _factorToMegasecond;
      case TimeUnit.gigasecond:
        return _factorToGigasecond;
      case TimeUnit.minute:
        return _factorToMinute;
      case TimeUnit.hour:
        return _factorToHour;
      case TimeUnit.day:
        return _factorToDay;
      case TimeUnit.week:
        return _factorToWeek;
      case TimeUnit.fortnight:
        return _factorToFortnight;
      case TimeUnit.month:
        return _factorToMonth;
      case TimeUnit.year:
        return _factorToYear;
      case TimeUnit.decade:
        return _factorToDecade;
      case TimeUnit.century:
        return _factorToCentury;
    }
  }
}
