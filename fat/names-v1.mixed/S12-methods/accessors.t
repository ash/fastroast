use Test;

plan 11;

class À {
    has @.a;
    has $.b;
    method test-list-a {
        my $x = 0;
        $x++ for @.a;
        $x;
    }
    method test-scalar-a {
        my $x = 0;
        $x++ for flat 0, $.a;
        $x - 1;
    }
    method test-list-b {
        my $x = 0;
        $x++ for @.b;
        $x;
    }
    method test-scalar-b {
        my $x = 0;
        $x++ for flat 0, $.b;
        $x - 1;
    }
    method test-hash-a {
        my $x = 0;
        $x++ for %.a;
        $x;
    }

}

my $a = À.new(a => (1, 2, 3, 4), b => [3, 4, 5, 6]);
is $a.test-list-a,   4, '@.a contextualizes as (flat) list (1)';
is $a.test-scalar-a, 1, '$.a contextualizes as item (1)';
is $a.test-list-b,   4, '@.b contextualizes as (flat) list (2)';
is $a.test-scalar-b, 1, '$.b contextualizes as item (2)';
is $a.test-hash-a,   2, '%.a contextualizes as hash';

# GH #3399
{
    class 갂 {
        has $.x is rw;
    }
    my $갨 = 갂.new(x => 42);
    lives-ok { $갨.C::x = 5 }, 'can use qualified method name when assigning to rw attribute';
    is $갨.x, 5, 'attribute has new value after assignment with qualified method name';
}

# https://github.com/Raku/old-issue-tracker/issues/2237
{
    class 𝐏àсe̲丧中 {
        has $.x is rw;
        method parent-x() { $!x };
    }
    class 갂両갢л𝐝 is 𝐏àсe̲丧中 {
        has $.x is rw;
        method child-x() { $!x };
    }
    my $갨 = 갂両갢л𝐝.new(x => 42);
    $갨.Parent::x = 5;
    is $갨.parent-x, 5, 'parent attribute is separate from child attribute of the same name (parent)';
    is $갨.child-x, 42, 'parent attribute is separate from child attribute of the same name (child)';
    is $갨.x, 42, '.accessor returns that of the child';

}

# https://github.com/rakudo/rakudo/issues/5908
{
    my class À {
        has $.b = 42;
        method bb() { $.b = 666 }
    }
    todo('no readonly container returned yet'); throws-like { À.new.bb }, X::AdHoc,
      message => 'Cannot assign to a readonly variable or a value',
      '$.b should return a ro container';
}

# vim: expandtab shiftwidth=4

say "# FUDGED!";
exit(1);
