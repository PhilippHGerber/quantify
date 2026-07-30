// Tests for `Unit.isSI` and `Unit.isMetric` across every implemented unit.
//
// Expectations here are defined independently of the implementation
// (TDD-style): each unit is classified by hand as SI / metric or not,
// based on standard measurement-system conventions. A failure means either
// the implementation or this classification needs to be reconciled — not
// necessarily that the implementation is wrong.
//
// isSI: true only for the single coherent SI unit of a quantity family.
// isMetric: true for SI base units, coherent SI derived units, and their
// decimal (SI-prefixed) multiples/submultiples. False for units merely
// *accepted for use with* the SI (degree, minute, hour, day, litre, tonne,
// hectare, …), other separately named non-SI metric-family units (bar,
// calorie, gravitational kgf-based units, gradian, ångström, carat, metric
// horsepower, …), imperial/US customary/nautical/astronomical/CGS units, and
// non-physical units (bit/byte and their prefixed forms — bit is not an SI
// unit, so kbit is not a decimal multiple of one). A compound unit is
// metric only if every factor is metric, so km/h, L/s, kWh, and g/mL are
// all false.
//
// Families that are purely logarithmic ratios (LevelRatio, PowerLevel,
// VoltageLevel, SoundPressureLevel) are always false for both getters.
// FuelConsumption and Information are always false for both isSI and
// isMetric (no member of either family is an SI unit).

import 'package:quantify/quantify.dart';
import 'package:test/test.dart';

