import 'resistance.dart';
import 'resistance_unit.dart';

/// Provides convenient access to [Resistance] values in specific units
/// using getter properties.
extension ResistanceValueGetters on Resistance {
  /// Returns the resistance value in Ohms (Ω).
  double get inOhms => getValue(ResistanceUnit.ohm);

  /// Returns the resistance value in Nanoohms (nΩ).
  double get inNanoohms => getValue(ResistanceUnit.nanoohm);

  /// Returns the resistance value in Microohms (µΩ).
  double get inMicroohms => getValue(ResistanceUnit.microohm);

  /// Returns the resistance value in Milliohms (mΩ).
  double get inMilliohms => getValue(ResistanceUnit.milliohm);

  /// Returns the resistance value in Kiloohms (kΩ).
  double get inKiloohms => getValue(ResistanceUnit.kiloohm);

  /// Returns the resistance value in Megaohms (MΩ).
  double get inMegaohms => getValue(ResistanceUnit.megaohm);

  /// Returns the resistance value in Gigaohms (GΩ).
  double get inGigaohms => getValue(ResistanceUnit.gigaohm);

  // --- "As" Getters for new Resistance objects ---

  /// Returns a new [Resistance] object representing this resistance in Ohms (Ω).
  Resistance get asOhms => convertTo(ResistanceUnit.ohm);

  /// Returns a new [Resistance] object representing this resistance in Nanoohms (nΩ).
  Resistance get asNanoohms => convertTo(ResistanceUnit.nanoohm);

  /// Returns a new [Resistance] object representing this resistance in Microohms (µΩ).
  Resistance get asMicroohms => convertTo(ResistanceUnit.microohm);

  /// Returns a new [Resistance] object representing this resistance in Milliohms (mΩ).
  Resistance get asMilliohms => convertTo(ResistanceUnit.milliohm);

  /// Returns a new [Resistance] object representing this resistance in Kiloohms (kΩ).
  Resistance get asKiloohms => convertTo(ResistanceUnit.kiloohm);

  /// Returns a new [Resistance] object representing this resistance in Megaohms (MΩ).
  Resistance get asMegaohms => convertTo(ResistanceUnit.megaohm);

  /// Returns a new [Resistance] object representing this resistance in Gigaohms (GΩ).
  Resistance get asGigaohms => convertTo(ResistanceUnit.gigaohm);
}

/// Provides convenient factory methods for creating [Resistance] instances from [num]
/// using getter properties named after common unit symbols or names.
extension ResistanceCreation on num {
  /// Creates a [Resistance] instance representing this numerical value in Ohms (Ω).
  Resistance get ohms => Resistance(toDouble(), ResistanceUnit.ohm);

  /// Creates a [Resistance] instance representing this numerical value in Nanoohms (nΩ).
  Resistance get nanoohms => Resistance(toDouble(), ResistanceUnit.nanoohm);

  /// Creates a [Resistance] instance representing this numerical value in Microohms (µΩ).
  Resistance get microohms => Resistance(toDouble(), ResistanceUnit.microohm);

  /// Creates a [Resistance] instance representing this numerical value in Milliohms (mΩ).
  Resistance get milliohms => Resistance(toDouble(), ResistanceUnit.milliohm);

  /// Creates a [Resistance] instance representing this numerical value in Kiloohms (kΩ).
  Resistance get kiloohms => Resistance(toDouble(), ResistanceUnit.kiloohm);

  /// Creates a [Resistance] instance representing this numerical value in Megaohms (MΩ).
  Resistance get megaohms => Resistance(toDouble(), ResistanceUnit.megaohm);

  /// Creates a [Resistance] instance representing this numerical value in Gigaohms (GΩ).
  Resistance get gigaohms => Resistance(toDouble(), ResistanceUnit.gigaohm);
}
