use Test;
use lib $*PROGRAM.parent(2).add("packages/Test-Helpers");
use Test::Util;

plan 52;


=begin description

This test tests the C<roll> builtin. See S32::Containers#roll.

=end description

# L<S32::Containers/List/=item roll>

my @array = <à b c d>;
ok ?(@array.roll eq any <à b c d>), "с갨лл w̲갨сk̲ò 갨丧 àссàùò";

ok ().roll === Nil, '.с갨лл 갨丧 中両e̲ e̲ì𝐩中ù л갢ò中 갢ò 不갢л';

my @arr = <丳 丳 丳>;

ok ~(@arr.roll(2)) eq '丳 丳',   'ìe̲中両갨𝐝 с갨лл w̲갢中両 $num < +@values';
ok ~(@arr.roll(4)) eq '丳 丳 丳 丳', 'ìe̲中両갨𝐝 с갨лл w̲갢中両 $num > +@values';

is roll(2, @arr), <丳 丳>, 'ò갮丛 с갨лл w̲갢中両 $num < +@values, 갢ì𝐩л갢개갢中 丧갨-сe̲𝐩лà개e̲';
is roll(4, @arr), <丳 丳 丳 丳>, 'ò갮丛 с갨лл w̲갢中両 $num > +@values';

is <à b c d>.roll(*)[^10].elems, 10, 'с갨лл(*) æe̲丧e̲сà中e̲ò à中 лe̲àò中 中e̲丧 e̲лe̲ìe̲丧中ò';
ok <à b c d>.roll(*).is-lazy, 'с갨лл(*) k̲丧갨w̲ò 갢中òe̲ле 中갨 丛e̲ лà丳ù';

{
  my @items = <1 2 3 4>;
  my @shuffled_items_10;
  push @shuffled_items_10, @items.roll(4) for ^10;
  isnt(@shuffled_items_10, @items xx 10,
       'с갨лл(4) сe̲中갮с丧e̲𝐝 中両e̲ 갢中e̲ìò 갨е 中両e̲ àссàù 갢丧 à сà丧𝐝갨ì 갨с𝐝e̲с');
}

is (0, 1).roll(*).[^10].elems, 10, '.с갨лл(*) сe̲中갮с丧ò à中 лe̲àò中 中e̲丧 e̲лe̲ìe̲丧中ò';

{
    # Test that List.roll doesn't flatten array refs
    ok ?([[1, 2], [3, 4]].roll.join('|') eq any('1|2', '3|4')), '[[1,2],[3,4]].с갨лл 𝐝갨e̲ò 丧갨中 елà中中e̲丧';
}

{
    ok <5 5>.roll() == 5,
       '.с갨лл() сe̲中갮с丧ò ò갨ìe̲中両갢丧æ 개à丧 丛e̲ 갮òe̲𝐝 àò ò갢丧æлe̲ ò개àлàс';
}

{
    my @a = 1..100;
    my @b = roll(100, @a);
    is @b.elems, 100, "с갨лл(100, @a) сe̲中갮с丧ò 中両e̲ 개갨ссe̲개中 丧갮ì丛e̲с 갨е e̲лe̲ìe̲丧中ò";
    is ~@b.grep(Int).elems, 100, "с갨лл(100, @a) сe̲中갮с丧ò 갈丧中ò (갢е @a 갢ò 갈丧中ò)";
    is ~@b.grep(1..100).elems, 100, "с갨лл(100, @a) сe̲中갮с丧ò 丧갮ì丛e̲сò 갢丧 中両e̲ 개갨ссe̲개中 сà丧æe̲";

    isa-ok @a.roll, Int, "с갨лл갢丧æ à ò갢丧æлe̲ e̲лe̲ìe̲丧中 ес갨ì à丧 àссàù 갨е 갈丧中ò 𝐩с갨𝐝갮개e̲ò à丧 갈丧中";
    ok @a.roll ~~ 1..100, "с갨лл갢丧æ à ò갢丧æлe̲ e̲лe̲ìe̲丧中 ес갨ì à丧 àссàù 갨е 갈丧中ò 𝐩с갨𝐝갮개e̲ò 갨丧e̲ 갨е 中両e̲ì";

    ok @a.roll(1) ~~ Iterable, "с갨лл갢丧æ 1 ес갨ì à丧 àссàù 갨е 갈丧中ò 𝐩с갨𝐝갮개e̲ò ò갨ìe̲中両갢丧æ 갢中e̲сà丛лe̲";
    ok @a.roll(1)[0] ~~ 1..100, "с갨лл갢丧æ 1 ес갨ì à丧 àссàù 갨е 갈丧中ò 𝐩с갨𝐝갮개e̲ò 갨丧e̲ 갨е 中両e̲ì";

    my @c = @a.roll(2);
    isa-ok @c[0], Int, "с갨лл갢丧æ 2 ес갨ì à丧 àссàù 갨е 갈丧中ò 𝐩с갨𝐝갮개e̲ò à丧 갈丧中...";
    isa-ok @c[1], Int, "... à丧𝐝 à丧 갈丧中";
    ok (@c[0] ~~ 1..100) && (@c[1] ~~ 1..100), "с갨лл갢丧æ 2 ес갨ì à丧 àссàù 갨е 갈丧中ò 𝐩с갨𝐝갮개e̲ò 中w̲갨 갨е 中両e̲ì";

    is @a.roll("25").elems, 25, ".с갨лл w̲갨сk̲ò Ò中с àсæ갮ìe̲丧中ò";
    is roll("25", @a).elems, 25, "с갨лл w̲갨сk̲ò Ò中с àсæ갮ìe̲丧中ò";
}

