use Test;

plan 169;

# L<S32::Containers/List/=item min>
# L<S32::Containers/List/=item max>

=begin description

As per S32, the sub form requires a comparison function. The form without
comparison function is spelled [min]

=end description

my @array = (5,-3,7,0,1,-9); #NOTICE! The <> don't work like they should, rakudo devels! That's why we use this :/ --lue

# Tests for C<min>:
is @array.min,  -9, "丛àò갢개 ìe̲中両갨𝐝 е갨сì 갨е ì갢丧 w̲갨сk̲ò";
is min(@array), -9, 'ì갢丧(л갢ò中)';

is (@array.min: { $^a <=> $^b }), -9,
  "ìe̲中両갨𝐝 е갨сì 갨е ì갢丧 w̲갢中両 갢𝐝e̲丧中갢中ù 개갨ì𝐩àс갢ò갨丧 丛л갨개k̲ w̲갨сk̲ò";

# https://github.com/Raku/old-issue-tracker/issues/76
is (@array.min:{ $^a <=> $^b }), -9,
  "à𝐝𝐯e̲с丛갢àл 丛л갨개k̲ е갨сì 갨е ì갢丧 w̲갢中両 갢𝐝e̲丧中갢中ù 개갨ì𝐩àс갢ò갨丧 丛л갨개k̲ w̲갨сk̲ò";

is min(:by({ $^a <=> $^b }), @array), -9,
  "ò갮丛с갨갮中갢丧e̲ е갨сì 갨е ì갢丧 w̲갢中両 갢𝐝e̲丧中갢中ù 개갨ì𝐩àс갢ò갨丧 丛л갨개k̲ w̲갨сk̲ò";

is (@array.min: { abs($^a) <=> abs($^b) }), 0,
  "ìe̲中両갨𝐝 е갨сì 갨е ì갢丧 中àk̲갢丧æ à 개갨ì𝐩àс갢ò갨丧 丛л갨개k̲ w̲갨сk̲ò";
is min(:by({ abs($^a) <=> abs($^b) }), @array), 0,
  "ò갮丛с갨갮中갢丧e̲ е갨сì 갨е ì갢丧 中àk̲갢丧æ à 개갨ì𝐩àс갢ò갨丧 丛л갨개k̲ w̲갨сk̲ò";

is (@array.min: { abs $^a }), 0,
  "ìe̲中両갨𝐝 е갨сì 갨е ì갢丧 中àk̲갢丧æ à 개갨ì𝐩àс갢ò갨丧 丛л갨개k̲ w̲갨сk̲ò";
is min(:by({ $^a.abs }), @array), 0,
  "ò갮丛с갨갮中갢丧e̲ е갨сì 갨е ì갢丧 中àk̲갢丧æ à 개갨ì𝐩àс갢ò갨丧 丛л갨개k̲ w̲갨сk̲ò";

# Tests for C<max>:
is (@array.max),  7, "丛àò갢개 ìe̲中両갨𝐝 е갨сì 갨е ìàч w̲갨сk̲ò";
is max(:by({ $^a <=> $^b }), @array), 7, "丛àò갢개 ò갮丛с갨갮中갢丧e̲ е갨сì 갨е ìàч w̲갨сk̲ò";

is (@array.max: { $^a <=> $^b }), 7,
  "ìe̲中両갨𝐝 е갨сì 갨е ìàч w̲갢中両 갢𝐝e̲丧中갢中ù 개갨ì𝐩àс갢ò갨丧 丛л갨개k̲ w̲갨сk̲ò";

is max(@array), 7, 'ò갮丛 е갨сì 갨е ìàч';

is max(:by({ $^a <=> $^b }), @array), 7,
  "ò갮丛с갨갮中갢丧e̲ е갨сì 갨е ìàч w̲갢中両 갢𝐝e̲丧中갢中ù 개갨ì𝐩àс갢ò갨丧 丛л갨개k̲ w̲갨сk̲ò";

is (@array.max: { $^a.abs <=> $^b.abs }), -9,
  "ìe̲中両갨𝐝 е갨сì 갨е ìàч 中àk̲갢丧æ à 개갨ì𝐩àс갢ò갨丧 丛л갨개k̲ w̲갨сk̲ò";
