import 'information.dart';
import 'information_unit.dart';

/// Provides convenient access to [Information] values in specific units.
extension InformationValueGetters on Information {
  // --- Double value getters ---

  /// Returns the information value in Bits.
  double get inBit => getValue(InformationUnit.bit);

  /// Returns the information value in Bytes (B).
  double get inByte => getValue(InformationUnit.byte);

  // SI bit units

  /// Returns the information value in Kilobits (kbit, SI: 1 000 bits).
  double get inKbit => getValue(InformationUnit.kilobit);

  /// Returns the information value in Megabits (Mbit, SI: 10⁶ bits).
  double get inMbit => getValue(InformationUnit.megabit);

  /// Returns the information value in Gigabits (Gbit, SI: 10⁹ bits).
  double get inGbit => getValue(InformationUnit.gigabit);

  /// Returns the information value in Terabits (Tbit, SI: 10¹² bits).
  double get inTbit => getValue(InformationUnit.terabit);

  // SI / decimal byte units

  /// Returns the information value in Kilobytes (kB, SI: 1 000 bytes).
  double get inKB => getValue(InformationUnit.kilobyte);

  /// Returns the information value in Megabytes (MB, SI: 10⁶ bytes).
  double get inMB => getValue(InformationUnit.megabyte);

  /// Returns the information value in Gigabytes (GB, SI: 10⁹ bytes).
  double get inGB => getValue(InformationUnit.gigabyte);

  /// Returns the information value in Terabytes (TB, SI: 10¹² bytes).
  double get inTB => getValue(InformationUnit.terabyte);

  /// Returns the information value in Petabytes (PB, SI: 10¹⁵ bytes).
  double get inPB => getValue(InformationUnit.petabyte);

  // IEC / binary

  /// Returns the information value in Kibibytes (KiB, IEC: 1 024 bytes).
  double get inKiB => getValue(InformationUnit.kibibyte);

  /// Returns the information value in Mebibytes (MiB, IEC: 2²⁰ bytes).
  double get inMiB => getValue(InformationUnit.mebibyte);

  /// Returns the information value in Gibibytes (GiB, IEC: 2³⁰ bytes).
  double get inGiB => getValue(InformationUnit.gibibyte);

  /// Returns the information value in Tebibytes (TiB, IEC: 2⁴⁰ bytes).
  double get inTiB => getValue(InformationUnit.tebibyte);

  /// Returns the information value in Pebibytes (PiB, IEC: 2⁵⁰ bytes).
  double get inPiB => getValue(InformationUnit.pebibyte);

  // --- Information instance getters ---

  /// Returns an [Information] representing this quantity in Bits.
  Information get asBit => convertTo(InformationUnit.bit);

  /// Returns an [Information] representing this quantity in Bytes (B).
  Information get asByte => convertTo(InformationUnit.byte);

  // SI bit units

  /// Returns an [Information] representing this quantity in Kilobits (kbit).
  Information get asKbit => convertTo(InformationUnit.kilobit);

  /// Returns an [Information] representing this quantity in Megabits (Mbit).
  Information get asMbit => convertTo(InformationUnit.megabit);

  /// Returns an [Information] representing this quantity in Gigabits (Gbit).
  Information get asGbit => convertTo(InformationUnit.gigabit);

  /// Returns an [Information] representing this quantity in Terabits (Tbit).
  Information get asTbit => convertTo(InformationUnit.terabit);

  // SI / decimal byte units

  /// Returns an [Information] representing this quantity in Kilobytes (kB).
  Information get asKB => convertTo(InformationUnit.kilobyte);

  /// Returns an [Information] representing this quantity in Megabytes (MB).
  Information get asMB => convertTo(InformationUnit.megabyte);

  /// Returns an [Information] representing this quantity in Gigabytes (GB).
  Information get asGB => convertTo(InformationUnit.gigabyte);

  /// Returns an [Information] representing this quantity in Terabytes (TB).
  Information get asTB => convertTo(InformationUnit.terabyte);

  /// Returns an [Information] representing this quantity in Petabytes (PB).
  Information get asPB => convertTo(InformationUnit.petabyte);

  // IEC / binary

