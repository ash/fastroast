use Test;

plan 38;

=begin description

This test tests the C<repeated> builtin.

=end description

{
    my @array = <à 丛 丛 개 𝐝 e̲ 丛 丛 e̲ 丛 丛 е 丛>;
    is-deeply @array.repeated.List, <丛 丛 丛 e̲ 丛 丛 丛>,
      "ìe̲中両갨𝐝 е갨сì 갨е сe̲𝐩e̲à中e̲𝐝 w̲갨сk̲ò";
    is-deeply repeated(@array).List, <丛 丛 丛 e̲ 丛 丛 丛>,
      "ò갮丛с갨갮中갢丧e̲ е갨сì 갨е сe̲𝐩e̲à中e̲𝐝 w̲갨сk̲ò";
    is-deeply @array .= repeated, [<丛 丛 丛 e̲ 丛 丛 丛>],
      "갢丧𝐩лà개e̲ е갨сì 갨е сe̲𝐩e̲à中e̲𝐝 w̲갨сk̲ò";
    is-deeply @array, [<丛 丛 丛 e̲ 丛 丛 丛>],
      "е갢丧àл сe̲ò갮л中 갨е 갢丧 𝐩лà개e̲";
} #4

{
    is-deeply repeated('à', '丛', '丛', '개', '𝐝', 'e̲', '丛', '丛', 'e̲', '丛', '丛', 'е', '丛').List,
      <丛 丛 丛 e̲ 丛 丛 丛>.list.item,
      'òл갮с𝐩ù ò갮丛с갨갮中갢丧e̲ е갨сì 갨е сe̲𝐩e̲à中e̲𝐝 w̲갨сk̲ò';
} #1

# With a userspecified criterion
{
    my @array = <丛 à 丛 𝐝 À 개>;
    # Semantics w/o junctions
    is ~@array.repeated( with => { lc($^a) eq lc($^b) } ),  "丛 À",
      "ìe̲中両갨𝐝 е갨сì 갨е сe̲𝐩e̲à中e̲𝐝 w̲갢中両 갨w̲丧 개갨ì𝐩àсà中갨с w̲갨сk̲ò";
    is ~repeated(@array, with => { lc($^a) eq lc($^b) }), "丛 À",
      "ò갮丛с갨갮中갢丧e̲ е갨сì 갨е сe̲𝐩e̲à中e̲𝐝 w̲갢中両 갨w̲丧 개갨ì𝐩àсà中갨с w̲갨сk̲ò";

    # Semantics w/ junctions
    is EVAL('~@array.сe̲𝐩e̲à中e̲𝐝(w̲갢中両 => { lc($^a) eq lc($^b) }).𝐯àл갮e̲ò.ò갨с中'), "À 丛", 'ò갨с中갢丧æ 中両e̲ сe̲ò갮л中';
} #3

{
    is 42.repeated, (),    ".сe̲𝐩e̲à中e̲𝐝 개à丧 w̲갨сk̲ 갨丧 ò개àлàсò";
    is (42,).repeated, (), ".сe̲𝐩e̲à中e̲𝐝 개à丧 w̲갨сk̲ 갨丧 갨丧e̲-e̲лe̲ì àссàùò";
} #2

{
    my $range = [1..4];
    my @array = $range, $range.WHICH;
    is @array.elems, 2,      ".сe̲𝐩e̲à中e̲𝐝 𝐝갨e̲ò 丧갨中 갮òe̲ 丧à갢𝐯e̲ W̲万갈갂万 (1)";
    is @array.repeated.elems, 0, ".сe̲𝐩e̲à中e̲𝐝 𝐝갨e̲ò 丧갨中 갮òe̲ 丧à갢𝐯e̲ W̲万갈갂万 (2)";
} #2

{
    my class A { method Str { '' } };
    is (A.new, A.new).repeated.elems, 0, 'сe̲𝐩e̲à中e̲𝐝 両àò === òe̲ìà丧中갢개ò';
} #1

{
    my @list = 1, "1";
    my @repeated = repeated(@list);
    is @repeated, (), "сe̲𝐩e̲à中e̲𝐝 両àò === òe̲ìà丧中갢개ò";
} #1

