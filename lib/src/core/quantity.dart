import 'package:intl/intl.dart';
import 'package:meta/meta.dart';

import 'unit.dart';

/// An abstract representation of a physical quantity, encapsulating a numerical
/// [value] and a specific [unit] of measurement.
///
/// This class serves as the foundation for all specific quantity types (e.g., `Length`,
/// `Pressure`, `Temperature`). It enforces a common interface for unit conversions,
/// comparisons, and string formatting.
///
/// ## Immutability
/// `Quantity` objects are immutable. Operations that might seem to modify a quantity,
/// such as unit conversion (`convertTo`) or arithmetic, always return a new `Quantity`
/// instance with the updated value or unit, leaving the original instance unchanged.
/// This promotes safer and more predictable code.
///
/// ## Type Parameter `T`
/// The type parameter `T` represents the specific `Unit` enum associated with this
/// quantity type. For example, a `Pressure` quantity would use `PressureUnit` for `T`,
/// so it would be declared as `class Pressure extends Quantity<PressureUnit>`.
///
/// ## Comparison
/// `Quantity` implements `Comparable<Quantity<T>>`, allowing quantities of the
/// same type (e.g., two `Length` objects) to be compared based on their physical
/// magnitude, even if their internal units differ. The `compareTo` method handles
/// necessary conversions for accurate comparison.
@immutable
abstract class Quantity<T extends Unit<T>> implements Comparable<Quantity<T>> {
  /// Creates a new `Quantity` with a given numerical [value] and its corresponding [unit].
  ///
  /// Subclasses will typically call this constructor via `super(value, unit)`.
  ///
  /// - [_value]: The numerical magnitude of the quantity.
  /// - [_unit]: The unit of measurement for the `_value`.
  const Quantity(this._value, this._unit);

  /// The internal numerical value of this quantity, represented as a [double].
  /// This value is always in the context of the original [_unit] it was created with.
  final double _value;

  /// The internal unit of measurement for this quantity's [_value].
  /// This is an instance of the specific `Unit` enum `T`.
  final T _unit;

  /// Returns the numerical value of this quantity in its original [unit].
  ///
  /// Example:
  /// ```dart
  /// final length = Length(10.5, LengthUnit.meter);
  /// print(length.value); // Output: 10.5
  /// ```
  double get value => _value;

  /// Returns the unit of measurement associated with this quantity's original [value].
  ///
  /// Example:
  /// ```dart
  /// final length = Length(10.5, LengthUnit.meter);
  /// print(length.unit); // Output: LengthUnit.meter
  /// ```
  T get unit => _unit;

  /// Converts this quantity's [value] to the specified [targetUnit] and
  /// returns the numerical result of this conversion.
  ///
  /// This method must be implemented by concrete subclasses.
  ///
  /// For most quantities, this involves a direct multiplication by a conversion
  /// factor obtained from `this.unit.factorTo(targetUnit)`. Subclasses like
  /// Temperature override this to implement specific conversion formulas
  /// (e.g., for affine transformations).
  ///
  /// - [targetUnit]: The desired unit to which the current quantity's value
  ///   should be converted.
  ///
  /// Returns the numerical value of this quantity expressed in the [targetUnit].
  ///
  /// Example:
  /// ```dart
  /// final lengthInMeters = Length(1.0, LengthUnit.kilometer);
  /// double meters = lengthInMeters.getValue(LengthUnit.meter); // meters will be 1000.0
  ///
  /// final tempInCelsius = Temperature(0.0, TemperatureUnit.celsius);
  /// double fahrenheit = tempInCelsius.getValue(TemperatureUnit.fahrenheit); // fahrenheit will be 32.0
  /// ```
  double getValue(T targetUnit);

  /// Creates a new `Quantity` instance of the same type, with its value
  /// converted to the specified [targetUnit].
  ///
  /// This method must be implemented by concrete subclasses.
  /// It should utilize `getValue(targetUnit)` to get the numerical value in the
  /// target unit and then construct a new instance of the concrete quantity type.
  ///
  /// This is useful for obtaining a new `Quantity` object in a different unit
  /// while preserving the type information and immutability.
  ///
  /// - [targetUnit]: The desired unit for the new `Quantity` instance.
  ///
  /// Returns a new `Quantity` instance representing the same physical magnitude
  /// as this instance, but expressed in the [targetUnit]. If `targetUnit` is
  /// the same as `this.unit`, this method might return `this` instance directly
  /// as an optimization, since `Quantity` objects are immutable.
  ///
  /// Example:
  /// ```dart
  /// final lengthInKm = Length(1.5, LengthUnit.kilometer);
  /// final lengthInMeters = lengthInKm.convertTo(LengthUnit.meter);
  /// // lengthInMeters is now Length(1500.0, LengthUnit.meter)
  ///
  /// final tempInC = Temperature(20.0, TemperatureUnit.celsius);
  /// final tempInF = tempInC.convertTo(TemperatureUnit.fahrenheit);
  /// // tempInF is now Temperature(68.0, TemperatureUnit.fahrenheit)
  /// ```
  Quantity<T> convertTo(T targetUnit);

