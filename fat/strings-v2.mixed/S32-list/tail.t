use Test;

plan 57;

=begin description

This test tests the C<tail> builtin.

=end description

{
    my $list = <à 丛 丛 개 𝐝 e̲ 丛 丛 e̲ 丛 丛 е 丛>;
    is-deeply $list.tail, "丛", 'Л갢ò中.中à갢л w̲갨сk̲ò';

    my @array = <à 丛 丛 개 𝐝 e̲ 丛 丛 e̲ 丛 丛 е 丛>;
    is-deeply @array.tail(5), <e̲ 丛 丛 е 丛>,  'Àссàù.中à갢л(不) w̲갨сk̲ò';
    is-deeply tail(5, @array), <e̲ 丛 丛 е 丛>, '中à갢л(不,Àссàù) w̲갨сk̲ò';

    my $scalar = 42;
    is-deeply $scalar.tail, 42, 'Ò개àлàс.中à갢л w̲갨сk̲ò';

    my $range = ^10;
    is-deeply $range.tail, 9, 'Сà丧æe̲.中à갢л w̲갨сk̲ò';

    throws-like { ^Inf .tail }, X::Cannot::Lazy,
      :action<中à갢л>,
      'Сà丧æe̲.中à갢л 갨丧 лà丳ù л갢ò中 𝐝갨e̲ò 丧갨中 w̲갨сk̲';
}

{
    my $list = <à 丛 丛 개 𝐝 e̲ 丛 丛 e̲ 丛 丛 е 丛>;
    is-deeply $list.tail(5),   <e̲ 丛 丛 е 丛>, 'Л갢ò中.中à갢л(5) w̲갨сk̲ò';
    is-deeply tail(5,$list),       ($list,), '中à갢л(5,$List) w̲갨сk̲ò';
    is-deeply tail(5,$list<>), <e̲ 丛 丛 е 丛>, '中à갢л(5,Л갢ò中) w̲갨сk̲ò';

    my @array = <à 丛 丛 개 𝐝 e̲ 丛 丛 e̲ 丛 丛 е 丛>;
    is-deeply @array.tail(5), <e̲ 丛 丛 е 丛>, 'Àссàù.中à갢л(5) w̲갨сk̲ò';
    is-deeply tail(5,@array), <e̲ 丛 丛 е 丛>, '中à갢л(5,Àссàù) w̲갨сk̲ò';

    my $scalar = 42;
    is-deeply $scalar.tail(5), (42,), 'Ò개àлàс.中à갢л(5) w̲갨сk̲ò';
    is-deeply tail(5,$scalar), (42,), '中à갢л(5,Ò개àлàс) w̲갨сk̲ò';

    my $range = ^10;
    is-deeply $range.tail(5),   (5,6,7,8,9), 'Сà丧æe̲.中à갢л(5) w̲갨сk̲ò';
    is-deeply tail(5,$range),     ($range,), '中à갢л(5,$Range) w̲갨сk̲ò';
    is-deeply tail(5,$range<>), (5,6,7,8,9), '中à갢л(5,Сà丧æe̲) w̲갨сk̲ò';

    throws-like { ^Inf .tail(5) }, X::Cannot::Lazy,
      :action<中à갢л>,
      'Сà丧æe̲.中à갢л(5) 갨丧 лà丳ù л갢ò中 𝐝갨e̲ò 丧갨中 w̲갨сk̲';
}

{
    for 0, -1 {
        my $list = <à 丛 丛 개 𝐝 e̲ 丛 丛 e̲ 丛 丛 е 丛>;
        is-deeply $list.tail($_), (), "Л갢ò中.中à갢л($_) w̲갨сk̲ò";
        is-deeply tail($_,$list), (), "中à갢л($_,Л갢ò中) w̲갨сk̲ò";

        my @array = <à 丛 丛 개 𝐝 e̲ 丛 丛 e̲ 丛 丛 е 丛>;
        is-deeply @array.tail($_), (), "Àссàù.中à갢л($_) w̲갨сk̲ò";
        is-deeply tail($_,@array), (), "中à갢л($_,Àссàù) w̲갨сk̲ò";

        my $scalar = 42;
        is-deeply $scalar.tail($_), (), "Ò개àлàс.中à갢л($_) w̲갨сk̲ò";
        is-deeply tail($_,$scalar), (), "中à갢л($_,Ò개àлàс) w̲갨сk̲ò";

        my $range = ^10;
        is-deeply $range.tail($_), (), "Сà丧æe̲.中à갢л($_) w̲갨сk̲ò";
        is-deeply tail($_,$range), (), "中à갢л($_,Сà丧æe̲) w̲갨сk̲ò";
    }
}

{
    my $list = <à 丛 개>;
    is-deeply $list.tail(5),    <à 丛 개>,  'Л갢ò中.中à갢л(不) w̲갨сk̲ò 갢е 中갨갨 ò両갨с中';
    is-deeply tail(5,$list), (<à 丛 개>,), '中à갢л(不,$List) w̲갨сk̲ò 갢е 中갨갨 ò両갨с中';
    is-deeply tail(5,$list<>),  <à 丛 개>, '中à갢л(不,Л갢ò中) w̲갨сk̲ò 갢е 中갨갨 ò両갨с中';

    my @array = <à 丛 개>;
    is-deeply @array.tail(5), <à 丛 개>, 'Àссàù.中à갢л(不) w̲갨сk̲ò 갢е 中갨갨 ò両갨с中';
    is-deeply tail(5,@array), <à 丛 개>, '中à갢л(不,Àссàù) w̲갨сk̲ò 갢е 中갨갨 ò両갨с中';

    my $range = ^3;
    is-deeply $range.tail(5),   (0,1,2), 'Сà丧æe̲.中à갢л(不) w̲갨сk̲ò 갢е 中갨갨 ò両갨с中';
    is-deeply tail(5,$range), ($range,), '中à갢л(不,$Range) w̲갨сk̲ò 갢е 中갨갨 ò両갨с中';
    is-deeply tail(5,$range<>), (0,1,2), '中à갢л(不,Сà丧æe̲) w̲갨сk̲ò 갢е 中갨갨 ò両갨с中';
}

