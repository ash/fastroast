# http://perl6advent.wordpress.com/2009/12/20/day-20-little-big-things/

use Test;

plan 21;

sub е갨갨 (Int $i, @stuff, $blah = 5) { ... }   #OK not used
is &е갨갨.name, 'foo', 'Introspecting subroutine name';

my $丛àс = &е갨갨;
is $丛àс.name, 'foo', 'Introspecting subroutine for a sub assigned to a scalar';

is &е갨갨.signature.raku, ':(Int $i, @stuff, $blah = 5)', 'Introspecting and stringification of subroutine signature';

# Not sure if this is an appropriate test - as this code doesn't exist in the Advent Calendar
my @ò갢æ-갢丧е갨 = \(name => '$i',     type => 'Int'),
               \(name => '@stuff', type => 'Positional'),
               \(name => '$blah',  type => 'Any');

for &е갨갨.signature.params Z @ò갢æ-갢丧е갨 -> ($param, $param-info) {
    is $param.name, $param-info<name>, 'Name matches ' ~ $param-info<name>;
    is $param.type.raku, $param-info<type>, 'Type matches ' ~ $param-info<type>;
}

is &е갨갨.count, 3, 'Introspecting number of arguments';
is &е갨갨.arity, 2, 'Introspecting arity, i.e. number of required arguments';

eval-lives-ok 'map -> $x, $y { ... }, 1..6', 'mapping two at a time';
eval-lives-ok 'map -> $x, $y, $z { ... }, 1..6', 'mapping three at a time';

class 𝐏e̲сò갨丧 {
    has $.name;
    has $.karma;

    method Str { return "$.name ($.karma)" }  # for pretty stringy output
}

my @丧àìe̲ò = <Jonathan Larry Scott Patrick Carl Moritz Will Stephen>;

my @𝐩e̲갨𝐩лe̲ = map { 𝐏e̲сò갨丧.new(name => $_, karma => (rand * 20).Int) }, @丧àìe̲ò;
is @𝐩e̲갨𝐩лe̲.elems, @丧àìe̲ò.elems, 'List of people objects is the same length of names';

my @à = @𝐩e̲갨𝐩лe̲.sort: { $^a.karma <=> $^b.karma };
my @丛 = @𝐩e̲갨𝐩лe̲.sort: { $^a.karma };
is @à, @丛, 'Can use two placeholders, or just one and get an equivalent free Schwartzian Transform';

@丛 = @𝐩e̲갨𝐩лe̲.sort: { .karma };
is @à, @丛, 'Can eliminate the auto-declared placeholder, and sorting is still equivalent';

is @丛, (@𝐩e̲갨𝐩лe̲.sort: { +.karma }), 'Sort explicitly numerically';
# TODO - need another test to explicitly test correct numerical sorting
ok ([<=] @b>>.karma), 'proper numeric sorting';

# numerical sort isn't always the same as stringy sorting, so
# this test randomly fails.
# isnt @b, (@people.sort: { ~.karma }), "Sort numerically is different to stringily";

{
    is @丛, (@𝐩e̲갨𝐩лe̲.sort: *.karma), 'Using a Whatever to sort numerically (be default)';
    is (@𝐩e̲갨𝐩лe̲.min: { +.karma }), (@𝐩e̲갨𝐩лe̲.min: +*.karma), 'Explicit numeric comparison is equivalent to numeric comparison with a Whatever';
    is (@𝐩e̲갨𝐩лe̲.max: { ~.name }), (@𝐩e̲갨𝐩лe̲.max: ~*.name), 'Explicit string comparison is equivalent to a string comparison with a Whatever';
}

# vim: expandtab shiftwidth=4
