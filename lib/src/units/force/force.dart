import 'package:meta/meta.dart';

import '../../../quantify.dart' show QuantityParseException;
import '../../core/linear_quantity.dart';
import '../../core/quantity_format.dart';
import '../../core/quantity_parse_exception.dart' show QuantityParseException;
import '../../core/quantity_parser.dart';
import '../acceleration/acceleration.dart';
import '../acceleration/acceleration_extensions.dart';
import '../acceleration/acceleration_unit.dart';
import '../area/area.dart';
import '../area/area_extensions.dart';
import '../mass/mass.dart';
import '../mass/mass_extensions.dart';
import '../mass/mass_unit.dart';
import '../pressure/pressure.dart';
import '../pressure/pressure_extensions.dart';
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

  /// Creates a `Force` instance from `Mass` and `Acceleration` (F = m * a).
  ///
  /// This factory performs the dimensional calculation `Force = Mass × Acceleration`.
  /// It converts the inputs to their base SI units (kg and m/s²) for correctness.
  ///
  /// Example:
  /// ```dart
  /// final objectMass = 10.kg;
  /// final objectAcceleration = 2.mpsSquared;
  /// final requiredForce = Force.from(objectMass, objectAcceleration);
  /// print(requiredForce.inNewtons); // Output: 20.0
  /// ```
  factory Force.from(Mass mass, Acceleration acceleration) {
    final kg = mass.inKilograms;
    final mpss = acceleration.inMetersPerSecondSquared;
    return Force(kg * mpss, ForceUnit.newton);
  }

  /// Creates a [Force] quantity from [Pressure] and [Area] (F = P × A).
  ///
  /// Both inputs are converted to SI base units (pascals and square meters)
  /// before multiplying. The result is returned in newtons. This is the
  /// inverse of [Pressure.from].
  ///
  /// ```dart
  /// final pressure = 200.Pa;
  /// final area     = 0.5.m2;
  /// final force    = Force.fromPressure(pressure, area); // 100.0 N
  /// ```
  factory Force.fromPressure(Pressure pressure, Area area) =>
      Force(pressure.inPa * area.inSquareMeters, ForceUnit.newton);

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
