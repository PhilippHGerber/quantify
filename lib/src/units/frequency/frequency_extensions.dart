import 'frequency.dart';
import 'frequency_unit.dart';

// SI/IEC unit symbols use uppercase letters by international standard
// (e.g., 'Hz' for hertz, named after Heinrich Hertz).
// Dart's lowerCamelCase rule is intentionally overridden here to preserve
// domain correctness and discoverability for scientists and engineers.
// ignore_for_file: non_constant_identifier_names

/// Provides convenient access to [Frequency] values in specific units.
extension FrequencyValueGetters on Frequency {
  /// Returns the frequency value in Hertz (Hz).
  double get inHertz => getValue(FrequencyUnit.hertz);

  /// Returns the frequency value in Terahertz (THz).
  double get inTerahertz => getValue(FrequencyUnit.terahertz);

  /// Returns the frequency value in Gigahertz (GHz).
  double get inGigahertz => getValue(FrequencyUnit.gigahertz);

  /// Returns the frequency value in Megahertz (MHz).
  double get inMegahertz => getValue(FrequencyUnit.megahertz);

  /// Returns the frequency value in Kilohertz (kHz).
  double get inKilohertz => getValue(FrequencyUnit.kilohertz);

  /// Returns the frequency value in Millihertz (mHz).
  double get inMillihertz => getValue(FrequencyUnit.millihertz);

  /// Returns the frequency value in Revolutions per minute (rpm).
  double get inRevolutionsPerMinute => getValue(FrequencyUnit.revolutionsPerMinute);

  /// Returns the frequency value in Beats per minute (bpm).
  double get inBeatsPerMinute => getValue(FrequencyUnit.beatsPerMinute);

  /// Returns the frequency value in Radians per second (rad/s).
  double get inRadiansPerSecond => getValue(FrequencyUnit.radianPerSecond);

  /// Returns the frequency value in Degrees per second (°/s).
  double get inDegreesPerSecond => getValue(FrequencyUnit.degreePerSecond);

  /// Returns a new [Frequency] object representing this frequency in Hertz (Hz).
  Frequency get asHertz => convertTo(FrequencyUnit.hertz);

  /// Returns a new [Frequency] object representing this frequency in Terahertz (THz).
  Frequency get asTerahertz => convertTo(FrequencyUnit.terahertz);

  /// Returns a new [Frequency] object representing this frequency in Gigahertz (GHz).
  Frequency get asGigahertz => convertTo(FrequencyUnit.gigahertz);

  /// Returns a new [Frequency] object representing this frequency in Megahertz (MHz).
  Frequency get asMegahertz => convertTo(FrequencyUnit.megahertz);

  /// Returns a new [Frequency] object representing this frequency in Kilohertz (kHz).
  Frequency get asKilohertz => convertTo(FrequencyUnit.kilohertz);

  /// Returns a new [Frequency] object representing this frequency in Millihertz (mHz).
  Frequency get asMillihertz => convertTo(FrequencyUnit.millihertz);

  /// Returns a new [Frequency] object representing this frequency in Revolutions per minute (rpm).
  Frequency get asRevolutionsPerMinute => convertTo(FrequencyUnit.revolutionsPerMinute);

  /// Returns a new [Frequency] object representing this frequency in Beats per minute (bpm).
  Frequency get asBeatsPerMinute => convertTo(FrequencyUnit.beatsPerMinute);

  /// Returns a new [Frequency] object representing this frequency in Radians per second (rad/s).
  Frequency get asRadiansPerSecond => convertTo(FrequencyUnit.radianPerSecond);

  /// Returns a new [Frequency] object representing this frequency in Degrees per second (°/s).
  Frequency get asDegreesPerSecond => convertTo(FrequencyUnit.degreePerSecond);
}

/// Provides convenient factory methods for creating [Frequency] instances from [num].
extension FrequencyCreation on num {
  /// Creates a [Frequency] instance from this value in Hertz (Hz).
  ///
  /// The SI symbol for hertz is 'Hz' (capital H — named after Heinrich Hertz).
  Frequency get Hz => Frequency(toDouble(), FrequencyUnit.hertz);