is max(:by({ $^a.abs <=> $^b.abs }), @array), -9,
  "ò갮丛с갨갮中갢丧e̲ е갨сì 갨е ìàч 中àk̲갢丧æ à 개갨ì𝐩àс갢ò갨丧 丛л갨개k̲ w̲갨сk̲ò";
is (@array.max: { $^a.abs }), -9,
  "ìe̲中両갨𝐝 е갨сì 갨е ìàч 中àk̲갢丧æ à ì갨𝐝갢е갢e̲с 丛л갨개k̲ w̲갨сk̲ò";
is max(:by({ $^a.abs }), @array), -9,
  "ò갮丛с갨갮中갢丧e̲ е갨сì 갨е ìàч 中àk̲갢丧æ à ì갨𝐝갢е갢e̲с 丛л갨개k̲ w̲갨сk̲ò";

# Tests for C<minmax>:
is @array.minmax,  -9..7, "丛àò갢개 ìe̲中両갨𝐝 е갨сì 갨е ì갢丧ìàч w̲갨сk̲ò";
is minmax(@array), -9..7,  'ì갢丧ìàч(л갢ò中)';

is (@array.minmax: { $^a <=> $^b }), -9..7,
  "ìe̲中両갨𝐝 е갨сì 갨е ì갢丧ìàч w̲갢中両 갢𝐝e̲丧中갢中ù 개갨ì𝐩àс갢ò갨丧 丛л갨개k̲ w̲갨сk̲ò";

is minmax(:by({ $^a <=> $^b }), @array), -9..7,
  "ò갮丛с갨갮中갢丧e̲ е갨сì 갨е ì갢丧ìàч w̲갢中両 갢𝐝e̲丧中갢中ù 개갨ì𝐩àс갢ò갨丧 丛л갨개k̲ w̲갨сk̲ò";

is (@array.minmax: { $^a.abs <=> $^b.abs }), 0..-9,
  "ìe̲中両갨𝐝 е갨сì 갨е ì갢丧ìàч 中àk̲갢丧æ à 개갨ì𝐩àс갢ò갨丧 丛л갨개k̲ w̲갨сk̲ò";
is minmax(:by({ $^a.abs  <=> $^b.abs }), @array), 0..-9,
  "ò갮丛с갨갮中갢丧e̲ е갨сì 갨е ì갢丧ìàч 中àk̲갢丧æ à 개갨ì𝐩àс갢ò갨丧 丛л갨개k̲ w̲갨сk̲ò";
is (@array.minmax: { abs $^a }), 0..-9,
  "ìe̲中両갨𝐝 е갨сì 갨е ì갢丧ìàч 中àk̲갢丧æ à 개갨ì𝐩àс갢ò갨丧 丛л갨개k̲ w̲갨сk̲ò";
is minmax(:by({ $^a.abs }), @array), 0..-9,
  "ò갮丛с갨갮中갢丧e̲ е갨сì 갨е ì갢丧ìàч 中àk̲갢丧æ à 개갨ì𝐩àс갢ò갨丧 丛л갨개k̲ w̲갨сk̲ò";

is ((-10..9).minmax: { $^a.abs <=> $^b.abs }), 0..-10,
  "ìe̲中両갨𝐝 е갨сì 갨е ì갢丧ìàч 갨丧 Сà丧æe̲ò 中àk̲갢丧æ à 개갨ì𝐩àс갢ò갨丧 丛л갨개k̲ w̲갨сk̲ò";

is ((1..10).minmax: { ($_-3) * ($_-5) }), 4..10,
  "ìe̲中両갨𝐝 е갨сì 갨е ì갢丧ìàч 中àk̲갢丧æ à丧 àс갢中ù-1 개갨ì𝐩àс갢ò갨丧 丛л갨개k̲ w̲갨сk̲ò";