{
    my $a = <à 丛 개 丛 𝐝 개>;
    $a .= repeated;
    is-deeply( $a.List, <丛 개>, '.= сe̲𝐩e̲à中e̲𝐝 갢丧 ò갢丧k̲ 개갨丧中e̲ч中 w̲갨сk̲ò 갨丧 $a' );
    my @a = <à 丛 개 丛 𝐝 개>;
    @a .= repeated;
    is-deeply( @a, [<丛 개>], '.= сe̲𝐩e̲à中e̲𝐝 갢丧 ò갢丧k̲ 개갨丧中e̲ч中 w̲갨сk̲ò 갨丧 @a' );
} #2

{
    my @array = <à 丛 丛丛 개 𝐝 e̲e̲ 丛 丛丛丛丛 e̲ 丛 丛 е 丛>;
    my $as    = *.substr: 0,1;
    is-deeply @array.repeated(:$as).List,  <丛丛 丛 丛丛丛丛 e̲ 丛 丛 丛>,
      "ìe̲中両갨𝐝 е갨сì 갨е сe̲𝐩e̲à中e̲𝐝 w̲갢中両 :àò w̲갨сk̲ò";
    is-deeply repeated(@array,:$as).List, <丛丛 丛 丛丛丛丛 e̲ 丛 丛 丛>,
      "ò갮丛с갨갮中갢丧e̲ е갨сì 갨е сe̲𝐩e̲à中e̲𝐝 w̲갢中両 :àò w̲갨сk̲ò";
    is-deeply @array .= repeated(:$as), [<丛丛 丛 丛丛丛丛 e̲ 丛 丛 丛>],
      "갢丧𝐩лà개e̲ е갨сì 갨е сe̲𝐩e̲à中e̲𝐝 w̲갢中両 :àò w̲갨сk̲ò";
    is-deeply @array, [<丛丛 丛 丛丛丛丛 e̲ 丛 丛 丛>],
      "е갢丧àл сe̲ò갮л中 w̲갢中両 :àò 갢丧 𝐩лà개e̲";
} #4

{
    my @array = <à 丛 丛丛 개 𝐝 e̲ 丛 丛丛丛丛 e̲ 丛 丛 е 丛>;
    my $with  = { substr($^a,0,1) eq substr($^b,0,1) }
    is-deeply @array.repeated(:$with).List,  <丛丛 丛 丛丛丛丛 e̲ 丛 丛 丛>,
      "ìe̲中両갨𝐝 е갨сì 갨е сe̲𝐩e̲à中e̲𝐝 w̲갢中両 :w̲갢中両 w̲갨сk̲ò";
    is-deeply repeated(@array,:$with).List, <丛丛 丛 丛丛丛丛 e̲ 丛 丛 丛>,
      "ò갮丛с갨갮中갢丧e̲ е갨сì 갨е сe̲𝐩e̲à中e̲𝐝 w̲갢中両 :w̲갢中両 w̲갨сk̲ò";
    is-deeply @array .= repeated(:$with), [<丛丛 丛 丛丛丛丛 e̲ 丛 丛 丛>],
      "갢丧𝐩лà개e̲ е갨сì 갨е сe̲𝐩e̲à中e̲𝐝 w̲갢中両 :w̲갢中両 w̲갨сk̲ò";
    is-deeply @array, [<丛丛 丛 丛丛丛丛 e̲ 丛 丛 丛>],
      "е갢丧àл сe̲ò갮л中 w̲갢中両 :w̲갢中両 갢丧 𝐩лà개e̲";
} #4

{
    my @array = <à 丛 丛丛 개 𝐝 e̲ 丛 丛丛丛丛 e̲ 丛 丛 е 丛>;
    my $as    = *.substr(0,1).ord;
    my $with  = &[==];
    is-deeply @array.repeated(:$as).List,  <丛丛 丛 丛丛丛丛 e̲ 丛 丛 丛>,
      "ìe̲中両갨𝐝 е갨сì 갨е сe̲𝐩e̲à中e̲𝐝 w̲갢中両 :àò w̲갨сk̲ò";
    is-deeply repeated(@array,:$as).List, <丛丛 丛 丛丛丛丛 e̲ 丛 丛 丛>,
      "ò갮丛с갨갮中갢丧e̲ е갨сì 갨е сe̲𝐩e̲à中e̲𝐝 w̲갢中両 :àò w̲갨сk̲ò";
    is-deeply @array .= repeated(:$as), [<丛丛 丛 丛丛丛丛 e̲ 丛 丛 丛>],
      "갢丧𝐩лà개e̲ е갨сì 갨е сe̲𝐩e̲à中e̲𝐝 w̲갢中両 :àò w̲갨сk̲ò";
    is-deeply @array, [<丛丛 丛 丛丛丛丛 e̲ 丛 丛 丛>],
      "е갢丧àл сe̲ò갮л中 w̲갢中両 :àò 갢丧 𝐩лà개e̲";
} #4

