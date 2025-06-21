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

  /// Returns the time value in Minutes (min).
  double get inMinutes => getValue(TimeUnit.minute);

  /// Returns the time value in Hours (h).
  double get inHours => getValue(TimeUnit.hour);

  /// Returns the time value in Days (d).
  double get inDays => getValue(TimeUnit.day);

  /// Returns the time value in Weeks (wk).
  double get inWeeks => getValue(TimeUnit.week);

  /// Returns the time value in Months (mo).
  double get inMonths => getValue(TimeUnit.month);

  /// Returns the time value in Years (yr).
  double get inYears => getValue(TimeUnit.year);

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

  /// Creates a [Time] instance representing this numerical value in Minutes (min).
  Time get minutes => Time(toDouble(), TimeUnit.minute);

  /// Creates a [Time] instance representing this numerical value in Hours (h).
  Time get hours => Time(toDouble(), TimeUnit.hour);

  /// Creates a [Time] instance representing this numerical value in Days (d).
  Time get days => Time(toDouble(), TimeUnit.day);

  /// Creates a [Time] instance representing this numerical value in Weeks (wk).
  Time get weeks => Time(toDouble(), TimeUnit.week);

  /// Creates a [Time] instance representing this numerical value in Months (mo).
  Time get months => Time(toDouble(), TimeUnit.month);

  /// Creates a [Time] instance representing this numerical value in Years (yr).
  Time get years => Time(toDouble(), TimeUnit.year);

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
