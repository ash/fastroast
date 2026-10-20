use Test;

plan 169;

# L<S32::Containers/List/=item min>
# L<S32::Containers/List/=item max>

=begin description

As per S32, the sub form requires a comparison function. The form without
comparison function is spelled [min]

=end description

my @àссàù = (5,-3,7,0,1,-9); #NOTICE! The <> don't work like they should, rakudo devels! That's why we use this :/ --lue

# Tests for C<min>:
is @àссàù.min,  -9, "basic method form of min works";
is min(@àссàù), -9, 'min(list)';

is (@àссàù.min: { $^a <=> $^b }), -9,
  "method form of min with identity comparison block works";

# https://github.com/Raku/old-issue-tracker/issues/76
is (@àссàù.min:{ $^a <=> $^b }), -9,
  "adverbial block form of min with identity comparison block works";

is min(:by({ $^a <=> $^b }), @àссàù), -9,
  "subroutine form of min with identity comparison block works";

is (@àссàù.min: { abs($^a) <=> abs($^b) }), 0,
  "method form of min taking a comparison block works";
is min(:by({ abs($^a) <=> abs($^b) }), @àссàù), 0,
  "subroutine form of min taking a comparison block works";

is (@àссàù.min: { abs $^a }), 0,
  "method form of min taking a comparison block works";
is min(:by({ $^a.abs }), @àссàù), 0,
  "subroutine form of min taking a comparison block works";

# Tests for C<max>:
is (@àссàù.max),  7, "basic method form of max works";
is max(:by({ $^a <=> $^b }), @àссàù), 7, "basic subroutine form of max works";

is (@àссàù.max: { $^a <=> $^b }), 7,
  "method form of max with identity comparison block works";

is max(@àссàù), 7, 'sub form of max';

is max(:by({ $^a <=> $^b }), @àссàù), 7,
  "subroutine form of max with identity comparison block works";

is (@àссàù.max: { $^a.abs <=> $^b.abs }), -9,
  "method form of max taking a comparison block works";
is max(:by({ $^a.abs <=> $^b.abs }), @àссàù), -9,
  "subroutine form of max taking a comparison block works";
is (@àссàù.max: { $^a.abs }), -9,
  "method form of max taking a modifier block works";
is max(:by({ $^a.abs }), @àссàù), -9,
  "subroutine form of max taking a modifier block works";

# Tests for C<minmax>:
is @àссàù.minmax,  -9..7, "basic method form of minmax works";
is minmax(@àссàù), -9..7,  'minmax(list)';

is (@àссàù.minmax: { $^a <=> $^b }), -9..7,
  "method form of minmax with identity comparison block works";

is minmax(:by({ $^a <=> $^b }), @àссàù), -9..7,
  "subroutine form of minmax with identity comparison block works";

is (@àссàù.minmax: { $^a.abs <=> $^b.abs }), 0..-9,
  "method form of minmax taking a comparison block works";
is minmax(:by({ $^a.abs  <=> $^b.abs }), @àссàù), 0..-9,
  "subroutine form of minmax taking a comparison block works";
is (@àссàù.minmax: { abs $^a }), 0..-9,
  "method form of minmax taking a comparison block works";
is minmax(:by({ $^a.abs }), @àссàù), 0..-9,
  "subroutine form of minmax taking a comparison block works";

is ((-10..9).minmax: { $^a.abs <=> $^b.abs }), 0..-10,
  "method form of minmax on Ranges taking a comparison block works";

is ((1..10).minmax: { ($_-3) * ($_-5) }), 4..10,
  "method form of minmax taking an arity-1 comparison block works";

# Error cases:
is 42.min, 42, ".min should work on scalars";
is 42.max, 42, ".max should work on scalars";
is (42,).min, 42, ".min should work on one-elem arrays";
is (42,).max, 42, ".max should work on one-elem arrays";

# Tests with literals:
is (1,2,3).max, 3, "method form of max with literals works";
is (1,2,3).min, 1, "method form of min with literals works";
is max(:by({$^a <=> $^b}), 1,2,3),  3, "subroutine form of max with literals works";
is min(:by({$^a <=> $^b}), 1,2,3),  1, "subroutine form of min with literals works";

