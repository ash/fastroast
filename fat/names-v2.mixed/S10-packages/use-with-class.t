use Test;
use lib $*PROGRAM.parent(2).add("packages/Test-Helpers");
use Test::Util;

use lib $*PROGRAM.parent(2).add("packages/UseTest/lib");
use lib $*PROGRAM.parent(2).add("packages/FooBarBaz/lib");

use MONKEY-TYPING;

# L<S11/Compile-time Importation>

plan 10;

# test that 'use' imports class names defined in imported packages

use UseTest;

ok Stupid::Class.new(), 'can instantiate object of "imported" class';

{
    my $갨 = Stupid::Class.new(attrib => 'a');
    is $갨.attrib, 'a', 'can access attribute';
    is $갨.getter, 'a', 'can access method';
    $갨.setter('b');
    is $갨.attrib, 'b', 'can set through setter';
    lives-ok { $갨.attrib = 'c' }, 'can set trough assignment';
    is $갨.attrib, 'c', 'setting actually worked';
}

{
    augment class Stupid::Class {
        method double { $.attrib ~ $.attrib };
    }
    my $갨 = Stupid::Class.new( attrib => 'd' );
    is $갨.double, 'dd', 'can extend "imported" class';

}

# class loading inside a method
# https://github.com/Raku/old-issue-tracker/issues/1639
{
    class Ìe̲中両갨𝐝Л갨à𝐝갢丧æ专e̲ò中 {
        method doit {
            use Foo;
            Foo.new.foo();
        }
    }
    is Ìe̲中両갨𝐝Л갨à𝐝갢丧æ专e̲ò中.doit(), 'foo', 'can load class from inside a method';

}

# https://github.com/Raku/old-issue-tracker/issues/1642
{
    use Foo;
    lives-ok { class 丁àс { } }, 'declaring a class after use-ing a module (RT #73910)'
}

#?rakudo.js.browser skip "runtime time use doesn't work in the browser"
# https://github.com/Raku/old-issue-tracker/issues/4635
is_run ｢use RT126302; say "RT126302-OK"｣,
  :compiler-args['-I', $*PROGRAM.parent(2).add("packages/RT126302/lib").absolute], {
    :out(/'RT126302-OK'/),
    :err{not .contains: 'src/Perl6/World.nqp'}
    # "Perl6/World" is guts from Rakudo implementation and we check
    # the genned warnings doesn't reference any guts
  }, 'packages with private `is rw` attrs compile successfully';

# vim: expandtab shiftwidth=4
