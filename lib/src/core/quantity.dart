import 'package:intl/intl.dart';
import 'package:meta/meta.dart';

import 'unit.dart';

/// An abstract representation of a physical quantity, consisting of a numerical
/// [value] and a specific [unit] of measurement.
///
/// This class is immutable. Operations that change the value or unit
/// (like conversions) will return a new `Quantity` instance.
///
/// [T] is the specific [Unit] enum type associated with this quantity
/// (e.g., `PressureUnit` for a `Pressure` quantity).
@immutable
abstract class Quantity<T extends Unit<T>> implements Comparable<Quantity<T>> {
  /// Creates a new quantity with a given [value] and [unit].
  const Quantity(this._value, this._unit);

  /// The numerical value of this quantity, represented as a double.
  final double _value;

  /// The unit of measurement for this quantity, represented as an instance of [T].
  final T _unit;

  /// The numerical value of this quantity in its original [unit].
  double get value => _value;

  /// The unit of measurement for this quantity's original [value].
  T get unit => _unit;

  /// Converts this quantity's [value] to the specified [targetUnit] and
  /// returns the numerical result.
  ///
  /// For most quantities, this involves a direct multiplication by a
  /// conversion factor obtained from `this.unit.factorTo(targetUnit)`.
  ///
  /// For most quantities, this involves a direct multiplication by a conversion factor.
  /// Subclasses like Temperature override this to implement specific conversion formulas
  /// (e.g., for affine transformations).
  double getValue(T targetUnit);

  /// Creates a new Quantity of the same type with the value converted to [targetUnit].
  Quantity<T> convertTo(T targetUnit);

  /// Compares this quantity to another, after converting them to a common unit.
  @override
  int compareTo(Quantity<T> other);

  /// Returns a string representation of this quantity.
  ///
  /// By default, it formats as "[value] [`unit_symbol`]", using the quantity's
  /// current value and unit with default number formatting.
  ///
  /// Optional parameters allow customization:
  /// - [targetUnit]: If provided, the quantity's value will be converted to this
  ///   unit before formatting. The displayed symbol will be that of [targetUnit].
  /// - [fractionDigits]: If provided and [numberFormat] is not, the numerical
  ///   value will be formatted to this fixed number of decimal places.
  ///   If [locale] is also provided, formatting attempts to respect it for separators.
  /// - [showUnitSymbol]: Defaults to `true`. If `false`, only the numerical
  ///   value (potentially converted and formatted) is returned.
  /// - [unitSymbolSeparator]: The string used to separate the value and the unit
  ///   symbol. Defaults to a non-breaking space: `'\u00A0'`.
  /// - [locale]: A BCP 47 language tag (e.g., 'en_US', 'de_DE').
  ///   If provided and [numberFormat] is not, this locale is used for number formatting,
  ///   affecting decimal separators and potentially grouping.
  /// - [numberFormat]: An explicit `intl.NumberFormat` instance.
  ///   If provided, this takes precedence over [fractionDigits] and [locale]
  ///   for number formatting, offering maximum control.
  @override
  String toString({
    T? targetUnit,
    int? fractionDigits,
    bool showUnitSymbol = true,
    String unitSymbolSeparator = '\u00A0', // Non-breaking space
    String? locale,
    NumberFormat? numberFormat,
  }) {
    var valueToFormat = _value;
    var unitToDisplay = _unit;

    // 1. Convert to target unit if specified
    // If a target unit is provided and it's different from the current unit,
    // get the value in the target unit.
    if (targetUnit != null && targetUnit != _unit) {
      valueToFormat = getValue(targetUnit);
      unitToDisplay = targetUnit;
    }

    // 2. Format the numerical value
    String formattedValue;

    if (numberFormat != null) {
      // If an explicit NumberFormat is provided, use it directly.
      formattedValue = numberFormat.format(valueToFormat);
    } else {
      // Otherwise, use fractionDigits and/or locale if provided.
      if (locale != null) {
        if (fractionDigits != null) {
          // Use NumberFormat.decimalPatternDigits for locale-aware fixed fraction digits.
          // This constructor handles both decimal digits and locale.
          final nf = NumberFormat.decimalPatternDigits(
            locale: locale,
            decimalDigits: fractionDigits,
          );
          formattedValue = nf.format(valueToFormat);
        } else {
          // Locale provided, but no specific fractionDigits. Use a default decimal pattern for the locale.
          final nf = NumberFormat.decimalPattern(locale);
          formattedValue = nf.format(valueToFormat);
        }
      } else {
        // No locale and no explicit NumberFormat. Use Dart's built-in formatting.
        if (fractionDigits != null) {
          // Standard Dart way to format to a fixed number of decimal places.
          // This is NOT locale-aware (always uses '.' as decimal separator).
          formattedValue = valueToFormat.toStringAsFixed(fractionDigits);
        } else {
          // Default double to string conversion.
          formattedValue = valueToFormat.toString();
        }
      }
    }

    // 3. Construct the final string
    if (showUnitSymbol) {
      // Append the unit symbol if requested.
      return '$formattedValue$unitSymbolSeparator${unitToDisplay.symbol}';
    } else {
      // Return only the formatted value.
      return formattedValue;
    }
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is Quantity<T> &&
        runtimeType == other.runtimeType &&
        _value == other._value &&
        _unit == other._unit;
  }

  @override
  int get hashCode => Object.hash(runtimeType, _value, _unit);
}
