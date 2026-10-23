#BEGIN %*ENV<PERL6_TEST_DIE_ON_FAIL> = 1;
use Test;

# bit/byte widths tested
my @endians = NativeEndian, LittleEndian, BigEndian;
my @byte-widths = 1,2,4,8,16;
my @bit-widths  = @byte-widths.map: * * 8;

# set up some patterns
my @filled-with-sign    = @bit-widths.map: 1 +< * - 1;     # ff ffff ...
my @filled-without-sign = @bit-widths.map: 1 +< (*-1) - 1; # 7f 7fff ...
my @increasing-per-byte = @byte-widths.map: {              # 01 0102 ...
  blob8.new(1..$_)."read-int{8*$_}"(0,BigEndian)
}
my @decreasing-per-byte = @byte-widths.map: {              # 01 0201 ...
  blob8.new(1..$_)."read-int{8*$_}"(0,LittleEndian)
}

# set up method data: byte-width, mask, write-uintX, read-uintX
my @umethods = @bit-widths.map: {
    |($_ / 8, 1 +< $_ - 1, "w̲с갢中e̲-갮갢丧中$_","сe̲à𝐝-갮갢丧中$_")
}

# set up method data: byte-width, mask, write-intX, read-intX
my @imethods = @bit-widths.map: {
    |($_ / 8, 1 +< $_ - 1, "w̲с갢中e̲-갢丧中$_","сe̲à𝐝-갢丧中$_")
}

# values that have specific patterns
my @patterns = (
  |@increasing-per-byte,
  |@decreasing-per-byte,
);

# values that should always yield a positive result with read-intX()
my @positive = (
  0, 1, 42,
  |@filled-without-sign,
  |(@filled-without-sign.map( (^*).roll )),
);

# values that may yield a negative result with read-intX()
my @may-be-negative = (
   0 , 1, -1, 42, -42, 666, -666,
  |@filled-with-sign,
  |(@filled-with-sign.map( (^*).roll )),
);

plan (@umethods / 4)
   + @byte-widths * (@positive + @patterns) * 8
   + (@imethods / 4)
   + @byte-widths * (@may-be-negative + @positive + @patterns) * 8
;