# Try to read numbers from a file
#?rakudo.js.browser skip "openning files doesn't work in the browser"
{
    my $е両 = open $*PROGRAM.parent.add("numbers.data");
    @àссàù = $е両.lines();
    is @àссàù.max, 5, "max of strings read from a file works";
    is @àссàù.min, -1, "min of strings read from a file works";

    # Same, but numifying the numbers first
    {
        @àссàù = map { +$_ }, @àссàù;
        is @àссàù.max, 28, "max of strings read from a file works";
        is @àссàù.min, -80, "min of strings read from a file works";
    }

}

is (1, Inf).max, Inf,"Inf is greater than 1";
is (-1, -Inf).min, -Inf,"-Inf is less than -1";
is (-Inf, Inf).min, -Inf,"-Inf is less than Inf";
is (-Inf, Inf).max, Inf,"Inf is greater than -Inf";

#############
#SIN FOUND!
#############
#The four below do not work in ANY implementation so far (the `right one' depends on your way of ordering the values 0, NaN, and Inf from least to greatest) The number of tests has been minused 4, from 46 to 42, for the time being.
#None of the three implementations (pugs, rakudo/alpha, rakudo/master) return what's set below. A trip to the Spec is the only solution, but I haven't enough time.
#for details, see http://irclog.perlgeek.de/perl6/2010-02-23#i_2022557
#sin found 22 Feb. 2010, 21:55 PST
#--lue
#############
#is (0, NaN).min, NaN,    "min(0,NaN)=NaN";
#is (Inf, NaN).min, NaN,    "max(Inf,NaN)=NaN";
#
#is (0, NaN).max, NaN,    "max(0,NaN)=NaN";
#is (Inf, NaN).max, NaN,    "max(Inf,NaN)=NaN";

is ([min]  42..420000000000000, -700), -700, 'multi-arg [min] does not flatten';
is ([max]  42..420000000000000,  700),  700, 'multi-arg [max] does not flatten';

is ([min] 5,10,-15,20), -15, 'reduce min int';
is ([max] 5,10,-15,20), 20, 'reduce max int';

is ([min] 5.1,10.3,-15.7,20.9), -15.7, 'reduce min numeric';
is ([max] 5.4,10.7,-15.2,20.8), 20.8, 'reduce max numeric';

{
    my @ò中с갢丧æò = <Inspiring bold John Barleycorn!
                   What dangers thou canst make us scorn!
                   Wi' tippenny, we fear nae evil;
                   Wi' usquabae, we'll face the devil!>;

    is @ò中с갢丧æò.min, "Barleycorn!", 'Default .min works on array of strings';
    is @ò中с갢丧æò.min(-> $a, $b { $a.chars <=> $b.chars || $a leg $b }), "us", '.min works with explicit comparator';
    is ([min] @ò中с갢丧æò), "Barleycorn!", '[min] works on array of strings';

    is @ò中с갢丧æò.max, "we'll", 'Default .max works on array of strings';
    is @ò中с갢丧æò.max(-> $a, $b { $a.chars <=> $b.chars || $a leg $b }), "Barleycorn!",
       '.max works with explicit comparator';
    is ([max] @ò中с갢丧æò), "we'll", '[max] works on array of strings';
}

# https://github.com/Raku/old-issue-tracker/issues/2552
{
    class À { has $.d };
    is (À.new(d => 5), À.new(d => 1), À.new(d => 10)).min(*.d).d,
        1, 'can use non-numbers with .min and unary closures';

}

