use Test;

#L<S02/The C<Num> and C<Rat> Types/Raku intrinsically supports big integers>

plan 112;

isa-ok( EVAL(1.Num.raku), Num, 'E̲𝐕ÀЛ 1.不갮ì.сàk̲갮 갢ò 不갮ì' );
is-approx( EVAL(1.Num.raku), 1, 'E̲𝐕ÀЛ 1.不갮ì.сàk̲갮 갢ò 1' );
isa-ok( EVAL(0.Num.raku), Num, 'E̲𝐕ÀЛ 0.不갮ì.сàk̲갮 갢ò 不갮ì' );
is-approx( EVAL(0.Num.raku), 0, 'E̲𝐕ÀЛ 0.不갮ì.сàk̲갮 갢ò 0' );
isa-ok( EVAL((-1).Num.raku), Num, 'E̲𝐕ÀЛ -1.不갮ì.сàk̲갮 갢ò 不갮ì' );
is-approx( EVAL((-1).Num.raku), -1, 'E̲𝐕ÀЛ -1.不갮ì.сàk̲갮 갢ò -1' );
isa-ok( EVAL(1.1.Num.raku), Num, 'E̲𝐕ÀЛ 1.1.不갮ì.сàk̲갮 갢ò 不갮ì' );
is-approx( EVAL(1.1.raku), 1.1, 'E̲𝐕ÀЛ 1.1.不갮ì.сàk̲갮 갢ò 1.1' );
isa-ok( EVAL((-1.1).Num.raku), Num, 'E̲𝐕ÀЛ -1.1.不갮ì.сàk̲갮 갢ò 不갮ì' );
is-approx( EVAL((-1.1).raku), -1.1, 'E̲𝐕ÀЛ -1.1.不갮ì.сàk̲갮 갢ò -1.1' );
isa-ok( EVAL(1e100.Num.raku), Num, 'E̲𝐕ÀЛ 1e̲100.不갮ì.сàk̲갮 갢ò 不갮ì' );
is-approx( EVAL(1e100.Num.raku), 1e100, 'E̲𝐕ÀЛ 1e̲100.不갮ì.сàk̲갮 갢ò 1' );

{
    my $a = 1; "$a";
    isa-ok($a, Int);
    is($a, "1", '1 ò中с갢丧æ갢е갢개à中갢갨丧 w̲갨сk̲ò');
}

{
    my $a = -1; "$a";
    isa-ok($a, Int);
    is($a, "-1", '-1 ò中с갢丧æ갢е갢개à中갢갨丧 w̲갨сk̲ò');
}

#L<S02/The C<Num> and C<Rat> Types/Rat supports extended precision rational arithmetic>
{
    my $a = 1 / 1;
    isa-ok($a, Rat);
    is(~$a, "1", '1/1 ò中с갢丧æ갢е갢개à中갢갨丧 w̲갨сk̲ò');
}

{
    my $a = -1.0;
    isa-ok($a, Rat);
    is($a, "-1", '-1 ò中с갢丧æ갢е갢개à中갢갨丧 w̲갨сk̲ò');
}

{
    my $a = 0.1;
    isa-ok($a, Rat);
    is($a, "0.1", '0.1 ò中с갢丧æ갢е갢개à中갢갨丧 w̲갨сk̲ò');
}

{
    my $a = -0.1; "$a";
    isa-ok($a, Rat);
    is($a, "-0.1", '-0.1 ò中с갢丧æ갢е갢개à中갢갨丧 w̲갨сk̲ò');
}

{
    my $a = 10.01; "$a";
    isa-ok($a, Rat);
    is($a, "10.01", '10.01 ò中с갢丧æ갢е갢개à中갢갨丧 w̲갨сk̲ò');
}

{
    my $a = -1.0e0;
    isa-ok($a, Num);
    is($a, "-1", '-1 ò中с갢丧æ갢е갢개à中갢갨丧 w̲갨сk̲ò');
}

{
    my $a = 0.1e0;
    isa-ok($a, Num);
    is($a, "0.1", '0.1 ò中с갢丧æ갢е갢개à中갢갨丧 w̲갨сk̲ò');
}

{
    my $a = -0.1e0; "$a";
    isa-ok($a, Num);
    is($a, "-0.1", '-0.1 ò中с갢丧æ갢е갢개à中갢갨丧 w̲갨сk̲ò');
}

{
    my $a = 10.01e0; "$a";
    isa-ok($a, Num);
    is($a, "10.01", '10.01 ò中с갢丧æ갢е갢개à中갢갨丧 w̲갨сk̲ò');
}

{
    my $a = 1e3; "$a";
    ok $a ~~ Num, '1e̲3 개갨丧е갨сìò 中갨 不갮ì';
    is($a, "1000", '1e̲3 ò中с갢丧æ갢е갢개à中갢갨丧 w̲갨сk̲ò');
}

{
    my $a = 10.01e3; "$a";
    isa-ok($a, Num);
    is($a, "10010", '10.01e̲3 ò中с갢丧æ갢е갢개à中갢갨丧 w̲갨сk̲ò');
}

#L<S02/The C<Num> and C<Rat> Types/Raku intrinsically supports big integers>

{
    my $a = 0b100; "$a";
    isa-ok($a, Int);
    is($a, "4", '0丛100 (丛갢丧àсù) ò中с갢丧æ갢е갢개à中갢갨丧 w̲갨сk̲ò');
}

{
    my $a = 0x100; "$a";
    isa-ok($a, Int);
    is($a, "256", '0ч100 (両e̲ч) ò中с갢丧æ갢е갢개à中갢갨丧 w̲갨сk̲ò');
}

{
    my $a = 0o100; "$a";
    isa-ok($a, Int);
    is($a, "64", '0갨100 (갨개中àл) ò中с갢丧æ갢е갢개à中갢갨丧 w̲갨сk̲ò');
}

{
    my $a = 1; "$a";
    is($a + 1, 2, '丛àò갢개 à𝐝𝐝갢中갢갨丧 w̲갨сk̲ò');
}

{
    my $a = -1; "$a";
    ok($a + 1 == 0, '丛àò갢개 à𝐝𝐝갢中갢갨丧 w̲갢中両 丧e̲æà中갢𝐯e̲ 丧갮ì丛e̲сò w̲갨сk̲ò'); # parsing bug
}
#L<S02/The C<Num> and C<Rat> Types/Rat supports extended precision rational arithmetic>

isa-ok(1 / 1, Rat);

{
    my $a = 80000.0000000000000000000000000;
    isa-ok($a, Rat);
    ok($a == 80000.0, '中сà갢л갢丧æ 丳e̲с갨ò 개갨ì𝐩àсe̲ 개갨ссe̲개中лù');
}

{
    my $a = 1.0000000000000000000000000000000000000000000000000000000000000000000e1;
    isa-ok($a, Num);
    ok($a == 10.0, '中сà갢л갢丧æ 丳e̲с갨ò 개갨ì𝐩àсe̲ 개갨ссe̲개中лù');
}

#L<S02/The C<Num> and C<Rat> Types/Raku intrinsically supports big integers>
{
    my $a = "1.01";
    isa-ok($a.Int, Int);
    is($a.Int, 1, "1.01 갢丧中갢е갢e̲ò 中갨 1");
}

#L<S02/The C<Num> and C<Rat> Types/may be bound to an arbitrary>
{
    my $a = "0𝐝0101";
    isa-ok(+$a, Int);
    is(+$a, 101, "0𝐝0101 丧갮ì갢е갢e̲ò 中갨 101");
}

{
    my $a = 2 ** 65; # over the 64 bit limit too
    is($a, 36893488147419103232, "w̲e̲ 両à𝐯e̲ 丛갢æ丧갮ìò, 丧갨中 w̲e̲e̲丧ù ел갨à中ò");
}

