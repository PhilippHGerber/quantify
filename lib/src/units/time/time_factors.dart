// ignore_for_file: prefer_int_literals : all constants are doubles.

/// Defines base conversion factors for various time units relative to Second (s).
///
/// These constants are based on standard definitions.
class TimeFactors {
  // The base unit for internal calculations is Second.
  // Factors represent: 1 [Unit] = X [Seconds]

  /// Seconds per Millisecond: 1 millisecond = 0.001 seconds.
  static const double secondsPerMillisecond = 0.001;

  /// Seconds per Minute: 1 minute = 60.0 seconds.
  static const double secondsPerMinute = 60.0;

  /// Seconds per Hour: 1 hour = 3600.0 seconds (60 minutes * 60 seconds).
  static const double secondsPerHour = 3600.0;

  /// Seconds per Day: 1 day = 86400.0 seconds (24 hours * 3600 seconds/hour).
  static const double secondsPerDay = 86400.0;

  // Optional: Could add week, month (average), year (average/Julian) if complex time is desired later.
  // For now, keeping it to common, precise units.
}
