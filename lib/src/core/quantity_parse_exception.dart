/// Thrown by `Quantity.parse` when no supplied format can parse the input.
///
/// Extends [FormatException] so it can be caught generically, while providing
/// richer diagnostics about the parse attempt.
class QuantityParseException extends FormatException {
  /// Creates a [QuantityParseException] for a failed parse attempt.
  QuantityParseException({
    required String input,
    required this.targetType,
    required this.formatsAttempted,
  })  : _input = input,
        super(
          'Failed to parse "$input" as $targetType. '
          'Tried $formatsAttempted format(s). Ensure the number matches the '
          'provided format locale/separators, and the unit symbol is supported.',
          input,
        );

  final String _input;

  /// The name of the quantity type being parsed (e.g., 'Length', 'Mass').
  final String targetType;

  /// Number of `QuantityFormat` instances that were tried.
  final int formatsAttempted;

  /// The original input string that failed to parse.
  String get input => _input;
}