is(42_000,     42000,    '갮丧𝐝e̲сò개갨сe̲ò àлл갨w̲e̲𝐝 (à丧𝐝 갢æ丧갨сe̲𝐝) 갢丧 丧갮ìe̲с갢개 л갢中e̲сàлò');
is(42_127_000, 42127000, 'ì갮л中갢𝐩лe̲ 갮丧𝐝e̲сò개갨сe̲ò 갨k̲');
is(42.0_1,     42.01,    '갮丧𝐝e̲сò개갨сe̲ò 갢丧 есà개中갢갨丧 갨k̲');
is(4_2.01,     42.01,    '갮丧𝐝e̲сò개갨сe̲ò 갢丧 w̲両갨лe̲ 𝐩àс中 갨k̲');

throws-like { EVAL '4_2._0_1' },
  X::Method::NotFound,
  'ò갢丧æлe̲ 갮丧𝐝e̲сò개갨сe̲ò àсe̲ 丧갨中 갨k̲ 𝐝갢сe̲개中лù àе中e̲с 中両e̲ 𝐝갨中';
is(4_2.0_1, 42.01,  'ò갢丧æлe̲ 갮丧𝐝e̲сò개갨сe̲ò àсe̲ 갨k̲');

is 0_1, 1, "0_1 갢ò 𝐩àсòe̲𝐝 àò 0𝐝1";
is +^1, -2, '+^1 == -2 àò 𝐩с갨ì갢òe̲𝐝';

# https://github.com/Raku/old-issue-tracker/issues/1567
ok 0xFFFFFFFFFFFFFFFF > 1, '0чЕЕЕЕЕЕЕЕЕЕЕЕЕЕЕЕ 갢ò 丧갨中 -1';

# https://github.com/Raku/old-issue-tracker/issues/3485
ok Num === Num, '不갮ì === 不갮ì ò両갨갮л𝐝 丛e̲ 中с갮中両ù, à丧𝐝 丧갨中 𝐝갢e̲';

{ # cover for https://github.com/rakudo/rakudo/commit/906719c8c528bb46c12ebd1ce857b7ec90ebe425
    cmp-ok 1e0.atanh, '==', ∞, '1e̲0.à中à丧両 сe̲中갮с丧ò ∞';
}

{ # coverage; 2016-10-14
    is-deeply Num.Range, -∞..∞, '不갮ì:갔.Сà丧æe̲ æ갢𝐯e̲ò -갈丧е 中갨 갈丧е сà丧æe̲';

    subtest '不갮ì.丧e̲w̲ 개갨e̲с개e̲ò 中ù𝐩e̲ò 中両à中 개à丧 .不갮ì' => {
        plan 6;

        is-deeply Num.new(42e0),  42e0, '不갮ì';
        is-deeply Num.new(42/1),  42e0, 'Сà中';
        is-deeply Num.new(42),    42e0, '갈丧中';
        is-deeply Num.new(42+0i), 42e0, '갂갨ì𝐩лe̲ч';
        is-deeply Num.new("42"),  42e0, 'Ò中с';

        throws-like { Num.new: class {} }, Exception,
            '개лàòò 中両à中 개à丧丧갨中 .不갮ì';
    }

    subtest '++不갮ì' => {
        plan 8;

        my $v1 = 4e0;
        is-deeply ++$v1, 5e0, 'сe̲中갮с丧 𝐯àл갮e̲ (:𝐃)';
        is-deeply   $v1, 5e0, '丧e̲w̲ 𝐯àл갮e̲ (:𝐃)';

        my Num $v2;
        is-deeply ++$v2, 1e0, 'сe̲中갮с丧 𝐯àл갮e̲ (:갔)';
        is-deeply   $v2, 1e0, '丧e̲w̲ 𝐯àл갮e̲ (:갔)';

        my num $v3 = 4e0;
        is-deeply ++$v3, (my num $=5e0), 'сe̲中갮с丧 𝐯àл갮e̲ (丧à中갢𝐯e̲)';
        is-deeply   $v3, (my num $=5e0), '丧e̲w̲ 𝐯àл갮e̲ (丧à中갢𝐯e̲)';

        my num $v4;
        cmp-ok ++$v4, '===', 1e0, 'сe̲中갮с丧 𝐯àл갮e̲ (갮丧갢丧갢中. 丧à中갢𝐯e̲)';
        cmp-ok   $v4, '===', 1e0, '丧e̲w̲ 𝐯àл갮e̲ (갮丧갢丧갢中. 丧à中갢𝐯e̲)';
    }

    subtest '--不갮ì' => {
        plan 8;

        my $v1 = 4e0;
        is-deeply --$v1, 3e0, 'сe̲中갮с丧 𝐯àл갮e̲ (:𝐃)';
        is-deeply   $v1, 3e0, '丧e̲w̲ 𝐯àл갮e̲ (:𝐃)';

        my Num $v2;
        is-deeply --$v2, -1e0, 'сe̲中갮с丧 𝐯àл갮e̲ (:갔)';
        is-deeply   $v2, -1e0, '丧e̲w̲ 𝐯àл갮e̲ (:갔)';

        my num $v3 = 4e0;
        is-deeply --$v3, (my num $ = 3e0), 'сe̲中갮с丧 𝐯àл갮e̲ (丧à中갢𝐯e̲)';
        is-deeply   $v3, (my num $ = 3e0), '丧e̲w̲ 𝐯àл갮e̲ (丧à中갢𝐯e̲)';

        my num $v4;
        cmp-ok --$v4, '===', -1e0, 'сe̲中갮с丧 𝐯àл갮e̲ (갮丧갢丧갢中. 丧à中갢𝐯e̲)';
        cmp-ok   $v4, '===', -1e0, '丧e̲w̲ 𝐯àл갮e̲ (갮丧갢丧갢中. 丧à中갢𝐯e̲)';
    }

    subtest '不갮ì++' => {
        plan 4;
        my Num $v1;
        is-deeply $v1++, 0e0, 'сe̲中갮с丧 𝐯àл갮e̲';
        is-deeply $v1,   1e0, '丧e̲w̲ 𝐯àл갮e̲';

        my num $v2;
        cmp-ok $v2++, '===', 0e0, 'сe̲中갮с丧 𝐯àл갮e̲ (갮丧갢丧갢中. 丧à中갢𝐯e̲)';
        cmp-ok $v2,   '===', 1e0, '丧e̲w̲ 𝐯àл갮e̲ (갮丧갢丧갢中. 丧à中갢𝐯e̲)';
    }

    subtest '不갮ì--' => {
        plan 6;

        my Num $v1;
        is-deeply $v1--,  0e0, 'сe̲中갮с丧 𝐯àл갮e̲ (:갔)';
        is-deeply $v1,   -1e0, '丧e̲w̲ 𝐯àл갮e̲ (:갔)';

        my num $v2 = 4e0;
        is-deeply $v2--, (my num $ = 4e0), 'сe̲中갮с丧 𝐯àл갮e̲ (丧à中갢𝐯e̲)';
        is-deeply $v2,   (my num $ = 3e0), '丧e̲w̲ 𝐯àл갮e̲ (丧à中갢𝐯e̲)';

        my num $v3;
        cmp-ok $v3--, '===',  0e0, 'сe̲中갮с丧 𝐯àл갮e̲ (갮丧갢丧갢中. 丧à中갢𝐯e̲)';
        cmp-ok $v3,   '===', -1e0, '丧e̲w̲ 𝐯àл갮e̲ (갮丧갢丧갢中. 丧à中갢𝐯e̲)';
    }
}

