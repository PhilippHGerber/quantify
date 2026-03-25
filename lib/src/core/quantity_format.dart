import 'dart:collection';

import 'package:intl/intl.dart';
import 'package:meta/meta.dart';

/// Immutable configuration for formatting and parsing a `Quantity`'s
/// numerical value and unit symbol.
///
/// A single instance can be reused for both `Quantity.toString` and
/// `Quantity.parse`, guaranteeing format/parser symmetry.
///
/// **Performance note:** Locale-derived `NumberFormat` instances are cached
/// internally by locale and fraction-digits configuration. For maximum control
/// in hot loops, prefer [QuantityFormat.withNumberFormat].
@immutable
class QuantityFormat {
  /// Creates a [QuantityFormat] with the given configuration.
  ///
  /// Priority for number formatting:
  /// 1. [numberFormat] (if provided) — used as-is
  /// 2. [locale] (if provided) — uses cached locale-aware `NumberFormat`
  /// 3. Neither — Dart-native formatting (dot decimal, no thousands)
  const QuantityFormat({
    this.numberFormat,
    this.locale,
    this.fractionDigits,
    this.unitSymbolSeparator = '\u00A0',
    this.showUnitSymbol = true,
  });

  /// Quick constructor for locale-driven formatting.
  const QuantityFormat.forLocale(
    String locale, {
    int? fractionDigits,
    String unitSymbolSeparator = '\u00A0',
  }) : this(
          locale: locale,
          fractionDigits: fractionDigits,
          unitSymbolSeparator: unitSymbolSeparator,
        );

  /// Wraps an existing [NumberFormat] for maximum control and performance.
  ///
  /// Note: When providing a custom [NumberFormat], properties like
  /// `locale` and `fractionDigits` are managed directly by the formatter
  /// and are ignored by this configuration.
  ///
  /// Highly recommended for parsing inside tight loops to avoid repeated
  /// `NumberFormat` allocations:
  /// ```dart
  /// final csvFormat = QuantityFormat.withNumberFormat(
  ///   NumberFormat.decimalPattern('de_DE'),
  /// );
  /// for (final row in csv) {
  ///   final mass = Mass.tryParse(row, formats:[csvFormat]);
  /// }
  /// ```
  const QuantityFormat.withNumberFormat(
    this.numberFormat, {
    this.unitSymbolSeparator = '\u00A0',
    this.showUnitSymbol = true,
  })  : locale = null,
        fractionDigits = null;

  static final LinkedHashMap<String, NumberFormat> _localeFormatCache = LinkedHashMap();
  static const int _maxCacheSize = 100;

  /// The explicit [NumberFormat] to use for formatting and parsing.
  ///
  /// When provided, takes priority over [locale].
  final NumberFormat? numberFormat;

  /// The locale identifier (e.g. `'en_US'`, `'de_DE'`) for number formatting.
  ///
  /// Used only when [numberFormat] is `null`.
  final String? locale;

  /// The number of fraction digits to display.
  ///
  /// Combined with [locale] to create a locale-aware fixed-precision format.
  /// Without [locale], falls back to `toStringAsFixed`.
  final int? fractionDigits;

  /// The separator between the formatted number and the unit symbol.
  ///
  /// Defaults to a non-breaking space (`\u00A0`).
  final String unitSymbolSeparator;

  /// Whether to append the unit symbol to the formatted value.
  final bool showUnitSymbol;

  /// Resolves and returns the [NumberFormat] for this configuration.
  ///
  /// Priority: [numberFormat] → locale-aware → `null` (invariant).
  ///
  /// Locale-derived formatters are cached internally using an LRU (Least
  /// Recently Used) policy to avoid repeated heavy `intl` formatter
  /// allocations while protecting host memory.
  NumberFormat? get effectiveNumberFormat {
    if (numberFormat != null) return numberFormat;
    if (locale != null) {
      final cacheKey = '${locale!}|${fractionDigits?.toString() ?? 'null'}';

      // LRU Cache Hit: Remove and re-insert to move to the end (most recently used)
      if (_localeFormatCache.containsKey(cacheKey)) {
        final format = _localeFormatCache.remove(cacheKey)!;
        _localeFormatCache[cacheKey] = format;
        return format;
      }

      // LRU Cache Miss: Create the new format.
      // Resolve locale with a fallback chain:
      // requested locale -> current default locale -> en_US.
      // This preserves locale-aware behavior even when callers pass an invalid locale.
      final defaultVerifiedLocale = Intl.verifiedLocale(
        Intl.getCurrentLocale(),
        NumberFormat.localeExists,
        onFailure: (_) => 'en_US',
      )!;

      final verifiedLocale = Intl.verifiedLocale(
        locale,
        NumberFormat.localeExists,
        onFailure: (_) => defaultVerifiedLocale,
      )!;

      final format = fractionDigits != null
          ? NumberFormat.decimalPatternDigits(
              locale: verifiedLocale,
              decimalDigits: fractionDigits,
            )
          : NumberFormat.decimalPattern(verifiedLocale);

      _localeFormatCache[cacheKey] = format;

      // Evict the least recently used item (the first one) if we exceed the cap
      if (_localeFormatCache.length > _maxCacheSize) {
        _localeFormatCache.remove(_localeFormatCache.keys.first);
      }

      return format;
    }
    return null;
  }

  /// Dart-native formatting: dot decimal, no thousands separator.
  static const QuantityFormat invariant = QuantityFormat();

  /// Like [invariant] but omits the unit symbol (value only).
  static const QuantityFormat valueOnly = QuantityFormat(showUnitSymbol: false);

  /// US English locale (dot decimal, comma thousands).
  static const QuantityFormat enUs = QuantityFormat(locale: 'en_US');

  /// German locale (comma decimal, dot thousands).
  static const QuantityFormat de = QuantityFormat(locale: 'de_DE');

  /// Compact notation (e.g. "1.5K", "3.4M", "2.1G").
  ///
  /// Uses [NumberFormat.compact()] from the `intl` package. Useful for
  /// displaying large quantities in tight UI spaces.
  ///
  /// The instance is cached and automatically invalidated when
  /// [Intl.defaultLocale] changes, so the format always reflects the
  /// current locale without repeated heavy `NumberFormat` allocations.
  // Factory semantics aren't quite right
  // ignore: prefer_constructors_over_static_methods
  static QuantityFormat get compact {
    final effectiveLocale = Intl.defaultLocale ?? Intl.getCurrentLocale();
    if (_cachedCompact == null || _compactLocaleKey != effectiveLocale) {
      _compactLocaleKey = effectiveLocale;
      _cachedCompact = QuantityFormat.withNumberFormat(NumberFormat.compact());
    }
    return _cachedCompact!;
  }

  static String? _compactLocaleKey;
  static QuantityFormat? _cachedCompact;
}