  /// Creates a [Frequency] instance from this value in Hertz (Hz).
  /// Dart-idiomatic alias for the SI symbol [Hz].
  Frequency get hertz => Frequency(toDouble(), FrequencyUnit.hertz);

  /// Creates a [Frequency] instance from this value in Kilohertz (kHz).
  Frequency get kHz => Frequency(toDouble(), FrequencyUnit.kilohertz);

  /// Creates a [Frequency] instance from this value in Kilohertz (kHz).
  /// Dart-idiomatic alias for the SI symbol [kHz].
  Frequency get kilohertz => Frequency(toDouble(), FrequencyUnit.kilohertz);

  /// Creates a [Frequency] instance from this value in Megahertz (MHz).
  ///
  /// The SI symbol for megahertz is 'MHz' (capital M = mega, capital H = Hertz).
  Frequency get MHz => Frequency(toDouble(), FrequencyUnit.megahertz);

  /// Creates a [Frequency] instance from this value in Megahertz (MHz).
  /// Dart-idiomatic alias for the SI symbol [MHz].
  Frequency get megahertz => Frequency(toDouble(), FrequencyUnit.megahertz);

  /// Creates a [Frequency] instance from this value in Gigahertz (GHz).
  ///
  /// The SI symbol for gigahertz is 'GHz' (capital G = giga, capital H = Hertz).
  Frequency get GHz => Frequency(toDouble(), FrequencyUnit.gigahertz);

  /// Creates a [Frequency] instance from this value in Gigahertz (GHz).
  /// Dart-idiomatic alias for the SI symbol [GHz].
  Frequency get gigahertz => Frequency(toDouble(), FrequencyUnit.gigahertz);

  /// Creates a [Frequency] instance from this value in Terahertz (THz).
  ///
  /// The SI symbol for terahertz is 'THz' (capital T = tera, capital H = Hertz).
  Frequency get THz => Frequency(toDouble(), FrequencyUnit.terahertz);

  /// Creates a [Frequency] instance from this value in Terahertz (THz).
  /// Dart-idiomatic alias for the SI symbol [THz].
  Frequency get terahertz => Frequency(toDouble(), FrequencyUnit.terahertz);

  /// Creates a [Frequency] instance from this value in Millihertz (mHz).
  Frequency get mHz => Frequency(toDouble(), FrequencyUnit.millihertz);

  /// Creates a [Frequency] instance from this value in Millihertz (mHz).
  /// Alias for [mHz].
  Frequency get millihertz => Frequency(toDouble(), FrequencyUnit.millihertz);

  /// Creates a [Frequency] instance from this value in Revolutions per minute (rpm).
  ///
  /// This is functionally equivalent to the `rpm` extension in `AngularVelocity`.
  /// Use the one that is most semantically appropriate for your context.
  //Frequency get rpm => Frequency(toDouble(), FrequencyUnit.revolutionsPerMinute);

  /// Creates a [Frequency] instance from this value in Beats per minute (bpm).
  Frequency get bpm => Frequency(toDouble(), FrequencyUnit.beatsPerMinute);

  /// Creates a [Frequency] instance from this value in Radians per second (rad/s).
  ///
  /// Note: `radiansPerSecond` is intentionally omitted here to avoid extension
  /// ambiguity with `AngularVelocityCreation`, which already provides that alias.
  Frequency get radPerSec => Frequency(toDouble(), FrequencyUnit.radianPerSecond);

  /// Creates a [Frequency] instance from this value in Degrees per second (°/s).
  ///
  /// Note: `degreesPerSecond` is intentionally omitted here to avoid extension
  /// ambiguity with `AngularVelocityCreation`, which already provides that alias.
  Frequency get degPerSec => Frequency(toDouble(), FrequencyUnit.degreePerSecond);
}

/// Provides an alias for the `rpm` extension on `num` for creating [Frequency] instances.
extension FrequencyCreationRpm on num {
  /// Creates a [Frequency] instance from this value in Revolutions per minute (rpm).
  ///
  /// This is functionally equivalent to the `rpm` extension in `AngularVelocity`.
  /// Use the one that is most semantically appropriate for your context.
  Frequency get rpm => Frequency(toDouble(), FrequencyUnit.revolutionsPerMinute);
}