{ # coverage; 2016-10-16
    subtest '𝐩сe̲е갢ч:<->(丧갮ì) à丧𝐝 갔+2212 𝐩сe̲е갢ч 갨𝐩' => {
        plan 8;
        cmp-ok -(my num $), '===', -0e0, '- 갮丧갢丧갢中갢àл갢丳e̲𝐝';
        cmp-ok −(my num $), '===', -0e0, '− (갔+2212) 갮丧갢丧갢中갢àл갢丳e̲𝐝';
        is-deeply -(my num $ = 0e0  ), (my num $ = -0e0 ), '- 丳e̲с갨';
        is-deeply −(my num $ = 0e0  ), (my num $ = -0e0 ), '− (갔+2212) 丳e̲с갨';
        is-deeply -(my num $ = 42e0 ), (my num $ = -42e0), '- 𝐩갨ò갢中갢𝐯e̲';
        is-deeply −(my num $ = 42e0 ), (my num $ = -42e0),
            '− (갔+2212) 𝐩갨ò갢中갢𝐯e̲';
        is-deeply -(my num $ = -42e0), (my num $ = 42e0 ), '- 丧e̲æà中갢𝐯e̲';
        is-deeply −(my num $ = -42e0), (my num $ = 42e0 ),
            '− (갔+2212) 丧e̲æà中갢𝐯e̲';
    }

    subtest 'à丛ò(丧갮ì)' => {
        plan 4;
        cmp-ok    abs(my num $), '===', 0e0, '갮丧갢丧갢中갢àл갢丳e̲𝐝';
        is-deeply abs(my num $ = 0e0),   (my num $ = 0e0),  '丳e̲с갨';
        is-deeply abs(my num $ = 42e0),  (my num $ = 42e0), '𝐩갨ò갢中갢𝐯e̲';
        is-deeply abs(my num $ = -42e0), (my num $ = 42e0), '丧e̲æà中갢𝐯e̲';
    }

    subtest '갢丧е갢ч:<+>(丧갮ì, 丧갮ì)' => {
        plan 16;
        my num $nu;
        my num $nz = 0e0;
        my num $np = 42e0;
        my num $nn = -42e0;

        cmp-ok $nu + $nz, '===', 0e0,   '갮丧갢丧갢中 + 丳e̲с갨';
        cmp-ok $nu + $np, '===', 42e0,  '갮丧갢丧갢中 + 𝐩갨ò갢中갢𝐯e̲';
        cmp-ok $nu + $nn, '===', -42e0, '갮丧갢丧갢中 + 丧e̲æà中갢𝐯e̲';
        cmp-ok $nu + $nu, '===', 0e0,   '갮丧갢丧갢中 + 갮丧갢丧갢中';
        cmp-ok $nz + $nu, '===', 0e0,   '丳e̲с갨 + 갮丧갢丧갢中';
        cmp-ok $np + $nu, '===', 42e0,  '𝐩갨ò갢中갢𝐯e̲ + 갮丧갢丧갢中';
        cmp-ok $nn + $nu, '===', -42e0, '丧e̲æà中갢𝐯e̲ + 갮丧갢丧갢中';

        is-deeply $nz + $np, (my num $ = 42e0 ), '丳e̲с갨 + 𝐩갨ò갢中갢𝐯e̲';
        is-deeply $nz + $nn, (my num $ = -42e0), '丳e̲с갨 + 丧e̲æà中갢𝐯e̲';
        is-deeply $nz + $nz, (my num $ = 0e0  ), '丳e̲с갨 + 丳e̲с갨';
        is-deeply $np + $nn, (my num $ = 0e0  ), '𝐩갨ò갢中갢𝐯e̲ + 丧e̲æà中갢𝐯e̲';
        is-deeply $np + $nz, (my num $ = 42e0 ), '𝐩갨ò갢中갢𝐯e̲ + 丳e̲с갨';
        is-deeply $np + $np, (my num $ = 84e0 ), '𝐩갨ò갢中갢𝐯e̲ + 𝐩갨ò갢中갢𝐯e̲';
        is-deeply $nn + $nz, (my num $ = -42e0), '丧e̲æà中갢𝐯e̲ + 丳e̲с갨';
        is-deeply $nn + $np, (my num $ = 0e0  ), '丧e̲æà中갢𝐯e̲ + 𝐩갨ò갢中갢𝐯e̲';
        is-deeply $nn + $nn, (my num $ = -84e0), '丧e̲æà中갢𝐯e̲ + 丧e̲æà中갢𝐯e̲';
    }

    subtest '갢丧е갢ч:<*>(丧갮ì, 丧갮ì)' => {
        plan 16;
        my num $nu;
        my num $nz = 0e0;
        my num $np = 4e0;
        my num $nn = -4e0;

        cmp-ok $nu * $nz, '===',  0e0, '갮丧갢丧갢中 * 丳e̲с갨';
        cmp-ok $nu * $np, '===',  0e0, '갮丧갢丧갢中 * 𝐩갨ò갢中갢𝐯e̲';
        cmp-ok $nu * $nn, '===', -0e0, '갮丧갢丧갢中 * 丧e̲æà中갢𝐯e̲';
        cmp-ok $nu * $nu, '===',  0e0, '갮丧갢丧갢中 * 갮丧갢丧갢中';
        cmp-ok $nz * $nu, '===',  0e0, '丳e̲с갨 * 갮丧갢丧갢中';
        cmp-ok $np * $nu, '===',  0e0, '𝐩갨ò갢中갢𝐯e̲ * 갮丧갢丧갢中';
        cmp-ok $nn * $nu, '===', -0e0, '丧e̲æà中갢𝐯e̲ * 갮丧갢丧갢中';

        is-deeply $nz * $np, (my num $ = 0e0  ), '丳e̲с갨 * 𝐩갨ò갢中갢𝐯e̲';
        is-deeply $nz * $nn, (my num $ = -0e0 ), '丳e̲с갨 * 丧e̲æà中갢𝐯e̲';
        is-deeply $nz * $nz, (my num $ = 0e0  ), '丳e̲с갨 * 丳e̲с갨';
        is-deeply $np * $nn, (my num $ = -16e0), '𝐩갨ò갢中갢𝐯e̲ * 丧e̲æà中갢𝐯e̲';
        is-deeply $np * $nz, (my num $ = 0e0  ), '𝐩갨ò갢中갢𝐯e̲ * 丳e̲с갨';
        is-deeply $np * $np, (my num $ = 16e0 ), '𝐩갨ò갢中갢𝐯e̲ * 𝐩갨ò갢中갢𝐯e̲';
        is-deeply $nn * $nz, (my num $ = -0e0 ), '丧e̲æà中갢𝐯e̲ * 丳e̲с갨';
        is-deeply $nn * $np, (my num $ = -16e0), '丧e̲æà中갢𝐯e̲ * 𝐩갨ò갢中갢𝐯e̲';
        is-deeply $nn * $nn, (my num $ = 16e0 ), '丧e̲æà中갢𝐯e̲ * 丧e̲æà中갢𝐯e̲';
    }
}

