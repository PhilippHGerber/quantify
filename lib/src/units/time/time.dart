import 'package:meta/meta.dart';

import '../../../quantify.dart' show QuantityParseException;
import '../../core/linear_quantity.dart';
import '../../core/quantity_format.dart';
import '../../core/quantity_parse_exception.dart' show QuantityParseException;
import '../../core/quantity_parser.dart';
import 'time_unit.dart';

/// Represents a quantity of time (duration).
@immutable
final class Time extends LinearQuantity<TimeUnit, Time> {
  /// Creates a new Time quantity with the given [value] and [unit].
  ///
  /// Example:
  /// ```dart
  /// final duration = Time(120.0, TimeUnit.second);
  /// final meetingLength = Time(1.5, TimeUnit.hour);
  /// ```
  const Time(super._value, super._unit);

  @override
  @protected
  Time create(double value, TimeUnit unit) => Time(value, unit);

  /// The parser instance used to convert strings into [Time] objects.
  ///
  /// The parser supports all standard units and handles both case-sensitive SI
  /// symbols (like `Ms` vs `ms`) and case-insensitive unit names.
  ///
  /// Create isolated parser variants to support custom or localized aliases:
  /// ```dart
  /// final customParser = Time.parser.copyWithAliases(
  ///   extraNameAliases: {'hora': TimeUnit.hour},
  /// );
  /// final custom = customParser.parse('2 hora');
  /// ```
  static final QuantityParser<TimeUnit, Time> parser = QuantityParser<TimeUnit, Time>(
    symbolAliases: TimeUnit.symbolAliases,
    nameAliases: TimeUnit.nameAliases,
    factory: Time.new,
  );

  /// Parses a string representation of a time duration into a [Time] object.
  ///
  /// The [input] string should follow the format `"<number> <unit>"`, where the
  /// space between the number and unit is optional.
  ///
  /// - **SI Prefixes**: Strictly case-sensitive (`10 ms` is milliseconds,
  ///   `10 Ms` is megaseconds).
  /// - **Common Units**: Case-insensitive (`1 hour`, `1 HOUR`, and `1 Hour`
  ///   all parse correctly).
  ///
  /// By default, [formats] uses `[QuantityFormat.invariant]` which accepts
  /// period as decimal separator and ignores visual grouping separators
  /// (space, NBSP, apostrophe). To parse locale-specific formats, provide
  /// custom [QuantityFormat] instances.
  ///
  /// Throws [QuantityParseException] if parsing fails.
  ///
  /// Example:
  /// ```dart
  /// final t1 = Time.parse('30 min');   // 30 minutes
  /// final t2 = Time.parse('1.5 h');    // 1.5 hours
  /// final t3 = Time.parse('100ms');    // 100 milliseconds (no space)
  /// ```
  static Time parse(
    String input, {
    List<QuantityFormat> formats = const [QuantityFormat.invariant],
  }) {
    return parser.parse(input, formats: formats);
  }

  /// Attempts to parse a string representation of time. Returns `null` if parsing fails.
  ///
  /// See [parse] for format details.
  ///
  /// Example:
  /// ```dart
  /// final valid = Time.tryParse('2 hours');   // Time(2.0, TimeUnit.hour)
  /// final invalid = Time.tryParse('invalid'); // null
  /// ```
  static Time? tryParse(
    String input, {
    List<QuantityFormat> formats = const [QuantityFormat.invariant],
  }) {
    return parser.tryParse(input, formats: formats);
  }
}
