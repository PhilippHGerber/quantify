import 'time.dart';
import 'time_unit.dart';

/// Provides convenient access to [Time] values in specific units.
extension TimeValueGetters on Time {
  /// Returns the time value in Seconds (s).
  double get inSeconds => getValue(TimeUnit.second);

  /// Returns the time value in Microseconds (μs).
  double get inMicroseconds => getValue(TimeUnit.microsecond);

  /// Returns the time value in Nanoseconds (ns).
  double get inNanoseconds => getValue(TimeUnit.nanosecond);

  /// Returns the time value in Picoseconds (ps).
  double get inPicoseconds => getValue(TimeUnit.picosecond);

  /// Returns the time value in Milliseconds (ms).
  double get inMilliseconds => getValue(TimeUnit.millisecond);

  /// Returns the time value in Centiseconds (cs).
  double get inCentiseconds => getValue(TimeUnit.centisecond);

  /// Returns the time value in Deciseconds (ds).
  double get inDeciseconds => getValue(TimeUnit.decisecond);

  /// Returns the time value in Decaseconds (das).
  double get inDecaseconds => getValue(TimeUnit.decasecond);

  /// Returns the time value in Hectoseconds (hs).
  double get inHectoseconds => getValue(TimeUnit.hectosecond);

  /// Returns the time value in Kiloseconds (ks).
  double get inKiloseconds => getValue(TimeUnit.kilosecond);

  /// Returns the time value in Megaseconds (Ms).
  double get inMegaseconds => getValue(TimeUnit.megasecond);

  /// Returns the time value in Gigaseconds (Gs).
  double get inGigaseconds => getValue(TimeUnit.gigasecond);

  /// Returns the time value in Minutes (min).
  double get inMinutes => getValue(TimeUnit.minute);

  /// Returns the time value in Hours (h).
  double get inHours => getValue(TimeUnit.hour);

  /// Returns the time value in Days (d).
  double get inDays => getValue(TimeUnit.day);

  /// Returns the time value in Weeks (wk).
  double get inWeeks => getValue(TimeUnit.week);

  /// Returns the time value in Fortnights (fn).
  double get inFortnights => getValue(TimeUnit.fortnight);

  /// Returns the time value in Months (mo).
  double get inMonths => getValue(TimeUnit.month);

  /// Returns the time value in Years (yr).
  double get inYears => getValue(TimeUnit.year);

  /// Returns the time value in Decades (dec).
  double get inDecades => getValue(TimeUnit.decade);

  /// Returns the time value in Centuries (c).
  double get inCenturies => getValue(TimeUnit.century);

  /// Returns a Time representing this time in Seconds (s).
  Time get asSeconds => convertTo(TimeUnit.second);

  /// Returns a Time representing this time in Microseconds (μs).
  Time get asMicroseconds => convertTo(TimeUnit.microsecond);

  /// Returns a Time representing this time in Nanoseconds (ns).
  Time get asNanoseconds => convertTo(TimeUnit.nanosecond);

  /// Returns a Time representing this time in Picoseconds (ps).
  Time get asPicoseconds => convertTo(TimeUnit.picosecond);

  /// Returns a Time representing this time in Milliseconds (ms).
  Time get asMilliseconds => convertTo(TimeUnit.millisecond);

  /// Returns a Time representing this time in Centiseconds (cs).
  Time get asCentiseconds => convertTo(TimeUnit.centisecond);

  /// Returns a Time representing this time in Deciseconds (ds).
  Time get asDeciseconds => convertTo(TimeUnit.decisecond);

  /// Returns a Time representing this time in Decaseconds (das).
  Time get asDecaseconds => convertTo(TimeUnit.decasecond);

  /// Returns a Time representing this time in Hectoseconds (hs).
  Time get asHectoseconds => convertTo(TimeUnit.hectosecond);

  /// Returns a Time representing this time in Kiloseconds (ks).
  Time get asKiloseconds => convertTo(TimeUnit.kilosecond);

  /// Returns a Time representing this time in Megaseconds (Ms).
  Time get asMegaseconds => convertTo(TimeUnit.megasecond);

  /// Returns a Time representing this time in Gigaseconds (Gs).
  Time get asGigaseconds => convertTo(TimeUnit.gigasecond);

  /// Returns a Time representing this time in Fortnights (fn).
  Time get asFortnights => convertTo(TimeUnit.fortnight);

  /// Returns a Time representing this time in Decades (dec).
  Time get asDecades => convertTo(TimeUnit.decade);

  /// Returns a Time representing this time in Centuries (c).
  Time get asCenturies => convertTo(TimeUnit.century);

  /// Returns a Time representing this time in Minutes (min).
  Time get asMinutes => convertTo(TimeUnit.minute);

  /// Returns a Time representing this time in Hours (h).
  Time get asHours => convertTo(TimeUnit.hour);

  /// Returns a Time representing this time in Days (d).
  Time get asDays => convertTo(TimeUnit.day);

  /// Returns a Time representing this time in Weeks (wk).
  Time get asWeeks => convertTo(TimeUnit.week);

  /// Returns a Time representing this time in Months (mo).
  Time get asMonths => convertTo(TimeUnit.month);

  /// Returns a Time representing this time in Years (yr).
  Time get asYears => convertTo(TimeUnit.year);
}

