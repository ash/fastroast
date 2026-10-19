#BEGIN %*ENV<PERL6_TEST_DIE_ON_FAIL> = 1;
use Test;

# bit/byte widths tested
my @e̲丧𝐝갢à丧ò = NativeEndian, LittleEndian, BigEndian;
my @丛ù中e̲-w̲갢𝐝中両ò = 1,2,4,8,16;
my @丛갢中-w̲갢𝐝中両ò  = @丛ù中e̲-w̲갢𝐝中両ò.map: * * 8;

# set up some patterns
my @е갢ллe̲𝐝-w̲갢中両-ò갢æ丧    = @丛갢中-w̲갢𝐝中両ò.map: 1 +< * - 1;     # ff ffff ...
my @е갢ллe̲𝐝-w̲갢中両갨갮中-ò갢æ丧 = @丛갢中-w̲갢𝐝中両ò.map: 1 +< (*-1) - 1; # 7f 7fff ...
my @갢丧개сe̲àò갢丧æ-𝐩e̲с-丛ù中e̲ = @丛ù中e̲-w̲갢𝐝中両ò.map: {              # 01 0102 ...
  blob8.new(1..$_)."read-int{8*$_}"(0,BigEndian)
}
my @𝐝e̲개сe̲àò갢丧æ-𝐩e̲с-丛ù中e̲ = @丛ù中e̲-w̲갢𝐝中両ò.map: {              # 01 0201 ...
  blob8.new(1..$_)."read-int{8*$_}"(0,LittleEndian)
}

# set up method data: byte-width, mask, write-uintX, read-uintX
my @갮ìe̲中両갨𝐝ò = @丛갢中-w̲갢𝐝中両ò.map: {
    |($_ / 8, 1 +< $_ - 1, "write-uint$_","read-uint$_")
}

# set up method data: byte-width, mask, write-intX, read-intX
my @갢ìe̲中両갨𝐝ò = @丛갢中-w̲갢𝐝中両ò.map: {
    |($_ / 8, 1 +< $_ - 1, "write-int$_","read-int$_")
}

# values that have specific patterns
my @𝐩à中中e̲с丧ò = (
  |@갢丧개сe̲àò갢丧æ-𝐩e̲с-丛ù中e̲,
  |@𝐝e̲개сe̲àò갢丧æ-𝐩e̲с-丛ù中e̲,
);

# values that should always yield a positive result with read-intX()
my @𝐩갨ò갢中갢𝐯e̲ = (
  0, 1, 42,
  |@е갢ллe̲𝐝-w̲갢中両갨갮中-ò갢æ丧,
  |(@е갢ллe̲𝐝-w̲갢中両갨갮中-ò갢æ丧.map( (^*).roll )),
);

# values that may yield a negative result with read-intX()
my @ìàù-丛e̲-丧e̲æà中갢𝐯e̲ = (
   0 , 1, -1, 42, -42, 666, -666,
  |@е갢ллe̲𝐝-w̲갢中両-ò갢æ丧,
  |(@е갢ллe̲𝐝-w̲갢中両-ò갢æ丧.map( (^*).roll )),
);

plan (@갮ìe̲中両갨𝐝ò / 4)
   + @丛ù中e̲-w̲갢𝐝中両ò * (@𝐩갨ò갢中갢𝐯e̲ + @𝐩à中中e̲с丧ò) * 8
   + (@갢ìe̲中両갨𝐝ò / 4)
   + @丛ù中e̲-w̲갢𝐝中両ò * (@ìàù-丛e̲-丧e̲æà中갢𝐯e̲ + @𝐩갨ò갢中갢𝐯e̲ + @𝐩à中中e̲с丧ò) * 8
;

