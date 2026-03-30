import 'dart:io';

import 'package:test/test.dart';

final class AnalyzerFixtureCase {
  const AnalyzerFixtureCase({
    required this.fileName,
    required this.expectedSnippets,
  });

  final String fileName;
  final List<String> expectedSnippets;
}

void main() {
  const fixtureCases = <AnalyzerFixtureCase>[
    AnalyzerFixtureCase(
      fileName: 'invalid_power_level_addition.dart',
      expectedSnippets: [
        'invalid_power_level_addition.dart',
        'The argument type',
        "can't be assigned to the parameter type 'LevelRatio'",
      ],
    ),
    AnalyzerFixtureCase(
      fileName: 'invalid_fuel_consumption_addition.dart',
      expectedSnippets: [
        'invalid_fuel_consumption_addition.dart',
        "The operator '+' isn't defined for the type 'FuelConsumption'",
      ],
    ),
    AnalyzerFixtureCase(
      fileName: 'invalid_sound_pressure_level_addition.dart',
      expectedSnippets: [
        'invalid_sound_pressure_level_addition.dart',
        'The argument type',
        "can't be assigned to the parameter type 'LevelRatio'",
      ],
    ),
    AnalyzerFixtureCase(
      fileName: 'invalid_power_level_ratio_subtraction_operator.dart',
      expectedSnippets: [
        'invalid_power_level_ratio_subtraction_operator.dart',
        'The argument type',
        "can't be assigned to the parameter type 'PowerLevel'",
      ],
    ),
    AnalyzerFixtureCase(
      fileName: 'invalid_granular_import_surface.dart',
      expectedSnippets: [
        'invalid_granular_import_surface.dart',
        "The getter 'dBSPL' isn't defined for the type 'int'",
      ],
    ),
  ];

  group('Analyzer fixtures', () {
    for (final fixtureCase in fixtureCases) {
      test(fixtureCase.fileName, () async {
        final repositoryRoot = Directory.current.path;
        final fixturePath = '$repositoryRoot/test/validation/fixtures/${fixtureCase.fileName}';

        final result = await Process.run(
          'dart',
          ['analyze', fixturePath],
          workingDirectory: repositoryRoot,
        );

        final combinedOutput = '${result.stdout}\n${result.stderr}';

        expect(
          result.exitCode,
          isNonZero,
          reason: 'Fixture should fail analysis:\n$combinedOutput',
        );

        for (final snippet in fixtureCase.expectedSnippets) {
          expect(
            combinedOutput,
            contains(snippet),
            reason: 'Expected analyzer output to contain "$snippet".\n$combinedOutput',
          );
        }
      });
    }
  });
}
