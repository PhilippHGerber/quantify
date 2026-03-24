import 'length.dart';
import 'length_unit.dart';

// SI/IEC unit symbols use uppercase letters by international standard
// (e.g., 'Mm' for megameter, 'Gm' for gigameter).
// Dart's lowerCamelCase rule is intentionally overridden here to preserve
// domain correctness and discoverability for scientists and engineers.
// ignore_for_file: non_constant_identifier_names

/// Provides convenient access to [Length] values in specific units
/// using shortened unit names where appropriate.
extension LengthValueGetters on Length {
  /// Returns the length value in Meters (m).
  double get inM => getValue(LengthUnit.meter);

  /// Returns the length value in Kilometers (km).
  double get inKm => getValue(LengthUnit.kilometer);

  /// Returns the length value in Kilometers (km).
  double get inKilometers => getValue(LengthUnit.kilometer);

  /// Returns the length value in Megameters (Mm).
  double get inMegaM => getValue(LengthUnit.megameter);

  /// Returns the length value in Gigameters (Gm).
  double get inGigaM => getValue(LengthUnit.gigameter);

  /// Returns the length value in Hectometers (hm).
  double get inHm => getValue(LengthUnit.hectometer);

  /// Returns the length value in Decameters (dam).
  double get inDam => getValue(LengthUnit.decameter);

  /// Returns the length value in Decimeters (dm).
  double get inDm => getValue(LengthUnit.decimeter);

  /// Returns the length value in Centimeters (cm).
  double get inCm => getValue(LengthUnit.centimeter);

  /// Returns the length value in Millimeters (mm).
  double get inMm => getValue(LengthUnit.millimeter);

  /// Returns the length value in Micrometers (μm).
  double get inUm => getValue(LengthUnit.micrometer);

  /// Returns the length value in Nanometers (nm).
  double get inNm => getValue(LengthUnit.nanometer);

  /// Returns the length value in Picometers (pm).
  double get inPm => getValue(LengthUnit.picometer);

  /// Returns the length value in Femtometers (fm).
  double get inFm => getValue(LengthUnit.femtometer);

  /// Returns the length value in Inches (in).
  double get inInch => getValue(LengthUnit.inch);

  /// Returns the length value in Feet (ft).
  double get inFt => getValue(LengthUnit.foot);

  /// Returns the length value in Yards (yd).
  double get inYd => getValue(LengthUnit.yard);

  /// Returns the length value in Miles (mi).
  double get inMi => getValue(LengthUnit.mile);

  /// Returns the length value in Nautical Miles (nmi).
  double get inNmi => getValue(LengthUnit.nauticalMile);

  /// Returns the length value in Astronomical Units (AU).
  double get inAU => getValue(LengthUnit.astronomicalUnit);

  /// Returns the length value in Light Years (ly).
  double get inLy => getValue(LengthUnit.lightYear);

  /// Returns the length value in Parsecs (pc).
  double get inPc => getValue(LengthUnit.parsec);

  /// Returns the length value in Ångströms (Å).
  double get inAngstrom => getValue(LengthUnit.angstrom);

  /// Returns a Length representing this length in Meters (m).
  Length get asM => convertTo(LengthUnit.meter);

  /// Returns a Length representing this length in Kilometers (km).
  Length get asKm => convertTo(LengthUnit.kilometer);

  /// Returns a Length representing this length in Megameters (Mm).
  Length get asMegaM => convertTo(LengthUnit.megameter);

  /// Returns a Length representing this length in Gigameters (Gm).
  Length get asGigaM => convertTo(LengthUnit.gigameter);

  /// Returns a Length representing this length in Hectometers (hm).
  Length get asHm => convertTo(LengthUnit.hectometer);

  /// Returns a Length representing this length in Decameters (dam).
  Length get asDam => convertTo(LengthUnit.decameter);

  /// Returns a Length representing this length in Decimeters (dm).
  Length get asDm => convertTo(LengthUnit.decimeter);

  /// Returns a Length representing this length in Centimeters (cm).
  Length get asCm => convertTo(LengthUnit.centimeter);

  /// Returns a Length representing this length in Millimeters (mm).
  Length get asMm => convertTo(LengthUnit.millimeter);

  /// Returns a Length representing this length in Micrometers (μm).
  Length get asUm => convertTo(LengthUnit.micrometer);

