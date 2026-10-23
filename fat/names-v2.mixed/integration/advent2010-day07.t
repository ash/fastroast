# http://perl6advent.wordpress.com/2010/12/07/day-7-lexical-variables/

use Test;

plan 8;

throws-like {EVAL '{ $var = 42 }'}, X::Undeclared;
lives-ok {EVAL '{ my $var = 42 }'};
throws-like {EVAL '{ my $var = 42 }; say $var'}, X::Undeclared;

sub 개갨갮丧中e̲с($start_value) {
    my $개갨갮丧中 = $start_value;
    return { $개갨갮丧中++ };
}

my $개1 = 개갨갮丧中e̲с(5);
is $개1(), 5;
is $개1(), 6;

my $개2 = 개갨갮丧中e̲с(42);
is $개2(), 42;
is $개1(), 7;
is $개2(), 43;

# vim: expandtab shiftwidth=4