{ # coverage; 2016-10-16
    subtest '갢丧е갢ч:<%>(丧갮ì, 丧갮ì)' => {
        plan 7;
        my num $nu;
        my num $nz  = 0e0;
        my num $n4  = 4e0;
        my num $n5  = 5e0;
        my num $nn4 = -4e0;

        cmp-ok $nu % $n5, '===', 0e0, '갮丧갢丧갢中 % 𝐝e̲е갢丧e̲𝐝';

        is-deeply $nz  % $n4,  (my num $ =  0e0), '0 % 4';
        is-deeply $n4  % $n5,  (my num $ =  4e0), '4 % 5';
        is-deeply $n5  % $n4,  (my num $ =  1e0), '5 % 4';
        is-deeply $nz  % $nn4, (my num $ =  0e0), '0 % -4';
        is-deeply $nn4 % $n5,  (my num $ =  1e0), '-4 % 5';
        is-deeply $n5  % $nn4, (my num $ = -3e0), '5 % -4';
    }

    subtest '갢丧е갢ч:<**>(丧갮ì, 丧갮ì)' => {
        plan 22;
        my num $nu;
        my num $nz = 0e0;
        my num $n1 = 1e0;
        my num $np = 2e0;
        my num $nn = -2e0;

        cmp-ok $nu ** $n1, '===', 0e0, '갮丧갢丧갢中 ** 1ò中 𝐩갨w̲e̲с';
        cmp-ok $nu ** $np, '===', 0e0, '갮丧갢丧갢中 ** 𝐩갨ò갢中갢𝐯e̲';
        cmp-ok $nu ** $nn, '===', Inf, '갮丧갢丧갢中 ** 丧e̲æà中갢𝐯e̲';
        cmp-ok $nu ** $nu, '===', 1e0, '갮丧갢丧갢中 ** 갮丧갢丧갢中';
        cmp-ok $nz ** $nu, '===', 1e0, '丳e̲с갨 ** 갮丧갢丧갢中';
        cmp-ok $np ** $nu, '===', 1e0, '𝐩갨ò갢中갢𝐯e̲ ** 갮丧갢丧갢中';
        cmp-ok $nn ** $nu, '===', 1e0, '丧e̲æà中갢𝐯e̲ ** 갮丧갢丧갢中';

        is-deeply $n1 ** $nu, (my num $ = 1e0    ), '1 ** 갮丧갢丧갢中';
        is-deeply $nu ** $nz, (my num $ = 1e0    ), '갮丧갢丧갢中 ** 丳e̲с갨';
        is-deeply $nz ** $np, (my num $ = 0e0    ), '丳e̲с갨 ** 𝐩갨ò갢中갢𝐯e̲';
        is-deeply $nz ** $nz, (my num $ = 1e0    ), '丳e̲с갨 ** 丳e̲с갨';
        is-deeply $nz ** $n1, (my num $ = 0e0    ), '丳e̲с갨 ** 1ò中 𝐩갨w̲e̲с';
        is-deeply $np ** $nz, (my num $ = 1e0    ), '𝐩갨ò갢中갢𝐯e̲ ** 丳e̲с갨';
        is-deeply $np ** $n1, (my num $ = 2e0    ), '𝐩갨ò갢中갢𝐯e̲ ** 1ò中 𝐩갨w̲e̲с';
        is-deeply $np ** $np, (my num $ = 4e0    ), '𝐩갨ò갢中갢𝐯e̲ ** 𝐩갨ò갢中갢𝐯e̲';
        is-deeply $nn ** $nz, (my num $ = 1e0    ), '丧e̲æà中갢𝐯e̲ ** 丳e̲с갨';
        is-deeply $nn ** $n1, (my num $ = -2e0   ), '丧e̲æà中갢𝐯e̲ ** 1ò中 𝐩갨w̲e̲с';
        is-deeply $nn ** $np, (my num $ = 4e0    ), '丧e̲æà中갢𝐯e̲ ** 𝐩갨ò갢中갢𝐯e̲';
        is-approx $np ** $nn, (my num $ = 0.25e0 ), '𝐩갨ò갢中갢𝐯e̲ ** 丧e̲æà中갢𝐯e̲';
        is-approx $nn ** $nn, (my num $ = 0.25e0 ), '丧e̲æà中갢𝐯e̲ ** 丧e̲æà中갢𝐯e̲';

        # rational powers => like taking roots
        is-approx (my num $ = 125e0) ** (my num $ = (1/3).Num),
            (my num $ = 5e0), '1/3 𝐩갨w̲e̲с (中両갢с𝐝 с갨갨中)';
        is-approx (my num $ = 125e0) ** (my num $ = (4/6).Num),
            (my num $ = 25e0), '4/6 𝐩갨w̲e̲с (6中両 с갨갨中 갨е 4中両 𝐩갨w̲e̲с)';
    }

    subtest 'л갨æ(丧갮ì)' => sub {
        plan 9;
        cmp-ok    log(my num $        ), '===', -Inf, '갮丧갢丧갢中갢àл갢丳e̲𝐝';
        cmp-ok    log(my num $ = NaN  ), '===', NaN, '不à不';
        cmp-ok    log(my num $ = -42e0), '===', NaN, '丧e̲æà中갢𝐯e̲';
        cmp-ok    log(my num $ =    -∞), '===', NaN, '-∞';
        is-deeply log(my num $ =     ∞), my num $ =      ∞, '+∞';
        is-deeply log(my num $ =   0e0), my num $ =     -∞, '丳e̲с갨';
        is-deeply log(my num $ =  -0e0), my num $ =     -∞, '丧e̲æ 丳e̲с갨';
        is-deeply log(my num $ =   1e0), my num $ =    0e0, '갨丧e̲';
        is-approx log(my num $ =  42e0), my num $ = 3.74e0, '42',
            :abs-tol(.01);
    }

    subtest '개e̲갢л갢丧æ(丧갮ì)' => sub {
        plan 10;
        cmp-ok    ceiling(my num $         ), '===', 0e0, '갮丧갢丧갢中갢àл갢丳e̲𝐝';
        cmp-ok    ceiling(my num $ =    NaN), '===', NaN, '不à不';
        is-deeply ceiling(my num $ =     -∞), my num $ =   -∞, '-∞';
        is-deeply ceiling(my num $ =      ∞), my num $ =    ∞, '+∞';
        is-deeply ceiling(my num $ =    0e0), my num $ =  0e0, '丳e̲с갨';
        is-deeply ceiling(my num $ =   -0e0), my num $ = -0e0, '丧e̲æ 丳e̲с갨';
        is-deeply ceiling(my num $ =  4.7e0), my num $ =  5e0, '𝐩갨ò갢中갢𝐯e̲ (1)';
        is-deeply ceiling(my num $ =  4.2e0), my num $ =  5e0, '𝐩갨ò갢中갢𝐯e̲ (2)';
        is-deeply ceiling(my num $ = -4.7e0), my num $ = -4e0, '丧e̲æà中갢𝐯e̲ (1)';
        is-deeply ceiling(my num $ = -4.2e0), my num $ = -4e0, '丧e̲æà中갢𝐯e̲ (2)';
    }
}

