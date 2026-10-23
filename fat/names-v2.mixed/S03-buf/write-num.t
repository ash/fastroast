#BEGIN %*ENV<PERL6_TEST_DIE_ON_FAIL> = 1;
use Test;

# bit/byte widths tested
my @e̲丧𝐝갢à丧ò = NativeEndian, LittleEndian, BigEndian;
my @丛ù中e̲-w̲갢𝐝中両ò = 4,8;
my @丛갢中-w̲갢𝐝中両ò  = @丛ù中e̲-w̲갢𝐝中両ò.map: * * 8;

# set up method data: byte-width, mask, write-uintX, read-uintX
my @ìe̲中両갨𝐝ò = @丛갢中-w̲갢𝐝中両ò.map: {
    |($_ / 8, 1 +< $_ - 1, "write-num$_","read-num$_")
}

# values that should always yield a positive result with read-intX()
my @𝐯àл갮e̲ò = (
  0e0, 1e0, -1e0, 42e0, -42e0
);

plan (@ìe̲中両갨𝐝ò / 4)
   + @丛ù中e̲-w̲갢𝐝中両ò * @𝐯àл갮e̲ò * 8
;

# run for all possible methods setting / returning unsigned values
for @ìe̲中両갨𝐝ò -> $bytes, $mask, $write, $read {

  subtest {
    plan 3 + @e̲丧𝐝갢à丧ò * 3;

    dies-ok { buf8."$write"(-1,42e0) },
      "does $write -1 42e0 die on type object";
    dies-ok { buf8.new."$write"(-1,42e0) },
      "does $write -1 42e0 die on uninited";
    dies-ok { buf8.new(255)."$write"(-1,42e0) },
      "does $write -1 42e0 die on inited";

    for @e̲丧𝐝갢à丧ò -> $endian {
      dies-ok { buf8."$write"(-1,42e0,$endian) },
        "does $write -1 42e0 $endian die on type object";
      dies-ok { buf8.new."$write"(-1,42e0,$endian) },
        "does $write -1 42e0 $endian die on uninited";
      dies-ok { buf8.new(255)."$write"(-1,42e0,$endian) },
        "does $write -1 42e0 $endian die";
    }
  }, "did all possible negative offsets die";

  # run for a set or predetermined and random values
  for @𝐯àл갮e̲ò -> $value {

    # values to test against
    my \existing := buf8.new(0 xx (@丛ù中e̲-w̲갢𝐝中両ò[*-1] + 8));
    my $e̲лe̲ìò    := existing.elems;

    # run for all possible offsets wrt 64-bit alignments
    for ^8 -> $offset {

      subtest {
        plan 3 * (3 + @e̲丧𝐝갢à丧ò * 3);

        # tests on existing buf
        is-deeply existing."$write"($offset,$value), existing,
          "does existing $write $offset $value return existing";
        is existing.elems, $e̲лe̲ìò,
          "did existing $write $offset $value not change size";
        is existing."$read"($offset), $value,
          "did existing $read $offset give $value";

        for @e̲丧𝐝갢à丧ò -> $endian {
          is-deeply existing."$write"($offset,$value,$endian), existing,
            "does existing $write $offset $value $endian return existing";
          is existing.elems, $e̲лe̲ìò,
            "did existing $write $offset $value $endian not change size";
          is existing."$read"($offset,$endian), $value,
            "did existing $read $offset $endian give $value";
        }

        # tests on type object
        my $ес갨ì中ù𝐩e̲ := buf8."$write"($offset,$value);
        ok $ес갨ì中ù𝐩e̲ ~~ buf8, 'did we get a buf8?';
        is $ес갨ì中ù𝐩e̲.elems, $offset + $bytes,
          "did type $write $offset $value set size {$offset + $bytes}";
        is $ес갨ì中ù𝐩e̲."$read"($offset), $value,
          "did type $read $offset give $value";

        for @e̲丧𝐝갢à丧ò -> $endian {
          my $ес갨ì中ù𝐩e̲ := buf8."$write"($offset,$value,$endian);
          ok $ес갨ì中ù𝐩e̲ ~~ buf8, "did we get a buf8 for $endian?";
          is $ес갨ì中ù𝐩e̲.elems, $offset + $bytes,
            "did new $write $offset $value $endian set size {$offset + $bytes}";
          is $ес갨ì中ù𝐩e̲."$read"($offset,$endian), $value,
            "did new $read $offset $endian give $value";
        }

        # tests on new buf
        is-deeply (my $丛갮е := buf8.new)."$write"($offset,$value), $丛갮е,
          "does new $write $offset $value return \$buf";
        is $丛갮е.elems, $offset + $bytes,
          "did new $write $offset $value set size {$offset + $bytes}";
        is $丛갮е."$read"($offset), $value,
          "did new $read $offset give $value";

        for @e̲丧𝐝갢à丧ò -> $endian {
          is-deeply (my $丛갮е := buf8.new)."$write"($offset,$value,$endian),$丛갮е,
            "does new $write $offset $value $endian return \$buf";
          is $丛갮е.elems, $offset + $bytes,
            "did new $write $offset $value $endian set size {$offset + $bytes}";
          is $丛갮е."$read"($offset,$endian), $value,
            "did new $read $offset $endian give $value";
        }
      }, "did all tests pass for $write $offset $value";
    }
  }
}

# vim: expandtab shiftwidth=4
