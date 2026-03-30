import 'package:meta/meta.dart';

import '../../../quantify.dart' show QuantityParseException;
import '../../../torque.dart';
import '../../core/linear_quantity.dart';
import '../../core/quantity_format.dart';
import '../../core/quantity_parse_exception.dart' show QuantityParseException;
import '../../core/quantity_parser.dart';
import '../force/force.dart';
import '../force/force_extensions.dart';
import '../force/force_unit.dart';
import '../length/length.dart';
import '../length/length_extensions.dart';
import '../length/length_unit.dart';

/// Represents a quantity of torque (rotational moment).
///
/// Torque is a measure of the rotational force applied about an axis.
/// The SI derived unit is the Newton-meter (N·m). This class provides a
/// type-safe way to handle torque values and conversions between different units
/// (e.g., N·m, lbf·ft, kgf·m, ozf·in).
///
/// **Note on dimensional equivalence:** Torque and energy are dimensionally
/// identical (both have SI unit N·m = kg·m²/s²), but they are semantically
/// distinct physical quantities. Using separate types prevents accidental
/// assignment of an `Energy` value where a [Torque] is expected, and vice versa.
///
/// ```dart
/// final engineTorque = Torque(450.0, TorqueUnit.newtonMeter);
/// final inPoundFeet = engineTorque.inPoundFeet; // ≈ 331.9 lbf·ft
/// ```
@immutable
final class Torque extends LinearQuantity<TorqueUnit, Torque> {
  /// Creates a new [Torque] quantity with the given numerical [value] and [unit].
  ///
  /// Example:
  /// ```dart
  /// final engineTorque = Torque(450.0, TorqueUnit.newtonMeter);
  /// final servoTorque  = Torque(55.0, TorqueUnit.ounceForceInch);
  /// final boltTorque   = Torque(25.0, TorqueUnit.poundFoot);
  /// ```
  const Torque(super._value, super._unit);

  /// Creates a [Torque] from a [force] and a [momentArm] length (τ = F × r).
  ///
  /// When the [force] and [momentArm] unit combination maps to a natural torque
  /// unit, the result preserves that unit and multiplies the raw values directly:
  ///
  /// | Force unit | Moment arm unit | Result unit |
  /// |---|---|---|
  /// | N  | mm | mN·m |
  /// | N  | m  | N·m  |
  /// | N  | km | kN·m |
  /// | kN | m  | kN·m |
  /// | kN | km | MN·m |
  /// | MN | m  | MN·m |
  /// | lbf | ft | lbf·ft |
  /// | lbf | in | lbf·in |
  /// | kgf | m  | kgf·m  |
  /// | dyn | cm | dyn·cm |
  ///
  /// All other combinations fall back to [TorqueUnit.newtonMeter] using SI values.
  ///
  /// **Note:** [TorqueUnit.ounceForceInch] cannot be produced by this factory
  /// because there is no ounce-force unit in [ForceUnit]. Create it directly:
  /// `Torque(value, TorqueUnit.ounceForceInch)` or via `value.ozfIn`.
  ///
  /// ```dart
  /// Torque.from(100.N, 0.3.m);    // 30.0 N·m
  /// Torque.from(200.N, 50.mm);    // 10000.0 mN·m  (= 10 N·m)
  /// Torque.from(50.lbf, 1.5.ft);  // 75.0 lbf·ft
  /// ```
  factory Torque.from(Force force, Length momentArm) {
    final target = _torqueUnitFor(force.unit, momentArm.unit);
    if (target != null) return Torque(force.value * momentArm.value, target);
    return Torque(force.inNewtons * momentArm.inM, TorqueUnit.newtonMeter);
  }

  /// Returns the moment-arm [Length] (in meters) for this torque applied by [force].
  ///
  /// Solves r = τ / F.
  ///
  /// Throws [ArgumentError] if [force] has a value of zero.
  ///
  /// ```dart
  /// final torque = 100.Nm;
  /// final arm = torque.momentArmFor(50.N); // 2.0 m
  /// ```
  Length momentArmFor(Force force) {
    if (force.value == 0) {
      throw ArgumentError.value(force, 'force', 'Force must be non-zero to compute a moment arm.');
    }
    return Length(inNewtonMeters / force.inNewtons, LengthUnit.meter);
  }

