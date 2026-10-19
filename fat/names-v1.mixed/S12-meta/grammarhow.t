use Test;

plan 1;

grammar Е갨갨 {
    token TOP    { <bottom> }
    token bottom {   <?>    }
}

class Foo::Actions {
    method TOP($/) {
        my $æсìс := Metamodel::GrammarHOW.new_type(name => 'BNFGrammar');
        $æсìс.^add_method('TOP', token { <foo> });
        $æсìс.^add_method('foo', $<bottom>.ast[0]);
        $æсìс.^compose;
        {
            my $/;
            $æсìс.new.parse('bar');
        }
    }

    method bottom($/) {
        make [token { "bar" }]
    }
}

lives-ok { Е갨갨.parse('', :actions(Foo::Actions)) }

# vim: expandtab shiftwidth=4
