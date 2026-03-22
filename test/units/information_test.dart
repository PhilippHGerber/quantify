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

    test('division by zero returns infinity', () {
      expect((1.GB / 0).value, double.infinity);
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

    test('legacy KB alias resolves to SI kilobyte', () {
      expect(Information.parse('1 KB').unit, InformationUnit.kilobyte);
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

  group('Information — Bit units (SI)', () {
    test('1 kbit == 1 000 bits', () {
      expect(1.kbit.inBit, closeTo(1000.0, 1e-9));
    });

    test('1 Mbit == 1 000 000 bits', () {
      expect(1.Mbit.inBit, closeTo(1e6, 1e-9));
    });

    test('1 Gbit == 1 000 000 000 bits', () {
      expect(1.Gbit.inBit, closeTo(1e9, 1e-9));
    });

    test('1 Tbit == 1 000 000 000 000 bits', () {
      expect(1.Tbit.inBit, closeTo(1e12, 1e-9));
    });

    test('100 Mbit in Gbit == 0.1', () {
      expect(100.Mbit.inGbit, closeTo(0.1, 1e-9));
    });

    test('1 Gbit in Mbit == 1 000', () {
      expect(1.Gbit.inMbit, closeTo(1000.0, 1e-9));
    });

    test('1 Tbit in Gbit == 1 000', () {
      expect(1.Tbit.inGbit, closeTo(1000.0, 1e-9));
    });

    test('round-trip Gbit → kbit → Gbit', () {
      expect(1.Gbit.asKbit.asGbit.inGbit, closeTo(1.0, 1e-9));
    });

    test('cross-track: 1 GB == 8 Gbit', () {
      expect(1.GB.inGbit, closeTo(8.0, 1e-9));
    });

    test('cross-track: 1 Gbit == 0.125 GB', () {
      expect(1.Gbit.inGB, closeTo(0.125, 1e-9));
    });

    test('extension sugar — kbit unit', () {
      expect(1.kbit.unit, InformationUnit.kilobit);
    });

    test('extension sugar — Mbit unit', () {
      expect(1.Mbit.unit, InformationUnit.megabit);
    });

    test('extension sugar — Gbit unit', () {
      expect(1.Gbit.unit, InformationUnit.gigabit);
    });

    test('extension sugar — Tbit unit', () {
      expect(1.Tbit.unit, InformationUnit.terabit);
    });

    test('toString contains Gbit symbol', () {
      expect(1.Gbit.toString(), contains('Gbit'));
    });

    test('parse kbit from symbol string', () {
      expect(Information.parse('1 kbit').unit, InformationUnit.kilobit);
    });

    test('parse Mbit from symbol string', () {
      final result = Information.parse('100\u00A0Mbit');
      expect(result.unit, InformationUnit.megabit);
      expect(result.value, closeTo(100.0, 1e-9));
    });

    test('parse Gbit from symbol string', () {
      expect(Information.parse('1 Gbit').unit, InformationUnit.gigabit);
    });

    test('parse Tbit from symbol string', () {
      expect(Information.parse('1 Tbit').unit, InformationUnit.terabit);
    });

    test('parse gigabit from name string', () {
      final result = Information.parse('2\u00A0gigabit');
      expect(result.unit, InformationUnit.gigabit);
      expect(result.value, closeTo(2.0, 1e-9));
    });

    test('asKbit returns Information in kilobits', () {
      expect(1.Mbit.asKbit.value, closeTo(1000.0, 1e-9));
      expect(1.Mbit.asKbit.unit, InformationUnit.kilobit);
    });

    test('asGbit returns Information in gigabits', () {
      expect(1000.Mbit.asGbit.value, closeTo(1.0, 1e-9));
    });
  });

  group('Lowercase extension aliases (§5)', () {
    // NOTE: lowercase aliases map to BIT-based units (industry convention:
    // 'b' = bit, 'B' = byte). Use .kB/.MB/.GB/.TB/.PB for byte-based units.

    test('kb == kbit (kilobit, NOT kilobyte)', () {
      expect(1.kb.unit, InformationUnit.kilobit);
      expect(1.kb.inKbit, closeTo(1.0, 1e-9));
      expect(1.kb.isEquivalentTo(1.kB), isFalse); // kB = kilobyte = 8× larger
    });

    test('mb == Mbit (megabit, NOT megabyte)', () {
      expect(1.mb.unit, InformationUnit.megabit);
      expect(1.mb.inMbit, closeTo(1.0, 1e-9));
      expect(1.mb.isEquivalentTo(1.MB), isFalse); // MB = megabyte = 8× larger
    });

    test('gb == Gbit (gigabit, NOT gigabyte)', () {
      expect(1.gb.unit, InformationUnit.gigabit);
      expect(1.gb.inGbit, closeTo(1.0, 1e-9));
      expect(1.gb.isEquivalentTo(1.GB), isFalse); // GB = gigabyte = 8× larger
    });

    test('tb == Tbit (terabit, NOT terabyte)', () {
      expect(1.tb.unit, InformationUnit.terabit);
      expect(1.tb.inTbit, closeTo(1.0, 1e-9));
      expect(1.tb.isEquivalentTo(1.TB), isFalse); // TB = terabyte = 8× larger
    });

    test('pb == Pbit (petabit, NOT petabyte)', () {
      expect(1.pb.unit, InformationUnit.petabit);
      expect(1.pb.inPbit, closeTo(1.0, 1e-9));
      expect(1.pb.isEquivalentTo(1.PB), isFalse); // PB = petabyte = 8× larger
    });

    test('kib == KiB (kibibyte)', () {
      expect(1.kib.unit, InformationUnit.kibibyte);
      expect(1.kib.isEquivalentTo(1.KiB), isTrue);
    });

    test('mib == MiB (mebibyte)', () {
      expect(1.mib.unit, InformationUnit.mebibyte);
      expect(1.mib.isEquivalentTo(1.MiB), isTrue);
    });

    test('gib == GiB (gibibyte)', () {
      expect(1.gib.unit, InformationUnit.gibibyte);
      expect(1.gib.isEquivalentTo(1.GiB), isTrue);
    });

    test('tib == TiB (tebibyte)', () {
      expect(1.tib.unit, InformationUnit.tebibyte);
      expect(1.tib.isEquivalentTo(1.TiB), isTrue);
    });

    test('pib == PiB (pebibyte)', () {
      expect(1.pib.unit, InformationUnit.pebibyte);
      expect(1.pib.isEquivalentTo(1.PiB), isTrue);
    });

    test('eb == EB (exabyte)', () {
      expect(1.eb.unit, InformationUnit.exabyte);
      expect(1.eb.isEquivalentTo(1.EB), isTrue);
    });

    test('zb == ZB (zettabyte)', () {
      expect(1.zb.unit, InformationUnit.zettabyte);
      expect(1.zb.isEquivalentTo(1.ZB), isTrue);
    });

    test('yb == YB (yottabyte)', () {
      expect(1.yb.unit, InformationUnit.yottabyte);
      expect(1.yb.isEquivalentTo(1.YB), isTrue);
    });

    test('eib == EiB (exbibyte)', () {
      expect(1.eib.unit, InformationUnit.exbibyte);
      expect(1.eib.isEquivalentTo(1.EiB), isTrue);
    });

    test('zib == ZiB (zebibyte)', () {
      expect(1.zib.unit, InformationUnit.zebibyte);
      expect(1.zib.isEquivalentTo(1.ZiB), isTrue);
    });

    test('yib == YiB (yobibyte)', () {
      expect(1.yib.unit, InformationUnit.yobibyte);
      expect(1.yib.isEquivalentTo(1.YiB), isTrue);
    });
  });

  group('Information — SI Bit units (extended)', () {
    test('1 Pbit == 10¹⁵ bits', () {
      expect(1.Pbit.inBit, closeTo(1e15, 1e6));
    });

    test('1 Ebit == 10¹⁸ bits', () {
      expect(1.Ebit.inBit, closeTo(1e18, 1e9));
    });

    test('1 Zbit == 10²¹ bits', () {
      expect(1.Zbit.inBit, closeTo(1e21, 1e12));
    });

    test('1 Ybit == 10²⁴ bits', () {
      expect(1.Ybit.inBit, closeTo(1e24, 1e15));
    });

    test('1 Ebit == 1 000 Pbit', () {
      expect(1.Ebit.inPbit, closeTo(1000.0, 1e-6));
    });

    test('round-trip Pbit → bit → Pbit', () {
      expect(1.Pbit.asBit.asPbit.inPbit, closeTo(1.0, 1e-6));
    });

    test('round-trip Ebit → Pbit → Ebit', () {
      expect(1.Ebit.asPbit.asEbit.inEbit, closeTo(1.0, 1e-6));
    });

    test('cross-track: 1 EB == 8 Ebit', () {
      expect(1.EB.inEbit, closeTo(8.0, 1e-6));
    });

    test('extension sugar — Pbit unit', () {
      expect(1.Pbit.unit, InformationUnit.petabit);
    });

    test('extension sugar — Ebit unit', () {
      expect(1.Ebit.unit, InformationUnit.exabit);
    });

    test('extension sugar — Zbit unit', () {
      expect(1.Zbit.unit, InformationUnit.zettabit);
    });

    test('extension sugar — Ybit unit', () {
      expect(1.Ybit.unit, InformationUnit.yottabit);
    });

    test('toString contains Pbit symbol', () {
      expect(1.Pbit.toString(), contains('Pbit'));
    });

    test('parse Pbit from symbol string', () {
      expect(Information.parse('1 Pbit').unit, InformationUnit.petabit);
    });

    test('parse Ebit from symbol string', () {
      expect(Information.parse('1 Ebit').unit, InformationUnit.exabit);
    });

    test('parse Zbit from symbol string', () {
      expect(Information.parse('1 Zbit').unit, InformationUnit.zettabit);
    });

    test('parse Ybit from symbol string', () {
      expect(Information.parse('1 Ybit').unit, InformationUnit.yottabit);
    });

    test('parse petabit from name', () {
      expect(Information.parse('2 petabits').unit, InformationUnit.petabit);
    });

    test('asPbit returns Information in petabits', () {
      expect(1.Ebit.asPbit.value, closeTo(1000.0, 1e-6));
      expect(1.Ebit.asPbit.unit, InformationUnit.petabit);
    });
  });

  group('Information — SI Byte units (extended)', () {
    test('1 EB == 10¹⁸ bytes', () {
      expect(1.EB.inByte, closeTo(1e18, 1e9));
    });

    test('1 ZB == 10²¹ bytes', () {
      expect(1.ZB.inByte, closeTo(1e21, 1e12));
    });

    test('1 YB == 10²⁴ bytes', () {
      expect(1.YB.inByte, closeTo(1e24, 1e15));
    });

    test('1 ZB == 1 000 EB', () {
      expect(1.ZB.inEB, closeTo(1000.0, 1e-6));
    });

    test('1 YB == 1 000 ZB', () {
      expect(1.YB.inZB, closeTo(1000.0, 1e-6));
    });

    test('round-trip EB → PB → EB', () {
      expect(1.EB.asPB.asEB.inEB, closeTo(1.0, 1e-6));
    });

    test('round-trip ZB → EB → ZB', () {
      expect(1.ZB.asEB.asZB.inZB, closeTo(1.0, 1e-6));
    });

    test('extension sugar — EB unit', () {
      expect(1.EB.unit, InformationUnit.exabyte);
    });

    test('extension sugar — ZB unit', () {
      expect(1.ZB.unit, InformationUnit.zettabyte);
    });

    test('extension sugar — YB unit', () {
      expect(1.YB.unit, InformationUnit.yottabyte);
    });

    test('toString contains EB symbol', () {
      expect(1.EB.toString(), contains('EB'));
    });

    test('parse EB from symbol string', () {
      expect(Information.parse('1 EB').unit, InformationUnit.exabyte);
    });

    test('parse ZB from symbol string', () {
      expect(Information.parse('1 ZB').unit, InformationUnit.zettabyte);
    });

    test('parse YB from symbol string', () {
      expect(Information.parse('1 YB').unit, InformationUnit.yottabyte);
    });

    test('parse exabyte from name', () {
      expect(Information.parse('2 exabytes').unit, InformationUnit.exabyte);
    });

    test('parse zettabyte from name', () {
      expect(Information.parse('1 zettabyte').unit, InformationUnit.zettabyte);
    });

    test('parse yottabyte from name', () {
      expect(Information.parse('1 yottabytes').unit, InformationUnit.yottabyte);
    });

    test('asEB returns Information in exabytes', () {
      expect(1.ZB.asEB.value, closeTo(1000.0, 1e-6));
      expect(1.ZB.asEB.unit, InformationUnit.exabyte);
    });

    test('SI vs IEC distinction: 1 EB != 1 EiB', () {
      expect(1.EB.inBit, isNot(closeTo(1.EiB.inBit, 1e10)));
    });
  });

  group('Information — IEC Binary units (extended)', () {
    test('1 EiB == 2⁶⁰ bytes', () {
      expect(1.EiB.inByte, closeTo(1.152921504606847e18, 1e9));
    });

    test('1 EiB == 1 024 PiB', () {
      expect(1.EiB.inPiB, closeTo(1024.0, 1e-6));
    });

    test('1 ZiB == 1 024 EiB', () {
      expect(1.ZiB.inEiB, closeTo(1024.0, 1e-6));
    });

    test('1 YiB == 1 024 ZiB', () {
      expect(1.YiB.inZiB, closeTo(1024.0, 1e-6));
    });

    test('round-trip EiB → PiB → EiB', () {
      expect(1.EiB.asPiB.asEiB.inEiB, closeTo(1.0, 1e-6));
    });

    test('round-trip ZiB → EiB → ZiB', () {
      expect(1.ZiB.asEiB.asZiB.inZiB, closeTo(1.0, 1e-6));
    });

    test('round-trip YiB → ZiB → YiB', () {
      expect(1.YiB.asZiB.asYiB.inYiB, closeTo(1.0, 1e-6));
    });

    test('extension sugar — EiB unit', () {
      expect(1.EiB.unit, InformationUnit.exbibyte);
    });

    test('extension sugar — ZiB unit', () {
      expect(1.ZiB.unit, InformationUnit.zebibyte);
    });

    test('extension sugar — YiB unit', () {
      expect(1.YiB.unit, InformationUnit.yobibyte);
    });

    test('toString contains EiB symbol', () {
      expect(1.EiB.toString(), contains('EiB'));
    });

    test('parse EiB from symbol string', () {
      expect(Information.parse('1 EiB').unit, InformationUnit.exbibyte);
    });

    test('parse ZiB from symbol string', () {
      expect(Information.parse('1 ZiB').unit, InformationUnit.zebibyte);
    });

    test('parse YiB from symbol string', () {
      expect(Information.parse('1 YiB').unit, InformationUnit.yobibyte);
    });

    test('parse exbibyte from name', () {
      expect(Information.parse('2 exbibytes').unit, InformationUnit.exbibyte);
    });

    test('parse zebibyte from name', () {
      expect(Information.parse('1 zebibyte').unit, InformationUnit.zebibyte);
    });

    test('parse yobibyte from name', () {
      expect(Information.parse('1 yobibytes').unit, InformationUnit.yobibyte);
    });

    test('asEiB returns Information in exbibytes', () {
      expect(1024.0.PiB.asEiB.value, closeTo(1.0, 1e-6));
      expect(1024.0.PiB.asEiB.unit, InformationUnit.exbibyte);
    });
  });
}
