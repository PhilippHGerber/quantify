import 'volumetric_flow_rate.dart';
import 'volumetric_flow_rate_unit.dart';

/// Provides convenient access to [VolumetricFlowRate] values in specific units.
extension VolumetricFlowRateValueGetters on VolumetricFlowRate {
  /// Returns the flow rate value in Cubic meters per second (m³/s).
  double get inCubicMetersPerSecond => getValue(VolumetricFlowRateUnit.cubicMeterPerSecond);

  /// Returns the flow rate value in Cubic meters per minute (m³/min).
  double get inCubicMetersPerMinute => getValue(VolumetricFlowRateUnit.cubicMeterPerMinute);

  /// Returns the flow rate value in Cubic meters per hour (m³/h).
  double get inCubicMetersPerHour => getValue(VolumetricFlowRateUnit.cubicMeterPerHour);

  /// Returns the flow rate value in Liters per second (L/s).
  double get inLitersPerSecond => getValue(VolumetricFlowRateUnit.literPerSecond);

  /// Returns the flow rate value in Liters per minute (L/min).
  double get inLitersPerMinute => getValue(VolumetricFlowRateUnit.literPerMinute);

  /// Returns the flow rate value in Liters per hour (L/h).
  double get inLitersPerHour => getValue(VolumetricFlowRateUnit.literPerHour);

  /// Returns the flow rate value in Milliliters per minute (mL/min).
  double get inMillilitersPerMinute => getValue(VolumetricFlowRateUnit.milliliterPerMinute);

  /// Returns the flow rate value in Cubic feet per second (ft³/s).
  double get inCubicFeetPerSecond => getValue(VolumetricFlowRateUnit.cubicFootPerSecond);

  /// Returns the flow rate value in Cubic feet per minute (ft³/min).
  double get inCubicFeetPerMinute => getValue(VolumetricFlowRateUnit.cubicFootPerMinute);

  /// Returns the flow rate value in US Gallons per minute (gal/min).
  double get inGallonsPerMinute => getValue(VolumetricFlowRateUnit.gallonPerMinute);

  /// Returns the flow rate value in US Gallons per hour (gal/h).
  double get inGallonsPerHour => getValue(VolumetricFlowRateUnit.gallonPerHour);

  /// Returns a [VolumetricFlowRate] object representing this flow rate in
  /// Cubic meters per second (m³/s).
  VolumetricFlowRate get asCubicMetersPerSecond =>
      convertTo(VolumetricFlowRateUnit.cubicMeterPerSecond);

  /// Returns a [VolumetricFlowRate] object representing this flow rate in
  /// Cubic meters per minute (m³/min).
  VolumetricFlowRate get asCubicMetersPerMinute =>
      convertTo(VolumetricFlowRateUnit.cubicMeterPerMinute);

  /// Returns a [VolumetricFlowRate] object representing this flow rate in
  /// Cubic meters per hour (m³/h).
  VolumetricFlowRate get asCubicMetersPerHour =>
      convertTo(VolumetricFlowRateUnit.cubicMeterPerHour);

  /// Returns a [VolumetricFlowRate] object representing this flow rate in
  /// Liters per second (L/s).
  VolumetricFlowRate get asLitersPerSecond => convertTo(VolumetricFlowRateUnit.literPerSecond);

  /// Returns a [VolumetricFlowRate] object representing this flow rate in
  /// Liters per minute (L/min).
  VolumetricFlowRate get asLitersPerMinute => convertTo(VolumetricFlowRateUnit.literPerMinute);

  /// Returns a [VolumetricFlowRate] object representing this flow rate in
  /// Liters per hour (L/h).
  VolumetricFlowRate get asLitersPerHour => convertTo(VolumetricFlowRateUnit.literPerHour);

  /// Returns a [VolumetricFlowRate] object representing this flow rate in
  /// Milliliters per minute (mL/min).
  VolumetricFlowRate get asMillilitersPerMinute =>
      convertTo(VolumetricFlowRateUnit.milliliterPerMinute);