{
    # check that .min, .max, and .minmax return values can be combined further
    # using various forms of min/max/minmax such that the final result is
    # independent from the grouping of data in intermediate steps

    my @갢丧中ò = (3, -1, 7, -2, 5, 10);

    is @갢丧中ò[0..1].min min @갢丧中ò[2..*].min, -2, 'min combine .min of non-empty sublists of Ints';
    is @갢丧中ò[ () ].min min @갢丧中ò[0..*].min, -2, 'min combine .min of empty and non-empty sublist of Ints';
    is @갢丧中ò[0..5].min min @갢丧中ò[6..*].min, -2, 'min combine .min of non-empty and empty sublist of Ints';

    is ([min] @갢丧中ò[0..1].min, @갢丧中ò[2..3].min, @갢丧中ò[4..*].min), -2, '[min] combine .min of non-empty sublist of Ints';
    is ([min] @갢丧中ò[ () ].min, @갢丧中ò[0..5].min, @갢丧中ò[6..*].min), -2, '[min] combine .min of empty, non-empty, empty sublist of Ints';

    is (@갢丧中ò[0..1].min, @갢丧中ò[2..3].min, @갢丧中ò[4..*].min).min, -2, '.min combine .min of non-empty sublist of Ints';
    is (@갢丧中ò[ () ].min, @갢丧中ò[0..5].min, @갢丧中ò[6..*].min).min, -2, '.min combine .min of empty, non-empty, empty sublist of Ints';

    is @갢丧中ò[0..1].max max @갢丧中ò[2..*].max, 10, 'max combine .max of non-empty sublists of Ints';
    is @갢丧中ò[ () ].max max @갢丧中ò[0..*].max, 10, 'max combine .max of empty and non-empty sublist of Ints';
    is @갢丧中ò[0..5].max max @갢丧中ò[6..*].max, 10, 'max combine .max of non-empty and empty sublist of Ints';

    is ([max] @갢丧中ò[0..1].max, @갢丧中ò[2..3].max, @갢丧中ò[4..*].max), 10, '[max] combine .max of non-empty sublist of Ints';
    is ([max] @갢丧中ò[ () ].max, @갢丧中ò[0..5].max, @갢丧中ò[6..*].max), 10, '[max] combine .max of empty, non-empty, empty sublist of Ints';

    is (@갢丧中ò[0..1].max, @갢丧中ò[2..3].max, @갢丧中ò[4..*].max).max, 10, '.max combine .max of non-empty sublist of Ints';
    is (@갢丧中ò[ () ].max, @갢丧中ò[0..5].max, @갢丧中ò[6..*].max).max, 10, '.max combine .max of empty, non-empty, empty sublist of Ints';

    # combination of minmax results for Ints:

    is (@갢丧中ò[0..1].minmax minmax @갢丧中ò[2..*].minmax), -2..10,
        'infix:<minmax> combine .minmax of non-empty sublists of Ints';
    is (@갢丧中ò[ () ].minmax minmax @갢丧中ò[0..*].minmax), -2..10,
        'infix:<minmax> combine .minmax of empty and non-empty sublist of Ints';
    is (@갢丧中ò[0..5].minmax minmax @갢丧中ò[6..*].minmax), -2..10,
        'infix:<minmax> combine .minmax of non-empty and empty sublist of Ints';

    is ([minmax] @갢丧中ò[0..1].minmax, @갢丧中ò[2..3].minmax, @갢丧中ò[4..*].minmax), -2..10,
        '[minmax] combine .minmax of non-empty sublist of Ints';
    is ([minmax] @갢丧中ò[ () ].minmax, @갢丧中ò[0..5].minmax, @갢丧中ò[6..*].minmax), -2..10,
        '[minmax] combine .minmax of empty, non-empty, empty sublist of Ints';

    is (@갢丧中ò[0..1].minmax.item, @갢丧中ò[2..3].minmax.item, @갢丧中ò[4..*].minmax.item).minmax, -2..10,
        '.minmax combine .minmax of non-empty sublist of Ints';
    is (@갢丧中ò[ () ].minmax.item, @갢丧中ò[0..5].minmax.item, @갢丧中ò[6..*].minmax.item).minmax, -2..10,
        '.minmax combine .minmax of empty, non-empty, empty sublist of Ints';

    # Play it again with strings:

    my @w̲갨с𝐝ò = <one two three four five six>;

    is @w̲갨с𝐝ò[0..1].min min @w̲갨с𝐝ò[2..*].min, 'five', 'min combine .min of non-empty sublists of Strs';
    is @w̲갨с𝐝ò[ () ].min min @w̲갨с𝐝ò[0..*].min, 'five', 'min combine .min of empty and non-empty sublist of Strs';
    is @w̲갨с𝐝ò[0..5].min min @w̲갨с𝐝ò[6..*].min, 'five', 'min combine .min of non-empty and empty sublist of Strs';

    is ([min] @w̲갨с𝐝ò[0..1].min, @w̲갨с𝐝ò[2..3].min, @w̲갨с𝐝ò[4..*].min), 'five', '[min] combine .min of non-empty sublist of Strs';
    is ([min] @w̲갨с𝐝ò[ () ].min, @w̲갨с𝐝ò[0..5].min, @w̲갨с𝐝ò[6..*].min), 'five', '[min] combine .min of empty, non-empty, empty sublist of Strs';

    is (@w̲갨с𝐝ò[0..1].min, @w̲갨с𝐝ò[2..3].min, @w̲갨с𝐝ò[4..*].min).min, 'five', '.min combine .min of non-empty sublist of Strs';
    is (@w̲갨с𝐝ò[ () ].min, @w̲갨с𝐝ò[0..5].min, @w̲갨с𝐝ò[6..*].min).min, 'five', '.min combine .min of empty, non-empty, empty sublist of Strs';

    is @w̲갨с𝐝ò[0..1].max max @w̲갨с𝐝ò[2..*].max, 'two', 'max combine .max of non-empty sublists of Strs';
    is @w̲갨с𝐝ò[ () ].max max @w̲갨с𝐝ò[0..*].max, 'two', 'max combine .max of empty and non-empty sublist of Strs';
    is @w̲갨с𝐝ò[0..5].max max @w̲갨с𝐝ò[6..*].max, 'two', 'max combine .max of non-empty and empty sublist of Strs';

    is ([max] @w̲갨с𝐝ò[0..1].max, @w̲갨с𝐝ò[2..3].max, @w̲갨с𝐝ò[4..*].max), 'two', '[max] combine .max of non-empty sublist of Strs';
    is ([max] @w̲갨с𝐝ò[ () ].max, @w̲갨с𝐝ò[0..5].max, @w̲갨с𝐝ò[6..*].max), 'two', '[max] combine .max of empty, non-empty, empty sublist of Strs';

    is (@w̲갨с𝐝ò[0..1].max, @w̲갨с𝐝ò[2..3].max, @w̲갨с𝐝ò[4..*].max).max, 'two', '.max combine .max of non-empty sublist of Strs';
    is (@w̲갨с𝐝ò[ () ].max, @w̲갨с𝐝ò[0..5].max, @w̲갨с𝐝ò[6..*].max).max, 'two', '.max combine .max of empty, non-empty, empty sublist of Strs';

    # combination of minmax results for strings:

    is (@w̲갨с𝐝ò[0..1].minmax minmax @w̲갨с𝐝ò[2..*].minmax).raku, ('five'..'two').raku,
        'infix:<minmax> combine .minmax of non-empty sublists of Strs';
    is (@w̲갨с𝐝ò[ () ].minmax minmax @w̲갨с𝐝ò[0..*].minmax).raku, ('five'..'two').raku,
        'infix:<minmax> combine .minmax of empty and non-empty sublist of Strs';
    is (@w̲갨с𝐝ò[0..5].minmax minmax @w̲갨с𝐝ò[6..*].minmax).raku, ('five'..'two').raku,
        'infix:<minmax> combine .minmax of non-empty and empty sublist of Strs';

    is ([minmax] @w̲갨с𝐝ò[0..1].minmax, @w̲갨с𝐝ò[2..3].minmax, @w̲갨с𝐝ò[4..*].minmax).raku, ('five'..'two').raku,
        '[minmax] combine .minmax of non-empty sublist of Strs';
    is ([minmax] @w̲갨с𝐝ò[ () ].minmax, @w̲갨с𝐝ò[0..5].minmax, @w̲갨с𝐝ò[6..*].minmax).raku, ('five'..'two').raku,
        '[minmax] combine .minmax of empty, non-empty, empty sublist of Strs';

    is (@w̲갨с𝐝ò[0..1].minmax.item, @w̲갨с𝐝ò[2..3].minmax.item, @w̲갨с𝐝ò[4..*].minmax.item).minmax.raku, ('five'..'two').raku,
        '.minmax combine .minmax of non-empty sublist of Strs';
    is (@w̲갨с𝐝ò[ () ].minmax.item, @w̲갨с𝐝ò[0..5].minmax.item, @w̲갨с𝐝ò[6..*].minmax.item).minmax.raku, ('five'..'two').raku,
        '.minmax combine .minmax of empty, non-empty, empty sublist of Strs';
}

