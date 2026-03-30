import 'package:quantify/fuel_consumption.dart';
import 'package:quantify/level_ratio.dart';
import 'package:quantify/power.dart';
import 'package:quantify/power_level.dart';
import 'package:quantify/pressure.dart';
import 'package:quantify/sound_pressure_level.dart';
import 'package:quantify/voltage.dart';
import 'package:quantify/voltage_level.dart';
import 'package:test/test.dart';

void main() {
  group('Non-linear public API via granular imports', () {
    test('granular entry points expose intended creation and bridge helpers', () {
      const litersPerUsGallon = 3.785411784;
      const kilometersPerMile = 1.609344;
      const expectedMpgUs = (100.0 / 5.6) / (kilometersPerMile / litersPerUsGallon);

      expect((20.dBm + 3.dB).inDbm, closeTo(23.0, 1e-9));
      expect((20.dBm - (-80).dBm).inDecibel, closeTo(100.0, 1e-9));
      expect(4.dBu.subtract(6.dB).inDbu, closeTo(-2.0, 1e-9));
      expect(5.6.LPer100Km.inMpgUs, closeTo(expectedMpgUs, 1e-9));
      expect(20e-6.Pa.toSoundPressureLevel().inDbSpl, closeTo(0.0, 1e-9));
      expect(120.dBSPL.asPressureIn(PressureUnit.kilopascal).value, closeTo(0.02, 1e-9));
      expect(100.mW.toPowerLevel(PowerLevelUnit.dBm).inDbm, closeTo(20.0, 1e-9));
      expect(20.dBm.asPowerIn(PowerUnit.milliwatt).value, closeTo(100.0, 1e-9));
      expect(1.V.toVoltageLevel(VoltageLevelUnit.dBV).inDbV, closeTo(0.0, 1e-9));
      expect(0.dBu.asVoltageIn(VoltageUnit.millivolt).value, closeTo(774.5966692414834, 1e-6));
    });

    test('granular parsers are available without the main barrel', () {
      expect(FuelConsumption.parse('42 mpg(UK)').unit, FuelConsumptionUnit.mpgUk);
      expect(SoundPressureLevel.parse('94 dBSPL').unit, SoundPressureLevelUnit.decibelSpl);
      expect(PowerLevel.parse('20 dBm').unit, PowerLevelUnit.dBm);
      expect(VoltageLevel.parse('4 dBu').unit, VoltageLevelUnit.dBu);
      expect(LevelRatio.parse('3 dB').unit, LevelRatioUnit.decibel);
    });
  });
}
