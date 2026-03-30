import 'package:meta/meta.dart';

import '../../core/linear_quantity.dart';
import '../../core/quantity_format.dart';
import '../../core/quantity_parser.dart';
import '../current/current.dart';
import '../current/current_extensions.dart';
import '../current/current_unit.dart';
import '../time/time.dart';
import '../time/time_extensions.dart';
import '../time/time_unit.dart';
import 'electric_charge_unit.dart';

/// Represents a quantity of electric charge.
///
/// Electric charge is a fundamental property of matter that causes it to experience
/// a force in an electromagnetic field. The SI derived unit is the Coulomb (C),
/// defined as the charge transported by a constant current of one ampere in one second.
@immutable
final class ElectricCharge extends LinearQuantity<ElectricChargeUnit, ElectricCharge> {
  /// Creates a new `ElectricCharge` with a given [value] and [unit].
  const ElectricCharge(super._value, super._unit);

  /// Creates an `ElectricCharge` from a `Current` flowing over a `Time` duration (Q = I * t).
  ///
  /// Example:
  /// ```dart
  /// final current = 2.A;
  /// final time = 1.h;
  /// final charge = ElectricCharge.from(current, time);
  /// print(charge.inAmpereHours); // Output: 2.0
  /// print(charge.inCoulombs); // Output: 7200.0
  /// ```
  factory ElectricCharge.from(Current current, Time time) {
    final amperes = current.inAmperes;
    final seconds = time.inSeconds;
    return ElectricCharge(amperes * seconds, ElectricChargeUnit.coulomb);
  }

  @override
  @protected
  ElectricCharge create(double value, ElectricChargeUnit unit) => ElectricCharge(value, unit);

  /// The parser instance used to convert strings into [ElectricCharge]
  /// objects.
  ///
  /// The parser supports both strict symbol aliases and case-insensitive name
  /// aliases configured in [ElectricChargeUnit].
  static final QuantityParser<ElectricChargeUnit, ElectricCharge> parser =
      QuantityParser<ElectricChargeUnit, ElectricCharge>(
    symbolAliases: ElectricChargeUnit.symbolAliases,
    nameAliases: ElectricChargeUnit.nameAliases,
    factory: ElectricCharge.new,
  );

  /// Parses a string representation of electric charge into an
  /// [ElectricCharge] object.
  ///
  /// The [formats] list controls how the numeric portion is interpreted.
  static ElectricCharge parse(
    String input, {
    List<QuantityFormat> formats = const [QuantityFormat.invariant],
  }) {
    return parser.parse(input, formats: formats);
  }

  /// Parses a string representation of electric charge into an
  /// [ElectricCharge] object, returning `null` when parsing fails.
  ///
  /// See [parse] for formatting and matching behavior.
  static ElectricCharge? tryParse(
    String input, {
    List<QuantityFormat> formats = const [QuantityFormat.invariant],
  }) {
    return parser.tryParse(input, formats: formats);
  }

  /// Calculates the `Current` if this charge flows over a given `Time` (I = Q / t).
  ///
  /// If [time] is zero, the result follows IEEE 754 semantics: a non-zero charge
  /// yields [double.infinity] and a zero charge yields [double.nan].
  Current currentOver(Time time) {
    final coulombs = getValue(ElectricChargeUnit.coulomb);
    final seconds = time.inSeconds;
    return Current(coulombs / seconds, CurrentUnit.ampere);
  }

  /// Calculates the `Time` it takes for this charge to flow at a given `Current` (t = Q / I).
  ///
  /// If [current] is zero, the result follows IEEE 754 semantics: a non-zero charge
  /// yields [double.infinity] and a zero charge yields [double.nan].
  Time timeFor(Current current) {
    final coulombs = getValue(ElectricChargeUnit.coulomb);
    final amperes = current.inAmperes;
    return Time(coulombs / amperes, TimeUnit.second);
  }
}
