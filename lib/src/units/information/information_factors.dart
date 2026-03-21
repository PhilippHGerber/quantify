// ignore_for_file: prefer_int_literals : all constants are doubles.

/// Defines base conversion factors for various information units relative to Bit.
///
/// These constants follow IEC 80000-13 (binary prefixes) and SI (decimal prefixes).
class InformationFactors {
  // The base unit for internal calculations is Bit.
  // Factors represent: 1 [Unit] = X [Bits]

  // --- SI / Decimal units ---

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
}
