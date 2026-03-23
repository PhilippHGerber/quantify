import 'current.dart';
import 'current_unit.dart';

// SI/IEC unit symbols use uppercase letters by international standard
// (e.g., 'Hz' for hertz, named after Heinrich Hertz).
// Dart's lowerCamelCase rule is intentionally overridden here to preserve
// domain correctness and discoverability for scientists and engineers.
// ignore_for_file: non_constant_identifier_names

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

  /// Returns the electric current value in Picoamperes (pA).
  double get inPicoamperes => getValue(CurrentUnit.picoampere);

  /// Returns the electric current value in Femtoamperes (fA).
  double get inFemtoamperes => getValue(CurrentUnit.femtoampere);

  /// Returns the electric current value in Kiloamperes (kA).
  double get inKiloamperes => getValue(CurrentUnit.kiloampere);

  /// Returns the electric current value in Megaamperes (MA).
  double get inMegaamperes => getValue(CurrentUnit.megaampere);

  /// Returns the electric current value in Gigaamperes (GA).
  double get inGigaamperes => getValue(CurrentUnit.gigaampere);

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

  /// Returns a new [Current] object representing this current in Picoamperes (pA).
  Current get asPicoamperes => convertTo(CurrentUnit.picoampere);

  /// Returns a new [Current] object representing this current in Femtoamperes (fA).
  Current get asFemtoamperes => convertTo(CurrentUnit.femtoampere);

  /// Returns a new [Current] object representing this current in Kiloamperes (kA).
  Current get asKiloamperes => convertTo(CurrentUnit.kiloampere);

  /// Returns a new [Current] object representing this current in Megaamperes (MA).
  Current get asMegaamperes => convertTo(CurrentUnit.megaampere);

  /// Returns a new [Current] object representing this current in Gigaamperes (GA).
  Current get asGigaamperes => convertTo(CurrentUnit.gigaampere);

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

  /// Creates a [Current] instance representing this numerical value in Picoamperes (pA).
  Current get pA => Current(toDouble(), CurrentUnit.picoampere);

  /// Creates a [Current] instance representing this numerical value in Picoamperes (pA).
  /// Alias for `pA`.
  Current get picoamperes => Current(toDouble(), CurrentUnit.picoampere);

  /// Creates a [Current] instance representing this numerical value in Femtoamperes (fA).
  Current get fA => Current(toDouble(), CurrentUnit.femtoampere);

  /// Creates a [Current] instance representing this numerical value in Femtoamperes (fA).
  /// Alias for `fA`.
  Current get femtoamperes => Current(toDouble(), CurrentUnit.femtoampere);

  /// Creates a [Current] instance representing this numerical value in Kiloamperes (kA).
  Current get kA => Current(toDouble(), CurrentUnit.kiloampere);

  /// Creates a [Current] instance representing this numerical value in Kiloamperes (kA).
  /// Alias for `kA`.
  Current get kiloamperes => Current(toDouble(), CurrentUnit.kiloampere);

  /// Creates a [Current] instance representing this numerical value in Megaamperes (MA).
  Current get MA => Current(toDouble(), CurrentUnit.megaampere);

  /// Creates a [Current] instance representing this numerical value in Megaamperes (MA).
  /// Alias for `MA`.
  Current get megaamperes => Current(toDouble(), CurrentUnit.megaampere);

  /// Creates a [Current] instance representing this numerical value in Gigaamperes (GA).
  Current get GA => Current(toDouble(), CurrentUnit.gigaampere);

  /// Creates a [Current] instance representing this numerical value in Gigaamperes (GA).
  /// Alias for `GA`.
  Current get gigaamperes => Current(toDouble(), CurrentUnit.gigaampere);

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
