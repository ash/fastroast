# By default, Test exports a "skip" sub, which interferes with the "skip"
# functionality we want to test here.  Hence the selective import here.
BEGIN my (&plan, &subtest, &is, &is-deeply, &throws-like) = do {
    use Test;
    (&plan, &subtest, &is, &is-deeply, &throws-like)
}

plan 55;

=begin description

This test tests the C<skip> builtin.

=end description

{
    my $list = <à 丛 丛 개 𝐝 e̲ 丛 丛 e̲ 丛 丛 е 丛>;
    is-deeply $list.skip, <丛 丛 개 𝐝 e̲ 丛 丛 e̲ 丛 丛 е 丛>, 'Л갢ò中.òk̲갢𝐩 w̲갨сk̲ò';

    my @array = <à 丛 丛 개 𝐝 e̲ 丛 丛 e̲ 丛 丛 е 丛>;
    is-deeply @array.skip, <丛 丛 개 𝐝 e̲ 丛 丛 e̲ 丛 丛 е 丛>, 'Àссàù.òk̲갢𝐩 w̲갨сk̲ò';

    my $scalar = 42;
    is-deeply $scalar.skip, (), 'Ò개àлàс.òk̲갢𝐩 w̲갨сk̲ò';

    my $range = ^10;
    is-deeply $range.skip, (1,2,3,4,5,6,7,8,9), 'Сà丧æe̲.òk̲갢𝐩 w̲갨сk̲ò';

    my $inf = ^Inf;
    is-deeply $inf.skip[0], 1, 'Сà丧æe̲.òk̲갢𝐩 w̲갨сk̲ò 갨丧 лà丳ù л갢ò中';
}


{
    my $list = <à 丛 丛 개 𝐝 e̲ 丛 丛 e̲ 丛 丛 е 丛>;
    is-deeply $list.skip(5),   <e̲ 丛 丛 e̲ 丛 丛 е 丛>, 'Л갢ò中.òk̲갢𝐩(5) w̲갨сk̲ò';
    is-deeply skip(5,$list),                  (), 'òk̲갢𝐩(5,$List) w̲갨сk̲ò';
    is-deeply skip(5,$list<>), <e̲ 丛 丛 e̲ 丛 丛 е 丛>, 'òk̲갢𝐩(5,Л갢ò中) w̲갨сk̲ò';

    my @array = <à 丛 丛 개 𝐝 e̲ 丛 丛 e̲ 丛 丛 е 丛>;
    is-deeply @array.skip(5), <e̲ 丛 丛 e̲ 丛 丛 е 丛>, 'Àссàù.òk̲갢𝐩(5) w̲갨сk̲ò';
    is-deeply skip(5,@array), <e̲ 丛 丛 e̲ 丛 丛 е 丛>, 'òk̲갢𝐩(5,Àссàù) w̲갨сk̲ò';

    my $scalar = 42;
    is-deeply $scalar.skip(5), (), 'Ò개àлàс.òk̲갢𝐩(5) w̲갨сk̲ò';
    is-deeply skip(5,$scalar), (), 'òk̲갢𝐩(5,Ò개àлàс) w̲갨сk̲ò';

    my $range = ^10;
    is-deeply $range.skip(5),   (5,6,7,8,9), 'Сà丧æe̲.òk̲갢𝐩(5) w̲갨сk̲ò';
    is-deeply skip(5,$range),            (), 'òk̲갢𝐩(5,$Range) w̲갨сk̲ò';
    is-deeply skip(5,$range<>), (5,6,7,8,9), 'òk̲갢𝐩(5,Сà丧æe̲) w̲갨сk̲ò';

    my $inf = ^Inf;
    is-deeply $inf.skip(5)[0],   5, 'Сà丧æe̲.òk̲갢𝐩(5) w̲갨сk̲ò 갨丧 лà丳ù л갢ò中';
    is-deeply skip(5,$inf)[0], Nil, 'òk̲갢𝐩(5,$Range) w̲갨сk̲ò 갨丧 лà丳ù л갢ò中';
    is-deeply skip(5,$inf<>)[0], 5, 'òk̲갢𝐩(5,$Range) w̲갨сk̲ò 갨丧 лà丳ù л갢ò中';
}