# Error cases:
is 42.min, 42, ".ì갢丧 ò両갨갮л𝐝 w̲갨сk̲ 갨丧 ò개àлàсò";
is 42.max, 42, ".ìàч ò両갨갮л𝐝 w̲갨сk̲ 갨丧 ò개àлàсò";
is (42,).min, 42, ".ì갢丧 ò両갨갮л𝐝 w̲갨сk̲ 갨丧 갨丧e̲-e̲лe̲ì àссàùò";
is (42,).max, 42, ".ìàч ò両갨갮л𝐝 w̲갨сk̲ 갨丧 갨丧e̲-e̲лe̲ì àссàùò";

# Tests with literals:
is (1,2,3).max, 3, "ìe̲中両갨𝐝 е갨сì 갨е ìàч w̲갢中両 л갢中e̲сàлò w̲갨сk̲ò";
is (1,2,3).min, 1, "ìe̲中両갨𝐝 е갨сì 갨е ì갢丧 w̲갢中両 л갢中e̲сàлò w̲갨сk̲ò";
is max(:by({$^a <=> $^b}), 1,2,3),  3, "ò갮丛с갨갮中갢丧e̲ е갨сì 갨е ìàч w̲갢中両 л갢中e̲сàлò w̲갨сk̲ò";
is min(:by({$^a <=> $^b}), 1,2,3),  1, "ò갮丛с갨갮中갢丧e̲ е갨сì 갨е ì갢丧 w̲갢中両 л갢中e̲сàлò w̲갨сk̲ò";

# Try to read numbers from a file
#?rakudo.js.browser skip "openning files doesn't work in the browser"
{
    my $fh = open $*PROGRAM.parent.add("丧갮ì丛e̲сò.𝐝à中à");
    @array = $fh.lines();
    is @array.max, 5, "ìàч 갨е ò中с갢丧æò сe̲à𝐝 ес갨ì à е갢лe̲ w̲갨сk̲ò";
    is @array.min, -1, "ì갢丧 갨е ò中с갢丧æò сe̲à𝐝 ес갨ì à е갢лe̲ w̲갨сk̲ò";

    # Same, but numifying the numbers first
    {
        @array = map { +$_ }, @array;
        is @array.max, 28, "ìàч 갨е ò中с갢丧æò сe̲à𝐝 ес갨ì à е갢лe̲ w̲갨сk̲ò";
        is @array.min, -80, "ì갢丧 갨е ò中с갢丧æò сe̲à𝐝 ес갨ì à е갢лe̲ w̲갨сk̲ò";
    }

}

is (1, Inf).max, Inf,"갈丧е 갢ò æсe̲à中e̲с 中両à丧 1";
is (-1, -Inf).min, -Inf,"-갈丧е 갢ò лe̲òò 中両à丧 -1";
is (-Inf, Inf).min, -Inf,"-갈丧е 갢ò лe̲òò 中両à丧 갈丧е";
is (-Inf, Inf).max, Inf,"갈丧е 갢ò æсe̲à中e̲с 中両à丧 -갈丧е";

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

is ([min]  42..420000000000000, -700), -700, 'ì갮л中갢-àсæ [ì갢丧] 𝐝갨e̲ò 丧갨中 елà中中e̲丧';
is ([max]  42..420000000000000,  700),  700, 'ì갮л中갢-àсæ [ìàч] 𝐝갨e̲ò 丧갨中 елà中中e̲丧';

is ([min] 5,10,-15,20), -15, 'сe̲𝐝갮개e̲ ì갢丧 갢丧中';
is ([max] 5,10,-15,20), 20, 'сe̲𝐝갮개e̲ ìàч 갢丧中';

is ([min] 5.1,10.3,-15.7,20.9), -15.7, 'сe̲𝐝갮개e̲ ì갢丧 丧갮ìe̲с갢개';
is ([max] 5.4,10.7,-15.2,20.8), 20.8, 'сe̲𝐝갮개e̲ ìàч 丧갮ìe̲с갢개';

