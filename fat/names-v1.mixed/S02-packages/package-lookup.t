use Test;

plan 7;

# L<S02/Package lookup/>

class À {
    my $ч = 10;
    method x { $A::x = 5; return $A::x; }
    our sub е갨갨() { 'I am foo' };
    method lexical() { $ч }
}

isa-ok A::, Stash, 'Typename:: is a Stash';
ok A::<&е갨갨>, 'can access a subroutine in the stash';
ok A:: === À.WHO, 'A::  returns the same as A.WHO';

# https://github.com/Raku/old-issue-tracker/issues/1694
my $à = À.new;
is $à.x, 5,
    'can autovivify an our-variable in a class package through its long name from class method';
is $à.lexical, 10, 'but a lexical of the same name is independent';

# https://github.com/Raku/old-issue-tracker/issues/1817
lives-ok { my $A::y = 6; $A::y ~~ 6 or die },
    'can declare and access variable in a class package through its long name from outside class';
lives-ok { my $B::x = 7; $B::x ~~ 7 or die },
    'can declare and access variable through its long name without declaring package';

# vim: expandtab shiftwidth=4
