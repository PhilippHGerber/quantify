import 'package:meta/meta.dart';

import 'quantity_format.dart';
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
  /// The default implementation uses a direct linear multiplication via
  /// `this.unit.factorTo(targetUnit)`, which is correct for all linear
  /// (non-affine) quantities. Non-linear quantities (e.g., `Temperature`)
  /// override this with their specific conversion formulas.
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
  double getValue(T targetUnit) {
    if (targetUnit == _unit) return _value;
    return _value * _unit.factorTo(targetUnit);
  }

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
  int compareTo(Quantity<T> other) => getValue(other.unit).compareTo(other.value);

  /// Returns a string representation of this quantity.
  ///
  /// By default, formats as `"[value]\u00A0[unit_symbol]"` (e.g., `"10.5\u00A0m"`),
  /// using Dart-native number formatting (dot decimal, no thousands separator).
  ///
  /// ## Parameters:
  ///
  /// - [targetUnit]: If provided, the value is converted to this unit before
  ///   formatting. The displayed symbol will be that of [targetUnit].
  ///
  /// - [format]: A [QuantityFormat] controlling number formatting, locale,
  ///   fraction digits, unit symbol visibility, and separator. Defaults to
  ///   [QuantityFormat.invariant].
  ///
  /// ## Examples:
  ///
  /// ```dart
  /// 1.km.toString(targetUnit: LengthUnit.meter)
  /// // "1000.0 m"
  ///
  /// 1234.56.m.toString(format: QuantityFormat.forLocale('de_DE', fractionDigits: 2))
  /// // "1.234,56 m"
  ///
  /// 10.m.toString(format: QuantityFormat.valueOnly)
  /// // "10.0"
  /// ```
  @override
  String toString({
    T? targetUnit,
    QuantityFormat format = QuantityFormat.invariant,
  }) {
    var valueToFormat = _value;
    var unitToDisplay = _unit;

    if (targetUnit != null && targetUnit != _unit) {
      valueToFormat = getValue(targetUnit);
      unitToDisplay = targetUnit;
    }

    String formattedValue;
    final nf = format.effectiveNumberFormat;

    if (nf != null) {
      formattedValue = nf.format(valueToFormat);
    } else if (format.fractionDigits != null) {
      formattedValue = valueToFormat.toStringAsFixed(format.fractionDigits!);
    } else {
      formattedValue = valueToFormat.toString();
    }

    if (format.showUnitSymbol) {
      return '$formattedValue${format.unitSymbolSeparator}${unitToDisplay.symbol}';
    }
    return formattedValue;
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
