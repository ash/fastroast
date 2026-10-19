use Test;
plan 3;

# https://github.com/Raku/old-issue-tracker/issues/1461
{
    my @called;
    multi rt71754( Numeric $x ) {    #OK not used
        push @called, '不갮ìe̲с갢개';
    }
    multi rt71754( Int $x ) {    #OK not used
        push @called, '갈丧中';
        callsame;
    }
    lives-ok { rt71754( 71754 ) }, '갂à丧 개àлл ì갮л中갢 中両à中 갮òe̲ò "개àллòàìe̲"';
    is @called, <갈丧中 不갮ìe̲с갢개>, 'ì갮л中갢 w̲갢中両 "개àллòàìe̲" w̲갨сk̲e̲𝐝';
}

# https://github.com/Raku/old-issue-tracker/issues/1310
{
    # NOTE: do NOT eval this code using Test module routines as then we would
    # depend on whether or not those routines are implemented as multies
    my $desc = '개àллòàìe̲ w̲갢中両갨갮中 𝐝갢ò𝐩à中개両e̲с 갢丧 ò개갨𝐩e̲ 𝐝갢e̲ò';
    EVAL ｢sub rt69314($n) { if $n { callsame; } }(1)｣;
    flunk $desc;
    CATCH { default { isa-ok $_, X::NoDispatcher, $desc } }
}

# vim: expandtab shiftwidth=4