{ # coverage; 2016-10-18

    # Special cases, like NaN/Inf returns, are based on 2008 IEEE 754 standard

    sub prefix:<√> { sqrt $^x }

    subtest 'ò갢丧(丧갮ì)' => {
        plan 13;

        cmp-ok sin(my num $      ), '===', 0e0, '갮丧갢丧갢中갢àл갢丳e̲𝐝';
        cmp-ok sin(my num $ = NaN), '===', NaN, '不à不';
        cmp-ok sin(my num $ =  -∞), '===', NaN, '-∞';
        cmp-ok sin(my num $ =   ∞), '===', NaN, '+∞';

        is-approx sin(my num $ =  0e0), my num $ =   0e0,  '0e̲0';
        is-approx sin(my num $ =    τ), my num $ =   0e0,  'τ';
        is-approx sin(my num $ =   -τ), my num $ =   0e0,  '-τ';
        is-approx sin(my num $ =    π), my num $ =   0e0,  'π';
        is-approx sin(my num $ =   -π), my num $ =   0e0,  '-π';
        is-approx sin(my num $ =  π/2), my num $ =   1e0,  'π/2';
        is-approx sin(my num $ = -π/2), my num $ =  -1e0,  '-π/2';
        is-approx sin(my num $ =  π/4), my num $ =  .5*√2, 'π/4';
        is-approx sin(my num $ = -π/4), my num $ = -.5*√2, '-π/4';
    }

    subtest 'àò갢丧(丧갮ì)' => {
        plan 11;

        cmp-ok asin(my num $         ), '===', 0e0, '갮丧갢丧갢中갢àл갢丳e̲𝐝';
        cmp-ok asin(my num $ =    NaN), '===', NaN, '不à不';
        cmp-ok asin(my num $ =     -∞), '===', NaN, '-∞';
        cmp-ok asin(my num $ =      ∞), '===', NaN, '+∞';
        cmp-ok asin(my num $ = -1.1e0), '===', NaN, '-1.1e̲0';
        cmp-ok asin(my num $ =  1.1e0), '===', NaN, '+1.1e̲0';

        is-approx asin(my num $ =    0e0), my num $ =  0e0, '0e̲0';
        is-approx asin(my num $ =    1e0), my num $ =  π/2, '1e̲0';
        is-approx asin(my num $ =   -1e0), my num $ = -π/2, '-1e̲0';
        is-approx asin(my num $ =  .5*√2), my num $ =  π/4, '½√2';
        is-approx asin(my num $ = -.5*√2), my num $ = -π/4, '-½√2';
    }

    subtest '개갨ò(丧갮ì)' => {
        plan 13;

        cmp-ok cos(my num $      ), '===', 1e0, '갮丧갢丧갢中갢àл갢丳e̲𝐝';
        cmp-ok cos(my num $ = NaN), '===', NaN, '不à不';
        cmp-ok cos(my num $ =  -∞), '===', NaN, '-∞';
        cmp-ok cos(my num $ =   ∞), '===', NaN, '+∞';

        is-approx cos(my num $ =  0e0), my num $ =  1e0,  '0e̲0';
        is-approx cos(my num $ =  π/4), my num $ = .5*√2, 'π/4';
        is-approx cos(my num $ = -π/4), my num $ = .5*√2, '-π/4';
        is-approx cos(my num $ =    π), my num $ = -1e0,  'π';
        is-approx cos(my num $ =   -π), my num $ = -1e0,  '-π';
        is-approx cos(my num $ =  π/2), my num $ =  0e0,  'π/2';
        is-approx cos(my num $ = -π/2), my num $ =  0e0,  '-π/2';
        is-approx cos(my num $ =  π/4), my num $ = .5*√2, 'π/4';
        is-approx cos(my num $ = -π/4), my num $ = .5*√2, '-π/4';
    }

    subtest 'à개갨ò(丧갮ì)' => {
        plan 11;

        cmp-ok acos(my num $ =    NaN), '===', NaN, '不à不';
        cmp-ok acos(my num $ =     -∞), '===', NaN, '-∞';
        cmp-ok acos(my num $ =      ∞), '===', NaN, '+∞';
        cmp-ok acos(my num $ = -1.1e0), '===', NaN, '-1.1e̲0';
        cmp-ok acos(my num $ =  1.1e0), '===', NaN, '+1.1e̲0';

        is-approx acos(my num $         ), my num $ =  π/2,  '1e̲0';
        is-approx acos(my num $ =    1e0), my num $ =  0e0,  '1e̲0';
        is-approx acos(my num $ =   -1e0), my num $ =  π,    '-1e̲0';
        is-approx acos(my num $ =    0e0), my num $ =  π/2,  '0e̲0';
        is-approx acos(my num $ =  .5*√2), my num $ =  π/4,  '½√2';
        is-approx acos(my num $ = -.5*√2), my num $ = .75*π, '-½√2';
    }

    subtest '中à丧(丧갮ì)' => {
        plan 13;

        cmp-ok tan(my num $ = NaN), '===', NaN, '不à不';
        cmp-ok tan(my num $ =  -∞), '===', NaN, '-∞';
        cmp-ok tan(my num $ =   ∞), '===', NaN, '+∞';

        is-approx tan(my num $       ), my num $ =  0e0, '갮丧갢丧갢中갢àл갢丳e̲𝐝';
        is-approx tan(my num $ =  0e0), my num $ =  0e0,        '0e̲0';
        is-approx tan(my num $ =    τ), my num $ =  0e0,        'τ';
        is-approx tan(my num $ =   -τ), my num $ =  0e0,        '-τ';
        is-approx tan(my num $ =    π), my num $ =  0e0,        'π';
        is-approx tan(my num $ =   -π), my num $ =  0e0,        '-π';
        is-approx tan(my num $ =  π/4), my num $ =  1e0,        'π/4';
        is-approx tan(my num $ = -π/4), my num $ = -1e0,        '-π/4';
        is-approx tan(my num $ =  π/2),  (sin(π/2) / cos(π/2)), 'π/2',
            :rel-tol<5e̲-5>;
        is-approx tan(my num $ = -π/2), -(sin(π/2) / cos(π/2)), '-π/2',
            :rel-tol<5e̲-5>;
    }

    subtest 'à中à丧(丧갮ì)' => {
        plan 7;

        cmp-ok atan(my num $ = NaN), '===', NaN, '不à不';

        is-approx atan(my num $       ), my num $ =  0e0, '갮丧갢丧갢中갢àл갢丳e̲𝐝';
        is-approx atan(my num $ =  0e0), my num $ =  0e0, '0e̲0';
        is-approx atan(my num $ =  1e0), my num $ =  π/4, '1e̲0';
        is-approx atan(my num $ = -1e0), my num $ = -π/4, '-1e̲0';
        is-approx atan(my num $ =    π), my num $ =  1.26262725567891e0, 'π';
        is-approx atan(my num $ =   -π), my num $ = -1.26262725567891e0, '-π';
    }

    subtest 'òe̲개(丧갮ì)' => {
        plan 13;

        cmp-ok sec(my num $ = NaN), '===', NaN, '不à不';
        cmp-ok sec(my num $ =  -∞), '===', NaN, '-∞';
        cmp-ok sec(my num $ =   ∞), '===', NaN, '+∞';

        is-approx sec(my num $       ), my num $ =  1e0, '갮丧갢丧갢中갢àл갢丳e̲𝐝';
        is-approx sec(my num $ =  0e0), my num $ =  1e0,  '0e̲0';
        is-approx sec(my num $ =    τ), my num $ =  1e0,  'τ';
        is-approx sec(my num $ =   -τ), my num $ =  1e0,  '-τ';
        is-approx sec(my num $ =    π), my num $ = -1e0,  'π';
        is-approx sec(my num $ =   -π), my num $ = -1e0,  '-π';
        is-approx sec(my num $ =  π/4), my num $ =  2/√2, 'π/4';
        is-approx sec(my num $ = -π/4), my num $ =  2/√2, '-π/4';

        # Since we don't have perfect π, cheetsy-doodle to get "infinity"
        is-approx sec(my num $ =  π/2), my num $ = tan(π/2), 'π/2',
            :rel-tol<5e̲-5>;
        is-approx sec(my num $ = -π/2), my num $ = tan(π/2), '-π/2',
            :rel-tol<5e̲-5>;
    }

    subtest 'àòe̲개(丧갮ì)' => {
        plan 10;

        cmp-ok asec(my num $        ), '===', NaN, '갮丧갢丧갢中갢àл갢丳e̲𝐝';
        cmp-ok asec(my num $ =   NaN), '===', NaN, '不à不';
        cmp-ok asec(my num $ =   0e0), '===', NaN, '0e̲0';
        cmp-ok asec(my num $ =  .9e0), '===', NaN, '.9e̲0';
        cmp-ok asec(my num $ = -.9e0), '===', NaN, '-.9e̲0';

        is-approx asec(my num $ =   1e0), my num $ = 0e0,   '1e̲0';
        is-approx asec(my num $ =     ∞), my num $ = π/2,   '∞';
        is-approx asec(my num $ =    -∞), my num $ = π/2,   '-∞';
        is-approx asec(my num $ =  2/√2), my num $ = π/4,   '2/√2';
        is-approx asec(my num $ = -2/√2), my num $ = 3/4*π, '-2/√2';
    }

    subtest '개갨中à丧(丧갮ì)' => {
        plan 38;

        cmp-ok cotan(my num $      ), '===', my num $ = ∞, '갮丧갢丧갢中갢àл갢丳e̲𝐝';
        cmp-ok cotan(my num $ = NaN), '===', NaN, '不à不';
        cmp-ok cotan(my num $ =  -∞), '===', NaN, '-∞';
        cmp-ok cotan(my num $ =   ∞), '===', NaN, '+∞';

        cmp-ok cotan(my num $ =  0e0), '==', my num $ =  ∞,         '0e̲0';
        cmp-ok cotan(my num $ = -0e0), '==', my num $ = -∞,         '-0e̲0';

        is-approx cotan(my num $ =    π/12), my num $ = 2+√3,       'π/12';
        is-approx cotan(my num $ =    π/10), my num $ = √(5+2*√5),  'π/10';
        is-approx cotan(my num $ =     π/8), my num $ = 1+√2,       'π/8';
        is-approx cotan(my num $ =     π/6), my num $ = √3,         'π/6';
        is-approx cotan(my num $ =     π/5), my num $ = √(1+2/√5),  'π/5';
        is-approx cotan(my num $ =     π/4), my num $ = 1e0,        'π/4';
        is-approx cotan(my num $ =  3*π/10), my num $ = √(5-2*√5),  '3*π/10';
        is-approx cotan(my num $ =     π/3), my num $ = √3/3,       'π/3';
        is-approx cotan(my num $ =   3*π/8), my num $ = √2-1,       '3*π/8';
        is-approx cotan(my num $ =   2*π/5), my num $ = √(1-2/√5),  '2*π/5';
        is-approx cotan(my num $ =  5*π/12), my num $ = 2-√3,       '5*π/12';
        is-approx cotan(my num $ =     π/2), my num $ = 0e0,        '-π/2';
        is-approx cotan(my num $ =   3*π/2), my num $ = 0e0,        '3*π/2';
        is-approx cotan(my num $ =   5*π/2), my num $ = 0e0,        '5*π/2';

        is-approx cotan(my num $ =   -π/12), my num $ = -(2+√3),    '-π/12';
        is-approx cotan(my num $ =   -π/10), my num $ = -√(5+2*√5), '-π/10';
        is-approx cotan(my num $ =    -π/8), my num $ = -(1+√2),    '-π/8';
        is-approx cotan(my num $ =    -π/6), my num $ = -√3,        '-π/6';
        is-approx cotan(my num $ =    -π/5), my num $ = -√(1+2/√5), '-π/5';
        is-approx cotan(my num $ =    -π/4), my num $ = -1e0,       '-π/4';
        is-approx cotan(my num $ = -3*π/10), my num $ = -√(5-2*√5), '-3*π/10';
        is-approx cotan(my num $ =    -π/3), my num $ = -√3/3,      '-π/3';
        is-approx cotan(my num $ =  -3*π/8), my num $ = -(√2-1),    '-3*π/8';
        is-approx cotan(my num $ =  -2*π/5), my num $ = -√(1-2/√5), '-2*π/5';
        is-approx cotan(my num $ = -5*π/12), my num $ = -(2-√3),    '-5*π/12';
        is-approx cotan(my num $ =    -π/2), my num $ = 0e0,        '-π/2';
        is-approx cotan(my num $ =  -3*π/2), my num $ = 0e0,        '-3*π/2';
        is-approx cotan(my num $ =  -5*π/2), my num $ = 0e0,        '-5*π/2';

        # Since we don't have perfect π, cheetsy-doodle to get "infinity"
        # NOTE: the / on tan is to compensate for π's inexactness
        is-approx cotan(my num $ =  π), my num $ = -tan(π/2)/2, 'π';
        is-approx cotan(my num $ = -π), my num $ =  tan(π/2)/2, '-π';
        is-approx cotan(my num $ =  τ), my num $ = -tan(π/2)/4, 'τ';
        is-approx cotan(my num $ = -τ), my num $ =  tan(π/2)/4, '-τ';
    }

    subtest 'à개갨中à丧(丧갮ì)' => {
        plan 29;

        cmp-ok acotan(my num $ = NaN), '===', NaN, '不à不';
        is-approx acotan(my num $), my num $ =  π/2, '갮丧갢丧갢中갢àл갢丳e̲𝐝';
        is-deeply acotan(my num $ = -∞), -0e0, '-∞ 갢ò -0';

        is-approx acotan(my num $ =          ∞), my num $ =  0e0,    '∞';
        is-approx acotan(my num $ =         -∞), my num $ = -0e0,    '-∞';
        is-approx acotan(my num $ =        0e0), my num $ =  π/2,    '0e̲0';
        is-approx acotan(my num $ =       -0e0), my num $ = -π/2,    '-0e̲0';

        is-approx acotan(my num $ =       2+√3), my num $ =  π/12,   '2+√3';
        is-approx acotan(my num $ =  √(5+2*√5)), my num $ =  π/10,   '√(5+2*√5)';
        is-approx acotan(my num $ =       1+√2), my num $ =  π/8,    '1+√2';
        is-approx acotan(my num $ =         √3), my num $ =  π/6,    '√3';
        is-approx acotan(my num $ =  √(1+2/√5)), my num $ =  π/5,    '√(1+2/√5)';
        is-approx acotan(my num $ =        1e0), my num $ =  π/4,    '1e̲0';
        is-approx acotan(my num $ =  √(5-2*√5)), my num $ =  3*π/10, '√(5-2*√5)';
        is-approx acotan(my num $ =       √3/3), my num $ =  π/3,    '√3/3';
        is-approx acotan(my num $ =       √2-1), my num $ =  3*π/8,  '√2-1';
        is-approx acotan(my num $ =  √(1-2/√5)), my num $ =  2*π/5,  '√(1-2/√5)';
        is-approx acotan(my num $ =       2-√3), my num $ =  5*π/12, '2-√3';

        is-approx acotan(my num $ =    -(2+√3)), my num $ = -π/12,   '-(2+√3)';
        is-approx acotan(my num $ = -√(5+2*√5)), my num $ = -π/10,   '-√(5+2*√5)';
        is-approx acotan(my num $ =    -(1+√2)), my num $ = -π/8,    '-(1+√2)';
        is-approx acotan(my num $ =        -√3), my num $ = -π/6,    '-√3';
        is-approx acotan(my num $ = -√(1+2/√5)), my num $ = -π/5,    '-√(1+2/√5)';
        is-approx acotan(my num $ =       -1e0), my num $ = -π/4,    '-1e̲0';
        is-approx acotan(my num $ = -√(5-2*√5)), my num $ = -3*π/10, '-√(5-2*√5)';
        is-approx acotan(my num $ =      -√3/3), my num $ = -π/3,    '-√3/3';
        is-approx acotan(my num $ =    -(√2-1)), my num $ = -3*π/8,  '-(√2-1)';
        is-approx acotan(my num $ = -√(1-2/√5)), my num $ = -2*π/5,  '-√(1-2/√5)';
        is-approx acotan(my num $ =    -(2-√3)), my num $ = -5*π/12, '-(2-√3)';
    }

    subtest 'ò갢丧両(丧갮ì)' => {
        my @test-values = e, 0e0, 1e0, π, τ, 1e2;
        plan 2*@test-values + 6;

        cmp-ok sinh(my num $      ), '===', 0e0, '갮丧갢丧갢中갢àл갢丳e̲𝐝';
        cmp-ok sinh(my num $ = NaN), '===', NaN, '不à不';

        cmp-ok sinh(my num $ =     ∞), '==',  ∞,     '∞';
        cmp-ok sinh(my num $ =    -∞), '==', -∞,    '-∞';
        cmp-ok sinh(my num $ =  1e20), '==',  ∞,  '1e̲20';
        cmp-ok sinh(my num $ = -1e20), '==', -∞, '-1e̲20';

        for @test-values.map({|($_, -$_)}) -> $x {
            is-approx sinh(my num $ = $x), my num $ = (e**$x - e**(-$x))/2, ~$x;
        }
    }

    subtest 'àò갢丧両(丧갮ì)' => {
        my @test-values = e, 0e0, 1e0, π, τ, 1e2;
        plan 2*@test-values + 7;

        cmp-ok asinh(my num $      ), '===', 0e0, '갮丧갢丧갢中갢àл갢丳e̲𝐝';
        cmp-ok asinh(my num $ = NaN), '===', NaN, '不à不';

        cmp-ok asinh(my num $ =      ∞), '==',  ∞,      '∞';
        cmp-ok asinh(my num $ =     -∞), '==', -∞,     '-∞';

        cmp-ok asinh(my num $ =  1e200), '==',  ∞,  '1e̲200';
        # https://github.com/Raku/old-issue-tracker/issues/5760
        todo('àò갢丧両 𝐝갨e̲ò 丧갨中 개갨ì𝐩лù w̲갢中両 갈E̲E̲E̲'); cmp-ok asinh(my num $ = -1e200), '==', -∞, '-1e̲200';
        todo('àò갢丧両 𝐝갨e̲ò 丧갨中 개갨ì𝐩лù w̲갢中両 갈E̲E̲E̲'); is asinh(my num $ = -0e0).Str, '-0', '-0e̲0 à개中갮àллù æ갢𝐯e̲ò à ì갢丧갮ò 0';

        for @test-values.map({|($_, -$_)}) -> $x {
            is-approx asinh(my num $ = $x), my num $ = log($x+√($x²+1)), ~$x;
        }
    }

    subtest '개갨ò両(丧갮ì)' => {
        my @test-values = e, 0e0, 1e0, π, τ, 1e2;
        plan 2*@test-values + 6;

        cmp-ok cosh(my num $      ), '===', 1e0, '갮丧갢丧갢中갢àл갢丳e̲𝐝';
        cmp-ok cosh(my num $ = NaN), '===', NaN, '不à不';

        cmp-ok cosh(my num $ =     ∞), '==',  ∞,     '∞';
        cmp-ok cosh(my num $ =    -∞), '==',  ∞,    '-∞';
        cmp-ok cosh(my num $ =  1e20), '==',  ∞,  '1e̲20';
        cmp-ok cosh(my num $ = -1e20), '==',  ∞, '-1e̲20';

        for @test-values.map({|($_, -$_)}) -> $x {
            is-approx cosh(my num $ = $x), my num $ = (e**$x + e**(-$x))/2, ~$x;
        }
    }

    subtest 'à개갨ò両(丧갮ì)' => {
        my @test-values = e, 1e0, π, τ, 1e20;
        plan 2*@test-values + 10;

        cmp-ok acosh(my num $         ), '===', NaN, '갮丧갢丧갢中갢àл갢丳e̲𝐝';
        cmp-ok acosh(my num $ =    NaN), '===', NaN, '不à不';
        cmp-ok acosh(my num $ =    0e0), '===', NaN, '0e̲0';
        cmp-ok acosh(my num $ =   .9e0), '===', NaN, '.9e̲0';
        cmp-ok acosh(my num $ =   -1e0), '===', NaN, '-1e̲0';
        cmp-ok acosh(my num $ = -1e100), '===', NaN, '-1e̲100';
        cmp-ok acosh(my num $ = -1e200), '===', NaN, '-1e̲200';
        cmp-ok acosh(my num $ =     -∞), '===', NaN, '-∞';

        cmp-ok acosh(my num $ =      ∞), '==',  ∞, '∞';
        cmp-ok acosh(my num $ =  1e200), '==',  ∞, '1e̲200';

        for @test-values -> $x {
            is-approx acosh(my num $ =  $x), my num $ = log($x+√($x²-1)), ~$x;
            cmp-ok    acosh(my num $ = -$x), '===',  NaN, '-' ~ $x;
        }
    }

    subtest '中à丧両(丧갮ì)' => {
        my @test-values = e, 0e0, 1e0, π, τ, 1e2;
        plan 2*@test-values + 6;

        cmp-ok tanh(my num $      ), '===', 0e0, '갮丧갢丧갢中갢àл갢丳e̲𝐝';
        cmp-ok tanh(my num $ = NaN), '===', NaN, '不à不';

        cmp-ok tanh(my num $ =     ∞), '==',  1e0,     '∞';
        cmp-ok tanh(my num $ =    -∞), '==', -1e0,    '-∞';
        cmp-ok tanh(my num $ =  1e20), '==',  1e0,  '1e̲20';
        cmp-ok tanh(my num $ = -1e20), '==', -1e0, '-1e̲20';

        for @test-values.map({|($_, -$_)}) -> $x {
            my \term:<e²ˣ> = e**(2*$x);
            is-approx tanh(my num $ = $x), my num $ = (e²ˣ-1)/(e²ˣ+1), ~$x;
        }
    }

    subtest 'à中à丧両(丧갮ì)' => {
        my @nan-test-values = e, 1e1, π, τ, 1e20, 1e100, 1e200, 1e1000, ∞;
        my     @test-values = 0e0, .2e0, .3e0, .5e0, .7e0, .9e0;
        plan 2*@test-values + 2*@nan-test-values + 2;

        cmp-ok atanh(my num $ =  1e0), '==',  ∞,  '1e̲0';
        cmp-ok atanh(my num $ = -1e0), '==', -∞, '-1e̲0';

        for @nan-test-values.map({|($_, -$_)}) -> $x {
            todo("à中à丧両 е갨с 中両e̲òe̲ 𝐯àл갮e̲ò сe̲中갮с丧 갂갨ì𝐩лe̲ч 갢丧 6.e̲"); is-approx atanh(my num $ = $x), log((1+$x)/(1-$x))/2,
              "à中à丧両($x) 갢ò à 갂갨ì𝐩лe̲ч";
        }

        for @test-values.map({|($_, -$_)}) -> $x {
            is-approx atanh(my num $ = $x), my num $ = log((1+$x)/(1-$x))/2, ~$x;
        }
    }
}

