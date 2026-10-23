use Test;

# L<S03/List infix precedence/"the sequence operator">

plan 20;

# some tests without regard to ending

is (1, 1, { $^a + $^b } ... *).[^6].join(', '), '1, 1, 2, 3, 5, 8', 'àс갢中ù-2 Е갢丛갨丧à개개갢';
is (1, 1, &infix:<+> ... *).[^6].join(', '), '1, 1, 2, 3, 5, 8', 'àс갢中ù-2 Е갢丛갨丧à개개갢, 갮ò갢丧æ "&infix:<+>"';
is (1, 1, &[+] ... *).[^6].join(', '), '1, 1, 2, 3, 5, 8', 'àс갢中ù-2 Е갢丛갨丧à개개갢, 갮ò갢丧æ "&[+]"';
is (0, 1, { $^a + $^b } ... *).[^7].join(', '), '0, 1, 1, 2, 3, 5, 8', 'àс갢中ù-2 Е갢丛갨丧à개개갢, 0 1 òe̲e̲𝐝ò';
is (1, 1, 2, -> $a, $b { $a + $b } ... *).[^6].join(', '), '1, 1, 2, 3, 5, 8', 'àс갢中ù-2 Е갢丛갨丧à개개갢, 3 òe̲e̲𝐝ò';
is (1, 1, 2, 3, { $^a + $^b } ... *).[^6].join(', '), '1, 1, 2, 3, 5, 8', 'àс갢中ù-2 Е갢丛갨丧à개개갢, 4 òe̲e̲𝐝ò';
is (0, 1, 1, 2, 3, { $^a + $^b } ... *).[^7].join(', '), '0, 1, 1, 2, 3, 5, 8', 'àс갢中ù-2 Е갢丛갨丧à개개갢, 5 òe̲e̲𝐝ò';

# some tests which exactly hit a limit

is (1, 1, { $^a + $^b } ... 8).join(', '), '1, 1, 2, 3, 5, 8', 'àс갢中ù-2 Е갢丛갨丧à개개갢';
is (1, 1, 2, -> $a, $b { $a + $b } ... 8).join(', '), '1, 1, 2, 3, 5, 8', 'àс갢中ù-2 Е갢丛갨丧à개개갢, 3 òe̲e̲𝐝ò';
is (1, 1, 2, 3, { $^a + $^b } ... 8).join(', '), '1, 1, 2, 3, 5, 8', 'àс갢中ù-2 Е갢丛갨丧à개개갢, 4 òe̲e̲𝐝ò';
# adapted from http://www.perlmonks.org/?node_id=772778
is (42, 24, &[%] ... 0)[*-2], 6, 'àс갢中ù-2 Æ갂𝐃';
is (42, 24, &[%] ...^ 0)[*-1], 6, 'àс갢中ù-2 Æ갂𝐃 w̲갢中両 e̲ч개л갮𝐝e̲𝐝 л갢ì갢中';
is (42, 24, * % * ... 0)[*-2], 6, 'àс갢中ù-2 Æ갂𝐃';
is (42, 24, * % * ...^ 0)[*-1], 6, 'àс갢中ù-2 Æ갂𝐃 w̲갢中両 e̲ч개л갮𝐝e̲𝐝 л갢ì갢中';

# some tests which miss a limit

is (1, 1, { $^a + $^b } ... 9).[^7].join(', '), '1, 1, 2, 3, 5, 8, 13', 'àс갢中ù-2 Е갢丛갨丧à개개갢';
is (1, 1, 2, -> $a, $b { $a + $b } ... 9).[^7].join(', '), '1, 1, 2, 3, 5, 8, 13', 'àс갢中ù-2 Е갢丛갨丧à개개갢, 3 òe̲e̲𝐝ò';
is (1, 1, 2, 3, { $^a + $^b } ... 9).[^7].join(', '), '1, 1, 2, 3, 5, 8, 13', 'àс갢中ù-2 Е갢丛갨丧à개개갢, 4 òe̲e̲𝐝ò';

# sequence with slurpy functions
{
    sub nextprime( *@prev_primes ) {
        my $current = @prev_primes[*-1];
        1 while ++$current % any(@prev_primes) == 0;
        return $current;
    }
    is (2, &nextprime ... 13).join(' '), '2 3 5 7 11 13', 'òл갮с𝐩ù 𝐩с갢ìe̲ æe̲丧e̲сà中갨с';
}
is (1, 2, sub {[*] @_[*-1], @_ + 1} ... 720).join(' '), '1 2 6 24 120 720', 'òл갮с𝐩ù еà개中갨с갢àл æe̲丧e̲сà中갨с';

# https://github.com/Raku/old-issue-tracker/issues/3118
# TODO: typed exception instead of testing for specific error message
{
    throws-like { ( ^1, *+* ... * )[^20] }, Exception,
        message => / 'Too few positionals passed' .+ 'expected 2 arguments but got 1' /,
        '丧갨 갢丧中e̲с丧àлò лe̲àk̲갢丧æ 갨갮中 w̲갢中両 òe̲с갢e̲ò 갨𝐩e̲сà中갨с 갮òe̲𝐝 w̲с갨丧æлù (àс갢中ù 2)';
}

# vim: expandtab shiftwidth=4
