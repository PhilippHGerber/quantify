import 'package:meta/meta.dart';

import '../../core/quantity.dart';
import 'luminous_intensity_unit.dart';

/// Represents a quantity of luminous intensity.
///
/// Luminous intensity is a measure of the wavelength-weighted power emitted
/// by a light source in a particular direction per unit solid angle, based on
/// the luminosity function, a standardized model of the sensitivity of the
/// human eye. The SI base unit for luminous intensity is the Candela (cd).
///
/// This class provides a type-safe way to handle luminous intensity values and
/// conversions between different units (e.g., candelas, millicandelas).
@immutable
class LuminousIntensity extends Quantity<LuminousIntensityUnit> {
  /// Creates a new `LuminousIntensity` quantity with the given numerical [value] and [unit].
  ///
  /// Example:
  /// ```dart
  /// final ledBrightness = LuminousIntensity(150.0, LuminousIntensityUnit.millicandela);
  /// final headlightIntensity = LuminousIntensity(800.0, LuminousIntensityUnit.candela);
  /// ```
  const LuminousIntensity(super._value, super._unit);

  /// Converts this luminous intensity's value to the specified [targetUnit].
  ///
  /// This method uses pre-calculated direct conversion factors from the
  /// `LuminousIntensityUnit` enum for efficiency.
  ///
  /// Example:
  /// ```dart
  /// final intensityInCd = LuminousIntensity(0.5, LuminousIntensityUnit.candela);
  /// final valueInMcd = intensityInCd.getValue(LuminousIntensityUnit.millicandela); // 500.0
  /// ```
  @override
  double getValue(LuminousIntensityUnit targetUnit) {
    if (targetUnit == unit) return value;
    return value * unit.factorTo(targetUnit);
  }

  /// Creates a new [LuminousIntensity] instance with the value converted to the [targetUnit].
  ///
  /// Example:
  /// ```dart
  /// final intensityInMcd = LuminousIntensity(2500.0, LuminousIntensityUnit.millicandela);
  /// final intensityInCdObj = intensityInMcd.convertTo(LuminousIntensityUnit.candela);
  /// // intensityInCdObj is LuminousIntensity(2.5, LuminousIntensityUnit.candela)
  /// print(intensityInCdObj); // Output: "2.5 cd"
  /// ```
  @override
  LuminousIntensity convertTo(LuminousIntensityUnit targetUnit) {
    if (targetUnit == unit) return this;
    final newValue = getValue(targetUnit);
    return LuminousIntensity(newValue, targetUnit);
  }

  /// Compares this [LuminousIntensity] object to another [Quantity<LuminousIntensityUnit>].
  ///
  /// Comparison is based on the physical magnitude of the luminous intensities.
  ///
  /// Example:
  /// ```dart
  /// final li1 = LuminousIntensity(1.0, LuminousIntensityUnit.candela);      // 1000 mcd
  /// final li2 = LuminousIntensity(1000.0, LuminousIntensityUnit.millicandela); // 1000 mcd
  /// final li3 = LuminousIntensity(0.5, LuminousIntensityUnit.candela);     // 500 mcd
  ///
  /// print(li1.compareTo(li2)); // 0 (equal magnitude)
  /// print(li1.compareTo(li3)); // 1 (li1 > li3)
  /// ```
  @override
  int compareTo(Quantity<LuminousIntensityUnit> other) {
    final thisValueInOtherUnit = getValue(other.unit);
    return thisValueInOtherUnit.compareTo(other.value);
  }

  // --- Arithmetic Operators ---

  /// Adds this luminous intensity to another luminous intensity.
  ///
  /// This is physically meaningful if, for example, combining light from multiple
  /// sources in the same direction (though solid angle considerations can be complex).
  /// The [other] intensity is converted to the unit of this intensity before addition.
  ///
  /// Example:
  /// ```dart
  /// final sourceA = LuminousIntensity(100.0, LuminousIntensityUnit.candela);
  /// final sourceB = LuminousIntensity(50000.0, LuminousIntensityUnit.millicandela); // 50 cd
  /// final combinedIntensity = sourceA + sourceB; // Result: LuminousIntensity(150.0, LuminousIntensityUnit.candela)
  /// ```
  LuminousIntensity operator +(LuminousIntensity other) {
    final otherValueInThisUnit = other.getValue(unit);
    return LuminousIntensity(value + otherValueInThisUnit, unit);
  }

  /// Subtracts another luminous intensity from this luminous intensity.
  ///
  /// This could represent the reduction in intensity if one source is removed or shielded.
  /// The [other] intensity is converted to the unit of this intensity before subtraction.
  ///
  /// Example:
  /// ```dart
  /// final totalLight = LuminousIntensity(500.0, LuminousIntensityUnit.candela);
  /// final blockedLight = LuminousIntensity(150.0, LuminousIntensityUnit.candela);
  /// final remainingLight = totalLight - blockedLight; // Result: LuminousIntensity(350.0, LuminousIntensityUnit.candela)
  /// ```
  LuminousIntensity operator -(LuminousIntensity other) {
    final otherValueInThisUnit = other.getValue(unit);
    return LuminousIntensity(value - otherValueInThisUnit, unit);
  }

  /// Multiplies this luminous intensity by a scalar value (a dimensionless number).
  ///
  /// Example:
  /// ```dart
  /// final singleLed = LuminousIntensity(20.0, LuminousIntensityUnit.millicandela);
  /// final arrayBrightness = singleLed * 10.0; // Result: LuminousIntensity(200.0, LuminousIntensityUnit.millicandela)
  /// ```
  LuminousIntensity operator *(double scalar) {
    return LuminousIntensity(value * scalar, unit);
  }

  /// Divides this luminous intensity by a scalar value (a dimensionless number).
  ///
  /// Throws [ArgumentError] if the [scalar] is zero.
  ///
  /// Example:
  /// ```dart
  /// final totalOutput = LuminousIntensity(1000.0, LuminousIntensityUnit.candela);
  /// final outputPerSegment = totalOutput / 5.0; // Result: LuminousIntensity(200.0, LuminousIntensityUnit.candela)
  /// ```
  LuminousIntensity operator /(double scalar) {
    if (scalar == 0) {
      throw ArgumentError('Cannot divide by zero.');
    }
    return LuminousIntensity(value / scalar, unit);
  }

  // Potential future enhancements:
  // - LuminousIntensity * SolidAngle = LuminousFlux (would require SolidAngle type or representation)
  // - LuminousIntensity / Area = Luminance (would require Area type)
}