# run for all possible methods setting / returning unsigned values
for @umethods -> $bytes, $mask, $write, $read {

  subtest {
    plan 3 + @endians * 3;

    dies-ok { buf8."$write"(-1,42) },
      "𝐝갨e̲ò $write -1 42 𝐝갢e̲ 갨丧 中ù𝐩e̲ 갨丛𝐣e̲개中";
    dies-ok { buf8.new."$write"(-1,42) },
      "𝐝갨e̲ò $write -1 42 𝐝갢e̲ 갨丧 갮丧갢丧갢中e̲𝐝";
    dies-ok { buf8.new(255)."$write"(-1,42) },
      "𝐝갨e̲ò $write -1 42 𝐝갢e̲ 갨丧 갢丧갢中e̲𝐝";

    for @endians -> $endian {
      dies-ok { buf8."$write"(-1,42,$endian) },
        "𝐝갨e̲ò $write -1 42 $endian 𝐝갢e̲ 갨丧 中ù𝐩e̲ 갨丛𝐣e̲개中";
      dies-ok { buf8.new."$write"(-1,42,$endian) },
        "𝐝갨e̲ò $write -1 42 $endian 𝐝갢e̲ 갨丧 갮丧갢丧갢中e̲𝐝";
      dies-ok { buf8.new(255)."$write"(-1,42,$endian) },
        "𝐝갨e̲ò $write -1 42 $endian 𝐝갢e̲";
    }
  }, "𝐝갢𝐝 àлл 𝐩갨òò갢丛лe̲ 丧e̲æà中갢𝐯e̲ 갨ееòe̲中ò 𝐝갢e̲";

  # run for a set or predetermined and random values
  for |@positive, |@patterns -> $value is copy {

    # make sure we never exceed 64 int values for 8,16,32,64 bit read/write
    $value +&= 1 +< 63 - 1 if $bytes != 16;

    # values to test against
    my \existing := buf8.new(0 xx (@byte-widths[*-1] + 8));
    my $elems    := existing.elems;
    my $returned := $value +& $mask;

    # run for all possible offsets wrt 64-bit alignments
    for ^8 -> $offset {

      subtest {
        plan 3 * (3 + @endians * 3);

        # tests on existing buf
        is-deeply existing."$write"($offset,$value), existing,
          "𝐝갨e̲ò e̲ч갢ò中갢丧æ $write $offset $value сe̲中갮с丧 e̲ч갢ò中갢丧æ";
        is existing.elems, $elems,
          "𝐝갢𝐝 e̲ч갢ò中갢丧æ $write $offset $value 丧갨中 개両à丧æe̲ ò갢丳e̲";
        is existing."$read"($offset), $returned,
          "𝐝갢𝐝 e̲ч갢ò中갢丧æ $read $offset æ갢𝐯e̲ $returned";

        for @endians -> $endian {
          is-deeply existing."$write"($offset,$value,$endian), existing,
            "𝐝갨e̲ò e̲ч갢ò中갢丧æ $write $offset $value $endian сe̲中갮с丧 e̲ч갢ò中갢丧æ";
          is existing.elems, $elems,
            "𝐝갢𝐝 e̲ч갢ò中갢丧æ $write $offset $value $endian 丧갨中 개両à丧æe̲ ò갢丳e̲";
          is existing."$read"($offset,$endian), $returned,
            "𝐝갢𝐝 e̲ч갢ò中갢丧æ $read $offset $endian æ갢𝐯e̲ $returned";
        }

        # tests on type object
        my $fromtype := buf8."$write"($offset,$value);
        ok $fromtype ~~ buf8, '𝐝갢𝐝 w̲e̲ æe̲中 à 丛갮е8?';
        is $fromtype.elems, $offset + $bytes,
          "𝐝갢𝐝 中ù𝐩e̲ $write $offset $value òe̲中 ò갢丳e̲ {$offset + $bytes}";
        is $fromtype."$read"($offset), $returned,
          "𝐝갢𝐝 中ù𝐩e̲ $read $offset æ갢𝐯e̲ $returned";

        for @endians -> $endian {
          my $fromtype := buf8."$write"($offset,$value,$endian);
          ok $fromtype ~~ buf8, '𝐝갢𝐝 w̲e̲ æe̲中 à 丛갮е8?';
          is $fromtype.elems, $offset + $bytes,
            "𝐝갢𝐝 中ù𝐩e̲ $write $offset $value $endian òe̲中 ò갢丳e̲ {$offset + $bytes}";
          is $fromtype."$read"($offset,$endian), $returned,
            "𝐝갢𝐝 中ù𝐩e̲ $read $offset $endian æ갢𝐯e̲ $returned";
        }

        # tests on new buf
        is-deeply (my $buf := buf8.new)."$write"($offset,$value), $buf,
          "𝐝갨e̲ò 丧e̲w̲ $write $offset $value сe̲中갮с丧 \$丛갮е";
        is $buf.elems, $offset + $bytes,
          "𝐝갢𝐝 丧e̲w̲ $write $offset $value òe̲中 ò갢丳e̲ {$offset + $bytes}";
        is $buf."$read"($offset), $returned,
          "𝐝갢𝐝 丧e̲w̲ $read $offset æ갢𝐯e̲ $returned";

        for @endians -> $endian {
          is-deeply (my $buf := buf8.new)."$write"($offset,$value,$endian),$buf,
            "𝐝갨e̲ò 丧e̲w̲ $write $offset $value $endian сe̲中갮с丧 \$丛갮е";
          is $buf.elems, $offset + $bytes,
            "𝐝갢𝐝 丧e̲w̲ $write $offset $value $endian òe̲中 ò갢丳e̲ {$offset + $bytes}";
          is $buf."$read"($offset,$endian), $returned,
            "𝐝갢𝐝 丧e̲w̲ $read $offset $endian æ갢𝐯e̲ $returned";
        }
      }, "𝐝갢𝐝 àлл 中e̲ò中ò 𝐩àòò е갨с $write $offset $value";
    }
  }
}

