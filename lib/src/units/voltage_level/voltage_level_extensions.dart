import '../voltage/voltage.dart';
import '../voltage/voltage_unit.dart';
import 'voltage_level.dart';
import 'voltage_level_unit.dart';

/// Provides convenient access to [VoltageLevel] values in specific units.
extension VoltageLevelValueGetters on VoltageLevel {
  /// Returns the voltage level value in dBV.
  double get inDbV => getValue(VoltageLevelUnit.dBV);

  /// Returns the voltage level value in dBu.
  double get inDbu => getValue(VoltageLevelUnit.dBu);

  /// Returns a [VoltageLevel] converted to dBV.
  VoltageLevel get asDbV => convertTo(VoltageLevelUnit.dBV);

  /// Returns a [VoltageLevel] converted to dBu.
  VoltageLevel get asDbu => convertTo(VoltageLevelUnit.dBu);
}

/// Provides convenient factory methods for creating [VoltageLevel] instances.
extension VoltageLevelCreation on num {
  /// Creates a [VoltageLevel] in dBV.
  VoltageLevel get dBV => VoltageLevel(toDouble(), VoltageLevelUnit.dBV);

  /// Creates a [VoltageLevel] in dBu.
  VoltageLevel get dBu => VoltageLevel(toDouble(), VoltageLevelUnit.dBu);
}

/// Provides bridge helpers between [Voltage] and [VoltageLevel].
extension VoltageVoltageLevelBridge on Voltage {
  /// Converts this voltage to a logarithmic [VoltageLevel] using [targetUnit]'s reference.
  VoltageLevel toVoltageLevel(VoltageLevelUnit targetUnit) {
    return VoltageLevel.fromVoltage(this, unit: targetUnit);
  }

  /// Alias for [toVoltageLevel].
  VoltageLevel asVoltageLevel(VoltageLevelUnit targetUnit) => toVoltageLevel(targetUnit);
}

/// Provides bridge helpers from [VoltageLevel] back to [Voltage].
extension VoltageLevelVoltageBridge on VoltageLevel {
  /// Converts this voltage level to linear [Voltage] in [targetUnit].
  Voltage asVoltage({VoltageUnit targetUnit = VoltageUnit.volt}) {
    return toVoltage(targetUnit: targetUnit);
  }

  /// Returns the equivalent voltage value in volts.
  double get inVolts => toVoltage().value;

  /// Converts this voltage level to [Voltage] in [targetUnit].
  Voltage asVoltageIn(VoltageUnit targetUnit) => toVoltage(targetUnit: targetUnit);
}