  /// Returns a Length representing this length in Nanometers (nm).
  Length get asNm => convertTo(LengthUnit.nanometer);

  /// Returns a Length representing this length in Picometers (pm).
  Length get asPm => convertTo(LengthUnit.picometer);

  /// Returns a Length representing this length in Femtometers (fm).
  Length get asFm => convertTo(LengthUnit.femtometer);

  /// Returns a Length representing this length in Inches (in).
  Length get asInch => convertTo(LengthUnit.inch);

  /// Returns a Length representing this length in Feet (ft).
  Length get asFt => convertTo(LengthUnit.foot);

  /// Returns a Length representing this length in Yards (yd).
  Length get asYd => convertTo(LengthUnit.yard);

  /// Returns a Length representing this length in Miles (mi).
  Length get asMi => convertTo(LengthUnit.mile);

  /// Returns a Length representing this length in Nautical Miles (nmi).
  Length get asNmi => convertTo(LengthUnit.nauticalMile);

  /// Returns a Length representing this length in Astronomical Units (AU).
  Length get asAU => convertTo(LengthUnit.astronomicalUnit);

  /// Returns a Length representing this length in Light Years (ly).
  Length get asLy => convertTo(LengthUnit.lightYear);

  /// Returns a Length representing this length in Parsecs (pc).
  Length get asPc => convertTo(LengthUnit.parsec);

  /// Returns a Length representing this length in Ångströms (Å).
  Length get asAngstrom => convertTo(LengthUnit.angstrom);
}

/// Provides convenient factory methods for creating [Length] instances from [num]
/// using both SI unit symbols and full English words (singular and plural).
extension LengthCreation on num {
  // --- Gigameters ---

  /// Creates a [Length] instance representing this numerical value in Gigameters (Gm).
  ///
  /// The SI symbol for gigameter is 'Gm' (capital G = giga prefix).
  Length get Gm => Length(toDouble(), LengthUnit.gigameter);

  /// Creates a [Length] instance representing this numerical value in Gigameters (Gm).
  Length get gigameter => Length(toDouble(), LengthUnit.gigameter);

  /// Creates a [Length] instance representing this numerical value in Gigameters (Gm).
  /// Alias for [Gm].
  Length get gigameters => Length(toDouble(), LengthUnit.gigameter);

  // --- Megameters ---

  /// Creates a [Length] instance representing this numerical value in Megameters (Mm).
  ///
  /// The SI symbol for megameter is 'Mm' (capital M = mega prefix).
  Length get Mm => Length(toDouble(), LengthUnit.megameter);

  /// Creates a [Length] instance representing this numerical value in Megameters (Mm).
  Length get megameter => Length(toDouble(), LengthUnit.megameter);

  /// Creates a [Length] instance representing this numerical value in Megameters (Mm).
  /// Alias for [Mm].
  Length get megameters => Length(toDouble(), LengthUnit.megameter);

  // --- Kilometers ---

  /// Creates a [Length] instance representing this numerical value in Kilometers (km).
  Length get km => Length(toDouble(), LengthUnit.kilometer);

  /// Creates a [Length] instance representing this numerical value in Kilometers (km).
  Length get kilometer => Length(toDouble(), LengthUnit.kilometer);

  /// Creates a [Length] instance representing this numerical value in Kilometers (km).
  /// Alias for [km].
  Length get kilometers => Length(toDouble(), LengthUnit.kilometer);

  // --- Hectometers ---

  /// Creates a [Length] instance representing this numerical value in Hectometers (hm).
  Length get hm => Length(toDouble(), LengthUnit.hectometer);

  /// Creates a [Length] instance representing this numerical value in Hectometers (hm).
  Length get hectometer => Length(toDouble(), LengthUnit.hectometer);

  /// Creates a [Length] instance representing this numerical value in Hectometers (hm).
  /// Alias for [hm].
  Length get hectometers => Length(toDouble(), LengthUnit.hectometer);

  // --- Decameters ---

  /// Creates a [Length] instance representing this numerical value in Decameters (dam).
  Length get dam => Length(toDouble(), LengthUnit.decameter);

  /// Creates a [Length] instance representing this numerical value in Decameters (dam).
  Length get decameter => Length(toDouble(), LengthUnit.decameter);

  /// Creates a [Length] instance representing this numerical value in Decameters (dam).
  /// Alias for [dam].
  Length get decameters => Length(toDouble(), LengthUnit.decameter);

