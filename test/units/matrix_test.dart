import 'dart:math' as math;

import 'package:quantify/quantify.dart';
import 'package:test/test.dart';

void main() {
  group('Unit Conversion Matrix Tests', () {
    /// A generic matrix test that verifies all N x N conversions for a given Unit enum.
    /// It ensures that every unit can convert to every other unit (including itself)
    /// with consistent results, verifying the pre-calculated factors and switch statements.
    void testUnitMatrix<T extends LinearUnit<T>>(
      String name,
      List<T> units, {
      double tolerance = 1e-9,
    }) {
      group('Matrix: $name', () {
        for (final unitA in units) {
          for (final unitB in units) {
            test('${unitA.symbol} to ${unitB.symbol}', () {
              final factor = unitA.factorTo(unitB);

              // 1. Check self-conversion
              if (unitA == unitB) {
                expect(factor, 1.0, reason: 'Self-conversion factor must be 1.0');
              }

              // 2. Cross-verify via a third unit (Consistency Check)
              // If A -> B is 'f', then A -> C -> B should also be 'f'.
              // We'll use the first unit in the list as the reference 'C'.
              final unitC = units.first;
              final factorAC = unitA.factorTo(unitC);
              final factorCB = unitC.factorTo(unitB);
              final indirectFactor = factorAC * factorCB;

              // Use relative tolerance for very large/small factors
              final diff = (factor - indirectFactor).abs();
              final maxVal = math.max(factor.abs(), indirectFactor.abs());
              final relDiff = maxVal > 0 ? diff / maxVal : diff;

              expect(
                relDiff,
                lessThanOrEqualTo(tolerance),
                reason:
                    'Inconsistent conversion: ${unitA.symbol} -> ${unitB.symbol} direct factor ($factor) '
                    'does not match indirect ${unitA.symbol} -> ${unitC.symbol} -> ${unitB.symbol} ($indirectFactor). '
                    'Relative diff: $relDiff (limit: $tolerance)',
              );
            });
          }
        }
      });
    }

    testUnitMatrix('Length', LengthUnit.values, tolerance: 1e-12);
    testUnitMatrix('Mass', MassUnit.values, tolerance: 1e-12);
    testUnitMatrix('Time', TimeUnit.values, tolerance: 1e-12);
    testUnitMatrix('Angle', AngleUnit.values, tolerance: 1e-12);
    testUnitMatrix('Speed', SpeedUnit.values, tolerance: 1e-12);
    testUnitMatrix('Force', ForceUnit.values, tolerance: 1e-12);
    testUnitMatrix('Pressure', PressureUnit.values, tolerance: 1e-12);
    testUnitMatrix('Energy', EnergyUnit.values, tolerance: 1e-12);
    testUnitMatrix('Power', PowerUnit.values, tolerance: 1e-12);
    testUnitMatrix('Volume', VolumeUnit.values, tolerance: 1e-12);
    testUnitMatrix('Area', AreaUnit.values, tolerance: 1e-12);
    testUnitMatrix('Acceleration', AccelerationUnit.values, tolerance: 1e-12);
    testUnitMatrix('Frequency', FrequencyUnit.values, tolerance: 1e-12);
    testUnitMatrix('ElectricCharge', ElectricChargeUnit.values, tolerance: 1e-12);
    testUnitMatrix('Current', CurrentUnit.values, tolerance: 1e-12);
    testUnitMatrix('Voltage', VoltageUnit.values, tolerance: 1e-12);
    testUnitMatrix('Resistance', ResistanceUnit.values, tolerance: 1e-12);
    testUnitMatrix('LuminousIntensity', LuminousIntensityUnit.values, tolerance: 1e-12);
    testUnitMatrix('Information', InformationUnit.values, tolerance: 1e-12);
    testUnitMatrix('LevelRatio', LevelRatioUnit.values, tolerance: 1e-12);
    testUnitMatrix('TemperatureDelta', TemperatureDeltaUnit.values, tolerance: 1e-12);
  });
}
