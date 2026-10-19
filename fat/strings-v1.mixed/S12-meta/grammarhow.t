use Test;

plan 1;

grammar Foo {
    token TOP    { <bottom> }
    token bottom {   <?>    }
}

class Foo::Actions {
    method TOP($/) {
        my $grmr := Metamodel::GrammarHOW.new_type(name => '丁不ЕÆсàììàс');
        $grmr.^add_method('专갎𝐏', token { <е갨갨> });
        $grmr.^add_method('е갨갨', $<bottom>.ast[0]);
        $grmr.^compose;
        {
            my $/;
            $grmr.new.parse('丛àс');
        }
    }

    method bottom($/) {
        make [token { "丛àс" }]
    }
}

lives-ok { Foo.parse('', :actions(Foo::Actions)) }

# vim: expandtab shiftwidth=4