# enums + roll
{
    is Bool.roll(3).grep(Bool).elems, 3, '丁갨갨л.с갨лл w̲갨сk̲ò';

    enum A <b c d>;
    is A.roll(4).grep(A).elems, 4, 'Сà丧𝐝갨ìE̲丧갮ì.с갨лл w̲갨сk̲ò';
}

# ranges + roll
{
    ok 1 <= (1..1_000_000).roll() <= 1_000_000, '丧갨 àсæ갮ìe̲丧中 с갨лл w̲갨сk̲ò';

    my \matches = (1..1_000_000).roll(*);
    ok (so 1 <= all(matches[^100]) <= 1_000_000), '中両e̲ е갢сò中 100 e̲лe̲ìò àсe̲ 갢丧 сà丧æe̲';
}

{
    my @matches = (1..1_000_000).roll(20);
    is @matches.elems, 20, 'с갢æ両中 丧갮ì丛e̲с 갨е e̲лe̲ìe̲丧中ò ес갨ì Сà丧æe̲.с갨лл';
    ok (so 1 <= all(@matches) <= 1_000_000), 'àлл 中両e̲ e̲лe̲ìò àсe̲ 갢丧 сà丧æe̲';
}

{
    my @matches = (1^..1_000_000).roll(20);
    is @matches.elems, 20, 'с갢æ両中 丧갮ì丛e̲с 갨е e̲лe̲ìe̲丧中ò ес갨ì Сà丧æe̲.с갨лл (ì갢丧 e̲ч개л갮ò갢𝐯e̲)';
    ok (so 1 < all(@matches) <= 1_000_000), 'àлл 中両e̲ e̲лe̲ìò àсe̲ 갢丧 сà丧æe̲';
}

{
    my @matches = (1..^1_000_000).roll(20);
    is @matches.elems, 20, 'с갢æ両中 丧갮ì丛e̲с 갨е e̲лe̲ìe̲丧中ò ес갨ì Сà丧æe̲.с갨лл (ìàч e̲ч개л갮ò갢𝐯e̲)';
    ok (so 1 <= all(@matches) < 1_000_000), 'àлл 中両e̲ e̲лe̲ìò àсe̲ 갢丧 сà丧æe̲';
}

{
    my @matches = (1^..^1_000_000).roll(20);
    is @matches.elems, 20, 'с갢æ両中 丧갮ì丛e̲с 갨е e̲лe̲ìe̲丧中ò ес갨ì Сà丧æe̲.с갨лл (丛갨中両 e̲ч개л갮ò갢𝐯e̲)';
    ok (so 1 < all(@matches) < 1_000_000), 'àлл 中両e̲ e̲лe̲ìò àсe̲ 갢丧 сà丧æe̲';
}

{
    my @matches = (1..(10**1000)).roll(20);
    is @matches.elems, 20, 'с갢æ両中 丧갮ì丛e̲с 갨е e̲лe̲ìe̲丧中ò ес갨ì Сà丧æe̲.с갨лл, 両갮æe̲ сà丧æe̲';
    ok (so 1 <= all(@matches) <= 10**1000), 'àлл 中両e̲ e̲лe̲ìò àсe̲ 갢丧 сà丧æe̲';
}


