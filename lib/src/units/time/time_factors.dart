// ignore_for_file: prefer_int_literals : all constants are doubles.

/// Defines base conversion factors for various time units relative to Second (s).
///
/// These constants are based on standard definitions.
class TimeFactors {
  // The base unit for internal calculations is Second.
  // Factors represent: 1 [Unit] = X [Seconds]

  /// Seconds per Microsecond: 1 microsecond = 1e-6 seconds.
  static const double secondsPerMicrosecond = 1e-6;

  /// Seconds per Nanosecond: 1 nanosecond = 1e-9 seconds.
  static const double secondsPerNanosecond = 1e-9;

  /// Seconds per Picosecond: 1 picosecond = 1e-12 seconds.
  static const double secondsPerPicosecond = 1e-12;

  /// Seconds per Millisecond: 1 millisecond = 0.001 seconds.
  static const double secondsPerMillisecond = 0.001;

  /// Seconds per Minute: 1 minute = 60.0 seconds.
  static const double secondsPerMinute = 60.0;

  /// Seconds per Hour: 1 hour = 3600.0 seconds (60 minutes * 60 seconds).
  static const double secondsPerHour = 3600.0;

  /// Seconds per Day: 1 day = 86400.0 seconds (24 hours * 3600 seconds/hour).
  static const double secondsPerDay = 86400.0;

  /// Seconds per Week: 1 week = 604800.0 seconds (7 days * 86400 seconds/day).
  static const double secondsPerWeek = 604800.0;

  /// Seconds per Month: 1 month ≈ 2629800.0 seconds.
  /// Based on average month length: 365.25 days / 12 months = 30.4375 days/month.
  static const double secondsPerMonth = 2629800.0;

  /// Seconds per Year: 1 year = 31557600.0 seconds.
  /// Based on Julian year: 365.25 days * 24 hours/day * 3600 seconds/hour.
  static const double secondsPerYear = 31557600.0;

  // Optional: Could add specific calendar years if needed
  // /// Seconds per Common Year: 1 common year = 31536000.0 seconds (365 days).
  // static const double secondsPerCommonYear = 31536000.0;

  // /// Seconds per Leap Year: 1 leap year = 31622400.0 seconds (366 days).
  // static const double secondsPerLeapYear = 31622400.0;
}
