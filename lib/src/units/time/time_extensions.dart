import 'time.dart';
import 'time_unit.dart';

/// Provides convenient access to [Time] values in specific units.
extension TimeValueGetters on Time {
  /// Returns the time value in Seconds (s).
  double get inSeconds => getValue(TimeUnit.second);

  /// Returns the time value in Milliseconds (ms).
  double get inMilliseconds => getValue(TimeUnit.millisecond);

  /// Returns the time value in Minutes (min).
  double get inMinutes => getValue(TimeUnit.minute);

  /// Returns the time value in Hours (h).
  double get inHours => getValue(TimeUnit.hour);

  /// Returns the time value in Days (d).
  double get inDays => getValue(TimeUnit.day);

  // Aliases for consistency with potential full names (optional)
  // double get inS => getValue(TimeUnit.second);
  // double get inMs => getValue(TimeUnit.millisecond);
  // double get inMin => getValue(TimeUnit.minute);
  // double get inH => getValue(TimeUnit.hour);
  // double get inD => getValue(TimeUnit.day);
}

/// Provides convenient factory methods for creating [Time] instances from [num].
extension TimeCreation on num {
  /// Creates a [Time] instance representing this numerical value in Seconds (s).
  Time get seconds => Time(toDouble(), TimeUnit.second);

  /// Creates a [Time] instance representing this numerical value in Milliseconds (ms).
  Time get milliseconds => Time(toDouble(), TimeUnit.millisecond);

  /// Creates a [Time] instance representing this numerical value in Minutes (min).
  Time get minutes => Time(toDouble(), TimeUnit.minute);

  /// Creates a [Time] instance representing this numerical value in Hours (h).
  Time get hours => Time(toDouble(), TimeUnit.hour);

  /// Creates a [Time] instance representing this numerical value in Days (d).
  Time get days => Time(toDouble(), TimeUnit.day);

  // Aliases for shorter creation syntax (optional, but common in other libs)
  // Time get s => Time(toDouble(), TimeUnit.second);
  // Time get ms => Time(toDouble(), TimeUnit.millisecond);
  // Time get min => Time(toDouble(), TimeUnit.minute); // 'm' is meter, so 'min' is better
  // Time get h => Time(toDouble(), TimeUnit.hour);
  // Time get d => Time(toDouble(), TimeUnit.day);
}
