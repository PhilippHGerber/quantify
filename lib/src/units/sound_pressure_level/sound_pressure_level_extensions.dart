import '../pressure/pressure.dart';
import '../pressure/pressure_unit.dart';
import 'sound_pressure_level.dart';
import 'sound_pressure_level_unit.dart';

/// Provides convenient access to [SoundPressureLevel] values.
extension SoundPressureLevelValueGetters on SoundPressureLevel {
  /// Returns the sound pressure level value in decibels SPL.
  double get inDecibelSpl => getValue(SoundPressureLevelUnit.decibelSpl);

  /// Short alias for [inDecibelSpl].
  double get inDbSpl => inDecibelSpl;

  /// Returns this level as a [SoundPressureLevel] in dB SPL.
  SoundPressureLevel get asDecibelSpl => convertTo(SoundPressureLevelUnit.decibelSpl);

  /// Short alias for [asDecibelSpl].
  SoundPressureLevel get asDbSpl => asDecibelSpl;
}

/// Provides convenient factory methods for creating [SoundPressureLevel] instances.
extension SoundPressureLevelCreation on num {
  /// Creates a [SoundPressureLevel] in dB SPL.
  SoundPressureLevel get dBSPL {
    return SoundPressureLevel(toDouble(), SoundPressureLevelUnit.decibelSpl);
  }

  /// Creates a [SoundPressureLevel] in dB SPL.
  SoundPressureLevel get decibelSpl {
    return SoundPressureLevel(toDouble(), SoundPressureLevelUnit.decibelSpl);
  }
}

/// Provides bridge helpers between [Pressure] and [SoundPressureLevel].
extension PressureSoundPressureLevelBridge on Pressure {
  /// Converts this pressure to a sound pressure level.
  SoundPressureLevel toSoundPressureLevel() {
    return SoundPressureLevel.fromPressure(this);
  }

  /// Alias for [toSoundPressureLevel].
  SoundPressureLevel get asSoundPressureLevel => toSoundPressureLevel();
}

/// Provides bridge helpers from [SoundPressureLevel] back to [Pressure].
extension SoundPressureLevelPressureBridge on SoundPressureLevel {
  /// Converts this sound pressure level to [Pressure] in pascals.
  Pressure get asPressure => toPressure();

  /// Returns the equivalent pressure value in pascals.
  double get inPa => toPressure().value;

  /// Converts this sound pressure level to [Pressure] in [targetUnit].
  Pressure asPressureIn(PressureUnit targetUnit) {
    return toPressure().convertTo(targetUnit);
  }
}
