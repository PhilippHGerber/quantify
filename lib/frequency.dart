/// Provides type-safe units for Frequency.
///
/// Import this file to use Frequency quantities and their
/// extensions on `num` (like `4.2.ghz`, `120.bpm`, `60.rpm`).
///
/// **Note:** If you also import `angular_velocity.dart`, the `.rpm` getter
/// will conflict. In that case, use the main `quantify.dart` barrel (which
/// resolves the conflict by defaulting `.rpm` to 'AngularVelocity') or hide
/// one of the extensions manually.
library;

export 'src/core/quantity.dart';
export 'src/core/unit.dart';
export 'src/units/frequency/frequency.dart';
export 'src/units/frequency/frequency_extensions.dart';
export 'src/units/frequency/frequency_unit.dart';