  /// Compares this quantity to another [Quantity] of the same type (`T`).
  ///
  /// This method must be implemented by concrete subclasses.
  /// The comparison is based on the physical magnitude of the quantities.
  /// To achieve this, one quantity (or both) might need to be converted to a
  /// common unit before their numerical values are compared. A common strategy
  /// is to convert `this.value` to `other.unit` using `getValue(other.unit)`
  /// and then compare the result with `other.value`.
  ///
  /// Returns:
  /// - A negative integer if this quantity is less than [other].
  /// - Zero if this quantity is equal in magnitude to [other].
  /// - A positive integer if this quantity is greater than [other].
  ///
  /// This method is essential for sorting collections of `Quantity` objects.
  @override
  int compareTo(Quantity<T> other);

  /// Returns a string representation of this quantity, with options for
  /// formatting and unit conversion.
  ///
  /// By default, it formats as `"[value] [unit_symbol]"` (e.g., "10.5 m"),
  /// using the quantity's current value and unit symbol, separated by a
  /// non-breaking space. Number formatting defaults to Dart's `double.toString()`.
  ///
  /// ## Parameters:
  ///
  /// - [targetUnit]: (Optional) If provided, the quantity's value will be
  ///   converted to this unit *before* formatting. The displayed unit symbol
  ///   will also be that of [targetUnit].
  ///   Example: `1.km.toString(targetUnit: LengthUnit.meter)` might produce "1000.0 m".
  ///
  /// - [fractionDigits]: (Optional) If provided and [numberFormat] is `null`,
  ///   the numerical value will be formatted to this fixed number of decimal places.
  ///   If [locale] is also provided, formatting attempts to respect it for decimal
  ///   and grouping separators (using `NumberFormat.decimalPatternDigits`).
  ///   Otherwise, `double.toStringAsFixed()` is used (locale-agnostic, uses '.' as decimal separator).
  ///   Example: `1.2345.m.toString(fractionDigits: 2)` might produce "1.23 m".
  ///
  /// - [showUnitSymbol]: (Optional) Defaults to `true`. If `false`, only the
  ///   numerical value (potentially converted and formatted) is returned, without
  ///   the unit symbol and separator.
  ///   Example: `10.m.toString(showUnitSymbol: false)` produces "10.0".
  ///
  /// - [unitSymbolSeparator]: (Optional) The string used to separate the formatted
  ///   numerical value and the unit symbol. Defaults to a non-breaking space (`'\u00A0'`).
  ///   Example: `10.m.toString(unitSymbolSeparator: "-")` produces "10.0-m".
  ///
  /// - [locale]: (Optional) A BCP 47 language tag (e.g., 'en_US', 'de_DE').
  ///   If provided and [numberFormat] is `null`, this locale is used for number
  ///   formatting (via `package:intl`). This affects decimal separators, grouping
  ///   separators, etc. Requires the `intl` package to be available.
  ///   Example: `1234.56.m.toString(locale: 'de_DE', fractionDigits: 1)` might produce "1234,6 m".
  ///
  /// - [numberFormat]: (Optional) An explicit `intl.NumberFormat` instance.
  ///   If provided, this takes precedence over [fractionDigits] and [locale] for
  ///   number formatting, offering maximum control. Requires the `intl` package.
  ///   Example:
  ///   ```dart
  ///   final customFormat = NumberFormat("#,##0.000", "en_US");
  ///   print(1234.5.m.toString(numberFormat: customFormat)); // "1,234.500 m"
  ///   ```
  ///
  /// Returns a string representation of the quantity according to the specified options.
  @override
  String toString({
    T? targetUnit,
    int? fractionDigits,
    bool showUnitSymbol = true,
    String unitSymbolSeparator = '\u00A0', // Default: Non-breaking space
    String? locale,
    NumberFormat? numberFormat,
  }) {
    var valueToFormat = _value;
    var unitToDisplay = _unit;

    // Step 1: Convert to target unit if specified.
    // If a target unit is provided and it's different from the current unit,
    // get the value in the target unit for formatting.
    if (targetUnit != null && targetUnit != _unit) {
      valueToFormat = getValue(targetUnit);
      unitToDisplay = targetUnit;
    }

    // Step 2: Format the numerical value.
    String formattedValue;

    if (numberFormat != null) {
      // If an explicit NumberFormat is provided, use it directly. This offers the most control.
      formattedValue = numberFormat.format(valueToFormat);
    } else {
      // Otherwise, use fractionDigits and/or locale if provided.
      if (locale != null) {
        // A locale is specified.
        if (fractionDigits != null) {
          // Both locale and fractionDigits: Use NumberFormat.decimalPatternDigits
          // for locale-aware fixed fraction digits.
          final nf = NumberFormat.decimalPatternDigits(
            locale: locale,
            decimalDigits: fractionDigits,
          );
          formattedValue = nf.format(valueToFormat);
        } else {
          // Locale provided, but no specific fractionDigits: Use a default decimal pattern for the locale.
          final nf = NumberFormat.decimalPattern(locale);
          formattedValue = nf.format(valueToFormat);
        }
      } else {
        // No locale and no explicit NumberFormat. Use Dart's built-in formatting.
        if (fractionDigits != null) {
          // Only fractionDigits provided: Use Dart's toStringAsFixed.
          // This is NOT locale-aware (always uses '.' as decimal separator).
          formattedValue = valueToFormat.toStringAsFixed(fractionDigits);
        } else {
          // No formatting options: Default double to string conversion.
          formattedValue = valueToFormat.toString();
        }
      }
    }

    // Step 3: Construct the final string.
    if (showUnitSymbol) {
      // Append the unit symbol (from unitToDisplay, which is targetUnit if conversion occurred)
      // and the specified separator.
      return '$formattedValue$unitSymbolSeparator${unitToDisplay.symbol}';
    } else {
      // Return only the formatted numerical value.
      return formattedValue;
    }
  }

