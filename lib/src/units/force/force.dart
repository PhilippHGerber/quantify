import 'package:meta/meta.dart';

import '../../../quantify.dart' show QuantityParseException;
import '../../constants/physical_constants.dart';
import '../../core/linear_quantity.dart';
import '../../core/quantity_format.dart';
import '../../core/quantity_parse_exception.dart' show QuantityParseException;
import '../../core/quantity_parser.dart';
import '../acceleration/acceleration.dart';
import '../acceleration/acceleration_extensions.dart';
import '../acceleration/acceleration_unit.dart';
import '../area/area.dart';
import '../area/area_extensions.dart';
import '../area/area_unit.dart';
import '../mass/mass.dart';
import '../mass/mass_extensions.dart';
import '../mass/mass_unit.dart';
import '../pressure/pressure.dart';
import '../pressure/pressure_extensions.dart';
import '../pressure/pressure_unit.dart';
import 'force_unit.dart';

/// Represents a quantity of force.
///
/// Force is a derived quantity representing an influence that can change the
/// motion of an object. The SI derived unit is the Newton (N), which is
/// defined as `kg·m/s²`.
@immutable
class Force extends LinearQuantity<ForceUnit, Force> {
  /// Creates a new `Force` with a given [value] and [unit].
  const Force(super._value, super._unit);

  /// Creates a `Force` from [mass] and [acceleration] (F = m × a).
  ///
  /// If the combination of [mass]'s unit and [acceleration]'s unit matches a
  /// standard force unit (e.g. kg + m/s² → N, g + cm/s² → dyn), the result
  /// uses that unit. Otherwise the result is in [ForceUnit.newton].
  ///
  /// ```dart
  /// Force.from(10.kg, 2.mPerS2);    // 20.0 N
  /// Force.from(5.g, 3.0.cmpss);     // 15.0 dyn
  /// ```
  factory Force.from(Mass mass, Acceleration acceleration) {
    final target = _correspondingForceUnit(mass.unit, acceleration.unit);
    if (target != null) {
      return Force(mass.value * acceleration.value, target);
    }
    return Force(mass.inKilograms * acceleration.inMetersPerSecondSquared, ForceUnit.newton);
  }

  /// Creates a [Force] representing the weight of a [Mass] under a given
  /// [gravity] (F = m × g).
  ///
  /// Defaults to [PhysicalConstants.standardGravity] (9.80665 m/s²). Always
  /// returns newtons because standard gravity is defined in SI units.
  ///
  /// ```dart
  /// final weightOnEarth = Force.fromMass(10.kg);
  /// final weightOnMoon  = Force.fromMass(10.kg, gravity: 1.625.mPerS2);
  /// ```
  factory Force.fromMass(Mass mass, {Acceleration? gravity}) {
    return Force.from(mass, gravity ?? PhysicalConstants.standardGravity);
  }

  /// Creates a [Force] from [Pressure] and [Area] (F = P × A).
  ///
  /// If [pressure]'s unit has a natural force counterpart (Pa → N, kPa → kN,
  /// psi → lbf), the result uses that unit and [area] is converted to the
  /// matching area unit. Otherwise the result is in [ForceUnit.newton].
  ///
  /// ```dart
  /// Force.fromPressure(200.Pa, 0.5.m2);   // 100.0 N
  /// Force.fromPressure(200.kPa, 0.5.m2);  // 100.0 kN
  /// Force.fromPressure(30.psi, 2.0.in2);  // 60.0 lbf
  /// ```
  factory Force.fromPressure(Pressure pressure, Area area) {
    final target = _correspondingForceUnitFromPressure(pressure.unit);
    final areaUnit = _embeddedAreaUnitForPressure(pressure.unit);
    if (target != null && areaUnit != null) {
      return Force(pressure.value * area.getValue(areaUnit), target);
    }
    return Force(pressure.inPa * area.inSquareMeters, ForceUnit.newton);
  }

  /// Maps a [MassUnit] × [AccelerationUnit] pair to its natural [ForceUnit].
  static ForceUnit? _correspondingForceUnit(MassUnit m, AccelerationUnit a) => switch ((m, a)) {
        (MassUnit.kilogram, AccelerationUnit.meterPerSecondSquared) => ForceUnit.newton,
        (MassUnit.gram, AccelerationUnit.centimeterPerSecondSquared) => ForceUnit.dyne,
        _ => null,
      };