/// Provides convenient factory methods for creating [Time] instances from [num].
extension TimeCreation on num {
  /// Creates a [Time] instance representing this numerical value in Seconds (s).
  Time get seconds => Time(toDouble(), TimeUnit.second);

  /// Creates a [Time] instance representing this numerical value in Microseconds (μs).
  Time get microseconds => Time(toDouble(), TimeUnit.microsecond);

  /// Creates a [Time] instance representing this numerical value in Nanoseconds (ns).
  Time get nanoseconds => Time(toDouble(), TimeUnit.nanosecond);

  /// Creates a [Time] instance representing this numerical value in Picoseconds (ps).
  Time get picoseconds => Time(toDouble(), TimeUnit.picosecond);

  /// Creates a [Time] instance representing this numerical value in Milliseconds (ms).
  Time get milliseconds => Time(toDouble(), TimeUnit.millisecond);

  /// Creates a [Time] instance from this numerical value in Centiseconds (cs).
  Time get cs => Time(toDouble(), TimeUnit.centisecond);

  /// Creates a [Time] instance from this numerical value in Deciseconds (ds).
  Time get ds => Time(toDouble(), TimeUnit.decisecond);

  /// Creates a [Time] instance from this numerical value in Decaseconds (das).
  Time get das => Time(toDouble(), TimeUnit.decasecond);

  /// Creates a [Time] instance from this numerical value in Hectoseconds (hs).
  Time get hs => Time(toDouble(), TimeUnit.hectosecond);

  /// Creates a [Time] instance from this numerical value in Kiloseconds (ks).
  Time get kiloS => Time(toDouble(), TimeUnit.kilosecond);

  /// Creates a [Time] instance from this numerical value in Megaseconds (Ms).
  Time get megaS => Time(toDouble(), TimeUnit.megasecond);

  /// Creates a [Time] instance from this numerical value in Gigaseconds (Gs).
  Time get gigaS => Time(toDouble(), TimeUnit.gigasecond);

  /// Creates a [Time] instance representing this numerical value in Minutes (min).
  Time get minutes => Time(toDouble(), TimeUnit.minute);

  /// Creates a [Time] instance representing this numerical value in Hours (h).
  Time get hours => Time(toDouble(), TimeUnit.hour);

  /// Creates a [Time] instance representing this numerical value in Days (d).
  Time get days => Time(toDouble(), TimeUnit.day);

  /// Creates a [Time] instance representing this numerical value in Weeks (wk).
  Time get weeks => Time(toDouble(), TimeUnit.week);

  /// Creates a [Time] instance from this numerical value in Fortnights (fn).
  Time get fortnights => Time(toDouble(), TimeUnit.fortnight);

  /// Creates a [Time] instance representing this numerical value in Months (mo).
  Time get months => Time(toDouble(), TimeUnit.month);

  /// Creates a [Time] instance representing this numerical value in Years (yr).
  Time get years => Time(toDouble(), TimeUnit.year);

  /// Creates a [Time] instance from this numerical value in Decades (dec).
  Time get decades => Time(toDouble(), TimeUnit.decade);

  /// Creates a [Time] instance from this numerical value in Centuries (c).
  /// Note: `.c` is avoided due to conflict with 'centi' prefix and Celsius.
  Time get centuries => Time(toDouble(), TimeUnit.century);

  // Short aliases for common units
  /// Creates a [Time] instance representing this numerical value in Seconds (s).
  /// Alias for `seconds`.
  Time get s => Time(toDouble(), TimeUnit.second);

  /// Creates a [Time] instance representing this numerical value in Microseconds (μs).
  /// Alias for `microseconds`.
  Time get us => Time(toDouble(), TimeUnit.microsecond);

  /// Creates a [Time] instance representing this numerical value in Nanoseconds (ns).
  /// Alias for `nanoseconds`.
  Time get ns => Time(toDouble(), TimeUnit.nanosecond);

  /// Creates a [Time] instance representing this numerical value in Picoseconds (ps).
  /// Alias for `picoseconds`.
  Time get ps => Time(toDouble(), TimeUnit.picosecond);

  /// Creates a [Time] instance representing this numerical value in Milliseconds (ms).
  /// Alias for `milliseconds`.
  Time get ms => Time(toDouble(), TimeUnit.millisecond);

  /// Creates a [Time] instance representing this numerical value in Minutes (min).
  /// Alias for `minutes`. Note: 'm' is used for meters, so 'min' is better for time.
  Time get min => Time(toDouble(), TimeUnit.minute);

  /// Creates a [Time] instance representing this numerical value in Hours (h).
  /// Alias for `hours`.
  Time get h => Time(toDouble(), TimeUnit.hour);

  /// Creates a [Time] instance representing this numerical value in Days (d).
  /// Alias for `days`.
  Time get d => Time(toDouble(), TimeUnit.day);

  /// Creates a [Time] instance representing this numerical value in Weeks (wk).
  /// Alias for `weeks`.
  Time get wk => Time(toDouble(), TimeUnit.week);

  /// Creates a [Time] instance representing this numerical value in Months (mo).
  /// Alias for `months`.
  Time get mo => Time(toDouble(), TimeUnit.month);

  /// Creates a [Time] instance representing this numerical value in Years (yr).
  /// Alias for `years`.
  Time get yr => Time(toDouble(), TimeUnit.year);
}
