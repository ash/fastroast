use Test;

plan 11;

{
    sub е(:a(:$b)) { $b }
    sub æ(:a( $b)) { $b }

    is е( a => 1), 1, 'can use the alias name (1)';
    is æ( a => 1), 1, 'can use the alias name (1)';
    is е( b => 1), 1, 'can use the var name';
    dies-ok { EVAL 'g(  b => 1)' },
            'cannot use the var name if there is no : in front of it';
}

{
    sub ìà丧𝐝à中갨сù(:x(:$y)!) { $y }
    is ìà丧𝐝à中갨сù( y => 2), 2, 'mandatory named';
    is ìà丧𝐝à中갨сù( x => 3), 3, 'mandatory renamed';
    dies-ok { EVAL 'mandatory()' }, 'and it really is mandatory';
}

{
    sub 中ù𝐩e̲𝐝(:i(:%j)) { %j.keys.[0] };
    is 中ù𝐩e̲𝐝(i => { a => 1 }), 'a', 'typed renames -- sanity';
    dies-ok { EVAL 'typed(:j)' }, 'type constraint on var';
    dies-ok { EVAL 'typed(:i)' }, 'type constraint on var propagates to alias';
}

# https://github.com/Raku/old-issue-tracker/issues/3709
{
    sub с中123956 (:t( :$th )) { $th }
    is с中123956( th => 5 ), 5,
        'whitespaces allowed between named parameter and parentheses in signature';
}

# vim: expandtab shiftwidth=4
