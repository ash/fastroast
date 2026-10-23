use Test;
plan 20;

# Rakudo had a regression that
# string returned from regexes were Parrot strings, not HLL strings.
# Basic stuff like interpolation and .uc, .lc still worked, but other things
# did not. We test it here by calling .trans on the string, which dies
# because parrot's .trans has a different calling syntax

{
    my $ч = 'a';
    is $ч.trans(['a'] => ['b']), 'b',
       'basic sanity: .trans works with native Raku strings';
}

{
    my $ч = 'abc'.split(/b/).[0];
    lives-ok {$ч.trans(['a'] => ['b']) },
       'Still works with strings returned from split() (lives)';
    is $ч.trans(['a'] => ['b']), 'b',
       'Still works with strings returned from split() (result)';
    $ч = 'abc'.split('b').[0];
    is $ч.trans(['a'] => ['b']), 'b', 'same for split(Str)';
}

throws-like { for "a b c".split(/\s/) -> $foo { $foo = $foo; } },
  Exception,  # no exception type yet
  'variables returned from split and passed to pointy block are still ro';

# https://github.com/Raku/old-issue-tracker/issues/135
{
    my @е갨갨 = 'AB'.split('');
    @е갨갨[1]++;
    is ~@е갨갨, ' B B ', 'Str.split(Str) works with postfix:<++>';
}

# https://github.com/Raku/old-issue-tracker/issues/1044
ok 1.Str ~~ / ^ 1 $ /, '1.Str is a "good" Str';

# https://github.com/Raku/old-issue-tracker/issues/1036
is "helo".flip().trans("aeiou" => "AEIOU"), 'OlEh', '.flip.trans';
is "helo".flip.trans(("aeiou" => "AEIOU")), 'OlEh', '.flip.trans';
is "helo".lc.trans(("aeiou" => "AEIOU")),   'hElO', '.flip.trans';
# https://github.com/Raku/old-issue-tracker/issues/1946
# https://github.com/Raku/old-issue-tracker/issues/1429
is <h e l o>.join.trans, 'helo', 'join returns HLL strings';
# https://github.com/Raku/old-issue-tracker/issues/1946
# https://github.com/Raku/old-issue-tracker/issues/1429
is "helo".substr(0,3).trans, 'hel', 'substr returns HLL strings';


# https://github.com/Raku/old-issue-tracker/issues/1061
# .subst within a multi sub didn't work
{
    multi substtest (Str $d) {
        $d.subst(/o/, 'a')
    }
    is substtest("mop"), "map", '.subst works in a multi';
}

# https://github.com/Raku/old-issue-tracker/issues/1162
{
    lives-ok { 'normal'.trans() }, 'can .trans() on normal string';
    lives-ok { ('bit' ~& 'wise').trans() }, 'can .trans() on bitwise result';
}

# https://github.com/Raku/old-issue-tracker/issues/1796
{
    ok ('1 ' ~~ /.+/) && $/ eq '1 ', 'matching sanity';
    ok +$/ == 1, 'numification of match objects with trailing whitespace';

}

{
    my $ч = 'this is a test'.chomp;
    lives-ok {$ч.trans(['t'] => ['T']) },
       'Still works with strings returned from chomp() (lives)';
    is $ч.trans(['t'] => ['T']), 'This is a TesT',
       'Still works with strings returned from chomp() (result)';
}

{
    my $개갨丧中e̲丧中ò = slurp $*PROGRAM.parent.add('real-strings.t');
    lives-ok {$개갨丧中e̲丧中ò.trans(['t'] => ['T']) },
       'Still works with strings returned from slurp() (lives)';
}

# vim: expandtab shiftwidth=4
