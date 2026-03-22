import 'package:meta/meta.dart';

import '../../core/linear_quantity.dart';
import '../../core/quantity_format.dart';
import '../../core/quantity_parser.dart';
import 'molar_unit.dart';

/// Represents a quantity of amount of substance, typically measured in moles.
///
/// The amount of substance is a measure of the number of elementary entities
/// (such as atoms, molecules, ions, or electrons) in a sample. The SI base unit
/// for amount of substance is the Mole (mol).
///
/// This class provides a type-safe way to handle molar amount values and
/// conversions between different units (e.g., moles, millimoles, kilomoles).
/// It is fundamental in chemistry and related fields.
@immutable
class MolarAmount extends LinearQuantity<MolarUnit, MolarAmount> {
  /// Creates a new `MolarAmount` quantity with the given numerical [value] and [unit].
  ///
  /// Example:
  /// ```dart
  /// final glucoseSample = MolarAmount(0.5, MolarUnit.mole);
  /// final reagentAmount = MolarAmount(25.0, MolarUnit.millimole);
  /// ```
  const MolarAmount(super._value, super._unit);

  @override
  @protected
  MolarAmount create(double value, MolarUnit unit) => MolarAmount(value, unit);

  /// The parser instance used to convert strings into [MolarAmount] objects.
  ///
  /// The parser supports both strict symbol aliases and case-insensitive name
  /// aliases configured in [MolarUnit].
  static final QuantityParser<MolarUnit, MolarAmount> parser =
      QuantityParser<MolarUnit, MolarAmount>(
    symbolAliases: MolarUnit.symbolAliases,
    nameAliases: MolarUnit.nameAliases,
    factory: MolarAmount.new,
  );

  /// Parses a string representation of amount of substance into a
  /// [MolarAmount] object.
  ///
  /// The [formats] list controls how the numeric portion is interpreted.
  static MolarAmount parse(
    String input, {
    List<QuantityFormat> formats = const [QuantityFormat.invariant],
  }) {
    return parser.parse(input, formats: formats);
  }

  /// Parses a string representation of amount of substance into a
  /// [MolarAmount] object, returning `null` when parsing fails.
  ///
  /// See [parse] for formatting and matching behavior.
  static MolarAmount? tryParse(
    String input, {
    List<QuantityFormat> formats = const [QuantityFormat.invariant],
  }) {
    return parser.tryParse(input, formats: formats);
  }

  // Potential future enhancements for MolarAmount:
  // - MolarAmount / Volume = MolarConcentration (would require Volume and MolarConcentration types)
  // - Mass / MolarAmount = MolarMass (would require Mass and MolarMass types or a way to handle compound units)
}