  /// Maps a [PressureUnit] to the implied [ForceUnit] when computing F = P × A.
  static ForceUnit? _correspondingForceUnitFromPressure(PressureUnit p) => switch (p) {
        PressureUnit.pascal => ForceUnit.newton,
        PressureUnit.kilopascal => ForceUnit.kilonewton,
        PressureUnit.psi => ForceUnit.poundForce,
        _ => null,
      };

  /// Maps a [PressureUnit] to the [AreaUnit] component embedded in its definition.
  static AreaUnit? _embeddedAreaUnitForPressure(PressureUnit p) => switch (p) {
        PressureUnit.pascal => AreaUnit.squareMeter,
        PressureUnit.kilopascal => AreaUnit.squareMeter,
        PressureUnit.psi => AreaUnit.squareInch,
        _ => null,
      };

  @override
  @protected
  Force create(double value, ForceUnit unit) => Force(value, unit);

  /// The parser instance used to convert strings into [Force] objects.
  ///
  /// The parser supports all standard units including symbols and full names.
  static final QuantityParser<ForceUnit, Force> parser = QuantityParser<ForceUnit, Force>(
    symbolAliases: ForceUnit.symbolAliases,
    nameAliases: ForceUnit.nameAliases,
    factory: Force.new,
  );

  /// Parses a string representation of a force into a [Force] object.
  ///
  /// Throws [QuantityParseException] if parsing fails.
  ///
  /// Example:
  /// ```dart
  /// final f1 = Force.parse('100 N');   // 100 newtons
  /// final f2 = Force.parse('5 kN');    // 5 kilonewtons
  /// final f3 = Force.parse('50 lbf');  // 50 pounds-force
  /// ```
  static Force parse(
    String input, {
    List<QuantityFormat> formats = const [QuantityFormat.invariant],
  }) {
    return parser.parse(input, formats: formats);
  }

  /// Attempts to parse a string representation of force. Returns `null` if parsing fails.
  ///
  /// Example:
  /// ```dart
  /// final valid = Force.tryParse('10 newtons');  // Force(10.0, ForceUnit.newton)
  /// final invalid = Force.tryParse('invalid');   // null
  /// ```
  static Force? tryParse(
    String input, {
    List<QuantityFormat> formats = const [QuantityFormat.invariant],
  }) {
    return parser.tryParse(input, formats: formats);
  }

  // --- Dimensional Analysis ---

  /// Calculates the [Acceleration] of a given [Mass] when this force is applied (a = F / m).
  ///
  /// If [mass] is zero, the result follows IEEE 754 semantics: a non-zero force
  /// yields [double.infinity] and a zero force yields [double.nan].
  /// The result is returned as an `Acceleration` quantity in m/s².
  ///
  /// Example:
  /// ```dart
  /// final force = 100.N;
  /// final mass = 10.kg;
  /// final resultingAcceleration = force.accelerationOf(mass);
  /// print(resultingAcceleration.inMetersPerSecondSquared); // Output: 10.0
  /// ```
  Acceleration accelerationOf(Mass mass) {
    final newtons = getValue(ForceUnit.newton);
    final kg = mass.inKilograms;
    return Acceleration(newtons / kg, AccelerationUnit.meterPerSecondSquared);
  }

  /// Calculates the [Mass] that would be accelerated at a given [Acceleration] by this force (m = F / a).
  ///
  /// If [acceleration] is zero, the result follows IEEE 754 semantics: a non-zero
  /// force yields [double.infinity] and a zero force yields [double.nan].
  /// The result is returned as a `Mass` quantity in kilograms.
  ///
  /// Example:
  /// ```dart
  /// final force = 20.N;
  /// final acceleration = 1.gravity; // ~9.8 m/s²
  /// final requiredMass = force.massFrom(acceleration);
  /// print(requiredMass.inKilograms); // Output: ~2.04
  /// ```
  Mass massFrom(Acceleration acceleration) {
    final newtons = getValue(ForceUnit.newton);
    final mpss = acceleration.inMetersPerSecondSquared;
    return Mass(newtons / mpss, MassUnit.kilogram);
  }
}