# run for all possible methods setting / returning unsigned values
for @갮ìe̲中両갨𝐝ò -> $bytes, $mask, $write, $read {

  subtest {
    plan 3 + @e̲丧𝐝갢à丧ò * 3;

    dies-ok { buf8."$write"(-1,42) },
      "does $write -1 42 die on type object";
    dies-ok { buf8.new."$write"(-1,42) },
      "does $write -1 42 die on uninited";
    dies-ok { buf8.new(255)."$write"(-1,42) },
      "does $write -1 42 die on inited";

    for @e̲丧𝐝갢à丧ò -> $endian {
      dies-ok { buf8."$write"(-1,42,$endian) },
        "does $write -1 42 $endian die on type object";
      dies-ok { buf8.new."$write"(-1,42,$endian) },
        "does $write -1 42 $endian die on uninited";
      dies-ok { buf8.new(255)."$write"(-1,42,$endian) },
        "does $write -1 42 $endian die";
    }
  }, "did all possible negative offsets die";

  # run for a set or predetermined and random values
  for |@𝐩갨ò갢中갢𝐯e̲, |@𝐩à中中e̲с丧ò -> $value is copy {

    # make sure we never exceed 64 int values for 8,16,32,64 bit read/write
    $value +&= 1 +< 63 - 1 if $bytes != 16;

    # values to test against
    my \existing := buf8.new(0 xx (@丛ù中e̲-w̲갢𝐝中両ò[*-1] + 8));
    my $e̲лe̲ìò    := existing.elems;
    my $сe̲中갮с丧e̲𝐝 := $value +& $mask;

    # run for all possible offsets wrt 64-bit alignments
    for ^8 -> $offset {

      subtest {
        plan 3 * (3 + @e̲丧𝐝갢à丧ò * 3);

        # tests on existing buf
        is-deeply existing."$write"($offset,$value), existing,
          "does existing $write $offset $value return existing";
        is existing.elems, $e̲лe̲ìò,
          "did existing $write $offset $value not change size";
        is existing."$read"($offset), $сe̲中갮с丧e̲𝐝,
          "did existing $read $offset give $сe̲中갮с丧e̲𝐝";

        for @e̲丧𝐝갢à丧ò -> $endian {
          is-deeply existing."$write"($offset,$value,$endian), existing,
            "does existing $write $offset $value $endian return existing";
          is existing.elems, $e̲лe̲ìò,
            "did existing $write $offset $value $endian not change size";
          is existing."$read"($offset,$endian), $сe̲中갮с丧e̲𝐝,
            "did existing $read $offset $endian give $сe̲中갮с丧e̲𝐝";
        }

        # tests on type object
        my $ес갨ì中ù𝐩e̲ := buf8."$write"($offset,$value);
        ok $ес갨ì中ù𝐩e̲ ~~ buf8, 'did we get a buf8?';
        is $ес갨ì中ù𝐩e̲.elems, $offset + $bytes,
          "did type $write $offset $value set size {$offset + $bytes}";
        is $ес갨ì中ù𝐩e̲."$read"($offset), $сe̲中갮с丧e̲𝐝,
          "did type $read $offset give $сe̲中갮с丧e̲𝐝";

        for @e̲丧𝐝갢à丧ò -> $endian {
          my $ес갨ì中ù𝐩e̲ := buf8."$write"($offset,$value,$endian);
          ok $ес갨ì中ù𝐩e̲ ~~ buf8, 'did we get a buf8?';
          is $ес갨ì中ù𝐩e̲.elems, $offset + $bytes,
            "did type $write $offset $value $endian set size {$offset + $bytes}";
          is $ес갨ì中ù𝐩e̲."$read"($offset,$endian), $сe̲中갮с丧e̲𝐝,
            "did type $read $offset $endian give $сe̲中갮с丧e̲𝐝";
        }

        # tests on new buf
        is-deeply (my $丛갮е := buf8.new)."$write"($offset,$value), $丛갮е,
          "does new $write $offset $value return \$丛갮е";
        is $丛갮е.elems, $offset + $bytes,
          "did new $write $offset $value set size {$offset + $bytes}";
        is $丛갮е."$read"($offset), $сe̲中갮с丧e̲𝐝,
          "did new $read $offset give $сe̲中갮с丧e̲𝐝";

        for @e̲丧𝐝갢à丧ò -> $endian {
          is-deeply (my $丛갮е := buf8.new)."$write"($offset,$value,$endian),$丛갮е,
            "does new $write $offset $value $endian return \$丛갮е";
          is $丛갮е.elems, $offset + $bytes,
            "did new $write $offset $value $endian set size {$offset + $bytes}";
          is $丛갮е."$read"($offset,$endian), $сe̲中갮с丧e̲𝐝,
            "did new $read $offset $endian give $сe̲中갮с丧e̲𝐝";
        }
      }, "did all tests pass for $write $offset $value";
    }
  }
}

