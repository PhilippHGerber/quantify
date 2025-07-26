// lib/src/units/power/power_extensions.dart

import 'power.dart';
import 'power_unit.dart';

/// Provides convenient access to [Power] values in specific units
/// using getter properties.
extension PowerValueGetters on Power {
  // --- SI Units ---
  /// Returns the power value in Watts (W).
  double get inWatts => getValue(PowerUnit.watt);

  /// Returns the power value in Milliwatts (mW).
  double get inMilliwatts => getValue(PowerUnit.milliwatt);

  /// Returns the power value in Kilowatts (kW).
  double get inKilowatts => getValue(PowerUnit.kilowatt);

  /// Returns the power value in Megawatts (MW).
  double get inMegawatts => getValue(PowerUnit.megawatt);

  /// Returns the power value in Gigawatts (GW).
  double get inGigawatts => getValue(PowerUnit.gigawatt);

  // --- Engineering / Common Units ---
  /// Returns the power value in mechanical Horsepower (hp).
  double get inHorsepower => getValue(PowerUnit.horsepower);

  /// Returns the power value in metric Horsepower (PS).
  double get inMetricHorsepower => getValue(PowerUnit.metricHorsepower);

  /// Returns the power value in British Thermal Units per hour (Btu/h).
  double get inBtuPerHour => getValue(PowerUnit.btuPerHour);

  // --- CGS Units ---
  /// Returns the power value in Ergs per second (erg/s).
  double get inErgPerSecond => getValue(PowerUnit.ergPerSecond);

  // --- "As" Getters for new Power objects ---

  /// Returns a new [Power] object representing this power in Watts (W).
  Power get asWatts => convertTo(PowerUnit.watt);

  /// Returns a new [Power] object representing this power in Milliwatts (mW).
  Power get asMilliwatts => convertTo(PowerUnit.milliwatt);

  /// Returns a new [Power] object representing this power in Kilowatts (kW).
  Power get asKilowatts => convertTo(PowerUnit.kilowatt);

  /// Returns a new [Power] object representing this power in Megawatts (MW).
  Power get asMegawatts => convertTo(PowerUnit.megawatt);

  /// Returns a new [Power] object representing this power in Gigawatts (GW).
  Power get asGigawatts => convertTo(PowerUnit.gigawatt);

  /// Returns a new [Power] object representing this power in mechanical Horsepower (hp).
  Power get asHorsepower => convertTo(PowerUnit.horsepower);

  /// Returns a new [Power] object representing this power in metric Horsepower (PS).
  Power get asMetricHorsepower => convertTo(PowerUnit.metricHorsepower);

  /// Returns a new [Power] object representing this power in British Thermal Units per hour (Btu/h).
  Power get asBtuPerHour => convertTo(PowerUnit.btuPerHour);

  /// Returns a new [Power] object representing this power in Ergs per second (erg/s).
  Power get asErgPerSecond => convertTo(PowerUnit.ergPerSecond);
}

/// Provides convenient factory methods for creating [Power] instances from [num].
extension PowerCreation on num {
  // --- SI Units ---
  /// Creates a [Power] instance from this value in Watts (W).
  Power get W => Power(toDouble(), PowerUnit.watt);

  /// Creates a [Power] instance from this value in Watts (W).
  Power get watts => Power(toDouble(), PowerUnit.watt);

  /// Creates a [Power] instance from this value in Milliwatts (mW).
  Power get mW => Power(toDouble(), PowerUnit.milliwatt);

  /// Creates a [Power] instance from this value in Milliwatts (mW).
  Power get milliwatts => Power(toDouble(), PowerUnit.milliwatt);

  /// Creates a [Power] instance from this value in Kilowatts (kW).
  Power get kW => Power(toDouble(), PowerUnit.kilowatt);

  /// Creates a [Power] instance from this value in Kilowatts (kW).
  Power get kilowatts => Power(toDouble(), PowerUnit.kilowatt);

  /// Creates a [Power] instance from this value in Megawatts (MW).
  Power get megaW => Power(toDouble(), PowerUnit.megawatt);

  /// Creates a [Power] instance from this value in Megawatts (MW).
  Power get megawatts => Power(toDouble(), PowerUnit.megawatt);

  /// Creates a [Power] instance from this value in Gigawatts (GW).
  Power get gigaW => Power(toDouble(), PowerUnit.gigawatt);

  /// Creates a [Power] instance from this value in Gigawatts (GW).
  Power get gigawatts => Power(toDouble(), PowerUnit.gigawatt);

  // --- Engineering / Common Units ---

  /// Creates a [Power] instance from this value in mechanical Horsepower (hp).
  Power get hp => Power(toDouble(), PowerUnit.horsepower);

  /// Creates a [Power] instance from this value in metric Horsepower (PS).
  Power get metricHp => Power(toDouble(), PowerUnit.metricHorsepower);

  /// Creates a [Power] instance from this value in British Thermal Units per hour (Btu/h).
  Power get btuPerHour => Power(toDouble(), PowerUnit.btuPerHour);

  // --- CGS Units ---

  /// Creates a [Power] instance from this value in Ergs per second (erg/s).
  Power get ergPerSecond => Power(toDouble(), PowerUnit.ergPerSecond);
}
