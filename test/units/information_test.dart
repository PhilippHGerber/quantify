import 'package:quantify/quantify.dart';
import 'package:test/test.dart';

void main() {
  group('Information — Constructors', () {
    test('direct constructor', () {
      const info = Information(1.5, InformationUnit.gigabyte);
      expect(info.value, 1.5);
      expect(info.unit, InformationUnit.gigabyte);
    });

    test('extension sugar — bit', () {
      final info = 8.bit;
      expect(info.value, 8.0);
      expect(info.unit, InformationUnit.bit);
    });

    test('extension sugar — byte', () {
      final info = 1.byte;
      expect(info.unit, InformationUnit.byte);
    });

    test('extension sugar — kB', () {
      final info = 1.kB;
      expect(info.unit, InformationUnit.kilobyte);
    });

    test('extension sugar — MB', () {
      final info = 1.MB;
      expect(info.unit, InformationUnit.megabyte);
    });

    test('extension sugar — GiB', () {
      final info = 1.5.GiB;
      expect(info.value, 1.5);
      expect(info.unit, InformationUnit.gibibyte);
    });
  });

  group('Information — Conversions', () {
    test('1 byte = 8 bits', () {
      expect(1.byte.inBit, closeTo(8.0, 1e-9));
    });

    test('8 bits = 1 byte', () {
      expect(8.bit.inByte, closeTo(1.0, 1e-9));
    });

    test('1 kB (SI) = 1 000 bytes', () {
      expect(1.kB.inByte, closeTo(1000.0, 1e-9));
    });

    test('1 KiB (IEC) = 1 024 bytes', () {
      expect(1.KiB.inByte, closeTo(1024.0, 1e-9));
    });

    test('1 MB (SI) = 1 000 kB', () {
      expect(1.MB.inKB, closeTo(1000.0, 1e-9));
    });

    test('1 MiB (IEC) = 1 024 KiB', () {
      expect(1.MiB.inKiB, closeTo(1024.0, 1e-9));
    });

    test('1 GB (SI) = 1 000 MB', () {
      expect(1.GB.inMB, closeTo(1000.0, 1e-9));
    });

    test('1 GiB (IEC) = 1 024 MiB', () {
      expect(1.GiB.inMiB, closeTo(1024.0, 1e-9));
    });

    test('1 TB = 1 000 GB', () {
      expect(1.TB.inGB, closeTo(1000.0, 1e-9));
    });

    test('1 TiB = 1 024 GiB', () {
      expect(1.TiB.inGiB, closeTo(1024.0, 1e-9));
    });

    test('1 PB = 1 000 TB', () {
      expect(1.PB.inTB, closeTo(1000.0, 1e-9));
    });

    test('1 PiB = 1 024 TiB', () {
      expect(1.PiB.inTiB, closeTo(1024.0, 1e-9));
    });

    test('convertTo returns same instance when unit is identical', () {
      final info = 1.GB;
      expect(info.convertTo(InformationUnit.gigabyte), same(info));
    });

    test('getValue returns same value when unit is identical', () {
      expect(1.5.MB.getValue(InformationUnit.megabyte), 1.5);
    });
  });

  group('Information — SI vs IEC distinction', () {
    test('1 GB ≠ 1 GiB', () {
      expect(1.GB.inBit, isNot(closeTo(1.GiB.inBit, 1)));
    });

    test('1 GiB > 1 GB (GiB is larger)', () {
      expect(1.GiB.inGB, greaterThan(1.0));
    });

    test('1 GiB ≈ 1.073741824 GB', () {
      expect(1.GiB.inGB, closeTo(1.073741824, 1e-9));
    });

    test('1 GB ≈ 0.9313 GiB', () {
      expect(1.GB.inGiB, closeTo(1e9 / (1024.0 * 1024.0 * 1024.0), 1e-9));
    });

    test('1 kB (SI) ≠ 1 KiB (IEC)', () {
      expect(1.kB.inBit, isNot(closeTo(1.KiB.inBit, 1)));
    });

    test('1 MiB ≈ 1.048576 MB', () {
      expect(1.MiB.inMB, closeTo(1.048576, 1e-9));
    });
  });

  group('Information — Round trips', () {
    const tolerance = 1e-9;
    const value = 1.5;

    test('bit round-trip', () {
      expect(const Information(value, InformationUnit.bit).inBit, closeTo(value, tolerance));
    });

    test('byte round-trip', () {
      expect(
        const Information(value, InformationUnit.byte).convertTo(InformationUnit.bit).inByte,
        closeTo(value, tolerance),
      );
    });

    test('kB round-trip', () {
      expect(
        const Information(value, InformationUnit.kilobyte).convertTo(InformationUnit.bit).inKB,
        closeTo(value, tolerance),
      );
    });

    test('MB round-trip', () {
      expect(
        const Information(value, InformationUnit.megabyte).convertTo(InformationUnit.bit).inMB,
        closeTo(value, tolerance),
      );
    });

    test('GB round-trip', () {
      expect(
        const Information(value, InformationUnit.gigabyte).convertTo(InformationUnit.bit).inGB,
        closeTo(value, tolerance),
      );
    });

    test('TB round-trip', () {
      expect(
        const Information(value, InformationUnit.terabyte).convertTo(InformationUnit.bit).inTB,
        closeTo(value, tolerance),
      );
    });

    test('PB round-trip', () {
      expect(
        const Information(value, InformationUnit.petabyte).convertTo(InformationUnit.bit).inPB,
        closeTo(value, tolerance),
      );
    });

    test('KiB round-trip', () {
      expect(
        const Information(value, InformationUnit.kibibyte).convertTo(InformationUnit.bit).inKiB,
        closeTo(value, tolerance),
      );
    });

    test('MiB round-trip', () {
      expect(
        const Information(value, InformationUnit.mebibyte).convertTo(InformationUnit.bit).inMiB,
        closeTo(value, tolerance),
      );
    });

    test('GiB round-trip', () {
      expect(
        const Information(value, InformationUnit.gibibyte).convertTo(InformationUnit.bit).inGiB,
        closeTo(value, tolerance),
      );
    });

    test('TiB round-trip', () {
      expect(
        const Information(value, InformationUnit.tebibyte).convertTo(InformationUnit.bit).inTiB,
        closeTo(value, tolerance),
      );
    });

    test('PiB round-trip', () {
      expect(
        const Information(value, InformationUnit.pebibyte).convertTo(InformationUnit.bit).inPiB,
        closeTo(value, tolerance),
      );
    });
  });

  group('Information — Arithmetic', () {
    test('500 MB + 1 GB = 1 500 MB', () {
      final result = 500.MB + 1.GB;
      expect(result.inMB, closeTo(1500.0, 1e-9));
    });

    test('2 GiB - 512 MiB = 1.5 GiB', () {
      final result = 2.GiB - 512.MiB;
      expect(result.inGiB, closeTo(1.5, 1e-9));
    });

    test('1 GB * 3 = 3 GB', () {
      final result = 1.GB * 3;
      expect(result.inGB, closeTo(3.0, 1e-9));
    });

    test('6 GB / 2 = 3 GB', () {
      final result = 6.GB / 2;
      expect(result.inGB, closeTo(3.0, 1e-9));
    });

    test('division by zero throws ArgumentError', () {
      expect(() => 1.GB / 0, throwsArgumentError);
    });

    test('result unit matches left operand unit for +', () {
      final result = 500.MB + 1.GB;
      expect(result.unit, InformationUnit.megabyte);
    });

    test('result unit matches left operand unit for -', () {
      final result = 2.GiB - 512.MiB;
      expect(result.unit, InformationUnit.gibibyte);
    });
  });

  group('Information — Comparisons', () {
    test('1 GB < 1 GiB', () {
      expect(1.GB.compareTo(1.GiB), isNegative);
    });

    test('1 GiB > 1 GB', () {
      expect(1.GiB.compareTo(1.GB), isPositive);
    });

    test('1 000 MB == 1 GB', () {
      expect(1000.MB.compareTo(1.GB), 0);
    });

    test('1 024 KiB == 1 MiB', () {
      expect(1024.KiB.compareTo(1.MiB), 0);
    });

    test('sort list by magnitude', () {
      final sizes = [1.GiB, 1.GB, 1.MiB, 1.TB]..sort();
      expect(sizes.map((s) => s.unit).toList(), [
        InformationUnit.mebibyte,
        InformationUnit.gigabyte,
        InformationUnit.gibibyte,
        InformationUnit.terabyte,
      ]);
    });
  });

  group('Information — Equality', () {
    test('same value and unit are equal', () {
      expect(
        const Information(1.5, InformationUnit.gigabyte),
        equals(const Information(1.5, InformationUnit.gigabyte)),
      );
    });

    test('different units are not equal even if physically same', () {
      expect(1000.MB, isNot(equals(1.GB)));
    });

    test('hashCode consistent with equality', () {
      const a = Information(1.5, InformationUnit.gigabyte);
      const b = Information(1.5, InformationUnit.gigabyte);
      expect(a.hashCode, equals(b.hashCode));
    });
  });

  group('Information — toString', () {
    test('bit symbol is "bit"', () {
      expect(1.bit.toString(), contains('bit'));
    });

    test('byte symbol is "B"', () {
      expect(1.byte.toString(), contains('B'));
    });

    test('kB symbol is "kB"', () {
      expect(1.kB.toString(), contains('kB'));
    });

    test('MB symbol is "MB"', () {
      expect(1.MB.toString(), contains('MB'));
    });

    test('GiB symbol is "GiB"', () {
      expect(1.GiB.toString(), contains('GiB'));
    });

    test('MiB symbol is "MiB"', () {
      expect(1.MiB.toString(), contains('MiB'));
    });
  });

  group('Information — parse', () {
    test('parse bits with "bit" symbol', () {
      final result = Information.parse('8 bit');
      expect(result.value, 8.0);
      expect(result.unit, InformationUnit.bit);
    });

    test('parse bits with "b" symbol (lowercase)', () {
      final result = Information.parse('8 b');
      expect(result.unit, InformationUnit.bit);
    });

    test('parse bytes with "B" symbol (uppercase)', () {
      final result = Information.parse('1 B');
      expect(result.unit, InformationUnit.byte);
    });

    test('"b" and "B" resolve to different units', () {
      expect(Information.parse('1 b').unit, InformationUnit.bit);
      expect(Information.parse('1 B').unit, InformationUnit.byte);
    });

    test('parse kB (SI kilobyte)', () {
      final result = Information.parse('2 kB');
      expect(result.unit, InformationUnit.kilobyte);
      expect(result.value, 2.0);
    });

    test('parse MB', () {
      expect(Information.parse('1.5 MB').unit, InformationUnit.megabyte);
    });

    test('parse GB', () {
      expect(Information.parse('1 GB').unit, InformationUnit.gigabyte);
    });

    test('parse TB', () {
      expect(Information.parse('1 TB').unit, InformationUnit.terabyte);
    });

    test('parse PB', () {
      expect(Information.parse('1 PB').unit, InformationUnit.petabyte);
    });

    test('parse KiB (IEC kibibyte)', () {
      final result = Information.parse('4 KiB');
      expect(result.unit, InformationUnit.kibibyte);
      expect(result.value, 4.0);
    });

    test('parse MiB', () {
      expect(Information.parse('1.5 MiB').unit, InformationUnit.mebibyte);
    });

    test('parse GiB', () {
      expect(Information.parse('1.5 GiB').unit, InformationUnit.gibibyte);
    });

    test('parse TiB', () {
      expect(Information.parse('1 TiB').unit, InformationUnit.tebibyte);
    });

    test('parse PiB', () {
      expect(Information.parse('1 PiB').unit, InformationUnit.pebibyte);
    });

    test('kB and KiB resolve to distinct units', () {
      expect(Information.parse('1 kB').unit, InformationUnit.kilobyte);
      expect(Information.parse('1 KiB').unit, InformationUnit.kibibyte);
    });

    test('parse name "gigabyte" (SI)', () {
      expect(Information.parse('1 gigabyte').unit, InformationUnit.gigabyte);
    });

    test('parse name "gigabytes" (plural)', () {
      expect(Information.parse('2 gigabytes').unit, InformationUnit.gigabyte);
    });

    test('parse name "gibibyte" (IEC)', () {
      expect(Information.parse('1 gibibyte').unit, InformationUnit.gibibyte);
    });

    test('parse name "bits"', () {
      expect(Information.parse('16 bits').unit, InformationUnit.bit);
    });

    test('parse name "bytes"', () {
      expect(Information.parse('4 bytes').unit, InformationUnit.byte);
    });

    test('parse without space between number and unit', () {
      expect(Information.parse('512MB').unit, InformationUnit.megabyte);
    });

    test('parse throws FormatException on bad input', () {
      expect(() => Information.parse('not info'), throwsFormatException);
    });

    test('tryParse returns null on bad input', () {
      expect(Information.tryParse('not info'), isNull);
    });

    test('tryParse returns Information on valid input', () {
      final result = Information.tryParse('1.5 GiB');
      expect(result, isNotNull);
      expect(result!.value, 1.5);
      expect(result.unit, InformationUnit.gibibyte);
    });
  });

  group('Information — as* conversion getters', () {
    test('asBit returns Information in bits', () {
      final result = 1.byte.asBit;
      expect(result.unit, InformationUnit.bit);
      expect(result.value, closeTo(8.0, 1e-9));
    });

    test('asKB returns Information in kilobytes', () {
      final result = 1.MB.asKB;
      expect(result.unit, InformationUnit.kilobyte);
      expect(result.value, closeTo(1000.0, 1e-9));
    });

    test('asGiB returns Information in gibibytes', () {
      final result = 1024.0.MiB.asGiB;
      expect(result.unit, InformationUnit.gibibyte);
      expect(result.value, closeTo(1.0, 1e-9));
    });
  });
}
