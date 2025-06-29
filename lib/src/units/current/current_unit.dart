import 'package:meta/meta.dart';

import '../../core/unit.dart';
import 'current_factors.dart';

/// Represents units for electric current.
///
/// This enum implements the [Unit] interface to provide conversion capabilities
/// and a display [symbol] for each electric current unit.
/// All conversion factors are pre-calculated in the constructor relative to Ampere (A),
/// which is the SI base unit for electric current.
enum CurrentUnit implements Unit<CurrentUnit> {
  /// Ampere (A), the SI base unit of electric current.
  /// Defined by taking the fixed numerical value of the elementary charge *e* to be
  /// 1.602176634 × 10⁻¹⁹ when expressed in the unit C, which is equal to A s.
  ampere(1, 'A'),

  /// Milliampere (mA), equal to 0.001 amperes.
  milliampere(CurrentFactors.amperesPerMilliampere, 'mA'),

  /// Microampere (µA), equal to 1e-6 amperes.
  microampere(CurrentFactors.amperesPerMicroampere, 'µA'),

  /// Nanoampere (nA), equal to 1e-9 amperes.
  nanoampere(CurrentFactors.amperesPerNanoampere, 'nA'),

  /// Kiloampere (kA), equal to 1000 amperes.
  kiloampere(CurrentFactors.amperesPerKiloampere, 'kA'),

  /// Statampere (statA), the CGS electrostatic unit of current.
  statampere(CurrentFactors.amperesPerStatampere, 'statA'),

  /// Abampere (abA) or Biot (Bi), the CGS electromagnetic unit of current.
  abampere(CurrentFactors.amperesPerAbampere, 'abA');

  /// Constant constructor for enum members.
  ///
  /// [_toAmpereFactor] is the factor to convert from this unit to the base unit (Ampere).
  /// For Ampere itself, this is 1.0.
  /// [symbol] is the display symbol for the unit.
  ///
  /// The constructor pre-calculates all direct conversion factors
  /// from this unit to every other `CurrentUnit`.
  const CurrentUnit(double toAmpereFactor, this.symbol)
      : _toAmpereFactor = toAmpereFactor,
        // Initialize direct factors from THIS unit to OTHERS.
        _factorToAmpere = toAmpereFactor / 1.0, // Base unit factor for ampere is 1.0
        _factorToMilliampere = toAmpereFactor / CurrentFactors.amperesPerMilliampere,
        _factorToMicroampere = toAmpereFactor / CurrentFactors.amperesPerMicroampere,
        _factorToNanoampere = toAmpereFactor / CurrentFactors.amperesPerNanoampere,
        _factorToKiloampere = toAmpereFactor / CurrentFactors.amperesPerKiloampere,
        _factorToStatampere = toAmpereFactor / CurrentFactors.amperesPerStatampere,
        _factorToAbampere = toAmpereFactor / CurrentFactors.amperesPerAbampere;
  // If biot were added:
  // _factorToBiot = toAmpereFactor / CurrentFactors.amperesPerBiot;

  /// The factor to convert a value from this unit to the base unit (Ampere).
  /// Example: For Milliampere, this is 0.001 (meaning 1 mA = 0.001 A).
  /// This field is primarily used internally by the constructor.
  // ignore: unused_field
  final double _toAmpereFactor;

  /// The human-readable symbol for this electric current unit (e.g., "A", "mA").
  @override
  final String symbol;

  // --- Pre-calculated direct conversion factors from this unit to all others ---
  final double _factorToAmpere;
  final double _factorToMilliampere;
  final double _factorToMicroampere;
  final double _factorToNanoampere;
  final double _factorToKiloampere;
  final double _factorToStatampere;
  final double _factorToAbampere;

  /// Returns the direct conversion factor to convert a value from this [CurrentUnit]
  /// to the [targetUnit].
  ///
  /// This method is marked as `@internal` and is primarily used by the `Current`
  /// class for conversions.
  @override
  @internal
  double factorTo(CurrentUnit targetUnit) {
    switch (targetUnit) {
      case CurrentUnit.ampere:
        return _factorToAmpere;
      case CurrentUnit.milliampere:
        return _factorToMilliampere;
      case CurrentUnit.microampere:
        return _factorToMicroampere;
      case CurrentUnit.nanoampere:
        return _factorToNanoampere;
      case CurrentUnit.kiloampere:
        return _factorToKiloampere;
      case CurrentUnit.statampere:
        return _factorToStatampere;
      case CurrentUnit.abampere:
        return _factorToAbampere;
    }
  }
}