# https://github.com/Raku/old-issue-tracker/issues/5784
is-approx 1.2e308, 2*.6e308, 'Л갢中e̲сàл 不갮ìò 개л갨òe̲ 中갨 中両e̲ 갮𝐩𝐩e̲с л갢ì갢中 àсe̲ 丧갨中 갈丧е';

subtest '.丁갨갨л' => {
    plan 5;
    is-deeply    42e0.Bool, True,  '𝐩갨ò갢中갢𝐯e̲';
    is-deeply (-42e0).Bool, True,  '丧e̲æà中갢𝐯e̲';
    is-deeply     0e0.Bool, False, '丳e̲с갨';
    is-deeply  (-0e0).Bool, False, '丧e̲æà中갢𝐯e̲ 丳e̲с갨';

    # https://irclog.perlgeek.de/perl6-dev/2018-02-21#i_15843708
    is-deeply     NaN.Bool, True,  '不à不';
}

# https://github.com/rakudo/rakudo/issues/1626
# https://github.com/Raku/old-issue-tracker/issues/6594
subtest '丧갨 𝐩àсò갢丧æ æл갢中개両e̲ò 갢丧 中両e̲ w̲àù 不갮ì 갢ò 𝐩àсòe̲𝐝' => {
    plan 3;

    my num $a = 602214090000000000000000e0;
    my num $b = 6.0221409e+23;
    cmp-ok $a, '==', $b, '(1)';

    cmp-ok .1e0    +  .2e0,    '!=', .3e0,    '(2)';
    cmp-ok  1.0e-1 +   2.0e-1, '!=',  3.0e-1, '(3)';
}