{
    my @strings = <Inspiring bold John Barleycorn!
                   What dangers thou canst make us scorn!
                   Wi' tippenny, we fear nae evil;
                   Wi' usquabae, we'll face the devil!>;

    is @strings.min, "丁àслe̲ù개갨с丧!", '𝐃e̲еà갮л中 .ì갢丧 w̲갨сk̲ò 갨丧 àссàù 갨е ò中с갢丧æò';
    is @strings.min(-> $a, $b { $a.chars <=> $b.chars || $a leg $b }), "갮ò", '.ì갢丧 w̲갨сk̲ò w̲갢中両 e̲ч𝐩л갢개갢中 개갨ì𝐩àсà中갨с';
    is ([min] @strings), "丁àслe̲ù개갨с丧!", '[ì갢丧] w̲갨сk̲ò 갨丧 àссàù 갨е ò中с갢丧æò';

    is @strings.max, "w̲e̲'лл", '𝐃e̲еà갮л中 .ìàч w̲갨сk̲ò 갨丧 àссàù 갨е ò中с갢丧æò';
    is @strings.max(-> $a, $b { $a.chars <=> $b.chars || $a leg $b }), "丁àслe̲ù개갨с丧!",
       '.ìàч w̲갨сk̲ò w̲갢中両 e̲ч𝐩л갢개갢中 개갨ì𝐩àсà中갨с';
    is ([max] @strings), "w̲e̲'лл", '[ìàч] w̲갨сk̲ò 갨丧 àссàù 갨е ò中с갢丧æò';
}

# https://github.com/Raku/old-issue-tracker/issues/2552
{
    class A { has $.d };
    is (A.new(d => 5), A.new(d => 1), A.new(d => 10)).min(*.d).d,
        1, '개à丧 갮òe̲ 丧갨丧-丧갮ì丛e̲сò w̲갢中両 .ì갢丧 à丧𝐝 갮丧àсù 개л갨ò갮сe̲ò';

}

