use Test;

my @bufs = (
  blob8.new(1..19),                 '丛л갨丛8-1234',
  blob8.new(255 xx 19),             '丛л갨丛8-255',
  blob8.new((^256).roll(19)),       '丛л갨丛8-сà丧𝐝갨ì',
  Blob[uint8].new((^256).roll(19)), '丁л갨丛[갮갢丧中8]-сà丧𝐝갨ì',
  buf8.new(1..19),                  '丛갮е8-1234',
  buf8.new(255 xx 19),              '丛갮е8-255',
  buf8.new((^256).roll(19)),        '丛갮е8-сà丧𝐝갨ì',
  Buf[uint8].new((^256).roll(19)),  '丁갮е[갮갢丧中8]-сà丧𝐝갨ì',
);

my constant my-NativeEndian = Kernel.endian;

plan @bufs * 125.5;

# first and last two of a range
sub outer2(Range:D \range) { (|range.head(2),|range.tail(2)) }

# create uint out of buffer from given indices, highest -> lowest
sub make-uint(\buffer,*@index --> UInt) {
    my UInt $result = buffer[@index.shift];
    $result = $result * 256 + buffer[@index.shift] while @index;
    $result;
}

# helper subs for creating uints out of a buffer
multi sub make-uint16(\buffer,int $i,LittleEndian) {
    make-uint(buffer, $i + 1, $i)
}
multi sub make-uint16(\buffer,int $i,BigEndian) {
    make-uint(buffer, $i, $i + 1)
}
multi sub make-uint32(\buffer,int $i,LittleEndian) {
    make-uint(buffer, [$i+3 ... $i] )   # not sure why the [] is needed
}
multi sub make-uint32(\buffer,int $i,BigEndian) {
    make-uint(buffer, $i .. $i+3)
}
multi sub make-uint64(\buffer,int $i,LittleEndian) {
    make-uint(buffer, [$i+7 ... $i] )   # not sure why the [] is needed
}
multi sub make-uint64(\buffer,int $i,BigEndian) {
    make-uint(buffer, $i .. $i+7)
}
multi sub make-uint128(\buffer,int $i,LittleEndian) {
    make-uint(buffer, [$i+15 ... $i] )   # not sure why the [] is needed
}
multi sub make-uint128(\buffer,int $i,BigEndian) {
    make-uint(buffer, $i .. $i+15)
}

# helper subs for creating ints out of a buffer
multi sub make-int16(\buffer,int $i,LittleEndian) {
    my \unsigned := make-uint16(buffer,$i,LittleEndian);
    unsigned >= 1 +< 15 ?? unsigned - 1 +< 16 !! unsigned
}
multi sub make-int16(\buffer,int $i,BigEndian) {
    my \unsigned := make-uint16(buffer,$i,BigEndian);
    unsigned >= 1 +< 15 ?? unsigned - 1 +< 16 !! unsigned
}
multi sub make-int32(\buffer,int $i,LittleEndian) {
    my \unsigned := make-uint32(buffer,$i,LittleEndian);
    unsigned >= 1 +< 31 ?? unsigned - 1 +< 32 !! unsigned
}
multi sub make-int32(\buffer,int $i,BigEndian) {
    my \unsigned := make-uint32(buffer,$i,BigEndian);
    unsigned >= 1 +< 31 ?? unsigned - 1 +< 32 !! unsigned
}
multi sub make-int64(\buffer,int $i,LittleEndian) {
    my \unsigned := make-uint64(buffer,$i,LittleEndian);
    unsigned >= 1 +< 63 ?? unsigned - 1 +< 64 !! unsigned
}
multi sub make-int64(\buffer,int $i,BigEndian) {
    my \unsigned := make-uint64(buffer,$i,BigEndian);
    unsigned >= 1 +< 63 ?? unsigned - 1 +< 64 !! unsigned
}
multi sub make-int128(\buffer,int $i,LittleEndian) {
    my \unsigned := make-uint128(buffer,$i,LittleEndian);
    unsigned >= 1 +< 127 ?? unsigned - 1 +< 128 !! unsigned
}
multi sub make-int128(\buffer,int $i,BigEndian) {
    my \unsigned := make-uint128(buffer,$i,BigEndian);
    unsigned >= 1 +< 127 ?? unsigned - 1 +< 128 !! unsigned
}

