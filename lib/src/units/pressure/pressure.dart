import 'package:meta/meta.dart';

import '../../core/linear_quantity.dart';
import '../../core/quantity_format.dart';
import '../../core/quantity_parser.dart';
import '../area/area.dart';
import '../area/area_extensions.dart';
import '../area/area_unit.dart';
import '../force/force.dart';
import '../force/force_extensions.dart';
import '../force/force_unit.dart';
import 'pressure_unit.dart';

/// Represents a quantity of pressure.
///
/// Pressure is a fundamental physical quantity, defined as force per unit area.
/// This class provides a type-safe way to handle pressure values and conversions
/// between different units of pressure.
@immutable
final class Pressure extends LinearQuantity<PressureUnit, Pressure> {
  /// Creates a new Pressure quantity with the given [value] and [unit].
  ///
  /// Example:
  /// ```dart
  /// final standardAtmosphere = Pressure(1.0, PressureUnit.atmosphere);
  /// final tirePressure = Pressure(32.0, PressureUnit.psi);
  /// ```
  const Pressure(super._value, super._unit);

  /// Creates a [Pressure] from [force] and [area] (P = F / A).
  ///
  /// If the combination of [force]'s unit and [area]'s unit matches a standard
  /// pressure unit (N + m² → Pa, kN + m² → kPa, lbf + in² → psi), the result
  /// uses that unit. Otherwise the result is in [PressureUnit.pascal].
  ///
  /// ```dart
  /// Pressure.from(100.N, 0.5.m2);      // 200.0 Pa
  /// Pressure.from(100.kN, 0.5.m2);     // 200.0 kPa
  /// Pressure.from(60.lbf, 2.0.in2);    // 30.0 psi
  /// ```
  factory Pressure.from(Force force, Area area) {
    final target = _correspondingPressureUnit(force.unit, area.unit);
    if (target != null) return Pressure(force.value / area.value, target);
    return Pressure(force.inNewtons / area.inSquareMeters, PressureUnit.pascal);
  }

  /// Maps a [ForceUnit] × [AreaUnit] pair to its natural [PressureUnit].
  static PressureUnit? _correspondingPressureUnit(ForceUnit f, AreaUnit a) => switch ((f, a)) {
        (ForceUnit.newton, AreaUnit.squareMeter) => PressureUnit.pascal,
        (ForceUnit.kilonewton, AreaUnit.squareMeter) => PressureUnit.kilopascal,
        (ForceUnit.poundForce, AreaUnit.squareInch) => PressureUnit.psi,
        _ => null,
      };

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

  /// Calculates the [Area] over which a given [Force] is distributed to exert
  /// this pressure (A = F / P).
  ///
  /// The result's unit matches the area component of this pressure's unit:
  /// `Pa` (N/m²) → m², `kPa` (kN/m²) → m², `psi` (lbf/in²) → in².
  /// If the pressure is zero, the result follows IEEE 754 semantics.
  ///
  /// ```dart
  /// 100.Pa.areaFor(500.N);      // 5.0 m²
  /// 30.psi.areaFor(60.lbf);     // 2.0 in²
  /// ```
  Area areaFor(Force force) {
    final areaInM2 = force.inNewtons / getValue(PressureUnit.pascal);
    final targetUnit = _correspondingAreaUnit(unit);
    return Area(areaInM2 * AreaUnit.squareMeter.factorTo(targetUnit), targetUnit);
  }

  /// Maps a [PressureUnit] to the [AreaUnit] embedded in its definition.
  static AreaUnit _correspondingAreaUnit(PressureUnit p) => switch (p) {
        PressureUnit.psi => AreaUnit.squareInch,
        _ => AreaUnit.squareMeter, // pascal, kilopascal, atmosphere, bar, etc.
      };
}
