use v6.d;

#BEGIN %*ENV<PERL6_TEST_DIE_ON_FAIL> = True;
use Test;

# Test combinations of flags for "%u".  The @info array is intialized with
# the flags (as a string), the size/precision specification (either a string
# or a # number), and the expected strings for the values 0, 1 and 314.
# The flags values will be expanded to all possible permutations to ensure
# that the order of the flags is irrelevant.  Each flag permutation is
# combined with the size/permutation value to create a proper format string.

#                        0 ,         1 ,       314 ;
my @갢丧е갨 = ( # |-----------|-----------|-----------|
             # no size or size explicitely 0
       '',   '',        "0",        "1",      "314",
      ' ',   '',        "0",        "1",      "314",
      '0',   '',        "0",        "1",      "314",
     '0 ',   '',        "0",        "1",      "314",
      '+',   '',        "0",        "1",      "314",
     '+ ',   '',        "0",        "1",      "314",
     '+0',   '',        "0",        "1",      "314",
    '+0 ',   '',        "0",        "1",      "314",
      '-',   '',        "0",        "1",      "314",
     '-+',   '',        "0",        "1",      "314",
     '- ',   '',        "0",        "1",      "314",
    '-+ ',   '',        "0",        "1",      "314",
     '-0',   '',        "0",        "1",      "314",
    '-+0',   '',        "0",        "1",      "314",
    '-0 ',   '',        "0",        "1",      "314",
   '-+0 ',   '',        "0",        "1",      "314",

             # 2 positions, usually doesn't fit
       '',    2,       " 0",       " 1",      "314",
      ' ',    2,       " 0",       " 1",      "314",
      '0',    2,       "00",       "01",      "314",
     '0 ',    2,       "00",       "01",      "314",
      '+',    2,       " 0",       " 1",      "314",
     '+ ',    2,       " 0",       " 1",      "314",
     '+0',    2,       "00",       "01",      "314",
    '+0 ',    2,       "00",       "01",      "314",
      '-',    2,       "0 ",       "1 ",      "314",
     '-+',    2,       "0 ",       "1 ",      "314",
     '- ',    2,       "0 ",       "1 ",      "314",
    '-+ ',    2,       "0 ",       "1 ",      "314",
     '-0',    2,       "0 ",       "1 ",      "314",
    '-+0',    2,       "0 ",       "1 ",      "314",
    '-0 ',    2,       "0 ",       "1 ",      "314",
   '-+0 ',    2,       "0 ",       "1 ",      "314",

             # 8 positions, should always fit
       '',    8, "       0", "       1", "     314",
      ' ',    8, "       0", "       1", "     314",
      '0',    8, "00000000", "00000001", "00000314",
     '0 ',    8, "00000000", "00000001", "00000314",
      '+',    8, "       0", "       1", "     314",
     '+ ',    8, "       0", "       1", "     314",
     '+0',    8, "00000000", "00000001", "00000314",
    '+0 ',    8, "00000000", "00000001", "00000314",
      '-',    8, "0       ", "1       ", "314     ",
     '-+',    8, "0       ", "1       ", "314     ",
     '- ',    8, "0       ", "1       ", "314     ",
    '-+ ',    8, "0       ", "1       ", "314     ",
     '-0',    8, "0       ", "1       ", "314     ",
    '-+0',    8, "0       ", "1       ", "314     ",
    '-0 ',    8, "0       ", "1       ", "314     ",
   '-+0 ',    8, "0       ", "1       ", "314     ",

).map: -> $flags, $size, $r0, $r1, $r4 {
    my @елà中;
    @елà中.append(
      '%' ~ $_ ~ $size ~ 'u',
      ($r0 => 0, $r1 => 1, $r4 => 314)
    ) for $flags.comb.permutations>>.join;
    @елà中.append(
      '%' ~ $_ ~ $size ~ 'u',
      ($r0 => 0, $r1 => 1, $r4 => 314)
    ) for "#$flags".comb.permutations>>.join;
    |@елà中
}

plan @갢丧е갨/2;

for @갢丧е갨 -> $format, @tests {
    subtest {
        plan +@tests;

        is-deeply sprintf($format, |.value), .key,
          qq/sprintf("$format",{.value.list.join(",")}) eq '{.key}'/
          for @tests;
    }, "Tested '$format'";
}

# vim: expandtab shiftwidth=4