void main() {
  void checkSI(String label, Map<Unit<dynamic>, bool> expectations) {
    group('$label isSI', () {
      for (final entry in expectations.entries) {
        test('${entry.key.symbol} isSI == ${entry.value}', () {
          expect(entry.key.isSI, entry.value);
        });
      }
    });
  }

  void checkMetric(String label, Map<Unit<dynamic>, bool> expectations) {
    group('$label isMetric', () {
      for (final entry in expectations.entries) {
        test('${entry.key.symbol} isMetric == ${entry.value}', () {
          expect(entry.key.isMetric, entry.value);
        });
      }
    });
  }

  // ---------------------------------------------------------------------
  // Acceleration
  // ---------------------------------------------------------------------
  checkSI('Acceleration', {
    AccelerationUnit.meterPerSecondSquared: true,
    AccelerationUnit.standardGravity: false,
    AccelerationUnit.kilometerPerHourPerSecond: false,
    AccelerationUnit.milePerHourPerSecond: false,
    AccelerationUnit.knotPerSecond: false,
    AccelerationUnit.footPerSecondSquared: false,
    AccelerationUnit.centimeterPerSecondSquared: false,
  });
  checkMetric('Acceleration', {
    AccelerationUnit.meterPerSecondSquared: true,
    AccelerationUnit.standardGravity: false,
    AccelerationUnit.kilometerPerHourPerSecond: false,
    AccelerationUnit.milePerHourPerSecond: false,
    AccelerationUnit.knotPerSecond: false,
    AccelerationUnit.footPerSecondSquared: false,
    AccelerationUnit.centimeterPerSecondSquared: true,
  });

  // ---------------------------------------------------------------------
  // Angle
  // ---------------------------------------------------------------------
  checkSI('Angle', {
    AngleUnit.radian: true,
    AngleUnit.degree: false,
    AngleUnit.gradian: false,
    AngleUnit.revolution: false,
    AngleUnit.arcminute: false,
    AngleUnit.arcsecond: false,
    AngleUnit.milliradian: false,
  });
  checkMetric('Angle', {
    AngleUnit.radian: true,
    AngleUnit.degree: false,
    AngleUnit.gradian: false,
    AngleUnit.revolution: false,
    AngleUnit.arcminute: false,
    AngleUnit.arcsecond: false,
    AngleUnit.milliradian: true,
  });

  // ---------------------------------------------------------------------
  // AngularVelocity
  // ---------------------------------------------------------------------
  checkSI('AngularVelocity', {
    AngularVelocityUnit.radianPerSecond: true,
    AngularVelocityUnit.degreePerSecond: false,
    AngularVelocityUnit.revolutionPerMinute: false,
    AngularVelocityUnit.revolutionPerSecond: false,
  });
  checkMetric('AngularVelocity', {
    AngularVelocityUnit.radianPerSecond: true,
    AngularVelocityUnit.degreePerSecond: false,
    AngularVelocityUnit.revolutionPerMinute: false,
    AngularVelocityUnit.revolutionPerSecond: false,
  });

  // ---------------------------------------------------------------------
  // Area
  // ---------------------------------------------------------------------
  checkSI('Area', {
    AreaUnit.squareMeter: true,
    AreaUnit.squareDecimeter: false,
    AreaUnit.squareCentimeter: false,
    AreaUnit.squareMillimeter: false,
    AreaUnit.squareMicrometer: false,
    AreaUnit.squareDecameter: false,
    AreaUnit.squareHectometer: false,
    AreaUnit.hectare: false,
    AreaUnit.squareKilometer: false,
    AreaUnit.squareMegameter: false,
    AreaUnit.squareInch: false,
    AreaUnit.squareFoot: false,
    AreaUnit.squareYard: false,
    AreaUnit.squareMile: false,
    AreaUnit.acre: false,
  });
  checkMetric('Area', {
    AreaUnit.squareMeter: true,
    AreaUnit.squareDecimeter: true,
    AreaUnit.squareCentimeter: true,
    AreaUnit.squareMillimeter: true,
    AreaUnit.squareMicrometer: true,
    AreaUnit.squareDecameter: true,
    AreaUnit.squareHectometer: true,
    AreaUnit.squareKilometer: true,
    AreaUnit.squareMegameter: true,
    AreaUnit.hectare: false,
    AreaUnit.squareInch: false,
    AreaUnit.squareFoot: false,
    AreaUnit.squareYard: false,
    AreaUnit.squareMile: false,
    AreaUnit.acre: false,
  });

  // ---------------------------------------------------------------------
  // Current
  // ---------------------------------------------------------------------
  checkSI('Current', {
    CurrentUnit.ampere: true,
    CurrentUnit.milliampere: false,
    CurrentUnit.microampere: false,
    CurrentUnit.nanoampere: false,
    CurrentUnit.picoampere: false,
    CurrentUnit.femtoampere: false,
    CurrentUnit.kiloampere: false,
    CurrentUnit.megaampere: false,
    CurrentUnit.gigaampere: false,
    CurrentUnit.statampere: false,
    CurrentUnit.abampere: false,
  });
  checkMetric('Current', {
    CurrentUnit.ampere: true,
    CurrentUnit.milliampere: true,
    CurrentUnit.microampere: true,
    CurrentUnit.nanoampere: true,
    CurrentUnit.picoampere: true,
    CurrentUnit.femtoampere: true,
    CurrentUnit.kiloampere: true,
    CurrentUnit.megaampere: true,
    CurrentUnit.gigaampere: true,
    CurrentUnit.statampere: false,
    CurrentUnit.abampere: false,
  });

  // ---------------------------------------------------------------------
  // Density
  // ---------------------------------------------------------------------
  checkSI('Density', {
    DensityUnit.kilogramPerCubicMeter: true,
    DensityUnit.gramPerCubicCentimeter: false,
    DensityUnit.gramPerMilliliter: false,
  });
  checkMetric('Density', {
    DensityUnit.kilogramPerCubicMeter: true,
    DensityUnit.gramPerCubicCentimeter: true,
    DensityUnit.gramPerMilliliter: false,
  });

  // ---------------------------------------------------------------------
  // ElectricCharge
  // ---------------------------------------------------------------------
  checkSI('ElectricCharge', {
    ElectricChargeUnit.coulomb: true,
    ElectricChargeUnit.kilocoulomb: false,
    ElectricChargeUnit.millicoulomb: false,
    ElectricChargeUnit.microcoulomb: false,
    ElectricChargeUnit.nanocoulomb: false,
    ElectricChargeUnit.picocoulomb: false,
    ElectricChargeUnit.elementaryCharge: false,
    ElectricChargeUnit.ampereHour: false,
    ElectricChargeUnit.milliampereHour: false,
    ElectricChargeUnit.statcoulomb: false,
    ElectricChargeUnit.franklin: false,
    ElectricChargeUnit.abcoulomb: false,
  });
  checkMetric('ElectricCharge', {
    ElectricChargeUnit.coulomb: true,
    ElectricChargeUnit.kilocoulomb: true,
    ElectricChargeUnit.millicoulomb: true,
    ElectricChargeUnit.microcoulomb: true,
    ElectricChargeUnit.nanocoulomb: true,
    ElectricChargeUnit.picocoulomb: true,
    ElectricChargeUnit.elementaryCharge: false,
    ElectricChargeUnit.ampereHour: false,
    ElectricChargeUnit.milliampereHour: false,
    ElectricChargeUnit.statcoulomb: false,
    ElectricChargeUnit.franklin: false,
    ElectricChargeUnit.abcoulomb: false,
  });

  // ---------------------------------------------------------------------
  // EnergyDensity
  // ---------------------------------------------------------------------
  checkSI('EnergyDensity', {
    EnergyDensityUnit.joulePerCubicMeter: true,
    EnergyDensityUnit.joulePerLiter: false,
    EnergyDensityUnit.wattHourPerLiter: false,
  });
  checkMetric('EnergyDensity', {
    EnergyDensityUnit.joulePerCubicMeter: true,
    EnergyDensityUnit.joulePerLiter: false,
    EnergyDensityUnit.wattHourPerLiter: false,
  });

  // ---------------------------------------------------------------------
  // Energy
  // ---------------------------------------------------------------------
  checkSI('Energy', {
    EnergyUnit.joule: true,
    EnergyUnit.millijoule: false,
    EnergyUnit.microjoule: false,
    EnergyUnit.kilojoule: false,
    EnergyUnit.megajoule: false,
    EnergyUnit.gigajoule: false,
    EnergyUnit.terajoule: false,
    EnergyUnit.calorie: false,
    EnergyUnit.calorieIT: false,
    EnergyUnit.kilocalorie: false,
    EnergyUnit.kilocalorieIT: false,
    EnergyUnit.wattHour: false,
    EnergyUnit.kilowattHour: false,
    EnergyUnit.electronvolt: false,
    EnergyUnit.btu: false,
  });
  checkMetric('Energy', {
    EnergyUnit.joule: true,
    EnergyUnit.millijoule: true,
    EnergyUnit.microjoule: true,
    EnergyUnit.kilojoule: true,
    EnergyUnit.megajoule: true,
    EnergyUnit.gigajoule: true,
    EnergyUnit.terajoule: true,
    EnergyUnit.calorie: false,
    EnergyUnit.calorieIT: false,
    EnergyUnit.kilocalorie: false,
    EnergyUnit.kilocalorieIT: false,
    EnergyUnit.wattHour: false,
    EnergyUnit.kilowattHour: false,
    EnergyUnit.electronvolt: false,
    EnergyUnit.btu: false,
  });

  // ---------------------------------------------------------------------
  // Force
  // ---------------------------------------------------------------------
  checkSI('Force', {
    ForceUnit.newton: true,
    ForceUnit.nanonewton: false,
    ForceUnit.micronewton: false,
    ForceUnit.millinewton: false,
    ForceUnit.kilonewton: false,
    ForceUnit.meganewton: false,
    ForceUnit.giganewton: false,
    ForceUnit.poundForce: false,
    ForceUnit.dyne: false,
    ForceUnit.kilogramForce: false,
    ForceUnit.gramForce: false,
    ForceUnit.poundal: false,
  });
  checkMetric('Force', {
    ForceUnit.newton: true,
    ForceUnit.nanonewton: true,
    ForceUnit.micronewton: true,
    ForceUnit.millinewton: true,
    ForceUnit.kilonewton: true,
    ForceUnit.meganewton: true,
    ForceUnit.giganewton: true,
    ForceUnit.poundForce: false,
    ForceUnit.dyne: false,
    ForceUnit.kilogramForce: false,
    ForceUnit.gramForce: false,
    ForceUnit.poundal: false,
  });

  // ---------------------------------------------------------------------
  // Frequency
  // ---------------------------------------------------------------------
  checkSI('Frequency', {
    FrequencyUnit.hertz: true,
    FrequencyUnit.terahertz: false,
    FrequencyUnit.gigahertz: false,
    FrequencyUnit.megahertz: false,
    FrequencyUnit.kilohertz: false,
    FrequencyUnit.millihertz: false,
    FrequencyUnit.revolutionsPerMinute: false,
    FrequencyUnit.beatsPerMinute: false,
    FrequencyUnit.radianPerSecond: false,
    FrequencyUnit.degreePerSecond: false,
  });
  checkMetric('Frequency', {
    FrequencyUnit.hertz: true,
    FrequencyUnit.terahertz: true,
    FrequencyUnit.gigahertz: true,
    FrequencyUnit.megahertz: true,
    FrequencyUnit.kilohertz: true,
    FrequencyUnit.millihertz: true,
    FrequencyUnit.revolutionsPerMinute: false,
    FrequencyUnit.beatsPerMinute: false,
    FrequencyUnit.radianPerSecond: true,
    FrequencyUnit.degreePerSecond: false,
  });

  // ---------------------------------------------------------------------
  // FuelConsumption — always non-SI and non-metric (litre-based or
  // imperial/US customary; inverse/non-linear family).
  // ---------------------------------------------------------------------
  checkSI('FuelConsumption', {
    FuelConsumptionUnit.litersPer100Km: false,
    FuelConsumptionUnit.kilometerPerLiter: false,
    FuelConsumptionUnit.mpgUs: false,
    FuelConsumptionUnit.mpgUk: false,
  });
  checkMetric('FuelConsumption', {
    FuelConsumptionUnit.litersPer100Km: false,
    FuelConsumptionUnit.kilometerPerLiter: false,
    FuelConsumptionUnit.mpgUs: false,
    FuelConsumptionUnit.mpgUk: false,
  });

  // ---------------------------------------------------------------------
  // Information — always non-SI and non-metric. Neither bit nor byte is an
  // SI unit, so their decimal-prefixed multiples are not decimal multiples
  // of an SI unit either; the binary (IEC, 1024-based) prefixed units are
  // excluded for that reason too.
  // ---------------------------------------------------------------------
  checkSI('Information', {
    for (final u in InformationUnit.values) u: false,
  });
  checkMetric('Information', {
    for (final u in InformationUnit.values) u: false,
  });

  // ---------------------------------------------------------------------
  // Length
  // ---------------------------------------------------------------------
  checkSI('Length', {
    LengthUnit.meter: true,
    LengthUnit.kilometer: false,
    LengthUnit.megameter: false,
    LengthUnit.gigameter: false,
    LengthUnit.hectometer: false,
    LengthUnit.decameter: false,
    LengthUnit.decimeter: false,
    LengthUnit.centimeter: false,
    LengthUnit.millimeter: false,
    LengthUnit.micrometer: false,
    LengthUnit.nanometer: false,
    LengthUnit.picometer: false,
    LengthUnit.femtometer: false,
    LengthUnit.inch: false,
    LengthUnit.foot: false,
    LengthUnit.yard: false,
    LengthUnit.mile: false,
    LengthUnit.nauticalMile: false,
    LengthUnit.astronomicalUnit: false,
    LengthUnit.lightYear: false,
    LengthUnit.parsec: false,
    LengthUnit.angstrom: false,
  });
  checkMetric('Length', {
    LengthUnit.meter: true,
    LengthUnit.kilometer: true,
    LengthUnit.megameter: true,
    LengthUnit.gigameter: true,
    LengthUnit.hectometer: true,
    LengthUnit.decameter: true,
    LengthUnit.decimeter: true,
    LengthUnit.centimeter: true,
    LengthUnit.millimeter: true,
    LengthUnit.micrometer: true,
    LengthUnit.nanometer: true,
    LengthUnit.picometer: true,
    LengthUnit.femtometer: true,
    LengthUnit.inch: false,
    LengthUnit.foot: false,
    LengthUnit.yard: false,
    LengthUnit.mile: false,
    LengthUnit.nauticalMile: false,
    LengthUnit.astronomicalUnit: false,
    LengthUnit.lightYear: false,
    LengthUnit.parsec: false,
    LengthUnit.angstrom: false,
  });

  // ---------------------------------------------------------------------
  // LevelRatio — purely logarithmic, always false for both.
  // ---------------------------------------------------------------------
  checkSI('LevelRatio', {
    LevelRatioUnit.decibel: false,
    LevelRatioUnit.neper: false,
  });
  checkMetric('LevelRatio', {
    LevelRatioUnit.decibel: false,
    LevelRatioUnit.neper: false,
  });

  // ---------------------------------------------------------------------
  // LuminousIntensity
  // ---------------------------------------------------------------------
  checkSI('LuminousIntensity', {
    LuminousIntensityUnit.candela: true,
    LuminousIntensityUnit.millicandela: false,
    LuminousIntensityUnit.microcandela: false,
    LuminousIntensityUnit.kilocandela: false,
    LuminousIntensityUnit.megacandela: false,
  });
  checkMetric('LuminousIntensity', {
    LuminousIntensityUnit.candela: true,
    LuminousIntensityUnit.millicandela: true,
    LuminousIntensityUnit.microcandela: true,
    LuminousIntensityUnit.kilocandela: true,
    LuminousIntensityUnit.megacandela: true,
  });

  // ---------------------------------------------------------------------
  // Mass
  // ---------------------------------------------------------------------
  checkSI('Mass', {
    MassUnit.kilogram: true,
    MassUnit.hectogram: false,
    MassUnit.decagram: false,
    MassUnit.gram: false,
    MassUnit.decigram: false,
    MassUnit.centigram: false,
    MassUnit.milligram: false,
    MassUnit.microgram: false,
    MassUnit.nanogram: false,
    MassUnit.megagram: false,
    MassUnit.gigagram: false,
    MassUnit.tonne: false,
    MassUnit.pound: false,
    MassUnit.ounce: false,
    MassUnit.stone: false,
    MassUnit.slug: false,
    MassUnit.shortTon: false,
    MassUnit.longTon: false,
    MassUnit.atomicMassUnit: false,
    MassUnit.carat: false,
  });
  checkMetric('Mass', {
    MassUnit.kilogram: true,
    MassUnit.hectogram: true,
    MassUnit.decagram: true,
    MassUnit.gram: true,
    MassUnit.decigram: true,
    MassUnit.centigram: true,
    MassUnit.milligram: true,
    MassUnit.microgram: true,
    MassUnit.nanogram: true,
    MassUnit.megagram: true,
    MassUnit.gigagram: true,
    MassUnit.tonne: false,
    MassUnit.pound: false,
    MassUnit.ounce: false,
    MassUnit.stone: false,
    MassUnit.slug: false,
    MassUnit.shortTon: false,
    MassUnit.longTon: false,
    MassUnit.atomicMassUnit: false,
    MassUnit.carat: false,
  });

  // ---------------------------------------------------------------------
  // MolarAmount
  // ---------------------------------------------------------------------
  checkSI('MolarAmount', {
    MolarUnit.mole: true,
    MolarUnit.megamole: false,
    MolarUnit.kilomole: false,
    MolarUnit.millimole: false,
    MolarUnit.micromole: false,
    MolarUnit.nanomole: false,
    MolarUnit.picomole: false,
    MolarUnit.femtomole: false,
    MolarUnit.poundMole: false,
  });
  checkMetric('MolarAmount', {
    MolarUnit.mole: true,
    MolarUnit.megamole: true,
    MolarUnit.kilomole: true,
    MolarUnit.millimole: true,
    MolarUnit.micromole: true,
    MolarUnit.nanomole: true,
    MolarUnit.picomole: true,
    MolarUnit.femtomole: true,
    MolarUnit.poundMole: false,
  });

  // ---------------------------------------------------------------------
  // PowerLevel — purely logarithmic, always false for both.
  // ---------------------------------------------------------------------
  checkSI('PowerLevel', {
    PowerLevelUnit.dBm: false,
    PowerLevelUnit.dBW: false,
  });
  checkMetric('PowerLevel', {
    PowerLevelUnit.dBm: false,
    PowerLevelUnit.dBW: false,
  });

  // ---------------------------------------------------------------------
  // Power
  // ---------------------------------------------------------------------
  checkSI('Power', {
    PowerUnit.watt: true,
    PowerUnit.nanowatt: false,
    PowerUnit.microwatt: false,
    PowerUnit.milliwatt: false,
    PowerUnit.kilowatt: false,
    PowerUnit.megawatt: false,
    PowerUnit.gigawatt: false,
    PowerUnit.terawatt: false,
    PowerUnit.horsepower: false,
    PowerUnit.metricHorsepower: false,
    PowerUnit.btuPerHour: false,
    PowerUnit.ergPerSecond: false,
  });
  checkMetric('Power', {
    PowerUnit.watt: true,
    PowerUnit.nanowatt: true,
    PowerUnit.microwatt: true,
    PowerUnit.milliwatt: true,
    PowerUnit.kilowatt: true,
    PowerUnit.megawatt: true,
    PowerUnit.gigawatt: true,
    PowerUnit.terawatt: true,
    PowerUnit.horsepower: false,
    PowerUnit.metricHorsepower: false,
    PowerUnit.btuPerHour: false,
    PowerUnit.ergPerSecond: false,
  });

  // ---------------------------------------------------------------------
  // Pressure
  // ---------------------------------------------------------------------
  checkSI('Pressure', {
    PressureUnit.pascal: true,
    PressureUnit.micropascal: false,
    PressureUnit.atmosphere: false,
    PressureUnit.bar: false,
    PressureUnit.psi: false,
    PressureUnit.torr: false,
    PressureUnit.millimeterOfMercury: false,
    PressureUnit.inchOfMercury: false,
    PressureUnit.gigapascal: false,
    PressureUnit.megapascal: false,
    PressureUnit.kilopascal: false,
    PressureUnit.hectopascal: false,
    PressureUnit.millibar: false,
    PressureUnit.centimeterOfWater: false,
    PressureUnit.inchOfWater: false,
  });
  checkMetric('Pressure', {
    PressureUnit.pascal: true,
    PressureUnit.micropascal: true,
    PressureUnit.atmosphere: false,
    PressureUnit.bar: false,
    PressureUnit.psi: false,
    PressureUnit.torr: false,
    PressureUnit.millimeterOfMercury: false,
    PressureUnit.inchOfMercury: false,
    PressureUnit.gigapascal: true,
    PressureUnit.megapascal: true,
    PressureUnit.kilopascal: true,
    PressureUnit.hectopascal: true,
    PressureUnit.millibar: false,
    PressureUnit.centimeterOfWater: false,
    PressureUnit.inchOfWater: false,
  });

  // ---------------------------------------------------------------------
  // Resistance
  // ---------------------------------------------------------------------
  checkSI('Resistance', {
    ResistanceUnit.ohm: true,
    ResistanceUnit.nanoohm: false,
    ResistanceUnit.microohm: false,
    ResistanceUnit.milliohm: false,
    ResistanceUnit.kiloohm: false,
    ResistanceUnit.megaohm: false,
    ResistanceUnit.gigaohm: false,
  });
  checkMetric('Resistance', {
    ResistanceUnit.ohm: true,
    ResistanceUnit.nanoohm: true,
    ResistanceUnit.microohm: true,
    ResistanceUnit.milliohm: true,
    ResistanceUnit.kiloohm: true,
    ResistanceUnit.megaohm: true,
    ResistanceUnit.gigaohm: true,
  });

  // ---------------------------------------------------------------------
  // SolidAngle
  // ---------------------------------------------------------------------
  checkSI('SolidAngle', {
    SolidAngleUnit.steradian: true,
    SolidAngleUnit.squareDegree: false,
    SolidAngleUnit.spat: false,
  });
  checkMetric('SolidAngle', {
    SolidAngleUnit.steradian: true,
    SolidAngleUnit.squareDegree: false,
    SolidAngleUnit.spat: false,
  });

  // ---------------------------------------------------------------------
  // SoundPressureLevel — purely logarithmic, always false for both.
  // ---------------------------------------------------------------------
  checkSI('SoundPressureLevel', {
    SoundPressureLevelUnit.decibelSpl: false,
  });
  checkMetric('SoundPressureLevel', {
    SoundPressureLevelUnit.decibelSpl: false,
  });

  // ---------------------------------------------------------------------
  // SpecificEnergy
  // ---------------------------------------------------------------------
  checkSI('SpecificEnergy', {
    SpecificEnergyUnit.joulePerKilogram: true,
    SpecificEnergyUnit.kilojoulePerKilogram: false,
    SpecificEnergyUnit.wattHourPerKilogram: false,
    SpecificEnergyUnit.kilowattHourPerKilogram: false,
  });
  checkMetric('SpecificEnergy', {
    SpecificEnergyUnit.joulePerKilogram: true,
    SpecificEnergyUnit.kilojoulePerKilogram: true,
    SpecificEnergyUnit.wattHourPerKilogram: false,
    SpecificEnergyUnit.kilowattHourPerKilogram: false,
  });

  // ---------------------------------------------------------------------
  // Speed
  // ---------------------------------------------------------------------
  checkSI('Speed', {
    SpeedUnit.meterPerSecond: true,
    SpeedUnit.kilometerPerSecond: false,
    SpeedUnit.kilometerPerHour: false,
    SpeedUnit.milePerHour: false,
    SpeedUnit.knot: false,
    SpeedUnit.footPerSecond: false,
  });
  checkMetric('Speed', {
    SpeedUnit.meterPerSecond: true,
    SpeedUnit.kilometerPerSecond: true,
    SpeedUnit.kilometerPerHour: false,
    SpeedUnit.milePerHour: false,
    SpeedUnit.knot: false,
    SpeedUnit.footPerSecond: false,
  });

  // ---------------------------------------------------------------------
  // TemperatureDelta
  // ---------------------------------------------------------------------
  checkSI('TemperatureDelta', {
    TemperatureDeltaUnit.kelvinDelta: true,
    TemperatureDeltaUnit.celsiusDelta: false,
    TemperatureDeltaUnit.fahrenheitDelta: false,
    TemperatureDeltaUnit.rankineDelta: false,
  });
  checkMetric('TemperatureDelta', {
    TemperatureDeltaUnit.kelvinDelta: true,
    TemperatureDeltaUnit.celsiusDelta: true,
    TemperatureDeltaUnit.fahrenheitDelta: false,
    TemperatureDeltaUnit.rankineDelta: false,
  });

  // ---------------------------------------------------------------------
  // Temperature
  // ---------------------------------------------------------------------
  checkSI('Temperature', {
    TemperatureUnit.kelvin: true,
    TemperatureUnit.celsius: false,
    TemperatureUnit.fahrenheit: false,
    TemperatureUnit.rankine: false,
  });
  checkMetric('Temperature', {
    TemperatureUnit.kelvin: true,
    TemperatureUnit.celsius: true,
    TemperatureUnit.fahrenheit: false,
    TemperatureUnit.rankine: false,
  });

  // ---------------------------------------------------------------------
  // Time
  // ---------------------------------------------------------------------
  checkSI('Time', {
    TimeUnit.second: true,
    TimeUnit.microsecond: false,
    TimeUnit.nanosecond: false,
    TimeUnit.picosecond: false,
    TimeUnit.millisecond: false,
    TimeUnit.centisecond: false,
    TimeUnit.decisecond: false,
    TimeUnit.decasecond: false,
    TimeUnit.hectosecond: false,
    TimeUnit.kilosecond: false,
    TimeUnit.megasecond: false,
    TimeUnit.gigasecond: false,
    TimeUnit.minute: false,
    TimeUnit.hour: false,
    TimeUnit.day: false,
    TimeUnit.week: false,
    TimeUnit.fortnight: false,
    TimeUnit.month: false,
    TimeUnit.year: false,
    TimeUnit.decade: false,
    TimeUnit.century: false,
  });
  checkMetric('Time', {
    TimeUnit.second: true,
    TimeUnit.microsecond: true,
    TimeUnit.nanosecond: true,
    TimeUnit.picosecond: true,
    TimeUnit.millisecond: true,
    TimeUnit.centisecond: true,
    TimeUnit.decisecond: true,
    TimeUnit.decasecond: true,
    TimeUnit.hectosecond: true,
    TimeUnit.kilosecond: true,
    TimeUnit.megasecond: true,
    TimeUnit.gigasecond: true,
    TimeUnit.minute: false,
    TimeUnit.hour: false,
    TimeUnit.day: false,
    TimeUnit.week: false,
    TimeUnit.fortnight: false,
    TimeUnit.month: false,
    TimeUnit.year: false,
    TimeUnit.decade: false,
    TimeUnit.century: false,
  });

  // ---------------------------------------------------------------------
  // Torque
  // ---------------------------------------------------------------------
  checkSI('Torque', {
    TorqueUnit.newtonMeter: true,
    TorqueUnit.millinewtonMeter: false,
    TorqueUnit.kilonewtonMeter: false,
    TorqueUnit.meganewtonMeter: false,
    TorqueUnit.poundFoot: false,
    TorqueUnit.poundInch: false,
    TorqueUnit.kilogramForceMeter: false,
    TorqueUnit.ounceForceInch: false,
    TorqueUnit.dyneCentimeter: false,
  });
  checkMetric('Torque', {
    TorqueUnit.newtonMeter: true,
    TorqueUnit.millinewtonMeter: true,
    TorqueUnit.kilonewtonMeter: true,
    TorqueUnit.meganewtonMeter: true,
    TorqueUnit.poundFoot: false,
    TorqueUnit.poundInch: false,
    TorqueUnit.kilogramForceMeter: false,
    TorqueUnit.ounceForceInch: false,
    TorqueUnit.dyneCentimeter: false,
  });

  // ---------------------------------------------------------------------
  // VoltageLevel — purely logarithmic, always false for both.
  // ---------------------------------------------------------------------
  checkSI('VoltageLevel', {
    VoltageLevelUnit.dBV: false,
    VoltageLevelUnit.dBu: false,
  });
  checkMetric('VoltageLevel', {
    VoltageLevelUnit.dBV: false,
    VoltageLevelUnit.dBu: false,
  });

  // ---------------------------------------------------------------------
  // Voltage
  // ---------------------------------------------------------------------
  checkSI('Voltage', {
    VoltageUnit.volt: true,
    VoltageUnit.nanovolt: false,
    VoltageUnit.microvolt: false,
    VoltageUnit.millivolt: false,
    VoltageUnit.kilovolt: false,
    VoltageUnit.megavolt: false,
    VoltageUnit.gigavolt: false,
    VoltageUnit.statvolt: false,
    VoltageUnit.abvolt: false,
  });
  checkMetric('Voltage', {
    VoltageUnit.volt: true,
    VoltageUnit.nanovolt: true,
    VoltageUnit.microvolt: true,
    VoltageUnit.millivolt: true,
    VoltageUnit.kilovolt: true,
    VoltageUnit.megavolt: true,
    VoltageUnit.gigavolt: true,
    VoltageUnit.statvolt: false,
    VoltageUnit.abvolt: false,
  });

  // ---------------------------------------------------------------------
  // Volume
  // ---------------------------------------------------------------------
  checkSI('Volume', {
    VolumeUnit.cubicMeter: true,
    VolumeUnit.cubicDecameter: false,
    VolumeUnit.cubicHectometer: false,
    VolumeUnit.cubicKilometer: false,
    VolumeUnit.cubicDecimeter: false,
    VolumeUnit.cubicCentimeter: false,
    VolumeUnit.cubicMillimeter: false,
    VolumeUnit.kiloliter: false,
    VolumeUnit.megaliter: false,
    VolumeUnit.gigaliter: false,
    VolumeUnit.teraliter: false,
    VolumeUnit.litre: false,
    VolumeUnit.milliliter: false,
    VolumeUnit.centiliter: false,
    VolumeUnit.microliter: false,
    VolumeUnit.cubicInch: false,
    VolumeUnit.cubicFoot: false,
    VolumeUnit.cubicMile: false,
    VolumeUnit.gallon: false,
    VolumeUnit.imperialGallon: false,
    VolumeUnit.quart: false,
    VolumeUnit.pint: false,
    VolumeUnit.fluidOunce: false,
    VolumeUnit.tablespoon: false,
    VolumeUnit.teaspoon: false,
  });
  checkMetric('Volume', {
    VolumeUnit.cubicMeter: true,
    VolumeUnit.cubicDecameter: true,
    VolumeUnit.cubicHectometer: true,
    VolumeUnit.cubicKilometer: true,
    VolumeUnit.cubicDecimeter: true,
    VolumeUnit.cubicCentimeter: true,
    VolumeUnit.cubicMillimeter: true,
    VolumeUnit.kiloliter: false,
    VolumeUnit.megaliter: false,
    VolumeUnit.gigaliter: false,
    VolumeUnit.teraliter: false,
    VolumeUnit.litre: false,
    VolumeUnit.milliliter: false,
    VolumeUnit.centiliter: false,
    VolumeUnit.microliter: false,
    VolumeUnit.cubicInch: false,
    VolumeUnit.cubicFoot: false,
    VolumeUnit.cubicMile: false,
    VolumeUnit.gallon: false,
    VolumeUnit.imperialGallon: false,
    VolumeUnit.quart: false,
    VolumeUnit.pint: false,
    VolumeUnit.fluidOunce: false,
    VolumeUnit.tablespoon: false,
    VolumeUnit.teaspoon: false,
  });

  // ---------------------------------------------------------------------
  // VolumetricFlowRate
  // ---------------------------------------------------------------------
  checkSI('VolumetricFlowRate', {
    VolumetricFlowRateUnit.cubicMeterPerSecond: true,
    VolumetricFlowRateUnit.cubicMeterPerMinute: false,
    VolumetricFlowRateUnit.cubicMeterPerHour: false,
    VolumetricFlowRateUnit.literPerSecond: false,
    VolumetricFlowRateUnit.literPerMinute: false,
    VolumetricFlowRateUnit.literPerHour: false,
    VolumetricFlowRateUnit.milliliterPerMinute: false,
    VolumetricFlowRateUnit.cubicFootPerSecond: false,
    VolumetricFlowRateUnit.cubicFootPerMinute: false,
    VolumetricFlowRateUnit.gallonPerMinute: false,
    VolumetricFlowRateUnit.gallonPerHour: false,
  });
  checkMetric('VolumetricFlowRate', {
    VolumetricFlowRateUnit.cubicMeterPerSecond: true,
    VolumetricFlowRateUnit.cubicMeterPerMinute: false,
    VolumetricFlowRateUnit.cubicMeterPerHour: false,
    VolumetricFlowRateUnit.literPerSecond: false,
    VolumetricFlowRateUnit.literPerMinute: false,
    VolumetricFlowRateUnit.literPerHour: false,
    VolumetricFlowRateUnit.milliliterPerMinute: false,
    VolumetricFlowRateUnit.cubicFootPerSecond: false,
    VolumetricFlowRateUnit.cubicFootPerMinute: false,
    VolumetricFlowRateUnit.gallonPerMinute: false,
    VolumetricFlowRateUnit.gallonPerHour: false,
  });

  // ---------------------------------------------------------------------
  // Every unit of every family must be classified above (completeness
  // guard): fails loudly if a new unit is added without updating this file.
  // ---------------------------------------------------------------------
  test('every unit is covered by this test file (completeness guard)', () {
    final allUnitLists = <List<Unit<dynamic>>>[
      AccelerationUnit.values,
      AngleUnit.values,
      AngularVelocityUnit.values,
      AreaUnit.values,
      CurrentUnit.values,
      DensityUnit.values,
      ElectricChargeUnit.values,
      EnergyDensityUnit.values,
      EnergyUnit.values,
      ForceUnit.values,
      FrequencyUnit.values,
      FuelConsumptionUnit.values,
      InformationUnit.values,
      LengthUnit.values,
      LevelRatioUnit.values,
      LuminousIntensityUnit.values,
      MassUnit.values,
      MolarUnit.values,
      PowerLevelUnit.values,
      PowerUnit.values,
      PressureUnit.values,
      ResistanceUnit.values,
      SolidAngleUnit.values,
      SoundPressureLevelUnit.values,
      SpecificEnergyUnit.values,
      SpeedUnit.values,
      TemperatureDeltaUnit.values,
      TemperatureUnit.values,
      TimeUnit.values,
      TorqueUnit.values,
      VoltageLevelUnit.values,
      VoltageUnit.values,
      VolumeUnit.values,
      VolumetricFlowRateUnit.values,
    ];
    final totalUnits = allUnitLists.fold<int>(0, (sum, list) => sum + list.length);
    // Bump this number when a new quantity/unit is added, after adding its
    // classification above.
    expect(totalUnits, 322);
  });

  test('every SI unit is also metric (isSI implies isMetric)', () {
    final allUnits = <Unit<dynamic>>[
      ...AccelerationUnit.values,
      ...AngleUnit.values,
      ...AngularVelocityUnit.values,
      ...AreaUnit.values,
      ...CurrentUnit.values,
      ...DensityUnit.values,
      ...ElectricChargeUnit.values,
      ...EnergyDensityUnit.values,
      ...EnergyUnit.values,
      ...ForceUnit.values,
      ...FrequencyUnit.values,
      ...FuelConsumptionUnit.values,
      ...InformationUnit.values,
      ...LengthUnit.values,
      ...LevelRatioUnit.values,
      ...LuminousIntensityUnit.values,
      ...MassUnit.values,
      ...MolarUnit.values,
      ...PowerLevelUnit.values,
      ...PowerUnit.values,
      ...PressureUnit.values,
      ...ResistanceUnit.values,
      ...SolidAngleUnit.values,
      ...SoundPressureLevelUnit.values,
      ...SpecificEnergyUnit.values,
      ...SpeedUnit.values,
      ...TemperatureDeltaUnit.values,
      ...TemperatureUnit.values,
      ...TimeUnit.values,
      ...TorqueUnit.values,
      ...VoltageLevelUnit.values,
      ...VoltageUnit.values,
      ...VolumeUnit.values,
      ...VolumetricFlowRateUnit.values,
    ];
    for (final unit in allUnits) {
      if (unit.isSI) {
        expect(
          unit.isMetric,
          isTrue,
          reason: '${unit.symbol} is SI but not classified as metric',
        );
      }
    }
  });
}