  /// Returns an [Information] representing this quantity in Kibibytes (KiB).
  Information get asKiB => convertTo(InformationUnit.kibibyte);

  /// Returns an [Information] representing this quantity in Mebibytes (MiB).
  Information get asMiB => convertTo(InformationUnit.mebibyte);

  /// Returns an [Information] representing this quantity in Gibibytes (GiB).
  Information get asGiB => convertTo(InformationUnit.gibibyte);

  /// Returns an [Information] representing this quantity in Tebibytes (TiB).
  Information get asTiB => convertTo(InformationUnit.tebibyte);

  /// Returns an [Information] representing this quantity in Pebibytes (PiB).
  Information get asPiB => convertTo(InformationUnit.pebibyte);
}

/// Provides convenient factory methods for creating [Information] instances from [num].
extension InformationCreation on num {
  /// Creates an [Information] instance representing this value in Bits.
  Information get bit => Information(toDouble(), InformationUnit.bit);

  /// Creates an [Information] instance representing this value in Bytes (B).
  Information get byte => Information(toDouble(), InformationUnit.byte);

  // SI bit units

  /// Creates an [Information] instance representing this value in Kilobits (kbit, SI: 1 000 bits).
  Information get kbit => Information(toDouble(), InformationUnit.kilobit);

  /// Creates an [Information] instance representing this value in Megabits (Mbit, SI: 10⁶ bits).
  // ignore: non_constant_identifier_names
  Information get Mbit => Information(toDouble(), InformationUnit.megabit);

  /// Creates an [Information] instance representing this value in Gigabits (Gbit, SI: 10⁹ bits).
  // ignore: non_constant_identifier_names
  Information get Gbit => Information(toDouble(), InformationUnit.gigabit);

  /// Creates an [Information] instance representing this value in Terabits (Tbit, SI: 10¹² bits).
  // ignore: non_constant_identifier_names
  Information get Tbit => Information(toDouble(), InformationUnit.terabit);

  // SI / decimal byte units

  /// Creates an [Information] instance representing this value in Kilobytes (kB, SI: 1 000 bytes).
  Information get kB => Information(toDouble(), InformationUnit.kilobyte);

  /// Creates an [Information] instance representing this value in Megabytes (MB, SI: 10⁶ bytes).
  // ignore: non_constant_identifier_names
  Information get MB => Information(toDouble(), InformationUnit.megabyte);

  /// Creates an [Information] instance representing this value in Gigabytes (GB, SI: 10⁹ bytes).
  // ignore: non_constant_identifier_names
  Information get GB => Information(toDouble(), InformationUnit.gigabyte);

  /// Creates an [Information] instance representing this value in Terabytes (TB, SI: 10¹² bytes).
  // ignore: non_constant_identifier_names
  Information get TB => Information(toDouble(), InformationUnit.terabyte);

  /// Creates an [Information] instance representing this value in Petabytes (PB, SI: 10¹⁵ bytes).
  // ignore: non_constant_identifier_names
  Information get PB => Information(toDouble(), InformationUnit.petabyte);

  // IEC / binary

  /// Creates an [Information] instance representing this value in Kibibytes (KiB, IEC: 1 024 bytes).
  // ignore: non_constant_identifier_names
  Information get KiB => Information(toDouble(), InformationUnit.kibibyte);

  /// Creates an [Information] instance representing this value in Mebibytes (MiB, IEC: 2²⁰ bytes).
  // ignore: non_constant_identifier_names
  Information get MiB => Information(toDouble(), InformationUnit.mebibyte);

  /// Creates an [Information] instance representing this value in Gibibytes (GiB, IEC: 2³⁰ bytes).
  // ignore: non_constant_identifier_names
  Information get GiB => Information(toDouble(), InformationUnit.gibibyte);

  /// Creates an [Information] instance representing this value in Tebibytes (TiB, IEC: 2⁴⁰ bytes).
  // ignore: non_constant_identifier_names
  Information get TiB => Information(toDouble(), InformationUnit.tebibyte);

  /// Creates an [Information] instance representing this value in Pebibytes (PiB, IEC: 2⁵⁰ bytes).
  // ignore: non_constant_identifier_names
  Information get PiB => Information(toDouble(), InformationUnit.pebibyte);
}
