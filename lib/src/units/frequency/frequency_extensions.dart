import 'frequency.dart';
import 'frequency_unit.dart';

/// Provides convenient access to [Frequency] values in specific units.
extension FrequencyValueGetters on Frequency {
  /// Returns the frequency value in Hertz (Hz).
  double get inHertz => getValue(FrequencyUnit.hertz);

  /// Returns the frequency value in Gigahertz (GHz).
  double get inGigahertz => getValue(FrequencyUnit.gigahertz);

  /// Returns the frequency value in Megahertz (MHz).
  double get inMegahertz => getValue(FrequencyUnit.megahertz);

  /// Returns the frequency value in Kilohertz (kHz).
  double get inKilohertz => getValue(FrequencyUnit.kilohertz);

  /// Returns the frequency value in Revolutions per minute (rpm).
  double get inRevolutionsPerMinute => getValue(FrequencyUnit.revolutionsPerMinute);

  /// Returns the frequency value in Beats per minute (bpm).
  double get inBeatsPerMinute => getValue(FrequencyUnit.beatsPerMinute);

  /// Returns a new [Frequency] object representing this frequency in Hertz (Hz).
  Frequency get asHertz => convertTo(FrequencyUnit.hertz);

  /// Returns a new [Frequency] object representing this frequency in Gigahertz (GHz).
  Frequency get asGigahertz => convertTo(FrequencyUnit.gigahertz);

  /// Returns a new [Frequency] object representing this frequency in Megahertz (MHz).
  Frequency get asMegahertz => convertTo(FrequencyUnit.megahertz);

  /// Returns a new [Frequency] object representing this frequency in Kilohertz (kHz).
  Frequency get asKilohertz => convertTo(FrequencyUnit.kilohertz);

  /// Returns a new [Frequency] object representing this frequency in Revolutions per minute (rpm).
  Frequency get asRevolutionsPerMinute => convertTo(FrequencyUnit.revolutionsPerMinute);

  /// Returns a new [Frequency] object representing this frequency in Beats per minute (bpm).
  Frequency get asBeatsPerMinute => convertTo(FrequencyUnit.beatsPerMinute);
}

/// Provides convenient factory methods for creating [Frequency] instances from [num].
extension FrequencyCreation on num {
  /// Creates a [Frequency] instance from this value in Hertz (Hz).
  Frequency get hz => Frequency(toDouble(), FrequencyUnit.hertz);

  /// Creates a [Frequency] instance from this value in Gigahertz (GHz).
  Frequency get ghz => Frequency(toDouble(), FrequencyUnit.gigahertz);

  /// Creates a [Frequency] instance from this value in Megahertz (MHz).
  Frequency get mhz => Frequency(toDouble(), FrequencyUnit.megahertz);

  /// Creates a [Frequency] instance from this value in Kilohertz (kHz).
  Frequency get khz => Frequency(toDouble(), FrequencyUnit.kilohertz);

  /// Creates a [Frequency] instance from this value in Revolutions per minute (rpm).
  ///
  /// This is functionally equivalent to the `rpm` extension in `AngularVelocity`.
  /// Use the one that is most semantically appropriate for your context.
  //Frequency get rpm => Frequency(toDouble(), FrequencyUnit.revolutionsPerMinute);

  /// Creates a [Frequency] instance from this value in Beats per minute (bpm).
  Frequency get bpm => Frequency(toDouble(), FrequencyUnit.beatsPerMinute);
}

/// Provides an alias for the `rpm` extension on `num` for creating [Frequency] instances.
extension FrequencyCreationRpm on num {
  /// Creates a [Frequency] instance from this value in Revolutions per minute (rpm).
  ///
  /// This is functionally equivalent to the `rpm` extension in `AngularVelocity`.
  /// Use the one that is most semantically appropriate for your context.
  Frequency get rpm => Frequency(toDouble(), FrequencyUnit.revolutionsPerMinute);
}