  /// Returns the [Force] (in Newtons) needed to produce this torque at [momentArm].
  ///
  /// Solves F = τ / r.
  ///
  /// Throws [ArgumentError] if [momentArm] has a value of zero.
  ///
  /// ```dart
  /// final torque = 100.Nm;
  /// final force = torque.forceAt(0.5.m); // 200.0 N
  /// ```
  Force forceAt(Length momentArm) {
    if (momentArm.value == 0) {
      throw ArgumentError.value(
        momentArm,
        'momentArm',
        'Moment arm must be non-zero to compute a force.',
      );
    }
    return Force(inNewtonMeters / momentArm.inM, ForceUnit.newton);
  }

  /// Maps a [ForceUnit] × [LengthUnit] pair to its natural [TorqueUnit].
  ///
  /// Returns `null` for combinations that have no natural torque unit,
  /// causing [Torque.from] to fall back to SI (N·m).
  static TorqueUnit? _torqueUnitFor(ForceUnit f, LengthUnit l) => switch ((f, l)) {
        (ForceUnit.newton, LengthUnit.millimeter) => TorqueUnit.millinewtonMeter,
        (ForceUnit.newton, LengthUnit.meter) => TorqueUnit.newtonMeter,
        (ForceUnit.newton, LengthUnit.kilometer) => TorqueUnit.kilonewtonMeter,
        (ForceUnit.kilonewton, LengthUnit.meter) => TorqueUnit.kilonewtonMeter,
        (ForceUnit.kilonewton, LengthUnit.kilometer) => TorqueUnit.meganewtonMeter,
        (ForceUnit.meganewton, LengthUnit.meter) => TorqueUnit.meganewtonMeter,
        (ForceUnit.poundForce, LengthUnit.foot) => TorqueUnit.poundFoot,
        (ForceUnit.poundForce, LengthUnit.inch) => TorqueUnit.poundInch,
        (ForceUnit.kilogramForce, LengthUnit.meter) => TorqueUnit.kilogramForceMeter,
        (ForceUnit.dyne, LengthUnit.centimeter) => TorqueUnit.dyneCentimeter,
        _ => null,
      };

  @override
  @protected
  Torque create(double value, TorqueUnit unit) => Torque(value, unit);

  /// The parser instance used to convert strings into [Torque] objects.
  ///
  /// Supports all standard units including SI symbols (with middle dot `·` or
  /// ASCII `.`), imperial symbols, and full word-form names.
  static final QuantityParser<TorqueUnit, Torque> parser = QuantityParser<TorqueUnit, Torque>(
    symbolAliases: TorqueUnit.symbolAliases,
    nameAliases: TorqueUnit.nameAliases,
    factory: Torque.new,
  );

  /// Parses a string representation of torque into a [Torque] object.
  ///
  /// Throws [QuantityParseException] if parsing fails.
  ///
  /// Example:
  /// ```dart
  /// final t1 = Torque.parse('100 N·m');       // 100 newton-meters
  /// final t2 = Torque.parse('35.5 lbf·ft');   // 35.5 pound-force-feet
  /// final t3 = Torque.parse('9 kgf·m');       // 9 kilogram-force-meters
  /// ```
  static Torque parse(
    String input, {
    List<QuantityFormat> formats = const [QuantityFormat.invariant],
  }) {
    return parser.parse(input, formats: formats);
  }

  /// Attempts to parse a string representation of torque. Returns `null` if parsing fails.
  ///
  /// Example:
  /// ```dart
  /// final valid   = Torque.tryParse('100 N·m');   // Torque(100.0, TorqueUnit.newtonMeter)
  /// final invalid = Torque.tryParse('invalid');    // null
  /// ```
  static Torque? tryParse(
    String input, {
    List<QuantityFormat> formats = const [QuantityFormat.invariant],
  }) {
    return parser.tryParse(input, formats: formats);
  }
}