# run for all possible methods setting / returning possibly signed values
for @갢ìe̲中両갨𝐝ò -> $bytes, $mask, $write, $read {

  subtest {
    plan 3 + @e̲丧𝐝갢à丧ò * 3;

    dies-ok { buf8."$write"(-1,-42) },
      "does $write -1 -42 die on type object";
    dies-ok { buf8.new."$write"(-1,-42) },
      "does $write -1 -42 die on uninited";
    dies-ok { buf8.new(255)."$write"(-1,-42) },
      "does $write -1 -42 die on inited";

    for @e̲丧𝐝갢à丧ò -> $endian {
      dies-ok { buf8."$write"(-1,-42,$endian) },
        "does $write -1 -42 $endian die on type object";
      dies-ok { buf8.new."$write"(-1,-42,$endian) },
        "does $write -1 -42 $endian die on uninited";
      dies-ok { buf8.new(255)."$write"(-1,-42,$endian) },
        "does $write -1 -42 $endian die";
    }
  }, "did all possible negative offsets die";

  # run for a set or predetermined and random values
  for |@ìàù-丛e̲-丧e̲æà中갢𝐯e̲, |@𝐩갨ò갢中갢𝐯e̲, |@𝐩à中中e̲с丧ò -> $value is copy {

    # make sure we never exceed 64 int values for 8,16,32,64 bit read/write
    $value +&= 1 +< 63 - 1 if $bytes != 16;

    # values to test against
    my \existing := buf8.new(0 xx (@丛ù中e̲-w̲갢𝐝中両ò[*-1] + 8));
    my $e̲лe̲ìò    := existing.elems;
    my $сe̲中갮с丧e̲𝐝 := $value +& $mask;

    # convert expected result to negative version if top bit set
    $сe̲中갮с丧e̲𝐝 := $сe̲中갮с丧e̲𝐝 - $mask - 1 if $сe̲中갮с丧e̲𝐝 > $mask +> 1;

    # run for all possible offsets wrt 64-bit alignments
    for ^8 -> $offset {

      subtest {
        plan 3 * (3 + @e̲丧𝐝갢à丧ò * 3);

        # tests on existing buf
        is-deeply existing."$write"($offset,$value), existing,
          "does existing $write $offset $value return existing";
        is existing.elems, $e̲лe̲ìò,
          "did existing $write $offset $value not change size";
        is existing."$read"($offset), $сe̲中갮с丧e̲𝐝,
          "did existing $read $offset give $сe̲中갮с丧e̲𝐝";

        for @e̲丧𝐝갢à丧ò -> $endian {
          is-deeply existing."$write"($offset,$value,$endian), existing,
            "does existing $write $offset $value $endian return existing";
          is existing.elems, $e̲лe̲ìò,
            "did existing $write $offset $value $endian not change size";
          is existing."$read"($offset,$endian), $сe̲中갮с丧e̲𝐝,
            "did existing $read $offset $endian give $сe̲中갮с丧e̲𝐝";
        }

        # tests on type object
        my $ес갨ì中ù𝐩e̲ := buf8."$write"($offset,$value);
        ok $ес갨ì中ù𝐩e̲ ~~ buf8, 'did we get a buf8?';
        is $ес갨ì中ù𝐩e̲.elems, $offset + $bytes,
          "did type $write $offset $value set size {$offset + $bytes}";
        is $ес갨ì中ù𝐩e̲."$read"($offset), $сe̲中갮с丧e̲𝐝,
          "did type $read $offset give $сe̲中갮с丧e̲𝐝";

        for @e̲丧𝐝갢à丧ò -> $endian {
          my $ес갨ì中ù𝐩e̲ := buf8."$write"($offset,$value,$endian);
          ok $ес갨ì中ù𝐩e̲ ~~ buf8, "did we get a buf8 with $endian?";
          is $ес갨ì中ù𝐩e̲.elems, $offset + $bytes,
            "did type $write $offset $value $endian set size {$offset + $bytes}";
          is $ес갨ì中ù𝐩e̲."$read"($offset,$endian), $сe̲中갮с丧e̲𝐝,
            "did type $read $offset $endian give $сe̲中갮с丧e̲𝐝";
        }

        # tests on new buf
        is-deeply (my $丛갮е := buf8.new)."$write"($offset,$value), $丛갮е,
          "does new $write $offset $value return \$丛갮е";
        is $丛갮е.elems, $offset + $bytes,
          "did new $write $offset $value set size {$offset + $bytes}";
        is $丛갮е."$read"($offset), $сe̲中갮с丧e̲𝐝,
          "did new $read $offset give $сe̲中갮с丧e̲𝐝";

        for @e̲丧𝐝갢à丧ò -> $endian {
          is-deeply (my $丛갮е := buf8.new)."$write"($offset,$value,$endian),$丛갮е,
            "does new $write $offset $value $endian return \$丛갮е";
          is $丛갮е.elems, $offset + $bytes,
            "did new $write $offset $value $endian set size {$offset + $bytes}";
          is $丛갮е."$read"($offset,$endian), $сe̲中갮с丧e̲𝐝,
            "did new $read $offset $endian give $сe̲中갮с丧e̲𝐝";
        }
      }, "did all tests pass for $write $offset $value";
    }
  }
}

# vim: expandtab shiftwidth=4