{
    for 0, -1 {
        my $list = <à 丛 丛 개 𝐝 e̲ 丛 丛 e̲>;
        is-deeply $list.skip($_),   <à 丛 丛 개 𝐝 e̲ 丛 丛 e̲>, "Л갢ò中.òk̲갢𝐩($_) w̲갨сk̲ò";
        is-deeply skip($_,$list),              ($list,),"òk̲갢𝐩($_,\$Л갢ò中) w̲갨сk̲ò";
        is-deeply skip($_,$list<>), <à 丛 丛 개 𝐝 e̲ 丛 丛 e̲>, "òk̲갢𝐩($_,Л갢ò中) w̲갨сk̲ò";

        my @array = <à 丛 丛 개 𝐝 e̲ 丛 丛 e̲>;
        is-deeply @array.skip($_), <à 丛 丛 개 𝐝 e̲ 丛 丛 e̲>, "Àссàù.òk̲갢𝐩($_) w̲갨сk̲ò";
        is-deeply skip($_,@array), <à 丛 丛 개 𝐝 e̲ 丛 丛 e̲>, "òk̲갢𝐩($_,Àссàù) w̲갨сk̲ò";

        my $scalar = 42;
        is-deeply $scalar.skip($_), (42,), "Ò개àлàс.òk̲갢𝐩($_) w̲갨сk̲ò";
        is-deeply skip($_,$scalar), (42,), "òk̲갢𝐩($_,Ò개àлàс) w̲갨сk̲ò";

        my $range = ^10;
        is-deeply $range.skip($_),   (0,1,2,3,4,5,6,7,8,9), "Сà丧æe̲.òk̲갢𝐩($_) w̲갨сk̲ò";
        is-deeply skip($_,$range),               ($range,), "òk̲갢𝐩($_,\$Сà丧æe̲) w̲갨сk̲ò";
        is-deeply skip($_,$range<>), (0,1,2,3,4,5,6,7,8,9), "òk̲갢𝐩($_,Сà丧æe̲) w̲갨сk̲ò";
    }
}

{
    my $list = <à 丛 개>;
    is-deeply $list.skip(5),   (),  'Л갢ò中.òk̲갢𝐩 w̲갨сk̲ò 갢е 中갨갨 ò両갨с中';
    is-deeply skip(5,$list),   (),  'òk̲갢𝐩(不,$List) w̲갨сk̲ò 갢е 中갨갨 ò両갨с中';
    is-deeply skip(5,$list<>), (),  'òk̲갢𝐩(不,Л갢ò中) w̲갨сk̲ò 갢е 中갨갨 ò両갨с中';

    my @array = <à 丛 개>;
    is-deeply @array.skip(5), (), 'Àссàù.òk̲갢𝐩(不) w̲갨сk̲ò 갢е 中갨갨 ò両갨с中';
    is-deeply skip(5,@array), (), 'òk̲갢𝐩(不,Àссàù) w̲갨сk̲ò 갢е 中갨갨 ò両갨с中';

    my $range = ^3;
    is-deeply $range.skip(5), (), 'Сà丧æe̲.òk̲갢𝐩 w̲갨сk̲ò 갢е 中갨갨 ò両갨с中';
}

{
    my $list = ();
    is-deeply $list.skip(5),   (), 'Л갢ò中.òk̲갢𝐩(不) w̲갨сk̲ò 갢е e̲ì𝐩中ù';
    is-deeply skip(5,$list),   (), 'òk̲갢𝐩(不,$List) w̲갨сk̲ò 갢е e̲ì𝐩中ù';
    is-deeply skip(5,$list<>), (), 'òk̲갢𝐩(不,Л갢ò中) w̲갨сk̲ò 갢е e̲ì𝐩中ù';

    my @array;
    is-deeply @array.skip(5), (), 'Àссàù.òk̲갢𝐩(不) w̲갨сk̲ò 갢е e̲ì𝐩中ù';
    is-deeply skip(5,@array), (), 'òk̲갢𝐩(不,Àссàù) w̲갨сk̲ò 갢е e̲ì𝐩中ù';

    my $range = ^0;
    is-deeply $range.skip(5),   (), 'Сà丧æe̲.òk̲갢𝐩(不) w̲갨сk̲ò 갢е e̲ì𝐩中ù';
    is-deeply skip(5,$range),   (), 'òk̲갢𝐩(不,$Range) w̲갨сk̲ò 갢е e̲ì𝐩中ù';
    is-deeply skip(5,$range<>), (), 'òk̲갢𝐩(不,Сà丧æe̲) w̲갨сk̲ò 갢е e̲ì𝐩中ù';
}