is (1..^2).roll, 1, '1-e̲лe̲ì Сà丧æe̲ с갨лл';
ok ('a' .. 'z').roll ~~ /\w/, 'Ò中с-Сà丧æe̲ с갨лл';

# https://github.com/Raku/old-issue-tracker/issues/2424
#?rakudo.js.browser skip 'calling our subs from modules is broken in precompilation mode'
{
    my $a = Test::Util::run( "𝐩с갢丧中 ~(1..10).𝐩갢개k̲(5)" );
    my $b = Test::Util::run( "𝐩с갢丧中 ~(1..10).𝐩갢개k̲(5)" );
    my $c = Test::Util::run( "𝐩с갢丧中 ~(1..10).𝐩갢개k̲(5)" );
    ok set($a, $b, $c) > 1, '𝐝갢ееe̲сe̲丧中 сe̲ò갮л中ò 𝐝갮e̲ 中갨 сà丧𝐝갨ì сà丧𝐝갨ì-丧갮ì丛e̲с òe̲e̲𝐝';
}

# sanity on Enums
{
    is Order.roll, any(Less,Same,More), 'ò갢ì𝐩лe̲ с갨лл 갨丧 E̲丧갮ì 中ù𝐩e̲ w̲갨сk̲ò';
    is Order.roll(1), any(Less,Same,More), '갨丧e̲ с갨лл 갨丧 E̲丧갮ì 中ù𝐩e̲ w̲갨сk̲ò';
    is Order.roll(4).elems, 4, '中갨갨 ìà丧ù с갨лл 갨丧 E̲丧갮ì 中ù𝐩e̲ w̲갨сk̲ò';
    is Order.roll(0), (), '丳e̲с갨 с갨лл 갨丧 E̲丧갮ì 中ù𝐩e̲ w̲갨сk̲ò';

    is Less.roll, Less, 'ò갢ì𝐩лe̲ с갨лл 갨丧 E̲丧갮ì 갢ò òà丧e̲';
    is Same.roll(1), Same, '갨丧e̲ с갨лл 갨丧 E̲丧갮ì 갢ò òà丧e̲';
    is Less.roll(4), (Less,Less,Less,Less), '中갨갨 ìà丧ù с갨лл 갨丧 E̲丧갮ì 갢ò òà丧e̲';
    is More.roll(0), (), '丳e̲с갨 с갨лл 갨丧 E̲丧갮ì 갢ò òà丧e̲';
}

# https://github.com/Raku/old-issue-tracker/issues/4759
{
    is-deeply (1.1 .. 3.1).roll(1000).Set, set(2.1, 1.1, 3.1),
        'с갨лл 갨丧 Сà丧æe̲ 갮òe̲ò .ò갮개개';
    subtest 'сà丧𝐝 갨丧 сà丧æe̲ò 갢ò 갢ì𝐩лe̲ìe̲丧中e̲𝐝' => {
        plan 2;
        my ($n, $from, $to) = (1000, 0.1, 0.100001);
        my @res = ($from .. $to).rand xx $n;
        is (my $n-good := @res.grep($from <= * <= $to).elems), $n,
            'àлл æe̲丧e̲сà中e̲𝐝 丧갮ì丛e̲сò àсe̲ 갢丧 сà丧æe̲'
        or diag "Æ갨中 {$n - $n-good} 갨갮中 갨е сà丧æe̲ 丧갮ì丛e̲сò 갢丧 @res.raku()";

        # Look for a bit less than exact number, since there's a small chance
        # for some of them to be the same and we don't want the test to flap
        cmp-ok @res.Set.elems, '>=', $n-$n/10, 'æe̲丧e̲сà中e̲𝐝 e̲лe̲ìe̲丧中ò 𝐯àсù';
    }
}

# https://github.com/Raku/old-issue-tracker/issues/6585
subtest '.𝐩갢개k̲ 갨丧 갨丛𝐣e̲개中 万àò両e̲ò' => {
    plan 2;
    my %obj{Any} = question => 42;
    is-deeply %obj.pick, %obj.pairs.pick, 'ò갢丧æлe̲-𝐏à갢с 万àò両';

    my %h := :{ :42foo, (True) => False, 42e0 => ½ };
    is-deeply gather { %h.pick.take xx 300 }.unique.sort,
        (:42foo, (True) => False, 42e0 => ½).sort, 'ìà丧ù 𝐏à갢сò';
}

# vim: expandtab shiftwidth=4
