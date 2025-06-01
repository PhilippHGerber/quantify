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
abstract class Quantity<T extends Unit<T>> {
  /// Creates a new quantity with a given [value] and [unit].
  ///
  /// Example: `Pressure(1013.25, PressureUnit.mbar)`
  const Quantity(this._value, this._unit);
  final double _value;
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
  /// For `Temperature` quantities, this method implements specific, optimized
  /// formulas to handle affine conversions (which include offsets).
  double getValue(T targetUnit);

  /// Returns a string representation of this quantity,
  /// typically in the format: "[value] [unit_symbol]".
  ///
  /// Example: "10.5 psi" or "25.0 °C"
  @override
  String toString() {
    // Use the symbol from the unit for a concise representation.
    // Format the double value to a reasonable number of decimal places,
    // or use a more sophisticated formatting if needed later.
    return '${_value.toStringAsFixed(4)} ${unit.symbol}'; // Using unit.symbol
  }

  /// Indicates whether some other object is "equal to" this one.
  ///
  /// Two quantities are considered equal if they are of the same runtime type,
  /// have the same [unit], and the same [value].
  ///
  /// This class is annotated with `@immutable`, so overriding `==` and
  /// `hashCode` is appropriate.
  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is Quantity<T> &&
        runtimeType == other.runtimeType &&
        _value == other._value &&
        _unit == other._unit;
  }

  /// Returns a hash code for this quantity.
  ///
  /// The hash code is based on the [runtimeType], [value], and [unit].
  /// This class is annotated with `@immutable`.
  @override
  int get hashCode => Object.hash(runtimeType, _value, _unit);
}