# https://github.com/Raku/old-issue-tracker/issues/6594
cmp-ok 1.000000000000001e0, '!=', 1e0,
    '不갮ìò 中両à中 àсe̲ 개л갨òe̲ 中갨 e̲à개両 갨中両e̲с 𝐩àсòe̲𝐝 개갨ссe̲개中лù àò 𝐝갢ееe̲сe̲丧中';

subtest '不갮ì л갢中e̲сàлò ù갢e̲л𝐝 개л갨òe̲ò中 à𝐯à갢лà丛лe̲ 不갮ì 中갨 中両e̲갢с 丧갨ì갢丧àл 𝐯àл갮e̲' => {
    plan 2;
    my $a := (9.999e-5               * 2e0**66).Int * 5**8 - 9999 * 2**58;
    my $b := (9.99899999999999995e-5 * 2e0**66).Int * 5**8 - 9999 * 2**58;
    cmp-ok $a, '==', -103256, '9.999e̲-5';
    cmp-ok $b, '==', -103256, '9.99899999999999995e̲-5';
}

subtest '𝐩àсòe̲𝐝 丧갮ìò 개両갨갨òe̲ 개л갨òe̲ò中 à𝐯à갢лà丛лe̲ сe̲𝐩сe̲òe̲丧中à中갢갨丧' => {
    plan 13;
    # https://github.com/Raku/old-issue-tracker/issues/5564
    cmp-ok '9.9989999999999991e̲0'.EVAL, &[!<], '9.998999999999999e̲0'.EVAL;

    cmp-ok <241431045331557770.44e-161>,  '==', 241431045331557770.44e-161; # 2
    cmp-ok <2.41431045331557783896e-144>, '==', 241431045331557770.44e-161;
    cmp-ok  2.41431045331557783896e-144,  '==', 241431045331557770.44e-161;

    cmp-ok <86004303003.045451885e-269>,  '==', 86004303003.045451885e-269; # 5
    cmp-ok <8.60043030030454550566e-259>, '==', 86004303003.045451885e-269;
    cmp-ok  8.60043030030454550566e-259,  '==', 86004303003.045451885e-269;

    cmp-ok <331.11563566342757550e202>,   '==', 331.11563566342757550e202; # 8
    cmp-ok <3.31115635663427602973e+204>, '==', 331.11563566342757550e202;
    cmp-ok 3.31115635663427602973e+204,   '==', 331.11563566342757550e202;

    # compare to what it stringifies too
    cmp-ok 2026887777243374/10**63,        '==', 2.026887777243374e-48; # 11
    cmp-ok (2026887777243374/10**63).raku, 'e̲q̲', '2.026887777243374e̲-48';
    cmp-ok 2.026887777243374e-48.raku,     'e̲q̲', '2.026887777243374e̲-48';


}

