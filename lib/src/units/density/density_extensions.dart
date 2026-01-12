import 'density.dart';
import 'density_unit.dart';

/// Provides convenient access to [Density] values in specific units.
extension DensityValueGetters on Density {
  /// Returns the density value in Kilograms per Cubic Meter (kg/m³).
  double get inKilogramsPerCubicMeter => getValue(DensityUnit.kilogramPerCubicMeter);

  /// Returns the density value in Grams per Cubic Centimeter (g/cm³).
  double get inGramsPerCubicCentimeter => getValue(DensityUnit.gramPerCubicCentimeter);

  /// Returns the density value in Grams per Milliliter (g/mL).
  double get inGramsPerMilliliter => getValue(DensityUnit.gramPerMilliliter);

  /// Returns a new [Density] object representing this density in Kilograms per Cubic Meter (kg/m³).
  Density get asKilogramsPerCubicMeter => convertTo(DensityUnit.kilogramPerCubicMeter);

  /// Returns a new [Density] object representing this density in Grams per Cubic Centimeter (g/cm³).
  Density get asGramsPerCubicCentimeter => convertTo(DensityUnit.gramPerCubicCentimeter);

  /// Returns a new [Density] object representing this density in Grams per Milliliter (g/mL).
  Density get asGramsPerMilliliter => convertTo(DensityUnit.gramPerMilliliter);
}

/// Provides convenient factory methods for creating [Density] instances from [num].
extension DensityCreation on num {
  /// Creates a [Density] instance from this value in Kilograms per Cubic Meter (kg/m³).
  Density get kgPerM3 => Density(toDouble(), DensityUnit.kilogramPerCubicMeter);

  /// Creates a [Density] instance from this value in Grams per Cubic Centimeter (g/cm³).
  Density get gPerCm3 => Density(toDouble(), DensityUnit.gramPerCubicCentimeter);

  /// Creates a [Density] instance from this value in Grams per Milliliter (g/mL).
  Density get gPerMl => Density(toDouble(), DensityUnit.gramPerMilliliter);
}
