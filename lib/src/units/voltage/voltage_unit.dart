import 'package:meta/meta.dart';

import '../../core/unit.dart';
import 'voltage_factors.dart';

/// Represents units for electric potential (voltage).
///
/// This enum implements the [LinearUnit] interface to provide conversion capabilities
/// and a display [symbol] for each voltage unit.
/// All conversion factors are pre-calculated in the constructor relative to Volt (V),
/// which is the SI derived unit for electric potential.
enum VoltageUnit implements LinearUnit<VoltageUnit> {
  /// Volt (V), the SI derived unit of electric potential.
  /// Defined as one joule per coulomb (J/C), or equivalently one watt per
  /// ampere (W/A).
  volt(1, 'V'),

  /// Nanovolt (nV), equal to 1e-9 volts.
  nanovolt(VoltageFactors.voltsPerNanovolt, 'nV'),

  /// Microvolt (µV), equal to 1e-6 volts.
  microvolt(VoltageFactors.voltsPerMicrovolt, 'µV'),

  /// Millivolt (mV), equal to 0.001 volts.
  millivolt(VoltageFactors.voltsPerMillivolt, 'mV'),

  /// Kilovolt (kV), equal to 1000 volts.
  kilovolt(VoltageFactors.voltsPerKilovolt, 'kV'),

  /// Megavolt (MV), equal to 1,000,000 volts.
  megavolt(VoltageFactors.voltsPerMegavolt, 'MV'),

  /// Gigavolt (GV), equal to 1,000,000,000 volts.
  gigavolt(VoltageFactors.voltsPerGigavolt, 'GV'),

  /// Statvolt (statV), the CGS electrostatic unit of electric potential.
  statvolt(VoltageFactors.voltsPerStatvolt, 'statV'),

  /// Abvolt (abV), the CGS electromagnetic unit of electric potential.
  abvolt(VoltageFactors.voltsPerAbvolt, 'abV');

  /// Constant constructor for enum members.
  ///
  /// [_toVoltFactor] is the factor to convert from this unit to the base unit (Volt).
  /// For Volt itself, this is 1.0.
  /// [symbol] is the display symbol for the unit.
  ///
  /// The constructor pre-calculates all direct conversion factors
  /// from this unit to every other `VoltageUnit`.
  const VoltageUnit(double toVoltFactor, this.symbol)
      : _toVoltFactor = toVoltFactor,
        _factorToVolt = toVoltFactor / 1.0,
        _factorToNanovolt = toVoltFactor / VoltageFactors.voltsPerNanovolt,
        _factorToMicrovolt = toVoltFactor / VoltageFactors.voltsPerMicrovolt,
        _factorToMillivolt = toVoltFactor / VoltageFactors.voltsPerMillivolt,
        _factorToKilovolt = toVoltFactor / VoltageFactors.voltsPerKilovolt,
        _factorToMegavolt = toVoltFactor / VoltageFactors.voltsPerMegavolt,
        _factorToGigavolt = toVoltFactor / VoltageFactors.voltsPerGigavolt,
        _factorToStatvolt = toVoltFactor / VoltageFactors.voltsPerStatvolt,
        _factorToAbvolt = toVoltFactor / VoltageFactors.voltsPerAbvolt;

  /// The factor to convert a value from this unit to the base unit (Volt).
  // ignore: unused_field
  final double _toVoltFactor;

  /// The human-readable symbol for this voltage unit (e.g., "V", "mV").
  @override
  final String symbol;

  // --- Pre-calculated direct conversion factors from this unit to all others ---
  final double _factorToVolt;
  final double _factorToNanovolt;
  final double _factorToMicrovolt;
  final double _factorToMillivolt;
  final double _factorToKilovolt;
  final double _factorToMegavolt;
  final double _factorToGigavolt;
  final double _factorToStatvolt;
  final double _factorToAbvolt;

  /// SI and unit symbols matched **strictly case-sensitive**.
  ///
  /// Used by `Voltage.parser`.
  @internal
  static const Map<String, VoltageUnit> symbolAliases = {
    // volt
    'V': VoltageUnit.volt,
    // nanovolt
    'nV': VoltageUnit.nanovolt,
    // microvolt
    'µV': VoltageUnit.microvolt,
    'uV': VoltageUnit.microvolt,
    // millivolt
    'mV': VoltageUnit.millivolt,
    // kilovolt
    'kV': VoltageUnit.kilovolt,
    // megavolt
    'MV': VoltageUnit.megavolt,
    // gigavolt
    'GV': VoltageUnit.gigavolt,
    // statvolt
    'statV': VoltageUnit.statvolt,
    // abvolt
    'abV': VoltageUnit.abvolt,
  };

  /// Full word-form names matched **case-insensitively**.
  ///
  /// Used by `Voltage.parser`.
  @internal
  static const Map<String, VoltageUnit> nameAliases = {
    // volt
    'volt': VoltageUnit.volt,
    'volts': VoltageUnit.volt,
    // nanovolt
    'nanovolt': VoltageUnit.nanovolt,
    'nanovolts': VoltageUnit.nanovolt,
    // microvolt
    'microvolt': VoltageUnit.microvolt,
    'microvolts': VoltageUnit.microvolt,
    // millivolt
    'millivolt': VoltageUnit.millivolt,
    'millivolts': VoltageUnit.millivolt,
    // kilovolt
    'kilovolt': VoltageUnit.kilovolt,
    'kilovolts': VoltageUnit.kilovolt,
    // megavolt
    'megavolt': VoltageUnit.megavolt,
    'megavolts': VoltageUnit.megavolt,
    // gigavolt
    'gigavolt': VoltageUnit.gigavolt,
    'gigavolts': VoltageUnit.gigavolt,
    // statvolt
    'statvolt': VoltageUnit.statvolt,
    'statvolts': VoltageUnit.statvolt,
    // abvolt
    'abvolt': VoltageUnit.abvolt,
    'abvolts': VoltageUnit.abvolt,
  };

  /// Returns the direct conversion factor to convert a value from this [VoltageUnit]
  /// to the [targetUnit].
  @override
  @internal
  double factorTo(VoltageUnit targetUnit) {
    switch (targetUnit) {
      case VoltageUnit.volt:
        return _factorToVolt;
      case VoltageUnit.nanovolt:
        return _factorToNanovolt;
      case VoltageUnit.microvolt:
        return _factorToMicrovolt;
      case VoltageUnit.millivolt:
        return _factorToMillivolt;
      case VoltageUnit.kilovolt:
        return _factorToKilovolt;
      case VoltageUnit.megavolt:
        return _factorToMegavolt;
      case VoltageUnit.gigavolt:
        return _factorToGigavolt;
      case VoltageUnit.statvolt:
        return _factorToStatvolt;
      case VoltageUnit.abvolt:
        return _factorToAbvolt;
    }
  }
}
