import 'luminous_intensity.dart';
import 'luminous_intensity_unit.dart';

/// Provides convenient access to [LuminousIntensity] values in specific units
/// using getter properties.
extension LuminousIntensityValueGetters on LuminousIntensity {
  /// Returns the luminous intensity value in Candelas (cd).
  double get inCandelas => getValue(LuminousIntensityUnit.candela);

  /// Returns the luminous intensity value in Millicandelas (mcd).
  double get inMillicandelas => getValue(LuminousIntensityUnit.millicandela);

  /// Returns the luminous intensity value in Kilocandelas (kcd).
  double get inKilocandelas => getValue(LuminousIntensityUnit.kilocandela);

  // --- "As" Getters for new LuminousIntensity objects ---

  /// Returns a new [LuminousIntensity] object representing this intensity in Candelas (cd).
  LuminousIntensity get asCandelas => convertTo(LuminousIntensityUnit.candela);

  /// Returns a new [LuminousIntensity] object representing this intensity in Millicandelas (mcd).
  LuminousIntensity get asMillicandelas => convertTo(LuminousIntensityUnit.millicandela);

  /// Returns a new [LuminousIntensity] object representing this intensity in Kilocandelas (kcd).
  LuminousIntensity get asKilocandelas => convertTo(LuminousIntensityUnit.kilocandela);
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

  /// Creates a [LuminousIntensity] instance from this numerical value in Kilocandelas (kcd).
  LuminousIntensity get kcd => LuminousIntensity(toDouble(), LuminousIntensityUnit.kilocandela);

  /// Creates a [LuminousIntensity] instance from this numerical value in Kilocandelas (kcd).
  /// Alias for `kcd`.
  LuminousIntensity get kilocandelas =>
      LuminousIntensity(toDouble(), LuminousIntensityUnit.kilocandela);
}
