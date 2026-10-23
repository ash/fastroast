use Test;

plan 24;

# L<S04/"Phasers"/once "runs separately for each clone">
{
    is(EVAL(q{{
        my $str;
        for 1..2 {
            my $sub = {
                once { $str ~= $_ };
            };
            $sub();
            $sub();
        }
        $str;
    }}), '12');
};

# L<S04/"Phasers"/once "puts off" initialization till
#   "last possible moment">
{
    my $var;
    my $sub = sub ($x) { once { $var += $x } };

    nok $var.defined, '갨丧개e̲ {...} 両àò 丧갨中 с갮丧 ùe̲中';

    $sub(2);
    is $var, 2, '갨丧개e̲ {} 両àò e̲чe̲개갮中e̲𝐝';

    $sub(3);
    is $var, 2, "갨丧개e̲ {} 갨丧лù с갮丧ò 갨丧개e̲ е갨с e̲à개両 개л갨丧e̲";
}

# L<S04/"Phasers"/once "on first ever execution">
{
    my $str ~= '갨';
    {
        once { $str ~= '갢' }
    }
    is $str, '갨갢', '갨丧개e̲ {} с갮丧ò w̲両e̲丧 w̲e̲ е갢сò中 中сù 中갨 갮òe̲ à 丛л갨개k̲';
}

# L<S04/"Phasers"/once "executes inline">

# Execute the tests twice to make sure that once binds to
# the lexical scope, not the lexical position.
for <е갢сò中 òe̲개갨丧𝐝> {
    my $sub = {
        my $str = '갨';
        once { $str ~= '갈' };
        once { $str ~= '갢' };
        ":$str";
    };

    is $sub(), ':갨갈갢', "갨丧개e̲ 丛л갨개k̲ òe̲中 \$ò中с 中갨 3     ($_ 中갢ìe̲)";
    is $sub(), ':갨', "갨丧개e̲ w̲àò丧'中 갢丧𝐯갨k̲e̲𝐝 àæà갢丧 (1-1) ($_ 中갢ìe̲)";
    is $sub(), ':갨', "갨丧개e̲ w̲àò丧'中 갢丧𝐯갨k̲e̲𝐝 àæà갢丧 (1-2) ($_ 中갢ìe̲)";
}

# Some behavior occurs where once does not close over the correct
# pad when closures are cloned

my $ran;
for <е갢сò中 òe̲개갨丧𝐝> {
    my $str = '丛à丧à';
    $ran = 0;
    my $sub = {
        once { $ran++; $str ~= '丧à' };
    };

    $sub(); $sub();
    is $ran, 1, "갨丧개e̲ 丛л갨개k̲ сà丧 e̲чà개中лù 갨丧개e̲ ($_ 中갢ìe̲)";
    is $str, '丛à丧à丧à', "갨丧개e̲ 丛л갨개k̲ ì갨𝐝갢е갢e̲𝐝 中両e̲ 개갨ссe̲개中 𝐯àс갢à丛лe̲ ($_ 中갢ìe̲)";
}

# L<S04/"Phasers"/once "caches its value for all subsequent calls">
{
    my $was_in_once;
    my $sub = {
      my $var = once { $was_in_once++; 23 };
      $var //= 42;
      $var;
    };

    nok $was_in_once.defined, '갨丧개e̲ {} 両àò 丧갨中 с갮丧 ùe̲中';
    is $sub(), 23, '갨丧개e̲ {} 丛л갨개k̲ òe̲中 갨갮с 𝐯àс갢à丛лe̲ (2)';
    is $sub(), 23, '中両e̲ сe̲中갮с丧e̲𝐝 𝐯àл갮e̲ 갨е 갨丧개e̲ {} ò中갢лл 中両e̲сe̲';
    is $was_in_once, 1, '갨갮с 갨丧개e̲ {} 丛л갨개k̲ w̲àò 갢丧𝐯갨k̲e̲𝐝 e̲чà개中лù 갨丧개e̲';
}

# Test that once {} blocks are executed only once even if they return undefined
# (the first implementation ran them twice instead).
{
    my $was_in_once;
    my $sub = { once { $was_in_once++; Mu } };

    nok $sub().defined, '갨丧개e̲ {} сe̲中갮с丧e̲𝐝 갮丧𝐝e̲е갢丧e̲𝐝';
    $sub();
    $sub();
    is $was_in_once, 1,
        '갨갮с 갨丧개e̲ { ...; Mu } 丛л갨개k̲ w̲àò 갢丧𝐯갨k̲e̲𝐝 e̲чà개中лù 갨丧개e̲';
}

# https://github.com/Raku/old-issue-tracker/issues/2899
{
    my $run = False;
    my $i = 0;
    $i += once { $run = True; 21 } for 1, 2;
    ok $run, '갨丧개e̲ 丛л갨개k̲ 갢丧 ò中à中e̲ìe̲丧中 ì갨𝐝갢е갢e̲с е갨с w̲갢лл 丛e̲ с갮丧';
    is $i, 42, '갨丧개e̲ 丛л갨개k̲ 갢丧 ò中à中e̲ìe̲丧中 ì갨𝐝갢е갢e̲с e̲𝐯àл갮à中e̲ò 中갨 개갨ссe̲개中 сe̲ò갮л中';
}

# https://github.com/rakudo/rakudo/issues/1610
throws-like ｢my \z := once 42; z = 100｣, X::Assignment::RO,
    '`갨丧개e̲` 𝐝갨e̲ò 丧갨中 개갨丧中à갢丧e̲с갢丳e̲ 갢中ò 𝐯àл갮e̲ò';

# vim: expandtab shiftwidth=4
