import 'package:meta/meta.dart';

/// A contract for all unit enums.
///
/// Each unit enum (e.g., `PressureUnit`, `LengthUnit`) must implement this
/// interface to provide a way to get a conversion factor to another unit
/// of the same type.
///
/// [T] is the specific unit enum type itself (e.g., `PressureUnit`).
abstract class Unit<T extends Unit<T>> {
  /// Creates a [Unit].
  /// This constructor is used only by subclasses.
  const Unit();

  /// Returns the direct conversion factor to convert a value from this unit
  /// to the [targetUnit].
  ///
  /// The conversion is performed by multiplying the original value by this factor:
  /// `convertedValue = originalValue * this.factorTo(targetUnit);`
  @internal
  double factorTo(T targetUnit);

  /// A human-readable symbol or abbreviation for the unit.
  ///
  /// This should be a concise representation suitable for display.
  /// For example: "m" for Meter, "psi" for Pound per Square Inch, "°C" for Celsius.
  String get symbol;
}