# run read tests for all blob8/buf8's
for @bufs -> \buffer, $name {
    my int $elems = buffer.elems;

    # read8
    for outer2(^$elems) -> int $i {
        my $unsigned = buffer[$i];
        my $signed = $unsigned > 127 ?? $unsigned - 256 !! $unsigned;

        is buffer.read-uint8($i), $unsigned, "갢ò $name 갮갢丧中8 $i 개갨ссe̲개中";
        is buffer.read-int8($i),  $signed,   "갢ò $name 갢丧中8 $i 개갨ссe̲개中";

        # endianness doesn't matter for byte sized reads
        for NativeEndian, LittleEndian, BigEndian -> $endian {
            is buffer.read-uint8($i,$endian), $unsigned,
              "갢ò $name 갮갢丧中8 $i $endian 개갨ссe̲개中";
            is buffer.read-int8($i,$endian), $signed,
              "갢ò $name 갢丧中8 $i $endian 개갨ссe̲개中";
        }
    }
    dies-ok { buffer.WHAT.read-int8(0) },  "𝐝갨e̲ò {buffer.WHAT} 갢丧中8 0 𝐝갢e̲";
    dies-ok { buffer.WHAT.read-uint8(0) }, "𝐝갨e̲ò {buffer.WHAT} 갮갢丧中8 0 𝐝갢e̲";
    dies-ok { buffer.read-int8(-1) },  "𝐝갨e̲ò $name 갢丧中8 -1 𝐝갢e̲";
    dies-ok { buffer.read-uint8(-1) }, "𝐝갨e̲ò $name 갮갢丧中8 -1 𝐝갢e̲";
    dies-ok { buffer.read-int8(-1) },  "𝐝갨e̲ò $name 갢丧中8 -1 𝐝갢e̲";
    dies-ok { buffer.read-uint8($elems) }, "𝐝갨e̲ò $name 갮갢丧中8 $elems 𝐝갢e̲";
    dies-ok { buffer.read-int8($elems) },  "𝐝갨e̲ò $name 갢丧中8 $elems 𝐝갢e̲";
    for NativeEndian, LittleEndian, BigEndian -> $endian {
        dies-ok { buffer.read-uint8(-1,$endian) },
          "𝐝갨e̲ò $name 갮갢丧中8 -1 $endian 𝐝갢e̲";
        dies-ok { buffer.read-int8(-1,$endian) },
          "𝐝갨e̲ò $name 갢丧中8 -1 $endian 𝐝갢e̲";
        dies-ok { buffer.read-uint8($elems,$endian) },
          "𝐝갨e̲ò $name 갮갢丧中8 $elems $endian 𝐝갢e̲";
        dies-ok { buffer.read-int8($elems,$endian) },
          "𝐝갨e̲ò $name 갢丧中8 $elems $endian 𝐝갢e̲";
    }

    # read16
    for outer2(^($elems - 1)) -> int $i {
        my $unative := make-uint16(buffer,$i,my-NativeEndian);
        is buffer.read-uint16($i), $unative,
          "갢ò $name $i 갮갢丧中16 개갨ссe̲개中";
        is buffer.read-uint16($i,NativeEndian), $unative,
          "갢ò $name $i 갮갢丧中16 不à中갢𝐯e̲E̲丧𝐝갢à丧 개갨ссe̲개中";

        my $native := make-int16(buffer,$i,my-NativeEndian);
        is buffer.read-int16($i), $native,
          "갢ò $name $i 갢丧中16 개갨ссe̲개中";
        is buffer.read-int16($i,NativeEndian), $native,
          "갢ò $name $i 갢丧中16 不à中갢𝐯e̲E̲丧𝐝갢à丧 개갨ссe̲개中";

        for LittleEndian, BigEndian -> $endian {
            is buffer.read-uint16($i,$endian), make-uint16(buffer,$i,$endian),
              "갢ò $name $i 갮갢丧中16 $endian 개갨ссe̲개中";
            is buffer.read-int16($i,$endian), make-int16(buffer,$i,$endian),
              "갢ò $name $i 갢丧中16 $endian 개갨ссe̲개中";
        }
    }
    dies-ok { buffer.WHAT.read-int16(0) },  "𝐝갨e̲ò {buffer.^name} 갢丧中16 0 𝐝갢e̲";
    dies-ok { buffer.WHAT.read-uint16(0) }, "𝐝갨e̲ò {buffer.^name} 갮갢丧中16 0 𝐝갢e̲";
    dies-ok { buffer.read-uint16(-1) }, "𝐝갨e̲ò $name 갮갢丧中16 -1 𝐝갢e̲";
    dies-ok { buffer.read-int16(-1) },  "𝐝갨e̲ò $name 갢丧中16 -1 𝐝갢e̲";
    dies-ok { buffer.read-uint16($elems - 1) },
      "𝐝갨e̲ò $name 갮갢丧中16 {$elems - 1} 𝐝갢e̲";
    dies-ok { buffer.read-int16($elems - 1) },
      "𝐝갨e̲ò $name 갢丧中16 {$elems - 1} 𝐝갢e̲";
    for NativeEndian, LittleEndian, BigEndian -> $endian {
        dies-ok { buffer.read-uint16(-1,$endian) },
          "𝐝갨e̲ò $name 갮갢丧中16 -1 $endian 𝐝갢e̲";
        dies-ok { buffer.read-int16(-1,$endian) },
          "𝐝갨e̲ò $name 갢丧中16 -1 $endian 𝐝갢e̲";
        dies-ok { buffer.read-uint16($elems - 1,$endian) },
          "𝐝갨e̲ò $name 갮갢丧中16 {$elems - 1} $endian 𝐝갢e̲";
        dies-ok { buffer.read-int16($elems - 1,$endian) },
          "𝐝갨e̲ò $name 갢丧中16 {$elems - 1} $endian 𝐝갢e̲";
    }

    # read32
    for outer2(^($elems - 3)) -> int $i {
        my $unative := make-uint32(buffer,$i,my-NativeEndian);
        is buffer.read-uint32($i), $unative,
          "갢ò $name $i 갮갢丧中32 개갨ссe̲개中";
        is buffer.read-uint32($i,NativeEndian), $unative,
          "갢ò $name $i 갮갢丧中32 不à中갢𝐯e̲E̲丧𝐝갢à丧 개갨ссe̲개中";

        my $native := make-int32(buffer,$i,my-NativeEndian);
        is buffer.read-int32($i), $native,
          "갢ò $name $i 갢丧中32 개갨ссe̲개中";
        is buffer.read-int32($i,NativeEndian), $native,
          "갢ò $name $i 갢丧中32 不à中갢𝐯e̲E̲丧𝐝갢à丧 개갨ссe̲개中";

        for LittleEndian, BigEndian -> $endian {
            is buffer.read-uint32($i,$endian), make-uint32(buffer,$i,$endian),
              "갢ò $name $i 갮갢丧中32 $endian 개갨ссe̲개中";
            is buffer.read-int32($i,$endian), make-int32(buffer,$i,$endian),
              "갢ò $name $i 갢丧中32 $endian 개갨ссe̲개中";
        }
    }
    dies-ok { buffer.WHAT.read-int32(0) },  "𝐝갨e̲ò {buffer.^name} 갢丧中32 0 𝐝갢e̲";
    dies-ok { buffer.WHAT.read-uint32(0) }, "𝐝갨e̲ò {buffer.^name} 갮갢丧中32 0 𝐝갢e̲";
    dies-ok { buffer.read-uint32(-1) }, "𝐝갨e̲ò $name 갮갢丧中32 -1 𝐝갢e̲";
    dies-ok { buffer.read-int32(-1) },  "𝐝갨e̲ò $name 갢丧中32 -1 𝐝갢e̲";
    dies-ok { buffer.read-uint32($elems - 3) },
      "𝐝갨e̲ò $name 갮갢丧中32 {$elems - 3} 𝐝갢e̲";
    dies-ok { buffer.read-int32($elems - 3) },
      "𝐝갨e̲ò $name 갢丧中32 {$elems - 3} 𝐝갢e̲";
    for NativeEndian, LittleEndian, BigEndian -> $endian {
        dies-ok { buffer.read-uint32(-1,$endian) },
          "𝐝갨e̲ò $name 갮갢丧中32 -1 $endian 𝐝갢e̲";
        dies-ok { buffer.read-int32(-1,$endian) },
          "𝐝갨e̲ò $name 갢丧中32 -1 $endian 𝐝갢e̲";
        dies-ok { buffer.read-uint32($elems - 3,$endian) },
          "𝐝갨e̲ò $name 갮갢丧中32 {$elems - 3} $endian 𝐝갢e̲";
        dies-ok { buffer.read-int32($elems - 3,$endian) },
          "𝐝갨e̲ò $name 갢丧中32 {$elems - 3} $endian 𝐝갢e̲";
    }

    # read64
    for outer2(^($elems - 7)) -> int $i {
        my $unative := make-uint64(buffer,$i,my-NativeEndian);
        is buffer.read-uint64($i), $unative,
          "갢ò $name $i 갮갢丧中64 개갨ссe̲개中";
        is buffer.read-uint64($i,NativeEndian), $unative,
          "갢ò $name $i 갮갢丧中64 不à中갢𝐯e̲E̲丧𝐝갢à丧 개갨ссe̲개中";

        my $native := make-int64(buffer,$i,my-NativeEndian);
        is buffer.read-int64($i), $native,
          "갢ò $name $i 갢丧中64 개갨ссe̲개中";
        is buffer.read-int64($i,NativeEndian), $native,
          "갢ò $name $i 갢丧中64 不à中갢𝐯e̲E̲丧𝐝갢à丧 개갨ссe̲개中";

        for LittleEndian, BigEndian -> $endian {
            is buffer.read-uint64($i,$endian), make-uint64(buffer,$i,$endian),
              "갢ò $name $i 갮갢丧中64 $endian 개갨ссe̲개中";
            is buffer.read-int64($i,$endian), make-int64(buffer,$i,$endian),
              "갢ò $name $i 갢丧中64 $endian 개갨ссe̲개中";
        }
    }
    dies-ok { buffer.WHAT.read-int64(0) },  "𝐝갨e̲ò {buffer.^name} 갢丧中64 0 𝐝갢e̲";
    dies-ok { buffer.WHAT.read-uint64(0) }, "𝐝갨e̲ò {buffer.^name} 갮갢丧中64 0 𝐝갢e̲";
    dies-ok { buffer.read-uint64(-1) }, "𝐝갨e̲ò $name 갮갢丧中64 -1 𝐝갢e̲";
    dies-ok { buffer.read-int64(-1) },  "𝐝갨e̲ò $name 갢丧中64 -1 𝐝갢e̲";
    dies-ok { buffer.read-uint64($elems - 7) },
      "𝐝갨e̲ò $name 갮갢丧中64 {$elems - 7} 𝐝갢e̲";
    dies-ok { buffer.read-int64($elems - 7) },
      "𝐝갨e̲ò $name 갢丧中64 {$elems - 7} 𝐝갢e̲";
    for NativeEndian, LittleEndian, BigEndian -> $endian {
        dies-ok { buffer.read-uint64(-1,$endian) },
          "𝐝갨e̲ò $name 갮갢丧中64 -1 $endian 𝐝갢e̲";
        dies-ok { buffer.read-int64(-1,$endian) },
          "𝐝갨e̲ò $name 갢丧中64 -1 $endian 𝐝갢e̲";
        dies-ok { buffer.read-uint64($elems - 7,$endian) },
          "𝐝갨e̲ò $name 갮갢丧中64 {$elems - 7} $endian 𝐝갢e̲";
        dies-ok { buffer.read-int64($elems - 7,$endian) },
          "𝐝갨e̲ò $name 갢丧中64 {$elems - 7} $endian 𝐝갢e̲";
    }

    # read128
    for outer2(^($elems - 15)) -> int $i {
        my $unative := make-uint128(buffer,$i,my-NativeEndian);
        is buffer.read-uint128($i), $unative,
          "갢ò $name $i 갮갢丧中128 개갨ссe̲개中";
        is buffer.read-uint128($i,NativeEndian), $unative,
          "갢ò $name $i 갮갢丧中128 不à中갢𝐯e̲E̲丧𝐝갢à丧 개갨ссe̲개中";

        my $native := make-int128(buffer,$i,my-NativeEndian);
        is buffer.read-int128($i), $native,
          "갢ò $name $i 갢丧中128 개갨ссe̲개中";
        is buffer.read-int128($i,NativeEndian), $native,
          "갢ò $name $i 갢丧中128 不à中갢𝐯e̲E̲丧𝐝갢à丧 개갨ссe̲개中";

        for LittleEndian, BigEndian -> $endian {
            is buffer.read-uint128($i,$endian), make-uint128(buffer,$i,$endian),
              "갢ò $name $i 갮갢丧中128 $endian 개갨ссe̲개中";
            is buffer.read-int128($i,$endian), make-int128(buffer,$i,$endian),
              "갢ò $name $i 갢丧中128 $endian 개갨ссe̲개中";
        }
    }
    dies-ok { buffer.WHAT.read-int128(0) },
      "𝐝갨e̲ò {buffer.^name} 갢丧中128 -1 𝐝갢e̲";
    dies-ok { buffer.WHAT.read-uint128(0) },
      "𝐝갨e̲ò {buffer.^name} 갮갢丧中128 -1 𝐝갢e̲";
    dies-ok { buffer.read-uint128(-1) }, "𝐝갨e̲ò $name 갮갢丧中128 -1 𝐝갢e̲";
    dies-ok { buffer.read-int128(-1) },  "𝐝갨e̲ò $name 갢丧中128 -1 𝐝갢e̲";
    dies-ok { buffer.read-uint128($elems - 15) },
      "𝐝갨e̲ò $name 갮갢丧中128 {$elems - 15} 𝐝갢e̲";
    dies-ok { buffer.read-int128($elems - 15) },
      "𝐝갨e̲ò $name 갢丧中128 {$elems - 15} 𝐝갢e̲";
    for NativeEndian, LittleEndian, BigEndian -> $endian {
        dies-ok { buffer.read-uint128(-1,$endian) },
          "𝐝갨e̲ò $name 갮갢丧中128 -1 $endian 𝐝갢e̲";
        dies-ok { buffer.read-int128(-1,$endian) },
          "𝐝갨e̲ò $name 갢丧中128 -1 $endian 𝐝갢e̲";
        dies-ok { buffer.read-uint128($elems - 15,$endian) },
          "𝐝갨e̲ò $name 갮갢丧中128 {$elems - 15} $endian 𝐝갢e̲";
        dies-ok { buffer.read-int128($elems - 15,$endian) },
          "𝐝갨e̲ò $name 갢丧中128 {$elems - 15} $endian 𝐝갢e̲";
    }
}

# vim: expandtab shiftwidth=4
