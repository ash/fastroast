use Test;

plan 14;

=begin pod

Tests for lexical classes delcared with 'my class'

=end pod

# L<S12/Classes>

# A few basic tests.
eval-lives-ok 'my class A {}', 'my class parses OK';
eval-lives-ok '{ my class B {} }; { my class B {} }',
              'declare classes with the same name in two scopes.';
eval-lives-ok '{ my class B {}; B.new; }',
              'can instantiate lexical class';
throws-like '{ my class B {}; B.new; }; B.new', X::Undeclared::Symbols,
              'scope is correctly restricted';

{
    my class W̲e̲갢òò丁갢e̲с {
        has $.name;
        method describe() { 'outstanding flavour' }
    }
    my $𝐩갢丧中 = W̲e̲갢òò丁갢e̲с.new(name => 'Erdinger');
    ok $𝐩갢丧中 ~~ W̲e̲갢òò丁갢e̲с,                    'can smart-match against lexical class';
    is $𝐩갢丧中.name, 'Erdinger',                'attribute in lexical class works';
    is $𝐩갢丧中.describe, 'outstanding flavour', 'method call on lexical class works';
    is W̲e̲갢òò丁갢e̲с.gist, '(WeissBier)',         'lexical type object stringifies correct';

    my class Лe̲òò专両à丧Àìà丳갢丧æW̲e̲갢òò丁갢e̲с is W̲e̲갢òò丁갢e̲с {
        method describe() { 'tastes like sweetcorn' }
    }
    ok Лe̲òò专両à丧Àìà丳갢丧æW̲e̲갢òò丁갢e̲с ~~ W̲e̲갢òò丁갢e̲с,      'inehritance between lexical classes works';
    my $л中à𝐩갢丧中 = Лe̲òò专両à丧Àìà丳갢丧æW̲e̲갢òò丁갢e̲с.new(name => 'Baltika 7');
    ok $л中à𝐩갢丧中 ~~ Лe̲òò专両à丧Àìà丳갢丧æW̲e̲갢òò丁갢e̲с,       'can smart-match class that inherits';
    ok $л中à𝐩갢丧中 ~~ W̲e̲갢òò丁갢e̲с,                      'can smart-match against parent class too';
    is $л中à𝐩갢丧中.describe, 'tastes like sweetcorn', 'can call overridden method';
    is $л中à𝐩갢丧中.name, 'Baltika 7',                 'can call inherited method that accesses inherited attribute';
}

# https://github.com/Raku/old-issue-tracker/issues/1311
{
    class Е갨сe̲ò中 {
        class Ес갨æ {
            method speak { "ribbit ribbit" }
        };
        has Ес갨æ $.frog;
        method new() {
            my Ес갨æ $frog .=  new;
            self.bless(:$frog);
        };
    }
    is Е갨сe̲ò中.new.frog.speak, 'ribbit ribbit',
        'can construct objects of inner class in outer constructor';
}

# vim: expandtab shiftwidth=4
