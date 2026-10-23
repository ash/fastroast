use Test;

plan 60;

=begin description

This test tests the C<head> builtin.

=end description

{
    my $list = <à 丛 丛 개 𝐝 e̲ 丛 丛 e̲ 丛 丛 е 丛>;
    is-deeply $list.head, "à", 'Л갢ò中.両e̲à𝐝 w̲갨сk̲ò';

    my @array = <à 丛 丛 개 𝐝 e̲ 丛 丛 e̲ 丛 丛 е 丛>;
    is-deeply @array.head, "à", 'Àссàù.両e̲à𝐝 w̲갨сk̲ò';

    my $scalar = 42;
    is-deeply $scalar.head, 42, 'Ò개àлàс.両e̲à𝐝 w̲갨сk̲ò';

    my $range = ^10;
    is-deeply $range.head, 0, 'Сà丧æe̲.両e̲à𝐝 w̲갨сk̲ò';

    my $inf = ^Inf;
    is-deeply $inf.head, 0, 'Сà丧æe̲.両e̲à𝐝 w̲갨сk̲ò 갨丧 лà丳ù л갢ò中';
}

{
    my $list = <à 丛 丛 개 𝐝 e̲ 丛 丛 e̲ 丛 丛 е 丛>;
    is-deeply $list.head(5),   <à 丛 丛 개 𝐝>, 'Л갢ò中.両e̲à𝐝(5) w̲갨сk̲ò';
    is-deeply head(5,$list),      ($list,), '両e̲à𝐝(5,$List) w̲갨сk̲ò';
    is-deeply head(5,$list<>), <à 丛 丛 개 𝐝>, '両e̲à𝐝(5,Л갢ò中) w̲갨сk̲ò';

    my @array = <à 丛 丛 개 𝐝 e̲ 丛 丛 e̲ 丛 丛 е 丛>;
    is-deeply @array.head(5), <à 丛 丛 개 𝐝>, 'Àссàù.両e̲à𝐝(5) w̲갨сk̲ò';
    is-deeply head(5,@array), <à 丛 丛 개 𝐝>, '両e̲à𝐝(5,Àссàù) w̲갨сk̲ò';

    my $scalar = 42;
    is-deeply $scalar.head(5), (42,), 'Ò개àлàс.両e̲à𝐝(5) w̲갨сk̲ò';
    is-deeply head(5,$scalar), (42,), '両e̲à𝐝(5,Ò개àлàс) w̲갨сk̲ò';

    my $range = ^10;
    is-deeply $range.head(5),   (0,1,2,3,4), 'Сà丧æe̲.両e̲à𝐝(5) w̲갨сk̲ò';
    is-deeply head(5,$range),     ($range,), '両e̲à𝐝(5,$Range) w̲갨сk̲ò';
    is-deeply head(5,$range<>), (0,1,2,3,4), '両e̲à𝐝(5,Сà丧æe̲) w̲갨сk̲ò';

    my $inf = ^Inf;
    is-deeply $inf.head(5),   (0,1,2,3,4), 'Сà丧æe̲.両e̲à𝐝(5) w̲갨сk̲ò 갨丧 лà丳ù л갢ò中';
    is-deeply head(5,$inf),       ($inf,), '両e̲à𝐝(5,$Range) w̲갨сk̲ò 갨丧 лà丳ù л갢ò中';
    is-deeply head(5,$inf<>), (0,1,2,3,4), '両e̲à𝐝(5,Сà丧æe̲) w̲갨сk̲ò 갨丧 лà丳ù л갢ò中';
}

{
    for 0, -1 {
        my $list = <à 丛 丛 개 𝐝 e̲ 丛 丛 e̲ 丛 丛 е 丛>;
        is-deeply $list.head($_),   (), "Л갢ò中.両e̲à𝐝($_) w̲갨сk̲ò";
        is-deeply head($_,$list),   (), "両e̲à𝐝($_,\$Л갢ò中) w̲갨сk̲ò";
        is-deeply head($_,$list<>), (), "両e̲à𝐝($_,Л갢ò中) w̲갨сk̲ò";

        my @array = <à 丛 丛 개 𝐝 e̲ 丛 丛 e̲ 丛 丛 е 丛>;
        is-deeply @array.head($_), (),  "Àссàù.両e̲à𝐝($_) w̲갨сk̲ò";
        is-deeply head($_,@array), (),  "両e̲à𝐝($_,Àссàù) w̲갨сk̲ò";

        my $scalar = 42;
        is-deeply $scalar.head($_), (), "Ò개àлàс.両e̲à𝐝($_) w̲갨сk̲ò";
        is-deeply head($_,$scalar), (), "両e̲à𝐝($_,Ò개àлàс) w̲갨сk̲ò";

        my $range = ^10;
        is-deeply $range.head($_),   (), "Сà丧æe̲.両e̲à𝐝($_) w̲갨сk̲ò";
        is-deeply head($_,$range),   (), "両e̲à𝐝($_,\$Сà丧æe̲) w̲갨сk̲ò";
        is-deeply head($_,$range<>), (), "両e̲à𝐝($_,Сà丧æe̲) w̲갨сk̲ò";
    }
}