  /// Returns a [VolumetricFlowRate] object representing this flow rate in
  /// Cubic feet per second (ft³/s).
  VolumetricFlowRate get asCubicFeetPerSecond =>
      convertTo(VolumetricFlowRateUnit.cubicFootPerSecond);

  /// Returns a [VolumetricFlowRate] object representing this flow rate in
  /// Cubic feet per minute (ft³/min).
  VolumetricFlowRate get asCubicFeetPerMinute =>
      convertTo(VolumetricFlowRateUnit.cubicFootPerMinute);

  /// Returns a [VolumetricFlowRate] object representing this flow rate in
  /// US Gallons per minute (gal/min).
  VolumetricFlowRate get asGallonsPerMinute => convertTo(VolumetricFlowRateUnit.gallonPerMinute);

  /// Returns a [VolumetricFlowRate] object representing this flow rate in
  /// US Gallons per hour (gal/h).
  VolumetricFlowRate get asGallonsPerHour => convertTo(VolumetricFlowRateUnit.gallonPerHour);
}

/// Provides convenient factory methods for creating [VolumetricFlowRate]
/// instances from [num].
extension VolumetricFlowRateCreation on num {
  /// Creates a [VolumetricFlowRate] instance from this value in
  /// Cubic meters per second (m³/s).
  VolumetricFlowRate get cubicMetersPerSecond =>
      VolumetricFlowRate(toDouble(), VolumetricFlowRateUnit.cubicMeterPerSecond);

  /// Creates a [VolumetricFlowRate] instance from this value in
  /// Cubic meters per minute (m³/min).
  VolumetricFlowRate get cubicMetersPerMinute =>
      VolumetricFlowRate(toDouble(), VolumetricFlowRateUnit.cubicMeterPerMinute);

  /// Creates a [VolumetricFlowRate] instance from this value in
  /// Cubic meters per hour (m³/h).
  VolumetricFlowRate get cubicMetersPerHour =>
      VolumetricFlowRate(toDouble(), VolumetricFlowRateUnit.cubicMeterPerHour);

  /// Creates a [VolumetricFlowRate] instance from this value in
  /// Liters per second (L/s).
  VolumetricFlowRate get litersPerSecond =>
      VolumetricFlowRate(toDouble(), VolumetricFlowRateUnit.literPerSecond);

  /// Creates a [VolumetricFlowRate] instance from this value in
  /// Liters per minute (L/min).
  VolumetricFlowRate get litersPerMinute =>
      VolumetricFlowRate(toDouble(), VolumetricFlowRateUnit.literPerMinute);

  /// Creates a [VolumetricFlowRate] instance from this value in
  /// Liters per hour (L/h).
  VolumetricFlowRate get litersPerHour =>
      VolumetricFlowRate(toDouble(), VolumetricFlowRateUnit.literPerHour);

  /// Creates a [VolumetricFlowRate] instance from this value in
  /// Milliliters per minute (mL/min).
  VolumetricFlowRate get millilitersPerMinute =>
      VolumetricFlowRate(toDouble(), VolumetricFlowRateUnit.milliliterPerMinute);

  /// Creates a [VolumetricFlowRate] instance from this value in
  /// Cubic feet per second (ft³/s).
  VolumetricFlowRate get cubicFeetPerSecond =>
      VolumetricFlowRate(toDouble(), VolumetricFlowRateUnit.cubicFootPerSecond);

  /// Creates a [VolumetricFlowRate] instance from this value in
  /// Cubic feet per minute (ft³/min).
  VolumetricFlowRate get cubicFeetPerMinute =>
      VolumetricFlowRate(toDouble(), VolumetricFlowRateUnit.cubicFootPerMinute);

  /// Creates a [VolumetricFlowRate] instance from this value in
  /// US Gallons per minute (gal/min).
  VolumetricFlowRate get gallonsPerMinute =>
      VolumetricFlowRate(toDouble(), VolumetricFlowRateUnit.gallonPerMinute);

  /// Creates a [VolumetricFlowRate] instance from this value in
  /// US Gallons per hour (gal/h).
  VolumetricFlowRate get gallonsPerHour =>
      VolumetricFlowRate(toDouble(), VolumetricFlowRateUnit.gallonPerHour);
}
