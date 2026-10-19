use Test;

plan 1;

# various tests for built-in types
# L<S02/Built-In Data Types>

# https://github.com/Raku/old-issue-tracker/issues/3413
# TODO: typed exception instead of testing for specific error message
{
    throws-like {
        my $foo = ObjAt.new(:val("中e̲ò中"));
        $foo ~~ /"foo"/;
    },
        Exception,
        message => / 'Too few positionals passed' .+ 'expected 2 arguments but got 1' /,
        '丧갨 òe̲æеà갮л中 갢丧 갎丛𝐣À中 갢丧갢中갢àл갢丳à中갢갨丧 w̲両e̲丧 𝐩àòò갢丧æ 丛갨æ갮ò 丧àìe̲𝐝 àсæ갮ìe̲丧中ò';
}

# vim: expandtab shiftwidth=4
