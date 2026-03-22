import 'package:meta/meta.dart';

import 'quantity.dart';
import 'unit.dart';

/// An abstract base class for physical quantities with linear (factor-based) unit conversions.
///
/// Extends [Quantity] with a generic implementation of arithmetic operators
/// (`+`, `-`, `*`, `/`) and [convertTo], eliminating the need to reimplement
/// these in every concrete quantity class.
///
/// ## F-Bounded Polymorphism
/// The type parameter `Q` is bound to the concrete subclass itself, enabling
/// operators to return the exact subclass type rather than the abstract base type:
/// ```dart
/// final a = 10.m;
/// final b = 5.m;
/// final c = a + b; // c is Length, not Quantity<LengthUnit>
/// ```
///
/// ## Implementing a new linear quantity
/// Concrete subclasses must implement [create], which acts as a factory:
/// ```dart
/// class Length extends LinearQuantity<LengthUnit, Length> {
///   const Length(super._value, super._unit);
///
///   @override
///   @protected
///   Length create(double value, LengthUnit unit) => Length(value, unit);
/// }
/// ```
@immutable
abstract class LinearQuantity<T extends Unit<T>, Q extends LinearQuantity<T, Q>>
    extends Quantity<T> {
  /// Creates a new [LinearQuantity] with the given [value] and [unit].
  const LinearQuantity(super._value, super._unit);

  /// Factory that creates a new instance of the concrete subtype [Q].
  ///
  /// This is the sole extension point for generic arithmetic and conversion.
  /// Subclasses must implement this to return `Q(value, unit)`.
  @protected
  Q create(double value, T unit);

  /// Creates a new [Q] instance with the value converted to [targetUnit].
  ///
  /// Returns `this` (cast to [Q]) if [targetUnit] equals the current unit,
  /// avoiding an unnecessary allocation.
  @override
  Q convertTo(T targetUnit) {
    if (targetUnit == unit) return this as Q;
    return create(getValue(targetUnit), targetUnit);
  }

  /// Adds [other] to this quantity.
  ///
  /// [other] is converted to this quantity's unit before addition.
  /// Returns a new [Q] in this quantity's unit.
  Q operator +(Q other) => create(value + other.getValue(unit), unit);

  /// Subtracts [other] from this quantity.
  ///
  /// [other] is converted to this quantity's unit before subtraction.
  /// Returns a new [Q] in this quantity's unit.
  Q operator -(Q other) => create(value - other.getValue(unit), unit);

  /// Multiplies this quantity by a dimensionless [scalar].
  ///
  /// Returns a new [Q] with the scaled value in the original unit.
  Q operator *(double scalar) => create(value * scalar, unit);

  /// Divides this quantity by a dimensionless [scalar].
  ///
  /// Returns a new [Q] with the scaled value in the original unit.
  /// Returns `Q(double.infinity, unit)` if [scalar] is zero (IEEE 754 semantics).
  Q operator /(double scalar) => create(value / scalar, unit);
}