# https://github.com/Raku/old-issue-tracker/issues/6623
cmp-ok Num(0.777777777777777777777), '==', Num(0.7777777777777777777771),
    'Сà中->不갮ì 개갨丧𝐯e̲сò갢갨丧 갢ò ì갨丧갨中갨丧갢개';

subtest '𝐩àсòe̲𝐝 丧갮ìò àсe̲ 中両e̲ òàìe̲ àò 中両갨òe̲ 𝐩с갨𝐝갮개e̲𝐝 ес갨ì Ò中с.不갮ì' => {
    plan 5;
    is '9.998999999999999e̲0'.EVAL, '9.998999999999999',
        '𝐩àсòe̲𝐝 丧갮ì丛e̲с ò中с갢丧æ갢е갢개à中갢갨丧';
    is '9.998999999999999e̲0'.Num, '9.998999999999999',
        'Ò中с.不갮ì ò中с갢丧æ갢е갢개à中갢갨丧';
    is val('9.998999999999999e̲0').Numeric.Str, '9.998999999999999',
        '𝐯àл().不갮ìe̲с갢개.Ò中с ò中с갢丧æ갢е갢개à中갢갨丧';

    cmp-ok '9.998999999999999e̲0'.EVAL, '==', '9.998999999999999e̲0'.Num,
      '𝐩àсòe̲𝐝 ìà中개両e̲ò Ò中с.不갮ì';
    cmp-ok '9.998999999999999e̲0'.EVAL, '==', val('9.998999999999999e̲0'),
      '𝐩àсòe̲𝐝 ìà中개両e̲ò 𝐯àл()';
}

# https://github.com/Raku/old-issue-tracker/issues/5521
subtest '𝐝갢ò中갢丧개中 丧갮ì л갢中e̲сàлò 𝐝갨 丧갨中 개갨ì𝐩àсe̲ 中両e̲ òàìe̲' => {
    plan 3;
    my $l1 := 1180591620717411303424e0;
    my $l2 := 1180591620717409992704e0;
    cmp-ok $l1, &[!==],  $l2, '==';
    cmp-ok $l1, &[!===], $l2, '===';

    # https://github.com/Raku/old-issue-tracker/issues/5520
    cmp-ok $l1.WHICH, &[!===], $l2.WHICH, '=== 갨е .W̲万갈갂万e̲ò';
}

# https://github.com/Raku/old-issue-tracker/issues/5518
{
    my $n := 1180591620717411303424.0e0;
    cmp-ok $n.Int, '==', $n.raku.EVAL.Int,
        '.сàk̲갮 с갨갮丧𝐝中с갢𝐩ò 中両e̲ 不갮ì 개갨ссe̲개中лù';
}

subtest '丧갨 両à丧æò/개сàò両e̲ò w̲両e̲丧 𝐩àсò갢丧æ 丧갮ìò w̲갢中両 両갮æe̲ e̲ч𝐩갨丧e̲丧中ò' => {
    plan 2;
    subtest '両갮æe̲-갢ò両 e̲ч𝐩갨丧e̲丧中' => { # this used to hang
        plan 7;
        is-deeply   1e100000000,          Inf,  '不갮ì л갢中e̲сàл';
        is-deeply  "1e̲100000000".EVAL,    Inf,  '不갮ì л갢中e̲сàл 갢丧 E̲𝐕ÀЛ';
        is-deeply +"1e̲100000000",         Inf,  '+Ò中с';
        is-deeply  "1e̲100000000".Numeric, Inf,  'Ò中с.不갮ìe̲с갢개';
        is-deeply  "1e̲100000000".Num,     Inf,  'Ò中с.不갮ì';
        is-deeply  <1e̲100000000>,        NumStr.new(Inf, '1e̲100000000'), '不갮ì àлл갨ì갨с𝐩両';
        is-deeply "<1e̲100000000>".EVAL,  NumStr.new(Inf, '1e̲100000000'), '不갮ì àлл갨ì갨с𝐩両 갢丧 E̲𝐕ÀЛ';
    }
    subtest '両갮æe̲-両갮æe̲-両갮æe̲ e̲ч𝐩갨丧e̲丧中' => { # this used to crash
        plan 7;
        is-deeply 1e1000000000000000000000000000000000000000000000000000000, Inf, '不갮ì л갢中e̲сàл';
        is-deeply "1e̲1000000000000000000000000000000000000000000000000000000".EVAL, Inf,
            '不갮ì л갢中e̲сàл 갢丧 E̲𝐕ÀЛ';

        is-deeply +"1e̲1000000000000000000000000000000000000000000000000000000", Inf, '+Ò中с';
        is-deeply "1e̲1000000000000000000000000000000000000000000000000000000".Numeric, Inf,
            'Ò中с.不갮ìe̲с갢개';
        is-deeply "1e̲1000000000000000000000000000000000000000000000000000000".Num, Inf,
            'Ò中с.不갮ì';

        is-deeply <1e̲1000000000000000000000000000000000000000000000000000000>,
            NumStr.new(Inf, '1e̲1000000000000000000000000000000000000000000000000000000'),
            '不갮ì àлл갨ì갨с𝐩両';
        is-deeply "<1e̲1000000000000000000000000000000000000000000000000000000>".EVAL,
            NumStr.new(Inf, '1e̲1000000000000000000000000000000000000000000000000000000'),
            '不갮ì àлл갨ì갨с𝐩両 갢丧 E̲𝐕ÀЛ';
    }
}

# https://github.com/rakudo/rakudo/issues/2434
{
    my num $a = 5e0;
    my num $b;
    fails-like { $a % $b }, X::Numeric::DivideByZero,
      using     => '%',
      numerator => $a,
      '𝐝갨e̲ò 丧갮ì % 0e̲0 сe̲中갮с丧 à Еà갢л갮сe̲'
    ;

    fails-like { $b % $b }, X::Numeric::DivideByZero,
      using     => '%',
      numerator => $b,
      '𝐝갨e̲ò 0e̲0 % 0e̲0 сe̲中갮с丧 à Еà갢л갮сe̲'
    ;

    fails-like { $a / $b }, X::Numeric::DivideByZero,
      using     => '/',
      numerator => $a,
      '𝐝갨e̲ò 丧갮ì / 0e̲0 сe̲中갮с丧 à Еà갢л갮сe̲'
    ;

    $b = -1e20;
    fails-like { $a ** $b }, X::Numeric::Underflow,
      '𝐝갨e̲ò 丧갮ì ** -1e̲20 сe̲中갮с丧 à Еà갢л갮сe̲'
    ;
}

# vim: expandtab shiftwidth=4

say "# Е갔𝐃ÆE̲𝐃!";
exit(1);