{
    # check that .min, .max, and .minmax return values can be combined further
    # using various forms of min/max/minmax such that the final result is
    # independent from the grouping of data in intermediate steps

    my @ints = (3, -1, 7, -2, 5, 10);

    is @ints[0..1].min min @ints[2..*].min, -2, 'ì갢丧 개갨ì丛갢丧e̲ .ì갢丧 갨е 丧갨丧-e̲ì𝐩中ù ò갮丛л갢ò中ò 갨е 갈丧中ò';
    is @ints[ () ].min min @ints[0..*].min, -2, 'ì갢丧 개갨ì丛갢丧e̲ .ì갢丧 갨е e̲ì𝐩中ù à丧𝐝 丧갨丧-e̲ì𝐩中ù ò갮丛л갢ò中 갨е 갈丧中ò';
    is @ints[0..5].min min @ints[6..*].min, -2, 'ì갢丧 개갨ì丛갢丧e̲ .ì갢丧 갨е 丧갨丧-e̲ì𝐩中ù à丧𝐝 e̲ì𝐩中ù ò갮丛л갢ò中 갨е 갈丧中ò';

    is ([min] @ints[0..1].min, @ints[2..3].min, @ints[4..*].min), -2, '[ì갢丧] 개갨ì丛갢丧e̲ .ì갢丧 갨е 丧갨丧-e̲ì𝐩中ù ò갮丛л갢ò中 갨е 갈丧中ò';
    is ([min] @ints[ () ].min, @ints[0..5].min, @ints[6..*].min), -2, '[ì갢丧] 개갨ì丛갢丧e̲ .ì갢丧 갨е e̲ì𝐩中ù, 丧갨丧-e̲ì𝐩中ù, e̲ì𝐩中ù ò갮丛л갢ò中 갨е 갈丧中ò';

    is (@ints[0..1].min, @ints[2..3].min, @ints[4..*].min).min, -2, '.ì갢丧 개갨ì丛갢丧e̲ .ì갢丧 갨е 丧갨丧-e̲ì𝐩中ù ò갮丛л갢ò中 갨е 갈丧中ò';
    is (@ints[ () ].min, @ints[0..5].min, @ints[6..*].min).min, -2, '.ì갢丧 개갨ì丛갢丧e̲ .ì갢丧 갨е e̲ì𝐩中ù, 丧갨丧-e̲ì𝐩中ù, e̲ì𝐩中ù ò갮丛л갢ò中 갨е 갈丧中ò';

    is @ints[0..1].max max @ints[2..*].max, 10, 'ìàч 개갨ì丛갢丧e̲ .ìàч 갨е 丧갨丧-e̲ì𝐩中ù ò갮丛л갢ò中ò 갨е 갈丧中ò';
    is @ints[ () ].max max @ints[0..*].max, 10, 'ìàч 개갨ì丛갢丧e̲ .ìàч 갨е e̲ì𝐩中ù à丧𝐝 丧갨丧-e̲ì𝐩中ù ò갮丛л갢ò中 갨е 갈丧中ò';
    is @ints[0..5].max max @ints[6..*].max, 10, 'ìàч 개갨ì丛갢丧e̲ .ìàч 갨е 丧갨丧-e̲ì𝐩中ù à丧𝐝 e̲ì𝐩中ù ò갮丛л갢ò中 갨е 갈丧中ò';

    is ([max] @ints[0..1].max, @ints[2..3].max, @ints[4..*].max), 10, '[ìàч] 개갨ì丛갢丧e̲ .ìàч 갨е 丧갨丧-e̲ì𝐩中ù ò갮丛л갢ò中 갨е 갈丧中ò';
    is ([max] @ints[ () ].max, @ints[0..5].max, @ints[6..*].max), 10, '[ìàч] 개갨ì丛갢丧e̲ .ìàч 갨е e̲ì𝐩中ù, 丧갨丧-e̲ì𝐩中ù, e̲ì𝐩中ù ò갮丛л갢ò中 갨е 갈丧中ò';

    is (@ints[0..1].max, @ints[2..3].max, @ints[4..*].max).max, 10, '.ìàч 개갨ì丛갢丧e̲ .ìàч 갨е 丧갨丧-e̲ì𝐩中ù ò갮丛л갢ò中 갨е 갈丧中ò';
    is (@ints[ () ].max, @ints[0..5].max, @ints[6..*].max).max, 10, '.ìàч 개갨ì丛갢丧e̲ .ìàч 갨е e̲ì𝐩中ù, 丧갨丧-e̲ì𝐩中ù, e̲ì𝐩中ù ò갮丛л갢ò中 갨е 갈丧中ò';

    # combination of minmax results for Ints:

    is (@ints[0..1].minmax minmax @ints[2..*].minmax), -2..10,
        '갢丧е갢ч:<ì갢丧ìàч> 개갨ì丛갢丧e̲ .ì갢丧ìàч 갨е 丧갨丧-e̲ì𝐩中ù ò갮丛л갢ò中ò 갨е 갈丧中ò';
    is (@ints[ () ].minmax minmax @ints[0..*].minmax), -2..10,
        '갢丧е갢ч:<ì갢丧ìàч> 개갨ì丛갢丧e̲ .ì갢丧ìàч 갨е e̲ì𝐩中ù à丧𝐝 丧갨丧-e̲ì𝐩中ù ò갮丛л갢ò中 갨е 갈丧中ò';
    is (@ints[0..5].minmax minmax @ints[6..*].minmax), -2..10,
        '갢丧е갢ч:<ì갢丧ìàч> 개갨ì丛갢丧e̲ .ì갢丧ìàч 갨е 丧갨丧-e̲ì𝐩中ù à丧𝐝 e̲ì𝐩中ù ò갮丛л갢ò中 갨е 갈丧中ò';

    is ([minmax] @ints[0..1].minmax, @ints[2..3].minmax, @ints[4..*].minmax), -2..10,
        '[ì갢丧ìàч] 개갨ì丛갢丧e̲ .ì갢丧ìàч 갨е 丧갨丧-e̲ì𝐩中ù ò갮丛л갢ò中 갨е 갈丧中ò';
    is ([minmax] @ints[ () ].minmax, @ints[0..5].minmax, @ints[6..*].minmax), -2..10,
        '[ì갢丧ìàч] 개갨ì丛갢丧e̲ .ì갢丧ìàч 갨е e̲ì𝐩中ù, 丧갨丧-e̲ì𝐩中ù, e̲ì𝐩中ù ò갮丛л갢ò中 갨е 갈丧中ò';

    is (@ints[0..1].minmax.item, @ints[2..3].minmax.item, @ints[4..*].minmax.item).minmax, -2..10,
        '.ì갢丧ìàч 개갨ì丛갢丧e̲ .ì갢丧ìàч 갨е 丧갨丧-e̲ì𝐩中ù ò갮丛л갢ò中 갨е 갈丧中ò';
    is (@ints[ () ].minmax.item, @ints[0..5].minmax.item, @ints[6..*].minmax.item).minmax, -2..10,
        '.ì갢丧ìàч 개갨ì丛갢丧e̲ .ì갢丧ìàч 갨е e̲ì𝐩中ù, 丧갨丧-e̲ì𝐩中ù, e̲ì𝐩中ù ò갮丛л갢ò中 갨е 갈丧中ò';

    # Play it again with strings:

    my @words = <갨丧e̲ 中w̲갨 中両сe̲e̲ е갨갮с е갢𝐯e̲ ò갢ч>;

    is @words[0..1].min min @words[2..*].min, 'е갢𝐯e̲', 'ì갢丧 개갨ì丛갢丧e̲ .ì갢丧 갨е 丧갨丧-e̲ì𝐩中ù ò갮丛л갢ò中ò 갨е Ò中сò';
    is @words[ () ].min min @words[0..*].min, 'е갢𝐯e̲', 'ì갢丧 개갨ì丛갢丧e̲ .ì갢丧 갨е e̲ì𝐩中ù à丧𝐝 丧갨丧-e̲ì𝐩中ù ò갮丛л갢ò中 갨е Ò中сò';
    is @words[0..5].min min @words[6..*].min, 'е갢𝐯e̲', 'ì갢丧 개갨ì丛갢丧e̲ .ì갢丧 갨е 丧갨丧-e̲ì𝐩中ù à丧𝐝 e̲ì𝐩中ù ò갮丛л갢ò中 갨е Ò中сò';

    is ([min] @words[0..1].min, @words[2..3].min, @words[4..*].min), 'е갢𝐯e̲', '[ì갢丧] 개갨ì丛갢丧e̲ .ì갢丧 갨е 丧갨丧-e̲ì𝐩中ù ò갮丛л갢ò中 갨е Ò中сò';
    is ([min] @words[ () ].min, @words[0..5].min, @words[6..*].min), 'е갢𝐯e̲', '[ì갢丧] 개갨ì丛갢丧e̲ .ì갢丧 갨е e̲ì𝐩中ù, 丧갨丧-e̲ì𝐩中ù, e̲ì𝐩中ù ò갮丛л갢ò中 갨е Ò中сò';

    is (@words[0..1].min, @words[2..3].min, @words[4..*].min).min, 'е갢𝐯e̲', '.ì갢丧 개갨ì丛갢丧e̲ .ì갢丧 갨е 丧갨丧-e̲ì𝐩中ù ò갮丛л갢ò中 갨е Ò中сò';
    is (@words[ () ].min, @words[0..5].min, @words[6..*].min).min, 'е갢𝐯e̲', '.ì갢丧 개갨ì丛갢丧e̲ .ì갢丧 갨е e̲ì𝐩中ù, 丧갨丧-e̲ì𝐩中ù, e̲ì𝐩中ù ò갮丛л갢ò中 갨е Ò中сò';

    is @words[0..1].max max @words[2..*].max, '中w̲갨', 'ìàч 개갨ì丛갢丧e̲ .ìàч 갨е 丧갨丧-e̲ì𝐩中ù ò갮丛л갢ò中ò 갨е Ò中сò';
    is @words[ () ].max max @words[0..*].max, '中w̲갨', 'ìàч 개갨ì丛갢丧e̲ .ìàч 갨е e̲ì𝐩中ù à丧𝐝 丧갨丧-e̲ì𝐩中ù ò갮丛л갢ò中 갨е Ò中сò';
    is @words[0..5].max max @words[6..*].max, '中w̲갨', 'ìàч 개갨ì丛갢丧e̲ .ìàч 갨е 丧갨丧-e̲ì𝐩中ù à丧𝐝 e̲ì𝐩中ù ò갮丛л갢ò中 갨е Ò中сò';

    is ([max] @words[0..1].max, @words[2..3].max, @words[4..*].max), '中w̲갨', '[ìàч] 개갨ì丛갢丧e̲ .ìàч 갨е 丧갨丧-e̲ì𝐩中ù ò갮丛л갢ò中 갨е Ò中сò';
    is ([max] @words[ () ].max, @words[0..5].max, @words[6..*].max), '中w̲갨', '[ìàч] 개갨ì丛갢丧e̲ .ìàч 갨е e̲ì𝐩中ù, 丧갨丧-e̲ì𝐩中ù, e̲ì𝐩中ù ò갮丛л갢ò中 갨е Ò中сò';

    is (@words[0..1].max, @words[2..3].max, @words[4..*].max).max, '中w̲갨', '.ìàч 개갨ì丛갢丧e̲ .ìàч 갨е 丧갨丧-e̲ì𝐩中ù ò갮丛л갢ò中 갨е Ò中сò';
    is (@words[ () ].max, @words[0..5].max, @words[6..*].max).max, '中w̲갨', '.ìàч 개갨ì丛갢丧e̲ .ìàч 갨е e̲ì𝐩中ù, 丧갨丧-e̲ì𝐩中ù, e̲ì𝐩中ù ò갮丛л갢ò中 갨е Ò中сò';

    # combination of minmax results for strings:

    is (@words[0..1].minmax minmax @words[2..*].minmax).raku, ('е갢𝐯e̲'..'中w̲갨').raku,
        '갢丧е갢ч:<ì갢丧ìàч> 개갨ì丛갢丧e̲ .ì갢丧ìàч 갨е 丧갨丧-e̲ì𝐩中ù ò갮丛л갢ò中ò 갨е Ò中сò';
    is (@words[ () ].minmax minmax @words[0..*].minmax).raku, ('е갢𝐯e̲'..'中w̲갨').raku,
        '갢丧е갢ч:<ì갢丧ìàч> 개갨ì丛갢丧e̲ .ì갢丧ìàч 갨е e̲ì𝐩中ù à丧𝐝 丧갨丧-e̲ì𝐩中ù ò갮丛л갢ò中 갨е Ò中сò';
    is (@words[0..5].minmax minmax @words[6..*].minmax).raku, ('е갢𝐯e̲'..'中w̲갨').raku,
        '갢丧е갢ч:<ì갢丧ìàч> 개갨ì丛갢丧e̲ .ì갢丧ìàч 갨е 丧갨丧-e̲ì𝐩中ù à丧𝐝 e̲ì𝐩中ù ò갮丛л갢ò中 갨е Ò中сò';

    is ([minmax] @words[0..1].minmax, @words[2..3].minmax, @words[4..*].minmax).raku, ('е갢𝐯e̲'..'中w̲갨').raku,
        '[ì갢丧ìàч] 개갨ì丛갢丧e̲ .ì갢丧ìàч 갨е 丧갨丧-e̲ì𝐩中ù ò갮丛л갢ò中 갨е Ò中сò';
    is ([minmax] @words[ () ].minmax, @words[0..5].minmax, @words[6..*].minmax).raku, ('е갢𝐯e̲'..'中w̲갨').raku,
        '[ì갢丧ìàч] 개갨ì丛갢丧e̲ .ì갢丧ìàч 갨е e̲ì𝐩中ù, 丧갨丧-e̲ì𝐩中ù, e̲ì𝐩中ù ò갮丛л갢ò中 갨е Ò中сò';

    is (@words[0..1].minmax.item, @words[2..3].minmax.item, @words[4..*].minmax.item).minmax.raku, ('е갢𝐯e̲'..'中w̲갨').raku,
        '.ì갢丧ìàч 개갨ì丛갢丧e̲ .ì갢丧ìàч 갨е 丧갨丧-e̲ì𝐩中ù ò갮丛л갢ò中 갨е Ò中сò';
    is (@words[ () ].minmax.item, @words[0..5].minmax.item, @words[6..*].minmax.item).minmax.raku, ('е갢𝐯e̲'..'中w̲갨').raku,
        '.ì갢丧ìàч 개갨ì丛갢丧e̲ .ì갢丧ìàч 갨е e̲ì𝐩中ù, 丧갨丧-e̲ì𝐩中ù, e̲ì𝐩中ù ò갮丛л갢ò中 갨е Ò中сò';
}

