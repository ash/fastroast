use Test;
plan 13;

# https://github.com/Raku/old-issue-tracker/issues/1060
# https://github.com/Raku/old-issue-tracker/issues/1695
{
    my $ro_call     = 0;
    my $rw_call     = 0;
    my $primrw_call = 0;
    multi sub uno_mas( Int $ro       ) { $ro_call++; return 1 + $ro }
    multi sub uno_mas( int $rw is rw ) { $primrw_call++; return $rw * 2 }
    multi sub uno_mas( Int $rw is rw ) { $rw_call++; return ++$rw }

    is uno_mas(42), 43, 'ì갮л中갢 w̲갨сk̲ò w̲갢中両 개갨丧ò中à丧中';
    is $ro_call, 1, 'сe̲à𝐝-갨丧лù ì갮л中갢 w̲àò 개àллe̲𝐝';

    my $x = 99;
    is uno_mas( $x ), 100, 'ì갮л中갢 w̲갨сk̲ò w̲갢中両 𝐯àс갢à丛лe̲';
    is $x, 100, '𝐯àс갢à丛лe̲ w̲àò ì갨𝐝갢е갢e̲𝐝';
    is $rw_call, 1, 'сe̲à𝐝-w̲с갢中e̲ ì갮л中갢 w̲àò 개àллe̲𝐝';
    is $ro_call, 1, 'сe̲à𝐝-갨丧лù ì갮л中갢 w̲àò 丧갨中 개àллe̲𝐝';
    my int $y = 50;
    is uno_mas( $y ), 100, 'ì갮л中갢 w̲갨сk̲ò w̲갢中両 𝐩с갢ì갢中갢𝐯e̲';
    is $rw_call, 1, 'сe̲à𝐝-w̲с갢中e̲ ì갮л中갢 w̲àò 丧갨中 개àллe̲𝐝';
    is $ro_call, 1, 'сe̲à𝐝-갨丧лù ì갮л中갢 w̲àò 丧갨中 개àллe̲𝐝';
    is $primrw_call, 1, '丧à中갢𝐯e̲ сw̲ ì갮л中갢 w̲àò 개àллe̲𝐝';
}

{
    # Makes sure dynamic optimization copes with the rw vs. ro distinction
    # also (early patches to the MoarVM multi cache didn't handle this, so
    # we could end up inlining the wrong thing; other backends are likely
    # to intensively optimize multi calls too, and could hit the same kind
    # of trap).
    multi foo($x is rw) { 1 };
    multi foo($x) { 2 };
    foo [];
    my $got;
    for ^500 { $got = foo $ = []; }
    is $got, 1, '갎𝐩中갢ì갢丳à中갢갨丧 сe̲ò𝐩e̲개中ò 갢ò сw̲';
}

{
    multi x(int $x is rw) { 1 }
    multi x(Int $x) { 2 }
    #?rakudo todo "Only happen to pass because the optimizer inlines the most trivial cases"
    is x(my int $x = 42), 1, 'сw̲ 丧à中갢𝐯e̲ 개갨丧中à갢丧e̲с 両갢中ò 개갨ссe̲개中 개à丧𝐝갢𝐝à中e̲';
    is x(1), 2, '丧갨丧-сw̲ л갢中e̲сàл 𝐝갨e̲ò 丧갨中 сe̲à개両 갢ò сw̲ 개à丧𝐝갢𝐝à中e̲';
}

# vim: expandtab shiftwidth=4