  // --- Meters ---

  /// Creates a [Length] instance representing this numerical value in Meters (m).
  Length get m => Length(toDouble(), LengthUnit.meter);

  /// Creates a [Length] instance representing this numerical value in Meters (m).
  Length get meter => Length(toDouble(), LengthUnit.meter);

  /// Creates a [Length] instance representing this numerical value in Meters (m).
  /// Alias for [m].
  Length get meters => Length(toDouble(), LengthUnit.meter);

  // --- Decimeters ---

  /// Creates a [Length] instance representing this numerical value in Decimeters (dm).
  Length get dm => Length(toDouble(), LengthUnit.decimeter);

  /// Creates a [Length] instance representing this numerical value in Decimeters (dm).
  Length get decimeter => Length(toDouble(), LengthUnit.decimeter);

  /// Creates a [Length] instance representing this numerical value in Decimeters (dm).
  /// Alias for [dm].
  Length get decimeters => Length(toDouble(), LengthUnit.decimeter);

  // --- Centimeters ---

  /// Creates a [Length] instance representing this numerical value in Centimeters (cm).
  Length get cm => Length(toDouble(), LengthUnit.centimeter);

  /// Creates a [Length] instance representing this numerical value in Centimeters (cm).
  Length get centimeter => Length(toDouble(), LengthUnit.centimeter);

  /// Creates a [Length] instance representing this numerical value in Centimeters (cm).
  /// Alias for [cm].
  Length get centimeters => Length(toDouble(), LengthUnit.centimeter);

  // --- Millimeters ---

  /// Creates a [Length] instance representing this numerical value in Millimeters (mm).
  Length get mm => Length(toDouble(), LengthUnit.millimeter);

  /// Creates a [Length] instance representing this numerical value in Millimeters (mm).
  Length get millimeter => Length(toDouble(), LengthUnit.millimeter);

  /// Creates a [Length] instance representing this numerical value in Millimeters (mm).
  /// Alias for [mm].
  Length get millimeters => Length(toDouble(), LengthUnit.millimeter);

  // --- Micrometers ---

  /// Creates a [Length] instance representing this numerical value in Micrometers (μm).
  Length get um => Length(toDouble(), LengthUnit.micrometer);

  /// Creates a [Length] instance representing this numerical value in Micrometers (μm).
  Length get micrometer => Length(toDouble(), LengthUnit.micrometer);

  /// Creates a [Length] instance representing this numerical value in Micrometers (μm).
  /// Alias for [um].
  Length get micrometers => Length(toDouble(), LengthUnit.micrometer);

  /// Creates a [Length] instance representing this numerical value in Micrometers (μm).
  /// Industry shorthand widely used in engineering and manufacturing.
  Length get micron => Length(toDouble(), LengthUnit.micrometer);

  /// Creates a [Length] instance representing this numerical value in Micrometers (μm).
  /// Alias for [micron].
  Length get microns => Length(toDouble(), LengthUnit.micrometer);

  // --- Nanometers ---

  /// Creates a [Length] instance representing this numerical value in Nanometers (nm).
  Length get nm => Length(toDouble(), LengthUnit.nanometer);

  /// Creates a [Length] instance representing this numerical value in Nanometers (nm).
  Length get nanometer => Length(toDouble(), LengthUnit.nanometer);

  /// Creates a [Length] instance representing this numerical value in Nanometers (nm).
  /// Alias for [nm].
  Length get nanometers => Length(toDouble(), LengthUnit.nanometer);

  // --- Picometers ---

  /// Creates a [Length] instance representing this numerical value in Picometers (pm).
  Length get pm => Length(toDouble(), LengthUnit.picometer);

  /// Creates a [Length] instance representing this numerical value in Picometers (pm).
  Length get picometer => Length(toDouble(), LengthUnit.picometer);

  /// Creates a [Length] instance representing this numerical value in Picometers (pm).
  /// Alias for [pm].
  Length get picometers => Length(toDouble(), LengthUnit.picometer);

  // --- Femtometers ---

  /// Creates a [Length] instance representing this numerical value in Femtometers (fm).
  Length get fm => Length(toDouble(), LengthUnit.femtometer);

  /// Creates a [Length] instance representing this numerical value in Femtometers (fm).
  Length get femtometer => Length(toDouble(), LengthUnit.femtometer);

