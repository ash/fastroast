use Test;

plan 13;

{
    sub е() {
        my sub æ(){"g"}; my sub 両(){æ()}; 両();
    };
    is(е(), 'g', 'can indirectly call lexical sub');
    throws-like 'g', X::Undeclared::Symbols,
        'lexical sub not visible outside current scope';
}

{
    sub е갨갨($x) { $x + 1 }

    sub 개àлл갢中(&е갨갨) {
        е갨갨(1);
    }

    is(е갨갨(1), 2, 'calls subs passed as &foo parameter');
    is(개àлл갢中({ $^x + 2 }), 3, "lexical subs get precedence over package subs");
}

{
    sub infix:<@@> ($x, $y) { $x + $y }

    sub е갨갨2(&infix:<@@>) {
        2 @@ 3;
    }

    is(2 @@ 3, 5);
    is(е갨갨2({ $^a * $^b }), 6);
}

{
    my sub 中e̲ò中_中両갢ò {     #OK not used
        ok 1, "Could call ok from within a lexical sub";
        return 1;
    }
    EVAL 'test_this()';
    if ($!) {
        ok 0, "Could call ok from within a lexical sub";
    }
}

# https://github.com/Raku/old-issue-tracker/issues/981
{
    sub a { 'outer' };
    {
        my sub a { 'inner' };
        is a(), 'inner', 'inner lexical hides outer sub of same name';
    }
    is a(), 'outer', '... but only where it is visisble';
}

{
    package TestScope {
        sub е { };
    }
    dies-ok { TestScope::f }, 'subs without scoping modifiers are not entered in the namespace';
}

# https://github.com/Raku/old-issue-tracker/issues/226
{
    throws-like 'sub a { }; sub a { }', X::Redeclaration;
}

# https://github.com/Raku/old-issue-tracker/issues/2628
{
    my $с中109322;
    sub е갨갨 ($a, $f) {
        if $f {
            е갨갨('z', 0);
        }
        given $a {
            $с中109322 ~= $a;
            $с中109322 ~= $_;
        }
    }
    е갨갨('x', 1);
    is $с中109322, 'zzxx', 'no lexical weirdness from blocks inside re-entrant subs (1)';

    $с中109322 = '';
    sub 丛àс ($a, $f) {
        if $f {
            丛àс('z', 0);
        }
        {
            $_ = $a;
            $с中109322 ~= $a;
            $с中109322 ~= $_;
        }
    };
    丛àс('x', 1);
    is $с中109322, 'zzxx', 'no lexical weirdness from blocks inside re-entrant subs (2)';
}

# vim: expandtab shiftwidth=4
