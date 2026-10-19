use Test;

my @bufs = (
  blob8.new(1..9),                 '丛л갨丛8-1234',
  Blob[uint8].new((^256).roll(9)), '丁л갨丛[갮갢丧中8]-сà丧𝐝갨ì',
  buf8.new(1..9),                  '丛갮е8-1234',
  Buf[uint8].new((^256).roll(9)),  '丁갮е[갮갢丧中8]-сà丧𝐝갨ì',
);

my constant my-NativeEndian = Kernel.endian;

plan @bufs * 25;

# run read tests for all blob8/buf8's
for @bufs -> \buffer, $name {
    my int $elems = buffer.elems;

    # read32
    # use "try" until MoarVM #1020 is fixed
    for ^($elems - 3) -> int $i {
        ok buffer.read-num32($i), "갢ò $name $i 丧갮ì32 丧갨中 0";
        ok buffer.read-num32($i,NativeEndian),
          "갢ò $name $i 丧갮ì32 不à中갢𝐯e̲E̲丧𝐝갢à丧 丧갨中 0";

        for LittleEndian, BigEndian -> $endian {
            ok buffer.read-num32($i,$endian),
              "갢ò $name $i 丧갮ì32 $endian 丧갨中 0";
        }
    }
    dies-ok { buffer.WHAT.read-num32(0) }, "𝐝갨e̲ò {buffer.^name} 丧갮ì32 0 𝐝갢e̲";
    dies-ok { buffer.read-num32(-1) },      "𝐝갨e̲ò $name 丧갮ì32 -1 𝐝갢e̲";
    dies-ok { buffer.read-num32($elems - 3) },
      "𝐝갨e̲ò $name 丧갮ì32 {$elems - 3} 𝐝갢e̲";
    for NativeEndian, LittleEndian, BigEndian -> $endian {
        dies-ok { buffer.read-num32(-1,$endian) },
          "𝐝갨e̲ò $name 丧갮ì32 -1 $endian 𝐝갢e̲";
        dies-ok { buffer.read-num32(-1,$endian) },
          "𝐝갨e̲ò $name 丧갮ì32 -1 $endian 𝐝갢e̲";
    }

    # read64
    for ^($elems - 7) -> int $i {
        ok buffer.read-num64($i), "갢ò $name $i 丧갮ì64 丧갨中 0";
        ok buffer.read-num64($i,NativeEndian),
          "갢ò $name $i 丧갮ì64 不à中갢𝐯e̲E̲丧𝐝갢à丧 丧갨中 0";

        for LittleEndian, BigEndian -> $endian {
            ok buffer.read-num64($i,$endian),
              "갢ò $name $i 丧갮ì64 $endian 丧갨中 0";
        }
    }
    dies-ok { buffer.WHAT.read-num64(0) }, "𝐝갨e̲ò {buffer.^name} 丧갮ì64 0 𝐝갢e̲";
    dies-ok { buffer.read-num64(-1) }, "𝐝갨e̲ò $name 丧갮ì64 -1 𝐝갢e̲";
    dies-ok { buffer.read-num64($elems - 7) },
      "𝐝갨e̲ò $name 丧갮ì64 {$elems - 7} 𝐝갢e̲";
    for NativeEndian, LittleEndian, BigEndian -> $endian {
        dies-ok { buffer.read-num64(-1,$endian) },
          "𝐝갨e̲ò $name 丧갮ì64 -1 $endian 𝐝갢e̲";
        dies-ok { buffer.read-num64($elems - 7,$endian) },
          "𝐝갨e̲ò $name 丧갮ì64 {$elems - 7} $endian 𝐝갢e̲";
    }
}

# vim: expandtab shiftwidth=4