  /// Determines whether this [Quantity] is equal to another [Object].
  ///
  /// Two `Quantity` instances are considered equal if they are:
  /// 1. The same instance (identical).
  /// 2. Of the exact same runtime type (e.g., both `Length`, not one `Length` and one `Pressure`).
  /// 3. Have the same numerical [value].
  /// 4. Have the same [unit].
  ///
  /// This means `1.m` is NOT equal to `100.cm` according to `==`, because their
  /// units differ, even though their physical magnitudes are the same.
  /// For magnitude comparison, use `compareTo()` or convert to a common unit first.
  ///
  /// - [other]: The object to compare against.
  ///
  /// Returns `true` if the objects are equal based on the criteria above, `false` otherwise.
  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is Quantity<T> &&
        runtimeType == other.runtimeType &&
        _value == other._value &&
        _unit == other._unit;
  }

  /// Checks if this quantity has the same physical magnitude as another.
  ///
  /// This method performs a unit-agnostic comparison. For example,
  /// `1.m.isEquivalentTo(100.cm)` will return `true`.
  ///
  /// Internally, this is equivalent to `this.compareTo(other) == 0` and relies on
  /// standard `double` equality. This means it can be sensitive to minute
  /// floating-point inaccuracies that may arise from arithmetic operations.
  ///
  /// For example, `(0.1.m + 0.2.m).isEquivalentTo(0.3.m)` might return `false`
  /// due to the nature of floating-point representation.
  ///
  /// Returns `true` if the physical magnitudes are exactly equal, `false` otherwise.
  bool isEquivalentTo(Quantity<T> other) => compareTo(other) == 0;

  /// Checks if this quantity's magnitude is greater than another's.
  ///
  /// Returns `true` if [compareTo]\([other]) > 0. Cross-unit comparisons are
  /// handled correctly; see [compareTo] for conversion semantics.
  bool operator >(Quantity<T> other) => compareTo(other) > 0;

  /// Checks if this quantity's magnitude is less than another's.
  ///
  /// Returns `true` if [compareTo]\([other]) < 0. Cross-unit comparisons are
  /// handled correctly; see [compareTo] for conversion semantics.
  bool operator <(Quantity<T> other) => compareTo(other) < 0;

  /// Checks if this quantity's magnitude is greater than or equal to another's.
  ///
  /// Returns `true` if [compareTo]\([other]) >= 0. Cross-unit comparisons are
  /// handled correctly; see [compareTo] for conversion semantics.
  bool operator >=(Quantity<T> other) => compareTo(other) >= 0;

  /// Checks if this quantity's magnitude is less than or equal to another's.
  ///
  /// Returns `true` if [compareTo]\([other]) <= 0. Cross-unit comparisons are
  /// handled correctly; see [compareTo] for conversion semantics.
  bool operator <=(Quantity<T> other) => compareTo(other) <= 0;

  /// Returns a hash code for this `Quantity` instance.
  ///
  /// The hash code is generated based on the [runtimeType], the numerical [_value],
  /// and the [_unit]. This is consistent with the `operator ==` implementation:
  /// if two `Quantity` objects are equal according to `==`, they will have the
  /// same hash code.
  @override
  int get hashCode => Object.hash(runtimeType, _value, _unit);
}
