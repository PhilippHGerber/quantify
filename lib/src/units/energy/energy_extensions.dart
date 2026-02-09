import 'energy.dart';
import 'energy_unit.dart';

/// Provides convenient access to [Energy] values in specific units
/// using getter properties.
///
/// These getters simplify retrieving the numerical value of an energy
/// in a desired unit without explicitly calling `getValue()`.
extension EnergyValueGetters on Energy {
  /// Returns the energy value in Joules (J).
  double get inJoules => getValue(EnergyUnit.joule);

  /// Returns the energy value in Megajoules (MJ).
  double get inMegajoules => getValue(EnergyUnit.megajoule);

  /// Returns the energy value in Kilojoules (kJ).
  double get inKilojoules => getValue(EnergyUnit.kilojoule);

  /// Returns the energy value in Calories (cal).
  double get inCalories => getValue(EnergyUnit.calorie);

  /// Returns the energy value in International Table Calories (cal_IT).
  double get inCaloriesIT => getValue(EnergyUnit.calorieIT);

  /// Returns the energy value in Kilocalories (kcal).
  double get inKilocalories => getValue(EnergyUnit.kilocalorie);

  /// Returns the energy value in International Table Kilocalories (kcal_IT).
  double get inKilocaloriesIT => getValue(EnergyUnit.kilocalorieIT);

  /// Returns the energy value in Kilowatt-hours (kWh).
  double get inKilowattHours => getValue(EnergyUnit.kilowattHour);

  /// Returns the energy value in Electronvolts (eV).
  double get inElectronvolts => getValue(EnergyUnit.electronvolt);

  /// Returns the energy value in British Thermal Units (Btu).
  double get inBtu => getValue(EnergyUnit.btu);

  // --- "As" Getters for new Energy objects ---

  /// Returns a new [Energy] object representing this energy in Joules (J).
  Energy get asJoules => convertTo(EnergyUnit.joule);

  /// Returns a new [Energy] object representing this energy in Megajoules (MJ).
  Energy get asMegajoules => convertTo(EnergyUnit.megajoule);

  /// Returns a new [Energy] object representing this energy in Kilojoules (kJ).
  Energy get asKilojoules => convertTo(EnergyUnit.kilojoule);

  /// Returns a new [Energy] object representing this energy in Calories (cal).
  Energy get asCalories => convertTo(EnergyUnit.calorie);

  /// Returns a new [Energy] object representing this energy in IT Calories (cal_IT).
  Energy get asCaloriesIT => convertTo(EnergyUnit.calorieIT);

  /// Returns a new [Energy] object representing this energy in Kilocalories (kcal).
  Energy get asKilocalories => convertTo(EnergyUnit.kilocalorie);

  /// Returns a new [Energy] object representing this energy in IT Kilocalories (kcal_IT).
  Energy get asKilocaloriesIT => convertTo(EnergyUnit.kilocalorieIT);

  /// Returns a new [Energy] object representing this energy in Kilowatt-hours (kWh).
  Energy get asKilowattHours => convertTo(EnergyUnit.kilowattHour);

  /// Returns a new [Energy] object representing this energy in Electronvolts (eV).
  Energy get asElectronvolts => convertTo(EnergyUnit.electronvolt);

  /// Returns a new [Energy] object representing this energy in British Thermal Units (Btu).
  Energy get asBtu => convertTo(EnergyUnit.btu);
}

/// Provides convenient factory methods for creating [Energy] instances from [num]
/// using getter properties named after common unit symbols or names.
///
/// This allows for an intuitive and concise way to create energy quantities,
/// for example: `250.kcal` or `1.2.kWh`.
extension EnergyCreation on num {
  /// Creates an [Energy] instance from this value in Joules (J).
  Energy get J => Energy(toDouble(), EnergyUnit.joule);

  /// Creates an [Energy] instance from this value in Joules (J).
  Energy get joules => Energy(toDouble(), EnergyUnit.joule);

  /// Creates an [Energy] instance from this value in Megajoules (MJ).
  Energy get megaJ => Energy(toDouble(), EnergyUnit.megajoule);

  /// Creates an [Energy] instance from this value in Megajoules (MJ).
  Energy get megajoules => Energy(toDouble(), EnergyUnit.megajoule);

  /// Creates an [Energy] instance from this value in Kilojoules (kJ).
  Energy get kJ => Energy(toDouble(), EnergyUnit.kilojoule);

  /// Creates an [Energy] instance from this value in Kilojoules (kJ).
  Energy get kilojoules => Energy(toDouble(), EnergyUnit.kilojoule);

  /// Creates an [Energy] instance from this value in Calories (cal).
  Energy get cal => Energy(toDouble(), EnergyUnit.calorie);

  /// Creates an [Energy] instance from this value in Calories (cal).
  Energy get calories => Energy(toDouble(), EnergyUnit.calorie);

  /// Creates an [Energy] instance from this value in International Table Calories (cal_IT).
  Energy get calIT => Energy(toDouble(), EnergyUnit.calorieIT);

  /// Creates an [Energy] instance from this value in International Table Calories (cal_IT).
  Energy get caloriesIT => Energy(toDouble(), EnergyUnit.calorieIT);

  /// Creates an [Energy] instance from this value in Kilocalories (kcal).
  Energy get kcal => Energy(toDouble(), EnergyUnit.kilocalorie);

  /// Creates an [Energy] instance from this value in Kilocalories (kcal).
  Energy get kilocalories => Energy(toDouble(), EnergyUnit.kilocalorie);

  /// Creates an [Energy] instance from this value in International Table Kilocalories (kcal_IT).
  Energy get kcalIT => Energy(toDouble(), EnergyUnit.kilocalorieIT);

  /// Creates an [Energy] instance from this value in International Table Kilocalories (kcal_IT).
  Energy get kilocaloriesIT => Energy(toDouble(), EnergyUnit.kilocalorieIT);

  /// Creates an [Energy] instance from this value in Kilowatt-hours (kWh).
  Energy get kWh => Energy(toDouble(), EnergyUnit.kilowattHour);

  /// Creates an [Energy] instance from this value in Kilowatt-hours (kWh).
  Energy get kilowattHours => Energy(toDouble(), EnergyUnit.kilowattHour);

  /// Creates an [Energy] instance from this value in Electronvolts (eV).
  Energy get eV => Energy(toDouble(), EnergyUnit.electronvolt);

  /// Creates an [Energy] instance from this value in Electronvolts (eV).
  Energy get electronvolts => Energy(toDouble(), EnergyUnit.electronvolt);

  /// Creates an [Energy] instance from this value in British Thermal Units (Btu).
  Energy get btu => Energy(toDouble(), EnergyUnit.btu);
}
