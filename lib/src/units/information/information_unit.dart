import 'package:meta/meta.dart';

import '../../core/unit.dart';
import 'information_factors.dart';

/// Represents units of digital information.
///
/// This enum implements the [LinearUnit] interface to provide conversion capabilities
/// and a display [symbol] for each information unit.
/// All conversion factors are pre-calculated in the constructor relative to Bit.
///
/// Three distinct tracks are supported:
/// - **SI bit** (`kbit`, `Mbit`, `Gbit`, `Tbit`, `Pbit`, `Ebit`, `Zbit`, `Ybit`) — powers of 10³, counting bits.
/// - **SI / decimal byte** (`kB`, `MB`, `GB`, `TB`, `PB`, `EB`, `ZB`, `YB`) — powers of 10³, counting bytes.
/// - **IEC / binary** (`KiB`, `MiB`, `GiB`, `TiB`, `PiB`, `EiB`, `ZiB`, `YiB`) — powers of 2¹⁰ (1 024).
enum InformationUnit implements LinearUnit<InformationUnit> {
  /// Bit (bit), the fundamental unit of digital information.
  bit(1, 'bit'),

  /// Byte (B), equal to 8 bits.
  byte(InformationFactors.bitsPerByte, 'B'),

  // --- SI / Decimal bit units ---

  /// Kilobit (kbit), SI decimal unit equal to 1 000 bits.
  kilobit(InformationFactors.bitsPerKilobit, 'kbit'),

  /// Megabit (Mbit), SI decimal unit equal to 10⁶ bits.
  megabit(InformationFactors.bitsPerMegabit, 'Mbit'),

  /// Gigabit (Gbit), SI decimal unit equal to 10⁹ bits.
  gigabit(InformationFactors.bitsPerGigabit, 'Gbit'),

  /// Terabit (Tbit), SI decimal unit equal to 10¹² bits.
  terabit(InformationFactors.bitsPerTerabit, 'Tbit'),

  /// Petabit (Pbit), SI decimal unit equal to 10¹⁵ bits.
  petabit(InformationFactors.bitsPerPetabit, 'Pbit'),

  /// Exabit (Ebit), SI decimal unit equal to 10¹⁸ bits.
  exabit(InformationFactors.bitsPerExabit, 'Ebit'),

  /// Zettabit (Zbit), SI decimal unit equal to 10²¹ bits.
  zettabit(InformationFactors.bitsPerZettabit, 'Zbit'),

  /// Yottabit (Ybit), SI decimal unit equal to 10²⁴ bits.
  yottabit(InformationFactors.bitsPerYottabit, 'Ybit'),

  // --- SI / Decimal byte units ---

  /// Kilobyte (kB), SI decimal unit equal to 1 000 bytes (8 000 bits).
  kilobyte(InformationFactors.bitsPerKilobyte, 'kB'),

  /// Megabyte (MB), SI decimal unit equal to 10⁶ bytes.
  megabyte(InformationFactors.bitsPerMegabyte, 'MB'),

  /// Gigabyte (GB), SI decimal unit equal to 10⁹ bytes.
  gigabyte(InformationFactors.bitsPerGigabyte, 'GB'),

  /// Terabyte (TB), SI decimal unit equal to 10¹² bytes.
  terabyte(InformationFactors.bitsPerTerabyte, 'TB'),

  /// Petabyte (PB), SI decimal unit equal to 10¹⁵ bytes.
  petabyte(InformationFactors.bitsPerPetabyte, 'PB'),

  /// Exabyte (EB), SI decimal unit equal to 10¹⁸ bytes.
  exabyte(InformationFactors.bitsPerExabyte, 'EB'),

  /// Zettabyte (ZB), SI decimal unit equal to 10²¹ bytes.
  zettabyte(InformationFactors.bitsPerZettabyte, 'ZB'),

  /// Yottabyte (YB), SI decimal unit equal to 10²⁴ bytes.
  yottabyte(InformationFactors.bitsPerYottabyte, 'YB'),

  // --- IEC / Binary ---

  /// Kibibyte (KiB), IEC binary unit equal to 2¹⁰ bytes (1 024 bytes).
  kibibyte(InformationFactors.bitsPerKibibyte, 'KiB'),

  /// Mebibyte (MiB), IEC binary unit equal to 2²⁰ bytes (1 048 576 bytes).
  mebibyte(InformationFactors.bitsPerMebibyte, 'MiB'),

  /// Gibibyte (GiB), IEC binary unit equal to 2³⁰ bytes.
  gibibyte(InformationFactors.bitsPerGibibyte, 'GiB'),

