import 'package:meta/meta.dart';

import '../../../quantify.dart' show QuantityParseException;
import '../../core/linear_quantity.dart';
import '../../core/quantity_format.dart';
import '../../core/quantity_parse_exception.dart' show QuantityParseException;
import '../../core/quantity_parser.dart';
import '../power/power.dart';
import '../power/power_extensions.dart';
import '../time/time.dart';
import '../time/time_extensions.dart';
import 'energy_unit.dart';

/// Represents a quantity of energy.
///
/// Energy is a fundamental physical quantity representing the capacity to do work.
/// The SI derived unit for energy is the Joule (J). This class provides a
/// type-safe way to handle energy values and conversions between different units
/// (e.g., joules, calories, kilowatt-hours).
@immutable
class Energy extends LinearQuantity<EnergyUnit, Energy> {
  /// Creates a new `Energy` quantity with the given numerical [value] and [unit].
  ///
  /// Example:
  /// ```dart
  /// final workDone = Energy(500.0, EnergyUnit.joule);
  /// final foodEnergy = Energy(250.0, EnergyUnit.kilocalorie);
  /// final electricityUsed = Energy(1.2, EnergyUnit.kilowattHour);
  /// ```
  const Energy(super._value, super._unit);

  /// Creates an [Energy] quantity from [Power] and [Time] (E = P × t).
  ///
  /// Both inputs are converted to SI base units (watts and seconds) before
  /// multiplying. The result is returned in joules.
  ///
  /// ```dart
  /// final power    = 1.kW;
  /// final duration = 1.hours;
  /// final energy   = Energy.from(power, duration); // 3600000.0 J (1 kWh)
  /// ```
  factory Energy.from(Power power, Time duration) =>
      Energy(power.inWatts * duration.inSeconds, EnergyUnit.joule);

  @override
  @protected
  Energy create(double value, EnergyUnit unit) => Energy(value, unit);

  /// The parser instance used to convert strings into [Energy] objects.
  ///
  /// The parser supports all standard units including symbols and full names.
  static final QuantityParser<EnergyUnit, Energy> parser = QuantityParser<EnergyUnit, Energy>(
    symbolAliases: EnergyUnit.symbolAliases,
    nameAliases: EnergyUnit.nameAliases,
    factory: Energy.new,
  );

  /// Parses a string representation of energy into an [Energy] object.
  ///
  /// Throws [QuantityParseException] if parsing fails.
  ///
  /// Example:
  /// ```dart
  /// final e1 = Energy.parse('100 J');      // 100 joules
  /// final e2 = Energy.parse('500 kcal');   // 500 kilocalories
  /// final e3 = Energy.parse('1.5 kWh');    // 1.5 kilowatt-hours
  /// ```
  static Energy parse(
    String input, {
    List<QuantityFormat> formats = const [QuantityFormat.invariant],
  }) {
    return parser.parse(input, formats: formats);
  }

  /// Attempts to parse a string representation of energy. Returns `null` if parsing fails.
  ///
  /// Example:
  /// ```dart
  /// final valid = Energy.tryParse('100 joules');  // Energy(100.0, EnergyUnit.joule)
  /// final invalid = Energy.tryParse('invalid');   // null
  /// ```
  static Energy? tryParse(
    String input, {
    List<QuantityFormat> formats = const [QuantityFormat.invariant],
  }) {
    return parser.tryParse(input, formats: formats);
  }
}
