import 'molar_amount.dart';
import 'molar_unit.dart';

/// Provides convenient access to [MolarAmount] values in specific units
/// using getter properties.
///
/// These getters simplify retrieving the numerical value of a molar amount
/// in a desired unit without explicitly calling `getValue()`.
extension MolarAmountValueGetters on MolarAmount {
  /// Returns the molar amount value in Moles (mol).
  double get inMoles => getValue(MolarUnit.mole);

  /// Returns the molar amount value in Millimoles (mmol).
  double get inMillimoles => getValue(MolarUnit.millimole);

  /// Returns the molar amount value in Micromoles (µmol).
  double get inMicromoles => getValue(MolarUnit.micromole);

  /// Returns the molar amount value in Nanomoles (nmol).
  double get inNanomoles => getValue(MolarUnit.nanomole);

  /// Returns the molar amount value in Picomoles (pmol).
  double get inPicomoles => getValue(MolarUnit.picomole);

  /// Returns the molar amount value in Kilomoles (kmol).
  double get inKilomoles => getValue(MolarUnit.kilomole);

  // --- "As" Getters for new MolarAmount objects ---

  /// Returns a new [MolarAmount] object representing this amount in Moles (mol).
  MolarAmount get asMoles => convertTo(MolarUnit.mole);

  /// Returns a new [MolarAmount] object representing this amount in Millimoles (mmol).
  MolarAmount get asMillimoles => convertTo(MolarUnit.millimole);

  /// Returns a new [MolarAmount] object representing this amount in Micromoles (µmol).
  MolarAmount get asMicromoles => convertTo(MolarUnit.micromole);

  /// Returns a new [MolarAmount] object representing this amount in Nanomoles (nmol).
  MolarAmount get asNanomoles => convertTo(MolarUnit.nanomole);

  /// Returns a new [MolarAmount] object representing this amount in Picomoles (pmol).
  MolarAmount get asPicomoles => convertTo(MolarUnit.picomole);

  /// Returns a new [MolarAmount] object representing this amount in Kilomoles (kmol).
  MolarAmount get asKilomoles => convertTo(MolarUnit.kilomole);
}

/// Provides convenient factory methods for creating [MolarAmount] instances from [num]
/// using getter properties named after common unit symbols or names.
///
/// This allows for an intuitive and concise way to create molar amount quantities,
/// for example: `0.5.mol` or `25.millimoles`.
extension MolarAmountCreation on num {
  /// Creates a [MolarAmount] instance representing this numerical value in Moles (mol).
  MolarAmount get mol => MolarAmount(toDouble(), MolarUnit.mole);

  /// Creates a [MolarAmount] instance representing this numerical value in Moles (mol).
  /// Alias for `mol`.
  MolarAmount get moles => MolarAmount(toDouble(), MolarUnit.mole);

  /// Creates a [MolarAmount] instance representing this numerical value in Millimoles (mmol).
  MolarAmount get mmol => MolarAmount(toDouble(), MolarUnit.millimole);

  /// Creates a [MolarAmount] instance representing this numerical value in Millimoles (mmol).
  /// Alias for `mmol`.
  MolarAmount get millimoles => MolarAmount(toDouble(), MolarUnit.millimole);

  /// Creates a [MolarAmount] instance representing this numerical value in Micromoles (µmol).
  MolarAmount get umol => MolarAmount(toDouble(), MolarUnit.micromole); // Using 'u' for micro

  /// Creates a [MolarAmount] instance representing this numerical value in Micromoles (µmol).
  /// Alias for `umol`.
  MolarAmount get micromoles => MolarAmount(toDouble(), MolarUnit.micromole);

  /// Creates a [MolarAmount] instance representing this numerical value in Nanomoles (nmol).
  MolarAmount get nmol => MolarAmount(toDouble(), MolarUnit.nanomole);

  /// Creates a [MolarAmount] instance representing this numerical value in Nanomoles (nmol).
  /// Alias for `nmol`.
  MolarAmount get nanomoles => MolarAmount(toDouble(), MolarUnit.nanomole);

  /// Creates a [MolarAmount] instance representing this numerical value in Picomoles (pmol).
  MolarAmount get pmol => MolarAmount(toDouble(), MolarUnit.picomole);

  /// Creates a [MolarAmount] instance representing this numerical value in Picomoles (pmol).
  /// Alias for `pmol`.
  MolarAmount get picomoles => MolarAmount(toDouble(), MolarUnit.picomole);

  /// Creates a [MolarAmount] instance representing this numerical value in Kilomoles (kmol).
  MolarAmount get kmol => MolarAmount(toDouble(), MolarUnit.kilomole);

  /// Creates a [MolarAmount] instance representing this numerical value in Kilomoles (kmol).
  /// Alias for `kmol`.
  MolarAmount get kilomoles => MolarAmount(toDouble(), MolarUnit.kilomole);
}
// END FILE: lib/src/units/molar/molar_extensions.dart