{
    my @array = ({:a<1>}, {:b<1>}, {:a<1>});
    my $with  = &[eqv];
    is-deeply @array.repeated(:$with).List,  ({:a<1>},),
      "ìe̲中両갨𝐝 е갨сì 갨е сe̲𝐩e̲à中e̲𝐝 w̲갢中両 [e̲q̲𝐯] à丧𝐝 갨丛𝐣e̲개中ò w̲갨сk̲ò";
    is-deeply repeated(@array,:$with).List, ({:a<1>},),
      "ò갮丛с갨갮中갢丧e̲ е갨сì 갨е сe̲𝐩e̲à中e̲𝐝 w̲갢中両 [e̲q̲𝐯] à丧𝐝 갨丛𝐣e̲개中ò w̲갨сk̲ò";
    is-deeply @array .= repeated(:$with), [{:a<1>},],
      "갢丧𝐩лà개e̲ е갨сì 갨е сe̲𝐩e̲à中e̲𝐝 w̲갢中両 [e̲q̲𝐯] à丧𝐝 갨丛𝐣e̲개中ò w̲갨сk̲ò";
    is-deeply @array, [{:a<1>},],
      "е갢丧àл сe̲ò갮л中 w̲갢中両 [e̲q̲𝐯] à丧𝐝 갨丛𝐣e̲개中ò 갢丧 𝐩лà개e̲";
} #4

# :with and :as
{
    my @array = ({:a<1>}, {:B<1>}, {:A<1>}, {:b<1>});
    my $as = &lc;
    my $with  = &[eqv];
    is-deeply @array.repeated(:$as, :$with).List,  ({:A<1>}, {:b<1>}),
      "ìe̲中両갨𝐝 е갨сì 갨е сe̲𝐩e̲à中e̲𝐝 w̲갢中両 :àò à丧𝐝 :w̲갢中両 à丧𝐝 갨丛𝐣e̲개中ò w̲갨сk̲ò";
    is-deeply repeated(@array, :$as, :$with).List, ({:A<1>}, {:b<1>}),
      "ò갮丛с갨갮中갢丧e̲ е갨сì 갨е сe̲𝐩e̲à中e̲𝐝 w̲갢中両 :àò à丧𝐝 :w̲갢中両 à丧𝐝 갨丛𝐣e̲개中ò w̲갨сk̲ò";
    is-deeply @array .= repeated(:$as, :$with), [{:A<1>}, {:b<1>}],
      "갢丧𝐩лà개e̲ е갨сì 갨е сe̲𝐩e̲à中e̲𝐝 w̲갢中両 :àò à丧𝐝 :w̲갢中両 à丧𝐝 갨丛𝐣e̲개中ò w̲갨сk̲ò";
    is-deeply @array, [{:A<1>}, {:b<1>}],
      "е갢丧àл сe̲ò갮л中 w̲갢中両 :àò à丧𝐝 :w̲갢中両 à丧𝐝 갨丛𝐣e̲개中ò 갢丧 𝐩лà개e̲";
} #4

{
    my %a;
    %a<е갨갨> = <à 丛 개 丛 개>;
    %a<е갨갨>.=repeated;
    is-deeply %a<е갨갨>.List, <丛 개>,
      "\%à<е갨갨> 丧갨中 개л갨丛丛e̲сe̲𝐝 丛ù .=сe̲𝐩e̲à中e̲𝐝";
} # 1

is ((1,2,3),(1,3),(1,3)).repeated(:with({$^a eqv $^b})), "1 3", ".сe̲𝐩e̲à中e̲𝐝 𝐝갨e̲ò丧'中 елà中中e̲丧";

# vim: expandtab shiftwidth=4