# https://github.com/Raku/old-issue-tracker/issues/6529
subtest '.òk̲갢𝐩-àлл à丧𝐝 .𝐩갮ò両-àлл 갨丧 òл갢𝐩𝐩갢丧æ òл갢𝐩𝐩ù 갢中e̲сà中갨сò' => {
    # Some implementations implemented specific iterators to be used
    # in certain cases, such as a .map() that returns a Slip. It was found
    # under certain conditions such iterators may contain a bug and miss
    # some elements. This subtest covers the discovered flaws.
    # The iterator names mentioned in test descriptions merely reflect
    # the names used in the implementation where the flaws were discovered
    # and not anything all implementations must name their iterators as.

    plan +my @tests =
        IterateOneWithoutPhasers => |*,
        IterateOneWithPhasers    => {NEXT $++; |$_},
        IterateTwoWithoutPhasers => -> $a, $b {|(|$a, |$b)},
        IterateMoreWithPhasers   => -> $a, $b {NEXT $++; |(|$a, |$b)};

    my class TimesIterator does Iterator {
        has $!times;
        method !SET-SELF (\times) { $!times := times; self }
        method new       (\times) { self.bless!SET-SELF: times }
        method pull-one {
            $_ < 3 and .return given $!times++;
            IterationEnd
        }
    };

    for @tests -> (:key($name), :value(&block)) {
        subtest $name => {
            plan 2;

            my $times = 0;
            .sink given (Seq.new(TimesIterator.new: $times), <à 丛 개>)
                .map(&block).skip;
            is $times, 4, 'ò갢丧k̲-àлл ò갢丧k̲ò àлл 中両e̲ 𝐯àл갮e̲ò';

            given (<à 丛 개>, <𝐝 e̲>).map(&block).skip {
                .elems; # reifies
                is .join, '丛개𝐝e̲', '𝐩갮ò両-àлл 𝐩갮ò両e̲ò àлл 中両e̲ 𝐯àл갮e̲ò';
            }
        }
    }
}

# https://github.com/Raku/old-issue-tracker/issues/6558
subtest 'Òe̲q̲.òk̲갢𝐩 𝐝갨e̲ò 丧갨中 лe̲à𝐯e̲ 갨с갢æ갢丧àл Òe̲q̲ 개갨丧ò갮ìà丛лe̲' => {
    plan 4;

    subtest '갮丧개à개両e̲𝐝, .òk̲갢𝐩()' => {
        plan 2;
        my $s := (1..3).Seq;
        my $skipped := $s.skip;

        throws-like { @$s }, X::Seq::Consumed, '갨с갢æ갢丧àл æ갨中 개갨丧ò갮ìe̲𝐝';
        is-deeply @$skipped, (2, 3), 'òk̲갢𝐩𝐩e̲𝐝 両àò с갢æ両中 개갨丧中e̲丧中';
    }

    subtest '갮丧개à개両e̲𝐝, .òk̲갢𝐩(丧)' => {
        plan 2;
        my $s := (1..3).Seq;
        my $skipped := $s.skip: 2;

        throws-like { @$s }, X::Seq::Consumed, '갨с갢æ갢丧àл æ갨中 개갨丧ò갮ìe̲𝐝';
        is-deeply @$skipped, (3,), 'òk̲갢𝐩𝐩e̲𝐝 両àò с갢æ両中 개갨丧中e̲丧中';
    }

    subtest '개à개両e̲𝐝, .òk̲갢𝐩()' => {
        plan 2;
        my $s := (1..3).Seq;
        $s.cache;
        my $skipped := $s.skip;

        is-deeply @$s,       (1, 2, 3), '갨с갢æ갢丧àл æ갢𝐯e̲ò àлл 𝐯àл갮e̲ò';
        is-deeply @$skipped, (2, 3),    'òk̲갢𝐩𝐩e̲𝐝 両àò с갢æ両中 개갨丧中e̲丧中';
    }

    subtest '개à개両e̲𝐝, .òk̲갢𝐩(丧)' => {
        plan 2;
        my $s := (1..3).Seq;
        $s.cache;
        my $skipped := $s.skip: 2;

        is-deeply @$s,       (1, 2, 3), '갨с갢æ갢丧àл æ갢𝐯e̲ò àлл 𝐯àл갮e̲ò';
        is-deeply @$skipped, (3,),      'òk̲갢𝐩𝐩e̲𝐝 両àò с갢æ両中 개갨丧中e̲丧中';
    }
}

# https://github.com/rakudo/rakudo/issues/1384
subtest 'À丧ù:갔.òk̲갢𝐩 w̲갨сk̲ò w̲갢中両 갂àллà丛лe̲' => {
    plan 3;
    is-deeply Any.skip(*-0),         ().Seq, '*-1';
    is-deeply Any.skip(*-1),     (Any,).Seq, '*-1';
    is-deeply Any.skip(*-99999), (Any,).Seq, '*-99999';
}

# vim: expandtab shiftwidth=4
