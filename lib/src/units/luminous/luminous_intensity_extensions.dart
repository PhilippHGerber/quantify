import 'luminous_intensity.dart';
import 'luminous_intensity_unit.dart';

// SI/IEC unit symbols use uppercase letters by international standard
// (e.g., 'Hz' for hertz, named after Heinrich Hertz).
// Dart's lowerCamelCase rule is intentionally overridden here to preserve
// domain correctness and discoverability for scientists and engineers.
// ignore_for_file: non_constant_identifier_names

/// Provides convenient access to [LuminousIntensity] values in specific units
/// using getter properties.
extension LuminousIntensityValueGetters on LuminousIntensity {
  /// Returns the luminous intensity value in Candelas (cd).
  double get inCandelas => getValue(LuminousIntensityUnit.candela);

  /// Returns the luminous intensity value in Millicandelas (mcd).
  double get inMillicandelas => getValue(LuminousIntensityUnit.millicandela);

  /// Returns the luminous intensity value in Microcandelas (µcd).
  double get inMicrocandelas => getValue(LuminousIntensityUnit.microcandela);

  /// Returns the luminous intensity value in Kilocandelas (kcd).
  double get inKilocandelas => getValue(LuminousIntensityUnit.kilocandela);

  /// Returns the luminous intensity value in Megacandelas (Mcd).
  double get inMegacandelas => getValue(LuminousIntensityUnit.megacandela);

  // --- "As" Getters for new LuminousIntensity objects ---

  /// Returns a new [LuminousIntensity] object representing this intensity in Candelas (cd).
  LuminousIntensity get asCandelas => convertTo(LuminousIntensityUnit.candela);

  /// Returns a new [LuminousIntensity] object representing this intensity in Millicandelas (mcd).
  LuminousIntensity get asMillicandelas => convertTo(LuminousIntensityUnit.millicandela);

  /// Returns a new [LuminousIntensity] object representing this intensity in Microcandelas (µcd).
  LuminousIntensity get asMicrocandelas => convertTo(LuminousIntensityUnit.microcandela);

  /// Returns a new [LuminousIntensity] object representing this intensity in Kilocandelas (kcd).
  LuminousIntensity get asKilocandelas => convertTo(LuminousIntensityUnit.kilocandela);

  /// Returns a new [LuminousIntensity] object representing this intensity in Megacandelas (Mcd).
  LuminousIntensity get asMegacandelas => convertTo(LuminousIntensityUnit.megacandela);
}

/// Provides convenient factory methods for creating [LuminousIntensity] instances from [num]
/// using getter properties named after common unit symbols or names.
extension LuminousIntensityCreation on num {
  /// Creates a [LuminousIntensity] instance from this numerical value in Candelas (cd).
  LuminousIntensity get cd => LuminousIntensity(toDouble(), LuminousIntensityUnit.candela);

  /// Creates a [LuminousIntensity] instance from this numerical value in Candelas (cd).
  /// Alias for `cd`.
  LuminousIntensity get candelas => LuminousIntensity(toDouble(), LuminousIntensityUnit.candela);

  /// Creates a [LuminousIntensity] instance from this numerical value in Millicandelas (mcd).
  LuminousIntensity get mcd => LuminousIntensity(toDouble(), LuminousIntensityUnit.millicandela);

  /// Creates a [LuminousIntensity] instance from this numerical value in Millicandelas (mcd).
  /// Alias for `mcd`.
  LuminousIntensity get millicandelas =>
      LuminousIntensity(toDouble(), LuminousIntensityUnit.millicandela);

  /// Creates a [LuminousIntensity] instance from this numerical value in Microcandelas (µcd).
  LuminousIntensity get ucd => LuminousIntensity(toDouble(), LuminousIntensityUnit.microcandela);

  /// Creates a [LuminousIntensity] instance from this numerical value in Microcandelas (µcd).
  /// Alias for `ucd`.
  LuminousIntensity get microcandelas =>
      LuminousIntensity(toDouble(), LuminousIntensityUnit.microcandela);

  /// Creates a [LuminousIntensity] instance from this numerical value in Kilocandelas (kcd).
  LuminousIntensity get kcd => LuminousIntensity(toDouble(), LuminousIntensityUnit.kilocandela);

  /// Creates a [LuminousIntensity] instance from this numerical value in Kilocandelas (kcd).
  /// Alias for `kcd`.
  LuminousIntensity get kilocandelas =>
      LuminousIntensity(toDouble(), LuminousIntensityUnit.kilocandela);

  /// Creates a [LuminousIntensity] instance from this numerical value in Megacandelas (Mcd).
  LuminousIntensity get Mcd => LuminousIntensity(toDouble(), LuminousIntensityUnit.megacandela);

  /// Creates a [LuminousIntensity] instance from this numerical value in Megacandelas (Mcd).
  /// Alias for `Mcd`.
  LuminousIntensity get megacandelas =>
      LuminousIntensity(toDouble(), LuminousIntensityUnit.megacandela);
}