  /// Tebibyte (TiB), IEC binary unit equal to 2⁴⁰ bytes.
  tebibyte(InformationFactors.bitsPerTebibyte, 'TiB'),

  /// Pebibyte (PiB), IEC binary unit equal to 2⁵⁰ bytes.
  pebibyte(InformationFactors.bitsPerPebibyte, 'PiB'),

  /// Exbibyte (EiB), IEC binary unit equal to 2⁶⁰ bytes.
  exbibyte(InformationFactors.bitsPerExbibyte, 'EiB'),

  /// Zebibyte (ZiB), IEC binary unit equal to 2⁷⁰ bytes.
  zebibyte(InformationFactors.bitsPerZebibyte, 'ZiB'),

  /// Yobibyte (YiB), IEC binary unit equal to 2⁸⁰ bytes.
  yobibyte(InformationFactors.bitsPerYobibyte, 'YiB');

  /// Constant constructor for enum members.
  ///
  /// [toBaseFactor] is the factor to convert from this unit to the base unit (Bit).
  /// [symbol] is the display symbol for the unit.
  ///
  /// The constructor pre-calculates all direct conversion factors
  /// from this unit to every other [InformationUnit].
  /// The formula `factor_A_to_B = _toBaseFactor_A / _toBaseFactor_B` is used.
  const InformationUnit(double toBaseFactor, this.symbol)
      : _toBitFactor = toBaseFactor,
        _factorToBit = toBaseFactor / 1,
        _factorToByte = toBaseFactor / InformationFactors.bitsPerByte,
        // SI bit units
        _factorToKilobit = toBaseFactor / InformationFactors.bitsPerKilobit,
        _factorToMegabit = toBaseFactor / InformationFactors.bitsPerMegabit,
        _factorToGigabit = toBaseFactor / InformationFactors.bitsPerGigabit,
        _factorToTerabit = toBaseFactor / InformationFactors.bitsPerTerabit,
        // SI byte units
        _factorToKilobyte = toBaseFactor / InformationFactors.bitsPerKilobyte,
        _factorToMegabyte = toBaseFactor / InformationFactors.bitsPerMegabyte,
        _factorToGigabyte = toBaseFactor / InformationFactors.bitsPerGigabyte,
        _factorToTerabyte = toBaseFactor / InformationFactors.bitsPerTerabyte,
        _factorToPetabyte = toBaseFactor / InformationFactors.bitsPerPetabyte,
        _factorToExabyte = toBaseFactor / InformationFactors.bitsPerExabyte,
        _factorToZettabyte = toBaseFactor / InformationFactors.bitsPerZettabyte,
        _factorToYottabyte = toBaseFactor / InformationFactors.bitsPerYottabyte,
        // SI bit units (extended)
        _factorToPetabit = toBaseFactor / InformationFactors.bitsPerPetabit,
        _factorToExabit = toBaseFactor / InformationFactors.bitsPerExabit,
        _factorToZettabit = toBaseFactor / InformationFactors.bitsPerZettabit,
        _factorToYottabit = toBaseFactor / InformationFactors.bitsPerYottabit,
        // IEC binary units
        _factorToKibibyte = toBaseFactor / InformationFactors.bitsPerKibibyte,
        _factorToMebibyte = toBaseFactor / InformationFactors.bitsPerMebibyte,
        _factorToGibibyte = toBaseFactor / InformationFactors.bitsPerGibibyte,
        _factorToTebibyte = toBaseFactor / InformationFactors.bitsPerTebibyte,
        _factorToPebibyte = toBaseFactor / InformationFactors.bitsPerPebibyte,
        _factorToExbibyte = toBaseFactor / InformationFactors.bitsPerExbibyte,
        _factorToZebibyte = toBaseFactor / InformationFactors.bitsPerZebibyte,
        _factorToYobibyte = toBaseFactor / InformationFactors.bitsPerYobibyte;

  /// The factor to convert a value from this unit to the base unit (Bit).
  // ignore: unused_field
  final double _toBitFactor;

  /// The human-readable symbol for this information unit (e.g., "bit", "B", "KiB").
  @override
  final String symbol;

