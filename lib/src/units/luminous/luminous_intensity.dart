import 'package:meta/meta.dart';

import '../../core/linear_quantity.dart';
import '../../core/quantity_format.dart';
import '../../core/quantity_parser.dart';
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
class LuminousIntensity extends LinearQuantity<LuminousIntensityUnit, LuminousIntensity> {
  /// Creates a new `LuminousIntensity` quantity with the given numerical [value] and [unit].
  ///
  /// Example:
  /// ```dart
  /// final ledBrightness = LuminousIntensity(150.0, LuminousIntensityUnit.millicandela);
  /// final headlightIntensity = LuminousIntensity(800.0, LuminousIntensityUnit.candela);
  /// ```
  const LuminousIntensity(super._value, super._unit);

  @override
  @protected
  LuminousIntensity create(double value, LuminousIntensityUnit unit) =>
      LuminousIntensity(value, unit);

  /// The parser instance used to convert strings into [LuminousIntensity]
  /// objects.
  ///
  /// The parser supports both strict symbol aliases and case-insensitive name
  /// aliases configured in [LuminousIntensityUnit].
  static final QuantityParser<LuminousIntensityUnit, LuminousIntensity> parser =
      QuantityParser<LuminousIntensityUnit, LuminousIntensity>(
    symbolAliases: LuminousIntensityUnit.symbolAliases,
    nameAliases: LuminousIntensityUnit.nameAliases,
    factory: LuminousIntensity.new,
  );

  /// Parses a string representation of luminous intensity into a
  /// [LuminousIntensity] object.
  ///
  /// The [formats] list controls how the numeric portion is interpreted.
  static LuminousIntensity parse(
    String input, {
    List<QuantityFormat> formats = const [QuantityFormat.invariant],
  }) {
    return parser.parse(input, formats: formats);
  }

  /// Parses a string representation of luminous intensity into a
  /// [LuminousIntensity] object, returning `null` when parsing fails.
  ///
  /// See [parse] for formatting and matching behavior.
  static LuminousIntensity? tryParse(
    String input, {
    List<QuantityFormat> formats = const [QuantityFormat.invariant],
  }) {
    return parser.tryParse(input, formats: formats);
  }

  // Potential future enhancements:
  // - LuminousIntensity * SolidAngle = LuminousFlux (would require SolidAngle type or representation)
  // - LuminousIntensity / Area = Luminance (would require Area type)
}