  /// Creates a [Length] instance representing this numerical value in Femtometers (fm).
  /// Alias for [fm].
  Length get femtometers => Length(toDouble(), LengthUnit.femtometer);

  // --- Ångströms ---

  /// Creates a [Length] instance representing this numerical value in Ångströms (Å).
  Length get angstrom => Length(toDouble(), LengthUnit.angstrom);

  /// Creates a [Length] instance representing this numerical value in Ångströms (Å).
  /// Alias for [angstrom].
  Length get angstroms => Length(toDouble(), LengthUnit.angstrom);

  // --- Imperial / US customary ---

  /// Creates a [Length] instance representing this numerical value in Inches (in).
  Length get inch => Length(toDouble(), LengthUnit.inch);

  /// Creates a [Length] instance representing this numerical value in Inches (in).
  /// Alias for [inch].
  Length get inches => Length(toDouble(), LengthUnit.inch);

  /// Creates a [Length] instance representing this numerical value in Feet (ft).
  Length get ft => Length(toDouble(), LengthUnit.foot);

  /// Creates a [Length] instance representing this numerical value in Feet (ft).
  Length get foot => Length(toDouble(), LengthUnit.foot);

  /// Creates a [Length] instance representing this numerical value in Feet (ft).
  /// Alias for [ft].
  Length get feet => Length(toDouble(), LengthUnit.foot);

  /// Creates a [Length] instance representing this numerical value in Yards (yd).
  Length get yd => Length(toDouble(), LengthUnit.yard);

  /// Creates a [Length] instance representing this numerical value in Yards (yd).
  Length get yard => Length(toDouble(), LengthUnit.yard);

  /// Creates a [Length] instance representing this numerical value in Yards (yd).
  /// Alias for [yd].
  Length get yards => Length(toDouble(), LengthUnit.yard);

  /// Creates a [Length] instance representing this numerical value in Miles (mi).
  Length get mi => Length(toDouble(), LengthUnit.mile);

  /// Creates a [Length] instance representing this numerical value in Miles (mi).
  Length get mile => Length(toDouble(), LengthUnit.mile);

  /// Creates a [Length] instance representing this numerical value in Miles (mi).
  /// Alias for [mi].
  Length get miles => Length(toDouble(), LengthUnit.mile);

  // --- Maritime ---

  /// Creates a [Length] instance representing this numerical value in Nautical Miles (nmi).
  Length get nmi => Length(toDouble(), LengthUnit.nauticalMile);

  /// Creates a [Length] instance representing this numerical value in Nautical Miles (nmi).
  Length get nauticalMile => Length(toDouble(), LengthUnit.nauticalMile);

  /// Creates a [Length] instance representing this numerical value in Nautical Miles (nmi).
  /// Alias for [nmi].
  Length get nauticalMiles => Length(toDouble(), LengthUnit.nauticalMile);

  // --- Astronomical ---

  /// Creates a [Length] instance representing this numerical value in Astronomical Units (AU).
  Length get AU => Length(toDouble(), LengthUnit.astronomicalUnit);

  /// Creates a [Length] instance representing this numerical value in Astronomical Units (AU).
  Length get astronomicalUnit => Length(toDouble(), LengthUnit.astronomicalUnit);

  /// Creates a [Length] instance representing this numerical value in Astronomical Units (AU).
  /// Alias for [AU].
  Length get astronomicalUnits => Length(toDouble(), LengthUnit.astronomicalUnit);

  /// Creates a [Length] instance representing this numerical value in Light Years (ly).
  Length get ly => Length(toDouble(), LengthUnit.lightYear);

  /// Creates a [Length] instance representing this numerical value in Light Years (ly).
  Length get lightYear => Length(toDouble(), LengthUnit.lightYear);

  /// Creates a [Length] instance representing this numerical value in Light Years (ly).
  /// Alias for [ly].
  Length get lightYears => Length(toDouble(), LengthUnit.lightYear);

  /// Creates a [Length] instance representing this numerical value in Parsecs (pc).
  Length get pc => Length(toDouble(), LengthUnit.parsec);

  /// Creates a [Length] instance representing this numerical value in Parsecs (pc).
  Length get parsec => Length(toDouble(), LengthUnit.parsec);

  /// Creates a [Length] instance representing this numerical value in Parsecs (pc).
  /// Alias for [pc].
  Length get parsecs => Length(toDouble(), LengthUnit.parsec);
}
