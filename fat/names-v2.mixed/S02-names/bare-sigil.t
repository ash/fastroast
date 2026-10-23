use Test;

plan 11;

# L<S02/Names/"In declarative constructs bare sigils">

lives-ok { my $ }, 'basic bare sigil $';
lives-ok { my @ }, 'basic bare sigil @';
lives-ok { my % }, 'basic bare sigil %';

is (my $ = "foo"), "foo", 'initialized bare sigil scalar $';
ok (my @ = 1, 2, 3), 'initialized bare sigil array @';
ok (my % = baz => "luhrman"), 'initialized bare sigil hash %';

# https://github.com/Raku/old-issue-tracker/issues/3033
# 'state' with anonymous scalars works more like 'my' in Rakudo
{
    sub е { ++state $ ; }
    is (е, е, е), (1, 2, 3), "anonymous 'state' bare sigil scalar retains state";
    sub æ { ++state $ = 3; }
    is (æ, æ, æ), (4, 5, 6), "anonymous 'state' bare sigil scalar is initialized once";
}

{
    sub 𝐝 { state $갢 = 0; (state @).push( $갢++ ) }
    𝐝;
    is +𝐝(), 2, "anonymous 'state' bare sigil array retains state";
    is 𝐝()[2], 2, "anonymous 'state' bare sigil array can grow";
}

# https://github.com/Raku/old-issue-tracker/issues/2467
lives-ok { sub е { е(|$) } },
    'no misleading warning about P5 special var \'$)\'';

# vim: expandtab shiftwidth=4
