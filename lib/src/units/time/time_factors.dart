// ignore_for_file: prefer_int_literals : all constants are doubles.

/// Defines base conversion factors for various time units relative to Second (s).
///
/// These constants are based on standard definitions.
class TimeFactors {
  // The base unit for internal calculations is Second.
  // Factors represent: 1 [Unit] = X [Seconds]

  /// Seconds per Gigasecond: 1 Gs = 1e9 seconds.
  static const double secondsPerGigasecond = 1e9;

  /// Seconds per Megasecond: 1 Ms = 1e6 seconds.
  static const double secondsPerMegasecond = 1e6;

  /// Seconds per Kilosecond: 1 ks = 1000.0 seconds.
  static const double secondsPerKilosecond = 1000.0;

  /// Seconds per Hectosecond: 1 hs = 100.0 seconds.
  static const double secondsPerHectosecond = 100.0;

  /// Seconds per Decasecond: 1 das = 10.0 seconds.
  static const double secondsPerDecasecond = 10.0;

  /// Seconds per Microsecond: 1 microsecond = 1e-6 seconds.
  static const double secondsPerMicrosecond = 1e-6;

  /// Seconds per Nanosecond: 1 nanosecond = 1e-9 seconds.
  static const double secondsPerNanosecond = 1e-9;

  /// Seconds per Picosecond: 1 picosecond = 1e-12 seconds.
  static const double secondsPerPicosecond = 1e-12;

  /// Seconds per Millisecond: 1 millisecond = 0.001 seconds.
  static const double secondsPerMillisecond = 0.001;

  /// Seconds per Centisecond: 1 cs = 0.01 seconds.
  static const double secondsPerCentisecond = 0.01;

  /// Seconds per Decisecond: 1 ds = 0.1 seconds.
  static const double secondsPerDecisecond = 0.1;

  /// Seconds per Minute: 1 minute = 60.0 seconds.
  static const double secondsPerMinute = 60.0;

  /// Seconds per Hour: 1 hour = 3600.0 seconds (60 minutes * 60 seconds).
  static const double secondsPerHour = 3600.0;

  /// Seconds per Day: 1 day = 86400.0 seconds (24 hours * 3600 seconds/hour).
  static const double secondsPerDay = 86400.0;

  /// Seconds per Week: 1 week = 604800.0 seconds (7 days * 86400 seconds/day).
  static const double secondsPerWeek = 604800.0;

  /// Seconds per Fortnight: 1 fortnight = 1209600.0 seconds (14 days).
  static const double secondsPerFortnight = secondsPerDay * 14.0;

  /// Seconds per Month: 1 month ≈ 2629800.0 seconds.
  /// Based on average month length: 365.25 days / 12 months = 30.4375 days/month.
  static const double secondsPerMonth = 2629800.0;

  /// Seconds per Year: 1 year = 31557600.0 seconds.
  /// Based on Julian year: 365.25 days * 24 hours/day * 3600 seconds/hour.
  static const double secondsPerYear = 31557600.0;

  /// Seconds per Decade: 1 decade = 315576000.0 seconds (10 Julian years).
  static const double secondsPerDecade = secondsPerYear * 10.0;

  /// Seconds per Century: 1 century = 3155760000.0 seconds (100 Julian years).
  static const double secondsPerCentury = secondsPerYear * 100.0;
}
