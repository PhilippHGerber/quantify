import 'package:meta/meta.dart';

/// A base contract for all unit enums.
///
/// This interface guarantees that every unit has a display symbol.
///
/// [T] is the specific unit enum type itself (e.g., `PressureUnit`).
abstract class Unit<T extends Unit<T>> {
  /// Creates a [Unit].
  /// This constructor is used only by subclasses.
  const Unit();

  /// A human-readable symbol or abbreviation for the unit.
  String get symbol;
}

/// A contract for units that scale linearly (via a simple multiplier).
///
/// Most physical units (Length, Mass, Speed) are linear. Non-linear units
/// (like absolute Temperature) implement [Unit] directly instead.
abstract class LinearUnit<T extends LinearUnit<T>> extends Unit<T> {
  /// Creates a [LinearUnit].
  /// This constructor is used only by subclasses.
  const LinearUnit();

  /// Returns the direct conversion factor to convert a value from this unit
  /// to the [targetUnit].
  ///
  /// The conversion is performed by multiplying the original value by this factor:
  /// `convertedValue = originalValue * this.factorTo(targetUnit);`
  @internal
  double factorTo(T targetUnit);
}