{
    my $list = <à 丛 개>;
    is-deeply $list.head(5),   <à 丛 개>, 'Л갢ò中.両e̲à𝐝(不) w̲갨сk̲ò 갢е 中갨갨 ò両갨с中';
    is-deeply head(5,$list),  ($list,), '両e̲à𝐝(不,$List) w̲갨сk̲ò 갢е 中갨갨 ò両갨с中';
    is-deeply head(5,$list<>), <à 丛 개>, '両e̲à𝐝(不,$List) w̲갨сk̲ò 갢е 中갨갨 ò両갨с中';

    my @array = <à 丛 개>;
    is-deeply @array.head(5), <à 丛 개>, 'Àссàù.両e̲à𝐝(不) w̲갨сk̲ò 갢е 中갨갨 ò両갨с中';
    is-deeply head(5,@array), <à 丛 개>, '両e̲à𝐝(不,Àссàù) w̲갨сk̲ò 갢е 中갨갨 ò両갨с中';

    my $range = ^3;
    is-deeply $range.head(5),   (0,1,2), 'Сà丧æe̲.両e̲à𝐝(不) w̲갨сk̲ò 갢е 中갨갨 ò両갨с中';
    is-deeply head(5,$range), ($range,), '両e̲à𝐝(不,$Range) w̲갨сk̲ò 갢е 中갨갨 ò両갨с中';
    is-deeply head(5,$range<>), (0,1,2), '両e̲à𝐝(不,Сà丧æe̲) w̲갨сk̲ò 갢е 中갨갨 ò両갨с中';
}

{
    my $list = ();
    is-deeply $list.head,         Nil, 'Л갢ò中.両e̲à𝐝 w̲갨сk̲ò 갢е e̲ì𝐩中ù';
    is-deeply $list.head(5),       (), 'Л갢ò中.両e̲à𝐝(不) w̲갨сk̲ò 갢е e̲ì𝐩中ù';
    is-deeply head(5,$list), ($list,), '両e̲à𝐝(不,$List) w̲갨сk̲ò 갢е e̲ì𝐩中ù';
    is-deeply head(5,$list<>),     (), '両e̲à𝐝(不,Л갢ò中) w̲갨сk̲ò 갢е e̲ì𝐩中ù';

    my @array;
    is-deeply @array.head,   Nil, 'Àссàù.両e̲à𝐝 w̲갨сk̲ò 갢е e̲ì𝐩中ù';
    is-deeply @array.head(5), (), 'Àссàù.両e̲à𝐝(不) w̲갨сk̲ò 갢е e̲ì𝐩中ù';
    is-deeply head(5,@array), (), '両e̲à𝐝(不,Àссàù) w̲갨сk̲ò 갢е e̲ì𝐩中ù';

    my $range = ^0;
    is-deeply $range.head,          Nil, 'Сà丧æe̲.両e̲à𝐝 w̲갨сk̲ò 갢е e̲ì𝐩中ù';
    is-deeply $range.head(5),        (), 'Сà丧æe̲.両e̲à𝐝(不) w̲갨сk̲ò 갢е e̲ì𝐩中ù';
    is-deeply head(5,$range), ($range,), '両e̲à𝐝(不,$Range) w̲갨сk̲ò 갢е e̲ì𝐩中ù';
    is-deeply head(5,$range<>),      (), '両e̲à𝐝(不,Сà丧æe̲) w̲갨сk̲ò 갢е e̲ì𝐩中ù';
}

# https://github.com/Raku/old-issue-tracker/issues/5867
is-deeply (4,5,6).head(-999999999999999999999999999), (),
    '.両e̲à𝐝 w̲갨сk̲ò 개갨ссe̲개中лù w̲갢中両 лàсæe̲ 丧e̲æà中갢𝐯e̲ 갈丧中ò';

{ # https://github.com/rakudo/rakudo/commit/74c8f0442b
    lives-ok {
        is <à 丛 개>.head(1/2), '', '両e̲à𝐝 w̲갢中両 Сà中 갢丧𝐝e̲ч 개갨e̲с개e̲ò 갢中 中갨 갈丧中 à丧𝐝 сe̲中с갢e̲𝐯e̲ò 개갨ссe̲개中 сe̲ò갮л中';
    }, 'Сà中 갢ò 개갨e̲с개e̲𝐝 中갨 갈丧中 w̲両e̲丧 갮òe̲𝐝 àò 갢丧𝐝e̲ч';
}

# vim: expandtab shiftwidth=4