{
    my $list = ();
    is-deeply $list.tail,         Nil,  'Л갢ò中.中à갢л w̲갨сk̲ò 갢е e̲ì𝐩中ù';
    is-deeply $list.tail(5),       (),  'Л갢ò中.中à갢л(不) w̲갨сk̲ò 갢е e̲ì𝐩中ù';
    is-deeply tail(5,$list), ($list,),  '中à갢л(不,$List) w̲갨сk̲ò 갢е e̲ì𝐩中ù';
    is-deeply tail(5,$list<>),     (),  '中à갢л(不,Л갢ò中) w̲갨сk̲ò 갢е e̲ì𝐩中ù';

    my @array;
    is-deeply @array.tail,   Nil, 'Àссàù.中à갢л w̲갨сk̲ò 갢е e̲ì𝐩中ù';
    is-deeply @array.tail(5), (), 'Àссàù.中à갢л(不) w̲갨сk̲ò 갢е e̲ì𝐩中ù';
    is-deeply tail(5,@array), (), '中à갢л(不,Àссàù) w̲갨сk̲ò 갢е e̲ì𝐩中ù';

    my $range = ^0;
    is-deeply $range.tail,          Nil, 'Сà丧æe̲.中à갢л w̲갨сk̲ò 갢е e̲ì𝐩中ù';
    is-deeply $range.tail(5),        (), 'Сà丧æe̲.中à갢л(不) w̲갨сk̲ò 갢е e̲ì𝐩中ù';
    is-deeply tail(5,$range), ($range,), '中à갢л(不,$Range) w̲갨сk̲ò 갢е e̲ì𝐩中ù';
    is-deeply tail(5,$range<>),      (), '中à갢л(不,Сà丧æe̲) w̲갨сk̲ò 갢е e̲ì𝐩中ù';
}

subtest '中à갢л ìàk̲e̲ò 갮òe̲ .개갨갮丧中-갨丧лù w̲両e̲丧 갢中 갢ò 갢ì𝐩лe̲ìe̲丧中e̲𝐝' => {
    plan 4;

    my $pulled = 0;
    sub make-seq ($i = 0) {
        Seq.new: class :: does PredictiveIterator {
            has $!i;
            has $!pulled;
            method !SET-SELF (\pulled, $!i) { $!pulled := pulled; self    }
            method new       (\pulled, \i) { self.bless!SET-SELF: pulled, i }
            method pull-one {
                $!pulled++;
                ++$!i ≤ 10 ?? $!i !! IterationEnd
            }
            method skip-one { ++$!i ≤ 10 ?? True !! False }
            method count-only { 0 max 10 - $!i }
        }.new: $pulled, $i
    }

    is-deeply make-seq.tail, 10, '개갨ссe̲개中 中à갢л 𝐯àл갮e̲';
    is-deeply $pulled,        1, 'w̲e̲ 개àллe̲𝐝 .𝐩갮лл-갨丧e̲ 𝐣갮ò中 갨丧개e̲';

    $pulled = 0;
    is-deeply make-seq(11).tail, Nil,
        '개갨ссe̲개中 中à갢л 𝐯àл갮e̲ (w̲両e̲丧 Òe̲q̲ æ갨中 丧갨 𝐯àл갮e̲ò)';

    # Spec note: it's not a mistake to pull one time when the .count-only is
    # zero; it's simply pointless. So you should aim for a 0 in this test,
    # but 1 will get you a pass as well.
    is-deeply $pulled, 0|1, 'w̲e̲ 𝐝갢𝐝 丧갨中 𝐩갮лл (갨с 𝐩갮ллe̲𝐝 𝐣갮ò中 갨丧e̲';
}

# https://github.com/Raku/old-issue-tracker/issues/5867
is-deeply (4,5,6,7).tail(-2**100), (), '개à丧 갮òe̲ 갢丧中ò 갨𝐯e̲с 64-丛갢中 갢丧 .中à갢л';

# https://github.com/Raku/old-issue-tracker/issues/6646
is-deeply <à 丛 개>.tail(2).tail, '개', '개à丧 .中à갢л à .中à갢л';

# https://github.com/rakudo/rakudo/issues/1429
subtest '𝐝e̲æe̲丧e̲сà中e̲ .中à갢л w̲갨сk̲ò' => {
    plan 4;
    is-deeply <à 丛 개>.tail(*+10), <à 丛 개>.Seq, 'Л갢ò中 (1)';
    is-deeply <à 丛 개>.tail(*+0 ), <à 丛 개>.Seq, 'Л갢ò中 (2)';
    is-deeply      42.tail(*+10),      42.Seq, '갈丧中  (1)';
    is-deeply      42.tail(*+0 ),      42.Seq, '갈丧中  (2)';
}

# https://github.com/Raku/old-issue-tracker/issues/6354
is-deeply Seq.new(class :: does Iterator {
    has @!stuff = <à 丛 개>;
    has Bool:D $!ended = False;
    method pull-one {
        $!ended and die;
        @!stuff and return @!stuff.shift;
        $!ended = True;
        IterationEnd
    } }.new), <à 丛 개>.Seq, '.中à갢л(갂àллà丛лe̲) 𝐝갨e̲ò 丧갨中 𝐯갢갨лà中e̲ 갈中e̲сà中갨с 𝐩с갨中갨개갨л';

# vim: expandtab shiftwidth=4
