import 'voltage.dart';
import 'voltage_unit.dart';

// SI/IEC unit symbols use uppercase letters by international standard
// (e.g., 'V' for volt, named after Alessandro Volta).
// Dart's lowerCamelCase rule is intentionally overridden here to preserve
// domain correctness and discoverability for scientists and engineers.
// ignore_for_file: non_constant_identifier_names

/// Provides convenient access to [Voltage] values in specific units
/// using getter properties.
extension VoltageValueGetters on Voltage {
  /// Returns the voltage value in Volts (V).
  double get inVolts => getValue(VoltageUnit.volt);

  /// Returns the voltage value in Nanovolts (nV).
  double get inNanovolts => getValue(VoltageUnit.nanovolt);

  /// Returns the voltage value in Microvolts (µV).
  double get inMicrovolts => getValue(VoltageUnit.microvolt);

  /// Returns the voltage value in Millivolts (mV).
  double get inMillivolts => getValue(VoltageUnit.millivolt);

  /// Returns the voltage value in Kilovolts (kV).
  double get inKilovolts => getValue(VoltageUnit.kilovolt);

  /// Returns the voltage value in Megavolts (MV).
  double get inMegavolts => getValue(VoltageUnit.megavolt);

  /// Returns the voltage value in Gigavolts (GV).
  double get inGigavolts => getValue(VoltageUnit.gigavolt);

  /// Returns the voltage value in Statvolts (statV).
  double get inStatvolts => getValue(VoltageUnit.statvolt);

  /// Returns the voltage value in Abvolts (abV).
  double get inAbvolts => getValue(VoltageUnit.abvolt);

  // --- "As" Getters for new Voltage objects ---

  /// Returns a new [Voltage] object representing this voltage in Volts (V).
  Voltage get asVolts => convertTo(VoltageUnit.volt);

  /// Returns a new [Voltage] object representing this voltage in Nanovolts (nV).
  Voltage get asNanovolts => convertTo(VoltageUnit.nanovolt);

  /// Returns a new [Voltage] object representing this voltage in Microvolts (µV).
  Voltage get asMicrovolts => convertTo(VoltageUnit.microvolt);

  /// Returns a new [Voltage] object representing this voltage in Millivolts (mV).
  Voltage get asMillivolts => convertTo(VoltageUnit.millivolt);

  /// Returns a new [Voltage] object representing this voltage in Kilovolts (kV).
  Voltage get asKilovolts => convertTo(VoltageUnit.kilovolt);

  /// Returns a new [Voltage] object representing this voltage in Megavolts (MV).
  Voltage get asMegavolts => convertTo(VoltageUnit.megavolt);

  /// Returns a new [Voltage] object representing this voltage in Gigavolts (GV).
  Voltage get asGigavolts => convertTo(VoltageUnit.gigavolt);

  /// Returns a new [Voltage] object representing this voltage in Statvolts (statV).
  Voltage get asStatvolts => convertTo(VoltageUnit.statvolt);

  /// Returns a new [Voltage] object representing this voltage in Abvolts (abV).
  Voltage get asAbvolts => convertTo(VoltageUnit.abvolt);
}

/// Provides convenient factory methods for creating [Voltage] instances from [num]
/// using getter properties named after common unit symbols or names.
extension VoltageCreation on num {
  /// Creates a [Voltage] instance representing this numerical value in Volts (V).
  Voltage get V => Voltage(toDouble(), VoltageUnit.volt);

  /// Creates a [Voltage] instance representing this numerical value in Volts (V).
  /// Alias for `V`.
  Voltage get volts => Voltage(toDouble(), VoltageUnit.volt);

  /// Creates a [Voltage] instance representing this numerical value in Nanovolts (nV).
  Voltage get nV => Voltage(toDouble(), VoltageUnit.nanovolt);

  /// Creates a [Voltage] instance representing this numerical value in Nanovolts (nV).
  /// Alias for `nV`.
  Voltage get nanovolts => Voltage(toDouble(), VoltageUnit.nanovolt);

  /// Creates a [Voltage] instance representing this numerical value in Microvolts (µV).
  Voltage get uV => Voltage(toDouble(), VoltageUnit.microvolt);

  /// Creates a [Voltage] instance representing this numerical value in Microvolts (µV).
  /// Alias for `uV`.
  Voltage get microvolts => Voltage(toDouble(), VoltageUnit.microvolt);

  /// Creates a [Voltage] instance representing this numerical value in Millivolts (mV).
  Voltage get mV => Voltage(toDouble(), VoltageUnit.millivolt);

  /// Creates a [Voltage] instance representing this numerical value in Millivolts (mV).
  /// Alias for `mV`.
  Voltage get millivolts => Voltage(toDouble(), VoltageUnit.millivolt);

  /// Creates a [Voltage] instance representing this numerical value in Kilovolts (kV).
  Voltage get kV => Voltage(toDouble(), VoltageUnit.kilovolt);

  /// Creates a [Voltage] instance representing this numerical value in Kilovolts (kV).
  /// Alias for `kV`.
  Voltage get kilovolts => Voltage(toDouble(), VoltageUnit.kilovolt);

  /// Creates a [Voltage] instance representing this numerical value in Megavolts (MV).
  Voltage get MV => Voltage(toDouble(), VoltageUnit.megavolt);

  /// Creates a [Voltage] instance representing this numerical value in Megavolts (MV).
  /// Alias for `MV`.
  Voltage get megavolts => Voltage(toDouble(), VoltageUnit.megavolt);

  /// Creates a [Voltage] instance representing this numerical value in Gigavolts (GV).
  Voltage get GV => Voltage(toDouble(), VoltageUnit.gigavolt);

  /// Creates a [Voltage] instance representing this numerical value in Gigavolts (GV).
  /// Alias for `GV`.
  Voltage get gigavolts => Voltage(toDouble(), VoltageUnit.gigavolt);

  /// Creates a [Voltage] instance from this numerical value in Statvolts (statV).
  Voltage get statV => Voltage(toDouble(), VoltageUnit.statvolt);

  /// Creates a [Voltage] instance from this numerical value in Statvolts (statV).
  /// Alias for `statV`.
  Voltage get statvolts => Voltage(toDouble(), VoltageUnit.statvolt);

  /// Creates a [Voltage] instance from this numerical value in Abvolts (abV).
  Voltage get abV => Voltage(toDouble(), VoltageUnit.abvolt);

  /// Creates a [Voltage] instance from this numerical value in Abvolts (abV).
  /// Alias for `abV`.
  Voltage get abvolts => Voltage(toDouble(), VoltageUnit.abvolt);
}
