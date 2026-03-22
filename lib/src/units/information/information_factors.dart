// ignore_for_file: prefer_int_literals : all constants are doubles.

/// Defines base conversion factors for various information units relative to Bit.
///
/// These constants follow IEC 80000-13 (binary prefixes) and SI (decimal prefixes).
class InformationFactors {
  // The base unit for internal calculations is Bit.
  // Factors represent: 1 [Unit] = X [Bits]

  // --- SI / Decimal bit units ---

  /// Bits per Kilobit (SI): 1 kbit = 1 000 bits.
  static const double bitsPerKilobit = 1e3;

  /// Bits per Megabit (SI): 1 Mbit = 10⁶ bits.
  static const double bitsPerMegabit = 1e6;

  /// Bits per Gigabit (SI): 1 Gbit = 10⁹ bits.
  static const double bitsPerGigabit = 1e9;

  /// Bits per Terabit (SI): 1 Tbit = 10¹² bits.
  static const double bitsPerTerabit = 1e12;

  /// Bits per Petabit (SI): 1 Pbit = 10¹⁵ bits.
  static const double bitsPerPetabit = 1e15;

  /// Bits per Exabit (SI): 1 Ebit = 10¹⁸ bits.
  static const double bitsPerExabit = 1e18;

  /// Bits per Zettabit (SI): 1 Zbit = 10²¹ bits.
  static const double bitsPerZettabit = 1e21;

  /// Bits per Yottabit (SI): 1 Ybit = 10²⁴ bits.
  static const double bitsPerYottabit = 1e24;

  // --- SI / Decimal byte units ---

  /// Bits per Byte: 1 byte = 8 bits (exact).
  static const double bitsPerByte = 8.0;

  /// Bits per Kilobyte (SI): 1 kB = 1000 bytes = 8 000 bits.
  static const double bitsPerKilobyte = 8.0 * 1e3;

  /// Bits per Megabyte (SI): 1 MB = 1 000 000 bytes = 8 000 000 bits.
  static const double bitsPerMegabyte = 8.0 * 1e6;

  /// Bits per Gigabyte (SI): 1 GB = 10⁹ bytes = 8 × 10⁹ bits.
  static const double bitsPerGigabyte = 8.0 * 1e9;

  /// Bits per Terabyte (SI): 1 TB = 10¹² bytes = 8 × 10¹² bits.
  static const double bitsPerTerabyte = 8.0 * 1e12;

  /// Bits per Petabyte (SI): 1 PB = 10¹⁵ bytes = 8 × 10¹⁵ bits.
  static const double bitsPerPetabyte = 8.0 * 1e15;

  /// Bits per Exabyte (SI): 1 EB = 10¹⁸ bytes = 8 × 10¹⁸ bits.
  static const double bitsPerExabyte = 8.0 * 1e18;

  /// Bits per Zettabyte (SI): 1 ZB = 10²¹ bytes = 8 × 10²¹ bits.
  static const double bitsPerZettabyte = 8.0 * 1e21;

  /// Bits per Yottabyte (SI): 1 YB = 10²⁴ bytes = 8 × 10²⁴ bits.
  static const double bitsPerYottabyte = 8.0 * 1e24;

  // --- IEC / Binary units (powers of 1024) ---

  /// Bits per Kibibyte (IEC): 1 KiB = 2¹⁰ bytes = 8 192 bits.
  static const double bitsPerKibibyte = 8.0 * 1024.0;

  /// Bits per Mebibyte (IEC): 1 MiB = 2²⁰ bytes = 8 388 608 bits.
  static const double bitsPerMebibyte = 8.0 * 1024.0 * 1024.0;

  /// Bits per Gibibyte (IEC): 1 GiB = 2³⁰ bytes = 8 589 934 592 bits.
  static const double bitsPerGibibyte = 8.0 * 1024.0 * 1024.0 * 1024.0;

  /// Bits per Tebibyte (IEC): 1 TiB = 2⁴⁰ bytes = 8 796 093 022 208 bits.
  static const double bitsPerTebibyte = 8.0 * 1024.0 * 1024.0 * 1024.0 * 1024.0;

  /// Bits per Pebibyte (IEC): 1 PiB = 2⁵⁰ bytes = 9 007 199 254 740 992 bits.
  static const double bitsPerPebibyte = 8.0 * 1024.0 * 1024.0 * 1024.0 * 1024.0 * 1024.0;

  /// Bits per Exbibyte (IEC): 1 EiB = 2⁶⁰ bytes.
  static const double bitsPerExbibyte = bitsPerPebibyte * 1024.0;

  /// Bits per Zebibyte (IEC): 1 ZiB = 2⁷⁰ bytes.
  static const double bitsPerZebibyte = bitsPerExbibyte * 1024.0;

  /// Bits per Yobibyte (IEC): 1 YiB = 2⁸⁰ bytes.
  static const double bitsPerYobibyte = bitsPerZebibyte * 1024.0;
}
