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

  /// Returns `true` if this unit is part of the International System of Units (SI).
  /// if the unit is SI derived, this will return `true` only for the base unit of that dimension.
  bool get isSI;

  /// Returns whether this unit is part of the metric system.
  ///
  /// This includes SI base units, SI derived units, and decimal multiples or
  /// submultiples of SI units (e.g. metre, pascal, millimetre).
  ///
  /// This does **not** indicate whether a unit is *accepted for use with* the
  /// metric system. Degree (°), minute (min), hour (h), day (d), litre (L)
  /// and tonne (t) are accepted for use with the SI but are **not** metric by
  /// this definition.
  ///
  /// A compound unit is metric only if every factor is metric (e.g. km/h is
  /// not metric because it contains the hour).
  bool get isMetric;
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
