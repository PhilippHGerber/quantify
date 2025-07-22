import 'electric_charge.dart';
import 'electric_charge_unit.dart';

/// Provides convenient access to [ElectricCharge] values in specific units.
extension ElectricChargeValueGetters on ElectricCharge {
  /// Returns the electric charge value in Coulombs (C).
  double get inCoulombs => getValue(ElectricChargeUnit.coulomb);

  /// Returns the electric charge value in Millicoulombs (mC).
  double get inMillicoulombs => getValue(ElectricChargeUnit.millicoulomb);

  /// Returns the electric charge value in Microcoulombs (µC).
  double get inMicrocoulombs => getValue(ElectricChargeUnit.microcoulomb);

  /// Returns the electric charge value in Nanocoulombs (nC).
  double get inNanocoulombs => getValue(ElectricChargeUnit.nanocoulomb);

  /// Returns the electric charge value in Elementary Charges (e).
  double get inElementaryCharges => getValue(ElectricChargeUnit.elementaryCharge);

  /// Returns the electric charge value in Ampere-hours (Ah).
  double get inAmpereHours => getValue(ElectricChargeUnit.ampereHour);

  /// Returns a new [ElectricCharge] object representing this charge in Coulombs (C).
  ElectricCharge get asCoulombs => convertTo(ElectricChargeUnit.coulomb);

  /// Returns a new [ElectricCharge] object representing this charge in Millicoulombs (mC).
  ElectricCharge get asMillicoulombs => convertTo(ElectricChargeUnit.millicoulomb);

  /// Returns a new [ElectricCharge] object representing this charge in Microcoulombs (µC).
  ElectricCharge get asMicrocoulombs => convertTo(ElectricChargeUnit.microcoulomb);

  /// Returns a new [ElectricCharge] object representing this charge in Nanocoulombs (nC).
  ElectricCharge get asNanocoulombs => convertTo(ElectricChargeUnit.nanocoulomb);

  /// Returns a new [ElectricCharge] object representing this charge in Elementary Charges (e).
  ElectricCharge get asElementaryCharges => convertTo(ElectricChargeUnit.elementaryCharge);

  /// Returns a new [ElectricCharge] object representing this charge in Ampere-hours (Ah).
  ElectricCharge get asAmpereHours => convertTo(ElectricChargeUnit.ampereHour);
}

/// Provides convenient factory methods for creating [ElectricCharge] instances from [num].
extension ElectricChargeCreation on num {
  /// Creates an [ElectricCharge] instance from this value in Coulombs (C).
  ElectricCharge get C => ElectricCharge(toDouble(), ElectricChargeUnit.coulomb);

  /// Creates an [ElectricCharge] instance from this value in Coulombs (C).
  /// Alias for `C`.
  ElectricCharge get coulombs => ElectricCharge(toDouble(), ElectricChargeUnit.coulomb);

  /// Creates an [ElectricCharge] instance from this value in Millicoulombs (mC).
  ElectricCharge get mC => ElectricCharge(toDouble(), ElectricChargeUnit.millicoulomb);

  /// Creates an [ElectricCharge] instance from this value in Microcoulombs (µC).
  ElectricCharge get uC => ElectricCharge(toDouble(), ElectricChargeUnit.microcoulomb);

  /// Creates an [ElectricCharge] instance from this value in Nanocoulombs (nC).
  ElectricCharge get nC => ElectricCharge(toDouble(), ElectricChargeUnit.nanocoulomb);

  /// Creates an [ElectricCharge] instance from this value in Elementary Charges (e).
  /// Represents the number of elementary charges (e.g., protons or electrons).
  ElectricCharge get e => ElectricCharge(toDouble(), ElectricChargeUnit.elementaryCharge);

  /// Creates an [ElectricCharge] instance from this value in Ampere-hours (Ah).
  ElectricCharge get ah => ElectricCharge(toDouble(), ElectricChargeUnit.ampereHour);
}
