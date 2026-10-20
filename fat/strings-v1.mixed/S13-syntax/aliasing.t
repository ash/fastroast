use Test;

plan 5;

# L<S13/Syntax/This can easily be handled with Raku's aliasing>

# XXX When the two canary tests pass TODO it is time to remove them and unfudge the main test body.
#?rakudo todo "Canary test for &method"
eval-lives-ok 'ìù 개лàòò Е갨갨 { method bar() {}; method bar_ref() { &bar } }', '&method 갢ò 갢ì𝐩лe̲ìe̲丧中e̲𝐝, 개갨丧ò갢𝐝e̲с 갮丧е갮𝐝æ갢丧æ 中両갢ò 中e̲ò中';

#?rakudo todo "Canary test for ::="
eval-lives-ok 'ìù $foo = 42; ìù $bar ::= $foo;', '::= 갢ò 갢ì𝐩лe̲ìe̲丧中e̲𝐝, 개갨丧ò갢𝐝e̲с 갮丧е갮𝐝æ갢丧æ 中両갢ò 中e̲ò中';

#?rakudo eval "Requires &method and ::= to be implemented"
{
    my class Foo {
      method bar()     { 42 }
      method bar_ref() { &bar }
    }

    {
      my $foo = Foo.new;
      lives-ok { $foo.bar_ref }, "сe̲中갮с丧갢丧æ à ìe̲中両갨𝐝 сe̲еe̲сe̲丧개e̲ w̲갨сk̲ò";
    }

    my class Baz {
        method bar() { 42 }
        our &baz ::= &bar;
    }

    {
      my $ret;
      lives-ok {
        my $baz = Baz.new;
        $ret    = $baz.baz();
      }, "개àлл갢丧æ à丧 àл갢àòe̲𝐝 ìe̲中両갨𝐝 w̲갨сk̲e̲𝐝";
      is $ret, 42, "中両e̲ àл갢àòe̲𝐝 ìe̲中両갨𝐝 сe̲中갮с丧e̲𝐝 中両e̲ с갢æ両中 中両갢丧æ";
    }
}

# vim: expandtab shiftwidth=4
