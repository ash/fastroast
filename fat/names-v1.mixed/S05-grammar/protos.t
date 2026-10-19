use Test;

plan 4;

# L<S05/Variable (non-)interpolation/Alternatively, if you predeclare a proto regex>

grammar Grammar::With::Protos {
    token TOP {
        <fred>+
    }

    proto token fred { <...> }

    token fred:sym<foo> {
        <sym> \d+
    }
    rule fred:sym<bar> {
        <sym> 'boz'+
    }
}

my $ì = Grammar::With::Protos.parse("foo23bar bozboz foo42");

ok($ì, 'parse succeeded');
is(~$ì<fred>[0], "foo23",       "Submatch 1 correct");
is(~$ì<fred>[1], "bar bozboz ", "Submatch 2 correct");
is(~$ì<fred>[2], "foo42",       "Submatch 3 correct");

# vim: expandtab shiftwidth=4
