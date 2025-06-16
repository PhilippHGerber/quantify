import 'current.dart';
import 'current_unit.dart';

/// Provides convenient access to [Current] values in specific units
/// using getter properties.
extension CurrentValueGetters on Current {
  /// Returns the electric current value in Amperes (A).
  double get inAmperes => getValue(CurrentUnit.ampere);

  /// Returns the electric current value in Milliamperes (mA).
  double get inMilliamperes => getValue(CurrentUnit.milliampere);

  /// Returns the electric current value in Microamperes (µA).
  double get inMicroamperes => getValue(CurrentUnit.microampere);

  /// Returns the electric current value in Nanoamperes (nA).
  double get inNanoamperes => getValue(CurrentUnit.nanoampere);

  /// Returns the electric current value in Kiloamperes (kA).
  double get inKiloamperes => getValue(CurrentUnit.kiloampere);

  // --- "As" Getters for new Current objects ---

  /// Returns a new [Current] object representing this current in Amperes (A).
  Current get asAmperes => convertTo(CurrentUnit.ampere);

  /// Returns a new [Current] object representing this current in Milliamperes (mA).
  Current get asMilliamperes => convertTo(CurrentUnit.milliampere);

  /// Returns a new [Current] object representing this current in Microamperes (µA).
  Current get asMicroamperes => convertTo(CurrentUnit.microampere);

  /// Returns a new [Current] object representing this current in Nanoamperes (nA).
  Current get asNanoamperes => convertTo(CurrentUnit.nanoampere);

  /// Returns a new [Current] object representing this current in Kiloamperes (kA).
  Current get asKiloamperes => convertTo(CurrentUnit.kiloampere);
}

/// Provides convenient factory methods for creating [Current] instances from [num]
/// using getter properties named after common unit symbols or names.
extension CurrentCreation on num {
  /// Creates a [Current] instance representing this numerical value in Amperes (A).
  Current get A => Current(toDouble(), CurrentUnit.ampere); // Using symbol 'A'

  /// Creates a [Current] instance representing this numerical value in Amperes (A).
  /// Alias for `A`.
  Current get amperes => Current(toDouble(), CurrentUnit.ampere);

  /// Creates a [Current] instance representing this numerical value in Milliamperes (mA).
  Current get mA => Current(toDouble(), CurrentUnit.milliampere);

  /// Creates a [Current] instance representing this numerical value in Milliamperes (mA).
  /// Alias for `mA`.
  Current get milliamperes => Current(toDouble(), CurrentUnit.milliampere);

  /// Creates a [Current] instance representing this numerical value in Microamperes (µA).
  Current get uA => Current(toDouble(), CurrentUnit.microampere); // Using 'uA' for micro

  /// Creates a [Current] instance representing this numerical value in Microamperes (µA).
  /// Alias for `uA`.
  Current get microamperes => Current(toDouble(), CurrentUnit.microampere);

  /// Creates a [Current] instance representing this numerical value in Nanoamperes (nA).
  Current get nA => Current(toDouble(), CurrentUnit.nanoampere);

  /// Creates a [Current] instance representing this numerical value in Nanoamperes (nA).
  /// Alias for `nA`.
  Current get nanoamperes => Current(toDouble(), CurrentUnit.nanoampere);

  /// Creates a [Current] instance representing this numerical value in Kiloamperes (kA).
  Current get kA => Current(toDouble(), CurrentUnit.kiloampere);

  /// Creates a [Current] instance representing this numerical value in Kiloamperes (kA).
  /// Alias for `kA`.
  Current get kiloamperes => Current(toDouble(), CurrentUnit.kiloampere);
}
