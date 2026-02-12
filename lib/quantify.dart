/// A type-safe library for units of measurement,
/// providing elegant syntax for unit conversions.
library;

// Exporting core classes for quantities and units
export 'src/core/quantity.dart';
export 'src/core/unit.dart';
// Exporting units and their extensions for acceleration
export 'src/units/acceleration/acceleration.dart';
export 'src/units/acceleration/acceleration_extensions.dart';
export 'src/units/acceleration/acceleration_unit.dart';
// Exporting units and their extensions for angle
export 'src/units/angle/angle.dart';
export 'src/units/angle/angle_extensions.dart';
export 'src/units/angle/angle_unit.dart';
// Exporting units and their extensions for angular velocity
export 'src/units/angular_velocity/angular_velocity.dart';
export 'src/units/angular_velocity/angular_velocity_extensions.dart';
export 'src/units/angular_velocity/angular_velocity_unit.dart';
// Exporting units and their extensions for area
export 'src/units/area/area.dart';
export 'src/units/area/area_extensions.dart';
export 'src/units/area/area_unit.dart';
// Exporting units and their extensions for electric current
export 'src/units/current/current.dart';
export 'src/units/current/current_extensions.dart';
export 'src/units/current/current_unit.dart';
// Exporting units and their extensions for density
export 'src/units/density/density.dart';
export 'src/units/density/density_extensions.dart';
export 'src/units/density/density_unit.dart';
// Exporting units and their extensions for electric charge
export 'src/units/electric_charge/electric_charge.dart';
export 'src/units/electric_charge/electric_charge_extensions.dart';
export 'src/units/electric_charge/electric_charge_unit.dart';
// Exporting units and their extensions for energy
export 'src/units/energy/energy.dart';
export 'src/units/energy/energy_extensions.dart';
export 'src/units/energy/energy_unit.dart';
// Exporting units and their extensions for force
export 'src/units/force/force.dart';
export 'src/units/force/force_extensions.dart';
export 'src/units/force/force_unit.dart';
// Exporting units and their extensions for frequency
export 'src/units/frequency/frequency.dart';
// FrequencyCreationRpm is hidden because its `.rpm` getter conflicts with
// AngularVelocityCreation.rpm from angular_velocity_extensions.dart.
// Use angular_velocity_extensions.dart for `.rpm` (returns AngularVelocity).
export 'src/units/frequency/frequency_extensions.dart' hide FrequencyCreationRpm;
export 'src/units/frequency/frequency_interop.dart';
export 'src/units/frequency/frequency_unit.dart';
// Exporting units and their extensions for length
export 'src/units/length/length.dart';
export 'src/units/length/length_extensions.dart';
export 'src/units/length/length_unit.dart';
// Exporting units and their extensions for luminous intensity
export 'src/units/luminous/luminous_intensity.dart';
export 'src/units/luminous/luminous_intensity_extensions.dart';
export 'src/units/luminous/luminous_intensity_unit.dart';
// Exporting units and their extensions for mass
export 'src/units/mass/mass.dart';
export 'src/units/mass/mass_extensions.dart';
export 'src/units/mass/mass_unit.dart';
// Exporting units and their extensions for molar amount
export 'src/units/molar/molar_amount.dart';
export 'src/units/molar/molar_extensions.dart';
export 'src/units/molar/molar_unit.dart';
// Exporting units and their extensions for power
export 'src/units/power/power.dart';
export 'src/units/power/power_extensions.dart';
export 'src/units/power/power_unit.dart';
// Exporting units and their extensions for pressure
export 'src/units/pressure/pressure.dart';
export 'src/units/pressure/pressure_extensions.dart';
export 'src/units/pressure/pressure_unit.dart';
// Exporting units and their extensions for solid angle
export 'src/units/solid_angle/solid_angle.dart';
export 'src/units/solid_angle/solid_angle_extensions.dart';
export 'src/units/solid_angle/solid_angle_unit.dart';
// Exporting units and their extensions for specific energy
export 'src/units/specific_energy/specific_energy.dart';
export 'src/units/specific_energy/specific_energy_extensions.dart';
export 'src/units/specific_energy/specific_energy_unit.dart';
// Exporting units and their extensions for speed
export 'src/units/speed/speed.dart';
export 'src/units/speed/speed_extensions.dart';
export 'src/units/speed/speed_unit.dart';
// Exporting units and their extensions for temperature
export 'src/units/temperature/temperature.dart';
export 'src/units/temperature/temperature_extensions.dart';
export 'src/units/temperature/temperature_unit.dart';
// Exporting units and their extensions for time
export 'src/units/time/time.dart';
export 'src/units/time/time_extensions.dart';
export 'src/units/time/time_unit.dart';
// Exporting units and their extensions for volume
export 'src/units/volume/volume.dart';
export 'src/units/volume/volume_extensions.dart';
export 'src/units/volume/volume_unit.dart';