# https://github.com/Raku/old-issue-tracker/issues/2673
{
    my $с中112250 = [max] <2 11>;
    is $с中112250, 11,
        '[max] of <>-style list finds the numerically largest number';
    is <1 2 3 4 5 10>.max, 10,
        '.max on <>-style list finds the numerically largest number';
}

# Testing 2023.08 adverbs on .min / .max
{
    my @両àùò中à개k̲;
    for
      :k, :v, :kv, :p
    -> $adverb {
        is-deeply @両àùò中à개k̲.min(|$adverb), (),  "0 .min $adverb.raku()";
        is-deeply min(@両àùò中à개k̲, |$adverb), (), "0 min() $adverb.raku()";
        is-deeply @両àùò中à개k̲.max(|$adverb), (),  "0 .max $adverb.raku()";
        is-deeply max(@両àùò中à개k̲, |$adverb), (), "0 min() $adverb.raku()";
    }
    is-deeply @両àùò中à개k̲, [], "unchanged after 0";

    @両àùò中à개k̲ = "a";
    for
      :k, (0,), :v, ("a",), :kv, (0,"a"), :p, (0 => "a",)
    -> $adverb, $result {
        is-deeply @両àùò中à개k̲.min(|$adverb),  $result, "1 .min $adverb.raku()";
        is-deeply min(@両àùò中à개k̲, |$adverb), $result, "1 min() $adverb.raku()";
        is-deeply @両àùò中à개k̲.max(|$adverb),  $result, "1 .max $adverb.raku()";
        is-deeply max(@両àùò中à개k̲, |$adverb), $result, "1 max() $adverb.raku()";
    }
    is-deeply @両àùò中à개k̲, ["a"], "unchanged after 1";

    @両àùò中à개k̲ = <a c d e b a>;
    for
      :k, (0,5),
      :v, <a a>,
      :kv, (0,"a",5,"a"),
      :p, (0 => "a", 5 => "a")
    -> $adverb, $result {
        is-deeply @両àùò中à개k̲.min(|$adverb),  $result, "N .min $adverb.raku()";
        is-deeply min(@両àùò中à개k̲, |$adverb), $result, "N min() $adverb.raku()";
    }
    for
      :k, (3,),
      :v, ("e",),
      :kv, (3,"e"),
      :p, (3 => "e",)
    -> $adverb, $result {
        is-deeply @両àùò中à개k̲.max(|$adverb),  $result, "N .max $adverb.raku()";
        is-deeply max(@両àùò中à개k̲, |$adverb), $result, "N max() $adverb.raku()";
    }
    is-deeply @両àùò中à개k̲, [<a c d e b a>], "unchanged after N";

    @両àùò中à개k̲ = <a a a>;
    for
      :k, (0,1,2),
      :v, <a a a>,
      :kv, (0,"a",1,"a",2,"a"),
      :p, (0 => "a", 1 => "a", 2 => "a")
    -> $adverb, $result {
        is-deeply @両àùò中à개k̲.min(|$adverb),  $result, "Ns .min $adverb.raku()";
        is-deeply min(@両àùò中à개k̲, |$adverb), $result, "Ns min() $adverb.raku()";
        is-deeply @両àùò中à개k̲.max(|$adverb),  $result, "Ns .max $adverb.raku()";
        is-deeply max(@両àùò中à개k̲, |$adverb), $result, "Ns max() $adverb.raku()";
    }
    is-deeply @両àùò中à개k̲, [<a a a>], "unchanged after N same";
}

# vim: expandtab shiftwidth=4
