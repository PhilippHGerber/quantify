import 'package:meta/meta.dart';

import '../../core/linear_quantity.dart';
import '../../core/quantity_format.dart';
import '../../core/quantity_parser.dart';
import '../time/time.dart';
import '../time/time_extensions.dart';
import '../time/time_unit.dart';
import 'frequency_unit.dart';

/// Represents a quantity of frequency.
///
/// Frequency is a derived quantity representing the number of occurrences of a
/// repeating event per unit of time. The SI derived unit is the Hertz (Hz),
/// defined as one cycle per second (s⁻¹).
@immutable
final class Frequency extends LinearQuantity<FrequencyUnit, Frequency> {
  /// Creates a new `Frequency` with a given [value] and [unit].
  const Frequency(super._value, super._unit);

  /// Creates a `Frequency` instance from a `Time` duration representing the
  /// period of one cycle (f = 1/T).
  ///
  /// If [time] is zero, the result follows IEEE 754 semantics: [double.infinity].
  ///
  /// Example:
  /// ```dart
  /// final period = 20.ms; // A 20 millisecond period
  /// final frequency = Frequency.from(period);
  /// print(frequency.inHertz); // Output: 50.0
  /// ```
  factory Frequency.from(Time time) {
    final seconds = time.inSeconds;
    return Frequency(1.0 / seconds, FrequencyUnit.hertz);
  }

  @override
  @protected
  Frequency create(double value, FrequencyUnit unit) => Frequency(value, unit);

  /// The parser instance used to convert strings into [Frequency] objects.
  ///
  /// The parser supports both strict symbol aliases and case-insensitive name
  /// aliases configured in [FrequencyUnit].
  static final QuantityParser<FrequencyUnit, Frequency> parser =
      QuantityParser<FrequencyUnit, Frequency>(
    symbolAliases: FrequencyUnit.symbolAliases,
    nameAliases: FrequencyUnit.nameAliases,
    factory: Frequency.new,
  );

  /// Parses a string representation of frequency into a [Frequency] object.
  ///
  /// The [formats] list controls how the numeric portion is interpreted.
  static Frequency parse(
    String input, {
    List<QuantityFormat> formats = const [QuantityFormat.invariant],
  }) {
    return parser.parse(input, formats: formats);
  }

  /// Parses a string representation of frequency into a [Frequency] object,
  /// returning `null` when parsing fails.
  ///
  /// See [parse] for formatting and matching behavior.
  static Frequency? tryParse(
    String input, {
    List<QuantityFormat> formats = const [QuantityFormat.invariant],
  }) {
    return parser.tryParse(input, formats: formats);
  }

  /// Calculates the time period for one cycle of this frequency (T = 1/f).
  ///
  /// If frequency is zero, the result follows IEEE 754 semantics: [double.infinity].
  /// The result is returned as a `Time` quantity in seconds.
  ///
  /// Example:
  /// ```dart
  /// final cpuClock = 4.2.ghz;
  /// final cycleTime = cpuClock.period;
  /// print(cycleTime.inNanoseconds); // Output: ~0.238
  /// ```
  Time get period {
    final hertz = getValue(FrequencyUnit.hertz);
    return Time(1.0 / hertz, TimeUnit.second);
  }
}