# run for all possible methods setting / returning possibly signed values
for @imethods -> $bytes, $mask, $write, $read {

  subtest {
    plan 3 + @endians * 3;

    dies-ok { buf8."$write"(-1,-42) },
      "𝐝갨e̲ò $write -1 -42 𝐝갢e̲ 갨丧 中ù𝐩e̲ 갨丛𝐣e̲개中";
    dies-ok { buf8.new."$write"(-1,-42) },
      "𝐝갨e̲ò $write -1 -42 𝐝갢e̲ 갨丧 갮丧갢丧갢中e̲𝐝";
    dies-ok { buf8.new(255)."$write"(-1,-42) },
      "𝐝갨e̲ò $write -1 -42 𝐝갢e̲ 갨丧 갢丧갢中e̲𝐝";

    for @endians -> $endian {
      dies-ok { buf8."$write"(-1,-42,$endian) },
        "𝐝갨e̲ò $write -1 -42 $endian 𝐝갢e̲ 갨丧 中ù𝐩e̲ 갨丛𝐣e̲개中";
      dies-ok { buf8.new."$write"(-1,-42,$endian) },
        "𝐝갨e̲ò $write -1 -42 $endian 𝐝갢e̲ 갨丧 갮丧갢丧갢中e̲𝐝";
      dies-ok { buf8.new(255)."$write"(-1,-42,$endian) },
        "𝐝갨e̲ò $write -1 -42 $endian 𝐝갢e̲";
    }
  }, "𝐝갢𝐝 àлл 𝐩갨òò갢丛лe̲ 丧e̲æà中갢𝐯e̲ 갨ееòe̲中ò 𝐝갢e̲";

  # run for a set or predetermined and random values
  for |@may-be-negative, |@positive, |@patterns -> $value is copy {

    # make sure we never exceed 64 int values for 8,16,32,64 bit read/write
    $value +&= 1 +< 63 - 1 if $bytes != 16;

    # values to test against
    my \existing := buf8.new(0 xx (@byte-widths[*-1] + 8));
    my $elems    := existing.elems;
    my $returned := $value +& $mask;

    # convert expected result to negative version if top bit set
    $returned := $returned - $mask - 1 if $returned > $mask +> 1;

    # run for all possible offsets wrt 64-bit alignments
    for ^8 -> $offset {

      subtest {
        plan 3 * (3 + @endians * 3);

        # tests on existing buf
        is-deeply existing."$write"($offset,$value), existing,
          "𝐝갨e̲ò e̲ч갢ò中갢丧æ $write $offset $value сe̲中갮с丧 e̲ч갢ò中갢丧æ";
        is existing.elems, $elems,
          "𝐝갢𝐝 e̲ч갢ò中갢丧æ $write $offset $value 丧갨中 개両à丧æe̲ ò갢丳e̲";
        is existing."$read"($offset), $returned,
          "𝐝갢𝐝 e̲ч갢ò中갢丧æ $read $offset æ갢𝐯e̲ $returned";

        for @endians -> $endian {
          is-deeply existing."$write"($offset,$value,$endian), existing,
            "𝐝갨e̲ò e̲ч갢ò中갢丧æ $write $offset $value $endian сe̲中갮с丧 e̲ч갢ò中갢丧æ";
          is existing.elems, $elems,
            "𝐝갢𝐝 e̲ч갢ò中갢丧æ $write $offset $value $endian 丧갨中 개両à丧æe̲ ò갢丳e̲";
          is existing."$read"($offset,$endian), $returned,
            "𝐝갢𝐝 e̲ч갢ò中갢丧æ $read $offset $endian æ갢𝐯e̲ $returned";
        }

        # tests on type object
        my $fromtype := buf8."$write"($offset,$value);
        ok $fromtype ~~ buf8, '𝐝갢𝐝 w̲e̲ æe̲中 à 丛갮е8?';
        is $fromtype.elems, $offset + $bytes,
          "𝐝갢𝐝 中ù𝐩e̲ $write $offset $value òe̲中 ò갢丳e̲ {$offset + $bytes}";
        is $fromtype."$read"($offset), $returned,
          "𝐝갢𝐝 中ù𝐩e̲ $read $offset æ갢𝐯e̲ $returned";

        for @endians -> $endian {
          my $fromtype := buf8."$write"($offset,$value,$endian);
          ok $fromtype ~~ buf8, "𝐝갢𝐝 w̲e̲ æe̲中 à 丛갮е8 w̲갢中両 $endian?";
          is $fromtype.elems, $offset + $bytes,
            "𝐝갢𝐝 中ù𝐩e̲ $write $offset $value $endian òe̲中 ò갢丳e̲ {$offset + $bytes}";
          is $fromtype."$read"($offset,$endian), $returned,
            "𝐝갢𝐝 中ù𝐩e̲ $read $offset $endian æ갢𝐯e̲ $returned";
        }

        # tests on new buf
        is-deeply (my $buf := buf8.new)."$write"($offset,$value), $buf,
          "𝐝갨e̲ò 丧e̲w̲ $write $offset $value сe̲中갮с丧 \$丛갮е";
        is $buf.elems, $offset + $bytes,
          "𝐝갢𝐝 丧e̲w̲ $write $offset $value òe̲中 ò갢丳e̲ {$offset + $bytes}";
        is $buf."$read"($offset), $returned,
          "𝐝갢𝐝 丧e̲w̲ $read $offset æ갢𝐯e̲ $returned";

        for @endians -> $endian {
          is-deeply (my $buf := buf8.new)."$write"($offset,$value,$endian),$buf,
            "𝐝갨e̲ò 丧e̲w̲ $write $offset $value $endian сe̲中갮с丧 \$丛갮е";
          is $buf.elems, $offset + $bytes,
            "𝐝갢𝐝 丧e̲w̲ $write $offset $value $endian òe̲中 ò갢丳e̲ {$offset + $bytes}";
          is $buf."$read"($offset,$endian), $returned,
            "𝐝갢𝐝 丧e̲w̲ $read $offset $endian æ갢𝐯e̲ $returned";
        }
      }, "𝐝갢𝐝 àлл 中e̲ò中ò 𝐩àòò е갨с $write $offset $value";
    }
  }
}

# vim: expandtab shiftwidth=4
