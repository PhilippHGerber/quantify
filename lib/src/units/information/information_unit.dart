import 'package:meta/meta.dart';

import '../../core/unit.dart';
import 'information_factors.dart';

/// Represents units of digital information.
///
/// This enum implements the [Unit] interface to provide conversion capabilities
/// and a display [symbol] for each information unit.
/// All conversion factors are pre-calculated in the constructor relative to Bit.
///
/// Two distinct tracks are supported:
/// - **SI / decimal** (`kB`, `MB`, `GB`, …) — powers of 10³.
/// - **IEC / binary** (`KiB`, `MiB`, `GiB`, …) — powers of 2¹⁰ (1 024).
enum InformationUnit implements Unit<InformationUnit> {
  /// Bit (bit), the fundamental unit of digital information.
  bit(1, 'bit'),

  /// Byte (B), equal to 8 bits.
  byte(InformationFactors.bitsPerByte, 'B'),

  // --- SI / Decimal ---

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
  pebibyte(InformationFactors.bitsPerPebibyte, 'PiB');

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
        _factorToKilobyte = toBaseFactor / InformationFactors.bitsPerKilobyte,
        _factorToMegabyte = toBaseFactor / InformationFactors.bitsPerMegabyte,
        _factorToGigabyte = toBaseFactor / InformationFactors.bitsPerGigabyte,
        _factorToTerabyte = toBaseFactor / InformationFactors.bitsPerTerabyte,
        _factorToPetabyte = toBaseFactor / InformationFactors.bitsPerPetabyte,
        _factorToKibibyte = toBaseFactor / InformationFactors.bitsPerKibibyte,
        _factorToMebibyte = toBaseFactor / InformationFactors.bitsPerMebibyte,
        _factorToGibibyte = toBaseFactor / InformationFactors.bitsPerGibibyte,
        _factorToTebibyte = toBaseFactor / InformationFactors.bitsPerTebibyte,
        _factorToPebibyte = toBaseFactor / InformationFactors.bitsPerPebibyte;

  /// The factor to convert a value from this unit to the base unit (Bit).
  // ignore: unused_field
  final double _toBitFactor;

  /// The human-readable symbol for this information unit (e.g., "bit", "B", "KiB").
  @override
  final String symbol;

  // --- Pre-calculated direct conversion factors from this unit to all others ---
  final double _factorToBit;
  final double _factorToByte;
  final double _factorToKilobyte;
  final double _factorToMegabyte;
  final double _factorToGigabyte;
  final double _factorToTerabyte;
  final double _factorToPetabyte;
  final double _factorToKibibyte;
  final double _factorToMebibyte;
  final double _factorToGibibyte;
  final double _factorToTebibyte;
  final double _factorToPebibyte;

  /// SI and IEC symbols matched **strictly case-sensitive**.
  ///
  /// This is critical: `'b'` (bit) ≠ `'B'` (byte), `'kB'` (kilobyte) ≠ `'KiB'` (kibibyte).
  /// No case folding is applied during lookup.
  ///
  /// Used by `Information.parser`.
  @internal
  static const Map<String, InformationUnit> symbolAliases = {
    // bit
    'bit': InformationUnit.bit,
    'b': InformationUnit.bit, // lowercase b = bit
    // byte
    'B': InformationUnit.byte, // uppercase B = byte
    // SI / decimal
    'kB': InformationUnit.kilobyte,
    // 'KB' is an ambiguous legacy form — resolves to SI kilobyte (kB).
    // Use 'KiB' for the IEC binary kibibyte.
    'KB': InformationUnit.kilobyte,
    'MB': InformationUnit.megabyte,
    'GB': InformationUnit.gigabyte,
    'TB': InformationUnit.terabyte,
    'PB': InformationUnit.petabyte,
    // IEC / binary
    'KiB': InformationUnit.kibibyte,
    'MiB': InformationUnit.mebibyte,
    'GiB': InformationUnit.gibibyte,
    'TiB': InformationUnit.tebibyte,
    'PiB': InformationUnit.pebibyte,
  };

  /// Full word-form names matched **case-insensitively**
  /// (after `.toLowerCase()` and whitespace normalization).
  ///
  /// Used by `Information.parser`.
  @internal
  static const Map<String, InformationUnit> nameAliases = {
    // bit
    'bit': InformationUnit.bit,
    'bits': InformationUnit.bit,
    // byte
    'byte': InformationUnit.byte,
    'bytes': InformationUnit.byte,
    // SI / decimal
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
    // IEC / binary
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
    }
  }
}
