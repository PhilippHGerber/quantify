import 'package:quantify/quantify.dart';
import 'package:test/test.dart';

void main() {
  group('Non-linear public API via quantify.dart', () {
    test('barrel export exposes new quantity families coherently', () {
      final gain = 3.dB;
      final power = 20.dBm + gain;
      final pathLoss = 20.dBm - (-80).dBm;
      final voltage = 4.dBu.subtract(6.dB);
      final economy = 5.6.LPer100Km;
      final spl = 20e-6.Pa.toSoundPressureLevel();
      final powerFromLevel = 20.dBm.asPowerIn(PowerUnit.milliwatt);
      final powerAsLevel = 100.mW.toPowerLevel(PowerLevelUnit.dBm);
      final voltageFromLevel = 0.dBu.asVoltageIn(VoltageUnit.millivolt);
      final voltageAsLevel = 1.V.toVoltageLevel(VoltageLevelUnit.dBV);

      expect(power.inDbm, closeTo(23.0, 1e-9));
      expect(pathLoss.inDecibel, closeTo(100.0, 1e-9));
      expect(voltage.inDbu, closeTo(-2.0, 1e-9));
      expect(economy.inKmPerL, closeTo(17.857142857142858, 1e-9));
      expect(spl.inDbSpl, closeTo(0.0, 1e-9));
      expect(120.dBSPL.toPressure().inPa, closeTo(20.0, 1e-9));
      expect(powerFromLevel.value, closeTo(100.0, 1e-9));
      expect(powerAsLevel.inDbm, closeTo(20.0, 1e-9));
      expect(voltageFromLevel.value, closeTo(774.5966692414834, 1e-6));
      expect(voltageAsLevel.inDbV, closeTo(0.0, 1e-9));
    });

    test('parser normalization stays consistent for non-linear quantities', () {
      expect(FuelConsumption.parse('42 mpg').unit, FuelConsumptionUnit.mpgUs);
      expect(SoundPressureLevel.parse('94 db spl').unit, SoundPressureLevelUnit.decibelSpl);
      expect(PowerLevel.parse('20 dBm').unit, PowerLevelUnit.dBm);
      expect(VoltageLevel.parse('4 dbu').unit, VoltageLevelUnit.dBu);
      expect(LevelRatio.parse('3 dB').unit, LevelRatioUnit.decibel);
    });
  });
}
