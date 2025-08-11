// quantify v0.12.0
// ignore_for_file: omit_local_variable_types

import 'dart:math' as math;

import 'package:quantify/quantify.dart';

void main() {
  // Define our pizza diameters
  final Length diam18 = 18.inch;
  final Length diam12 = 12.inch;

  // Calculate the area of each (Area = π * r²)
  final Area pizza18 = (math.pi * math.pow(diam18.inInch / 2, 2)).in2;
  final Area pizza12 = (math.pi * math.pow(diam12.inInch / 2, 2)).in2;

  print('One 18-inch pizza: ${pizza18.toString(fractionDigits: 0)}');
  print('Two 12-inch pizzas: ${(pizza12 * 2).toString(fractionDigits: 0)}');

  if (pizza18 > pizza12 * 2) {
    print(
      'The 18-inch pizza is MORE pizza! '
      '(By ${(pizza18 - pizza12 * 2).toString(fractionDigits: 0)})',
    );
  }

  // Output:
  // One 18-inch pizza: 254 in²
  // Two 12-inch pizzas: 226 in²
  // The 18-inch pizza is MORE pizza! (By 28 in²)
}
