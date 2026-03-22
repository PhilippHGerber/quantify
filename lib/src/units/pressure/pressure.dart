import 'package:meta/meta.dart';

import '../../core/linear_quantity.dart';
import '../../core/quantity_format.dart';
import '../../core/quantity_parser.dart';
import '../area/area.dart';
import '../area/area_extensions.dart';
import '../force/force.dart';
import '../force/force_extensions.dart';
import 'pressure_unit.dart';

/// Represents a quantity of pressure.
///
/// Pressure is a fundamental physical quantity, defined as force per unit area.
/// This class provides a type-safe way to handle pressure values and conversions
/// between different units of pressure.
@immutable
class Pressure extends LinearQuantity<PressureUnit, Pressure> {
  /// Creates a new Pressure quantity with the given [value] and [unit].
  ///
  /// Example:
  /// ```dart
  /// final standardAtmosphere = Pressure(1.0, PressureUnit.atmosphere);
  /// final tirePressure = Pressure(32.0, PressureUnit.psi);
  /// ```
  const Pressure(super._value, super._unit);

  /// Creates a [Pressure] quantity from [Force] and [Area] (P = F / A).
  ///
  /// Both inputs are converted to SI base units (newtons and square meters)
  /// before dividing. The result is returned in pascals.
  ///
  /// ```dart
  /// final force = 100.N;
  /// final area  = 0.5.m2;
  /// final pressure = Pressure.from(force, area); // 200.0 Pa
  /// ```
  factory Pressure.from(Force force, Area area) =>
      Pressure(force.inNewtons / area.inSquareMeters, PressureUnit.pascal);

  @override
  @protected
  Pressure create(double value, PressureUnit unit) => Pressure(value, unit);

  /// The parser instance used to convert strings into [Pressure] objects.
  ///
  /// The parser supports both strict symbol aliases and case-insensitive name
  /// aliases configured in [PressureUnit].
  static final QuantityParser<PressureUnit, Pressure> parser =
      QuantityParser<PressureUnit, Pressure>(
    symbolAliases: PressureUnit.symbolAliases,
    nameAliases: PressureUnit.nameAliases,
    factory: Pressure.new,
  );

  /// Parses a string representation of pressure into a [Pressure] object.
  ///
  /// The [formats] list controls how the numeric portion is interpreted.
  static Pressure parse(
    String input, {
    List<QuantityFormat> formats = const [QuantityFormat.invariant],
  }) {
    return parser.parse(input, formats: formats);
  }

  /// Parses a string representation of pressure into a [Pressure] object,
  /// returning `null` when parsing fails.
  ///
  /// See [parse] for formatting and matching behavior.
  static Pressure? tryParse(
    String input, {
    List<QuantityFormat> formats = const [QuantityFormat.invariant],
  }) {
    return parser.tryParse(input, formats: formats);
  }
}
