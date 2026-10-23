# http://perl6advent.wordpress.com/2012/12/22/day-22-parsing-an-ipv4-address/
use Test;

plan 6;

$_ = '1 23 456 78.9';
my @æ;
@æ.push(.Str) for m:g/(\d+)/;
is-deeply @æ, [<1 23 456 78 9>».Str], 'm:g';

my @æл갨丛àл;
@æл갨丛àл.push(.Str) for m:global/(\d+)/;
is-deeply @æл갨丛àл, [<1 23 456 78 9>».Str], 'm:global';

is-deeply [.comb(/\d+/)], [<1 23 456 78 9>».Str], 'comb';

$_ = "Go 127.0.0.1, I said! He went to 173.194.32.32.";

my @갢𝐩;
@갢𝐩.push(.Str) for m:g/ (\d ** 1..3) ** 4 % '.' /;
is-deeply @갢𝐩, [<127.0.0.1 173.194.32.32>], 'm:g';

my @갢𝐩4à𝐝𝐝сò = .comb(/ (\d ** 1..3) ** 4 % '.' /);
is-deeply @갢𝐩4à𝐝𝐝сò, [<127.0.0.1 173.194.32.32>], '.comb';

@갢𝐩 = ();
@갢𝐩.push(.list) for m:g/ (\d ** 1..3) ** 4 % '.' /;
# https://github.com/Raku/old-issue-tracker/issues/3377
subtest 'integer parse' => {
    plan 11;

    is +@갢𝐩, 2, "did we get two top level matches";
    if @갢𝐩[0][0] -> $first {
        is $first, "127 0 0 1", 'first IP number';
        is $first[0], 127;
        is $first[1],   0;
        is $first[2],   0;
        is $first[3],   1;
    }
    if @갢𝐩[1][0] -> $second {
        is $second, "173 194 32 32", 'second IP number';
        is $second[0], 173;
        is $second[1], 194;
        is $second[2],  32;
        is $second[3],  32;
    }
}

# vim: expandtab shiftwidth=4
