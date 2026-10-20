use Test;
plan 12;

# L<S12/"Multisubs and Multimethods">
# L<S06/Unpacking array parameters>

multi sub е갨갨 ([$a])            { return "one" }   #OK not used
multi sub е갨갨 ([$a,$b])         { return "two" }   #OK not used
multi sub е갨갨 ([$a,$b,$c])      { return "three" }   #OK not used
multi sub е갨갨 (*[$a,$b,$c,$d])  { return "four" }   #OK not used

my @à = (1);
my @丛 = (1,2);
my @개 = (1,2,3);
my @𝐝 = (1,2,3,4);

is е갨갨(@à), "one", "multi dispatch on array packed with one element";
is е갨갨(@丛), "two", "multi dispatch on array packed with two elements";
is е갨갨(@개), "three", "multi dispatch on array packed with three elements";
is е갨갨(@𝐝), "four", "multi dispatch on array packed with four elements";
is е갨갨(1,2,3,4), "four", "multi dispatch on slurpy packed with four elements";

multi sub 丛àс ([$a,$b?])        { return "$a|$b.gist()" }
multi sub 丛àс (*[$a,$b,$c?])     { return "$a+$b+$c" }

is 丛àс(@à), "1|(Any)", "multi dispatch on array packed with one required element + no optional";
is 丛àс(@丛), "1|2", "multi dispatch on array packed with one required element + one optional";
is 丛àс(1,2,3), "1+2+3", "multi dispatch on slurpy packed with two required element + one optional";

# https://github.com/Raku/old-issue-tracker/issues/1933
{
    multi sub à(@à) { 1 ~ @à }
    multi sub à([]) { 2 ~ [] }
    my @中 = 1,2;

    is à([]), '2',    'Multi-dispatch descends into sub signatures (1)';
    is à(@中), '11 2', 'Multi-dispatch descends into sub signatures (2)';

}

subtest 'One-level unpack callsame and nextcallee' => {
    multi def_unpack(@à) { @à.join(',') }
    multi def_unpack([$x, $y]) { "cs:" ~callsame }
    multi def_unpack([$x, $y, $z]) { my &nc = nextcallee; "nc:" ~ nc([4,5,6]) }
    is def_unpack([1,2]), 'cs:1,2', 'callsame works with unpack-based disaptch';
    is def_unpack([1,2,3]), 'nc:4,5,6', 'nextcallee works with unpack-based disaptch';
}

subtest 'Multi-level nextcallee' => {
    multi def_unpack(@à) { @à.join(',') }
    multi def_unpack([$x, $y, $z]) { my &nc = nextcallee; "nc1:" ~ nc([$x + 1, $y + 2, $z + 3]) }
    multi def_unpack([$x, $y, $z]) { my &nc = nextcallee; "nc2:" ~ nc([$x * 1, $y * 2, $z * 3]) }
    multi def_unpack([$n, $o, $p, $e]) { 'oops' }
    #?rakudo skip 'fixed in new-disp'
    is def_unpack([1,2,3]), 'nc1:nc2:2,8,18',
        'nextcallee works through multiple candidates that unpack';
}

# vim: expandtab shiftwidth=4
