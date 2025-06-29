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

  /// Returns the electric current value in Statamperes (statA).
  double get inStatamperes => getValue(CurrentUnit.statampere);

  /// Returns the electric current value in Abamperes (abA) or Biot (Bi).
  double get inAbamperes => getValue(CurrentUnit.abampere);

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

  /// Returns a new [Current] object representing this current in Statamperes (statA).
  Current get asStatamperes => convertTo(CurrentUnit.statampere);

  /// Returns a new [Current] object representing this current in Abamperes (abA) or Biot (Bi).
  Current get asAbamperes => convertTo(CurrentUnit.abampere);
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

  /// Creates a [Current] instance from this numerical value in Statamperes (statA).
  Current get statA => Current(toDouble(), CurrentUnit.statampere);

  /// Creates a [Current] instance from this numerical value in Statamperes (statA).
  /// Alias for `statA`.
  Current get statamperes => Current(toDouble(), CurrentUnit.statampere);

  /// Creates a [Current] instance from this numerical value in Abamperes (abA).
  Current get abA => Current(toDouble(), CurrentUnit.abampere);

  /// Creates a [Current] instance from this numerical value in Abamperes (abA).
  /// Alias for `abA`, also known as Biot (Bi).
  Current get abamperes => Current(toDouble(), CurrentUnit.abampere);

  /// Creates a [Current] instance from this numerical value in Biot (Bi).
  /// This is an alias for Abampere (`abA`).
  Current get bi => Current(toDouble(), CurrentUnit.abampere);
}