  // --- Pre-calculated direct conversion factors from this unit to all others ---
  final double _factorToBit;
  final double _factorToByte;
  // SI bit units
  final double _factorToKilobit;
  final double _factorToMegabit;
  final double _factorToGigabit;
  final double _factorToTerabit;
  // SI bit units (extended)
  final double _factorToPetabit;
  final double _factorToExabit;
  final double _factorToZettabit;
  final double _factorToYottabit;
  // SI byte units
  final double _factorToKilobyte;
  final double _factorToMegabyte;
  final double _factorToGigabyte;
  final double _factorToTerabyte;
  final double _factorToPetabyte;
  final double _factorToExabyte;
  final double _factorToZettabyte;
  final double _factorToYottabyte;
  // IEC binary units
  final double _factorToKibibyte;
  final double _factorToMebibyte;
  final double _factorToGibibyte;
  final double _factorToTebibyte;
  final double _factorToPebibyte;
  final double _factorToExbibyte;
  final double _factorToZebibyte;
  final double _factorToYobibyte;

  /// SI and IEC symbols matched **strictly case-sensitive**.
  ///
  /// This is critical: `'b'` (bit) ≠ `'B'` (byte), `'mb'` (megabit) ≠ `'MB'` (megabyte).
  /// No case folding is applied during lookup to prevent silent 8x magnitude errors.
  /// Mixed-case typos like 'mB' or 'Mb' will be safely rejected.
  ///
  /// Used by `Information.parser`.
  @internal
  static const Map<String, InformationUnit> symbolAliases = {
    // --- Base Units ---
    'bit': InformationUnit.bit,
    'b': InformationUnit.bit, // strict lowercase b = bit
    'B': InformationUnit.byte, // strict uppercase B = byte

    // --- SI Bit Units (powers of 1000) ---
    'kbit': InformationUnit.kilobit,
    'kb': InformationUnit.kilobit,
    'Mbit': InformationUnit.megabit,
    'mb': InformationUnit.megabit,
    'Gbit': InformationUnit.gigabit,
    'gb': InformationUnit.gigabit,
    'Tbit': InformationUnit.terabit,
    'tb': InformationUnit.terabit,
    'Pbit': InformationUnit.petabit,
    'pb': InformationUnit.petabit,
    'Ebit': InformationUnit.exabit,
    'eb': InformationUnit.exabit,
    'Zbit': InformationUnit.zettabit,
    'zb': InformationUnit.zettabit,
    'Ybit': InformationUnit.yottabit,
    'yb': InformationUnit.yottabit,

    // --- SI / Decimal Byte Units (powers of 1000) ---
    'kB': InformationUnit.kilobyte,
    'KB': InformationUnit.kilobyte, // Legacy abbreviation, mapped to SI kilobyte
    'MB': InformationUnit.megabyte,
    'GB': InformationUnit.gigabyte,
    'TB': InformationUnit.terabyte,
    'PB': InformationUnit.petabyte,
    'EB': InformationUnit.exabyte,
    'ZB': InformationUnit.zettabyte,
    'YB': InformationUnit.yottabyte,

    // --- IEC Binary Byte Units (powers of 1024) ---
    'KiB': InformationUnit.kibibyte,
    'MiB': InformationUnit.mebibyte,
    'GiB': InformationUnit.gibibyte,
    'TiB': InformationUnit.tebibyte,
    'PiB': InformationUnit.pebibyte,
    'EiB': InformationUnit.exbibyte,
    'ZiB': InformationUnit.zebibyte,
    'YiB': InformationUnit.yobibyte,

    // --- IEC Binary Byte Units (lowercase linter-friendly aliases) ---
    'kib': InformationUnit.kibibyte,
    'mib': InformationUnit.mebibyte,
    'gib': InformationUnit.gibibyte,
    'tib': InformationUnit.tebibyte,
    'pib': InformationUnit.pebibyte,
    'eib': InformationUnit.exbibyte,
    'zib': InformationUnit.zebibyte,
    'yib': InformationUnit.yobibyte,
  };