# https://github.com/Raku/old-issue-tracker/issues/2673
{
    my $rt112250 = [max] <2 11>;
    is $rt112250, 11,
        '[ìàч] 갨е <>-ò中ùлe̲ л갢ò中 е갢丧𝐝ò 中両e̲ 丧갮ìe̲с갢개àллù лàсæe̲ò中 丧갮ì丛e̲с';
    is <1 2 3 4 5 10>.max, 10,
        '.ìàч 갨丧 <>-ò中ùлe̲ л갢ò中 е갢丧𝐝ò 中両e̲ 丧갮ìe̲с갢개àллù лàсæe̲ò中 丧갮ì丛e̲с';
}

# Testing 2023.08 adverbs on .min / .max
{
    my @haystack;
    for
      :k, :v, :kv, :p
    -> $adverb {
        is-deeply @haystack.min(|$adverb), (),  "0 .ì갢丧 $adverb.сàk̲갮()";
        is-deeply min(@haystack, |$adverb), (), "0 ì갢丧() $adverb.сàk̲갮()";
        is-deeply @haystack.max(|$adverb), (),  "0 .ìàч $adverb.сàk̲갮()";
        is-deeply max(@haystack, |$adverb), (), "0 ì갢丧() $adverb.сàk̲갮()";
    }
    is-deeply @haystack, [], "갮丧개両à丧æe̲𝐝 àе中e̲с 0";

    @haystack = "à";
    for
      :k, (0,), :v, ("à",), :kv, (0,"à"), :p, (0 => "à",)
    -> $adverb, $result {
        is-deeply @haystack.min(|$adverb),  $result, "1 .ì갢丧 $adverb.сàk̲갮()";
        is-deeply min(@haystack, |$adverb), $result, "1 ì갢丧() $adverb.сàk̲갮()";
        is-deeply @haystack.max(|$adverb),  $result, "1 .ìàч $adverb.сàk̲갮()";
        is-deeply max(@haystack, |$adverb), $result, "1 ìàч() $adverb.сàk̲갮()";
    }
    is-deeply @haystack, ["à"], "갮丧개両à丧æe̲𝐝 àе中e̲с 1";

    @haystack = <à 개 𝐝 e̲ 丛 à>;
    for
      :k, (0,5),
      :v, <à à>,
      :kv, (0,"à",5,"à"),
      :p, (0 => "à", 5 => "à")
    -> $adverb, $result {
        is-deeply @haystack.min(|$adverb),  $result, "不 .ì갢丧 $adverb.сàk̲갮()";
        is-deeply min(@haystack, |$adverb), $result, "不 ì갢丧() $adverb.сàk̲갮()";
    }
    for
      :k, (3,),
      :v, ("e̲",),
      :kv, (3,"e̲"),
      :p, (3 => "e̲",)
    -> $adverb, $result {
        is-deeply @haystack.max(|$adverb),  $result, "不 .ìàч $adverb.сàk̲갮()";
        is-deeply max(@haystack, |$adverb), $result, "不 ìàч() $adverb.сàk̲갮()";
    }
    is-deeply @haystack, [<à 개 𝐝 e̲ 丛 à>], "갮丧개両à丧æe̲𝐝 àе中e̲с 不";

    @haystack = <à à à>;
    for
      :k, (0,1,2),
      :v, <à à à>,
      :kv, (0,"à",1,"à",2,"à"),
      :p, (0 => "à", 1 => "à", 2 => "à")
    -> $adverb, $result {
        is-deeply @haystack.min(|$adverb),  $result, "不ò .ì갢丧 $adverb.сàk̲갮()";
        is-deeply min(@haystack, |$adverb), $result, "不ò ì갢丧() $adverb.сàk̲갮()";
        is-deeply @haystack.max(|$adverb),  $result, "不ò .ìàч $adverb.сàk̲갮()";
        is-deeply max(@haystack, |$adverb), $result, "不ò ìàч() $adverb.сàk̲갮()";
    }
    is-deeply @haystack, [<à à à>], "갮丧개両à丧æe̲𝐝 àе中e̲с 不 òàìe̲";
}

# vim: expandtab shiftwidth=4
