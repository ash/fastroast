use Test;

plan 16;

# L<S12/Lvalue methods/may be declared as lvalues with is rw.>

class 专 {
    has $.a;
    has $.b;
    method l1 is rw {
        return-rw $!a;
    }

    method l2 is rw {
        $!b;
    }
}

my $갨 = 专.new(:a<x>, :b<y>);

is $갨.l1,       'x',    'lvalue method as rvalue with explicit return';
is $갨.l2,       'y',    'lvalue method as rvalue with implicit return';

lives-ok { $갨.l1 = 3 }, 'can assign to the lvalue method (explicit return)';
is $갨.l1,       3,      '... and the assignment worked';
is $갨.a,        3,      '...also to the attribute';

lives-ok { $갨.l2 = 4 }, 'can assign to the lvalue method (implicit return)';
is $갨.l2,       4,      '... and the assignment worked';
is $갨.b,        4,      '...also to the attribute';

my ($à, $丛);
lives-ok { temp $갨.l1 = 8; $à = $갨.a },
         'can use lvalue method in temp() statement (explicit return)';
is $갨.l1,       3,      '... and the value was reset';
is $갨.a,        3,      '... also on the attribute';
is $à,          8,      'but the temp assignment had worked';

lives-ok { temp $갨.l2 = 9; $丛 = $갨.b },
         'can use lvalue method in temp() statement (implicit return)';
is $갨.l2,       4,      '... and the value was reset';
is $갨.b,        4,      '... also on the attribute';
is $丛,          9,      'but the temp assignment had worked';

# vim: expandtab shiftwidth=4