  /// Full word-form names matched **case-insensitively**
  /// (after `.toLowerCase()` and whitespace normalization).
  ///
  /// Note: Absolutely NO short symbols (like 'kb' or 'mb') are included here.
  /// If they were, an ambiguous string like "Mb" would fall back to this map,
  /// be converted to "mb", and silently match megabit.
  ///
  /// Used by `Information.parser`.
  @internal
  static const Map<String, InformationUnit> nameAliases = {
    // --- Base Units ---
    'bit': InformationUnit.bit,
    'bits': InformationUnit.bit,
    'byte': InformationUnit.byte,
    'bytes': InformationUnit.byte,

    // --- SI Bit Units ---
    'kilobit': InformationUnit.kilobit,
    'kilobits': InformationUnit.kilobit,
    'megabit': InformationUnit.megabit,
    'megabits': InformationUnit.megabit,
    'gigabit': InformationUnit.gigabit,
    'gigabits': InformationUnit.gigabit,
    'terabit': InformationUnit.terabit,
    'terabits': InformationUnit.terabit,
    'petabit': InformationUnit.petabit,
    'petabits': InformationUnit.petabit,
    'exabit': InformationUnit.exabit,
    'exabits': InformationUnit.exabit,
    'zettabit': InformationUnit.zettabit,
    'zettabits': InformationUnit.zettabit,
    'yottabit': InformationUnit.yottabit,
    'yottabits': InformationUnit.yottabit,

    // --- SI / Decimal Byte Units ---
    'kilobyte': InformationUnit.kilobyte,
    'kilobytes': InformationUnit.kilobyte,
    'megabyte': InformationUnit.megabyte,
    'megabytes': InformationUnit.megabyte,
    'gigabyte': InformationUnit.gigabyte,
    'gigabytes': InformationUnit.gigabyte,
    'terabyte': InformationUnit.terabyte,
    'terabytes': InformationUnit.terabyte,
    'petabyte': InformationUnit.petabyte,
    'petabytes': InformationUnit.petabyte,
    'exabyte': InformationUnit.exabyte,
    'exabytes': InformationUnit.exabyte,
    'zettabyte': InformationUnit.zettabyte,
    'zettabytes': InformationUnit.zettabyte,
    'yottabyte': InformationUnit.yottabyte,
    'yottabytes': InformationUnit.yottabyte,

    // --- IEC / Binary Byte Units ---
    'kibibyte': InformationUnit.kibibyte,
    'kibibytes': InformationUnit.kibibyte,
    'mebibyte': InformationUnit.mebibyte,
    'mebibytes': InformationUnit.mebibyte,
    'gibibyte': InformationUnit.gibibyte,
    'gibibytes': InformationUnit.gibibyte,
    'tebibyte': InformationUnit.tebibyte,
    'tebibytes': InformationUnit.tebibyte,
    'pebibyte': InformationUnit.pebibyte,
    'pebibytes': InformationUnit.pebibyte,
    'exbibyte': InformationUnit.exbibyte,
    'exbibytes': InformationUnit.exbibyte,
    'zebibyte': InformationUnit.zebibyte,
    'zebibytes': InformationUnit.zebibyte,
    'yobibyte': InformationUnit.yobibyte,
    'yobibytes': InformationUnit.yobibyte,
  };

  /// Returns the direct conversion factor to convert a value from this [InformationUnit]
  /// to the [targetUnit].
  @override
  @internal
  double factorTo(InformationUnit targetUnit) {
    switch (targetUnit) {
      case InformationUnit.bit:
        return _factorToBit;
      case InformationUnit.byte:
        return _factorToByte;
      // SI bit units
      case InformationUnit.kilobit:
        return _factorToKilobit;
      case InformationUnit.megabit:
        return _factorToMegabit;
      case InformationUnit.gigabit:
        return _factorToGigabit;
      case InformationUnit.terabit:
        return _factorToTerabit;
      case InformationUnit.petabit:
        return _factorToPetabit;
      case InformationUnit.exabit:
        return _factorToExabit;
      case InformationUnit.zettabit:
        return _factorToZettabit;
      case InformationUnit.yottabit:
        return _factorToYottabit;
      // SI byte units
      case InformationUnit.kilobyte:
        return _factorToKilobyte;
      case InformationUnit.megabyte:
        return _factorToMegabyte;
      case InformationUnit.gigabyte:
        return _factorToGigabyte;
      case InformationUnit.terabyte:
        return _factorToTerabyte;
      case InformationUnit.petabyte:
        return _factorToPetabyte;
      case InformationUnit.exabyte:
        return _factorToExabyte;
      case InformationUnit.zettabyte:
        return _factorToZettabyte;
      case InformationUnit.yottabyte:
        return _factorToYottabyte;
      // IEC binary units
      case InformationUnit.kibibyte:
        return _factorToKibibyte;
      case InformationUnit.mebibyte:
        return _factorToMebibyte;
      case InformationUnit.gibibyte:
        return _factorToGibibyte;
      case InformationUnit.tebibyte:
        return _factorToTebibyte;
      case InformationUnit.pebibyte:
        return _factorToPebibyte;
      case InformationUnit.exbibyte:
        return _factorToExbibyte;
      case InformationUnit.zebibyte:
        return _factorToZebibyte;
      case InformationUnit.yobibyte:
        return _factorToYobibyte;
    }
  }
}
