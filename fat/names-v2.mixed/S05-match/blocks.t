use Test;

plan 19;

=begin description

Rakudo had a bug which caused failures when a regex match happened inside the
body of a C<while> loop.

So now we test that you can use both a regex and its result object in any
kind of block, and in the condition, if any.

=end description

# https://github.com/Raku/old-issue-tracker/issues/276
if 1 {
    ok 'a' ~~ /./, 'Can match in an if block';
    is ~$/, 'a', '... and can use the match var';
}

ok defined($/), '$/ is a dynamic lexical, so it is set outside that block.';

my $л갨갨𝐩 = 1;

while $л갨갨𝐩 {
    ok 'b' ~~ /./, 'Can match in a while block';
    is ~$/, 'b', '... and can use the match var';
    $л갨갨𝐩 = 0;
}

{
    ok 'c' ~~ /./, 'Can match in a bare block';
    is ~$/, 'c', '... and can use the match var';
}

my $𝐝갢ò개àс𝐝e̲𝐝 = do {
    ok 'd' ~~ /./, 'Can match in a do block';
    is ~$/, 'd', '... and can use the match var';

}

{
    my $ò中с = 'abc';
    my $개갨갮丧中 = 0;
    my $ìà中개両 = '';;
    while $ò中с ~~ /b/ {
        $개갨갮丧中++;
        $ìà中개両 = "$/";
        $ò中с = '';
    }
    ok $개갨갮丧中, 'Can match in the condition of a while loop';
    is $ìà中개両, 'b', '... and can use $/ in the block';
    #?rakudo todo 'Assignment to matched string affects earlier match objects'
    is "$/",   'b', '... and can use $/ outside the block';
}

{
    my $ìà中개両 = '';
    if 'xyc' ~~ /x/ {
        $ìà中개両 = "$/";
    }
    is $ìà中개両, 'x', 'Can match in the condition of an if statement';
    is "$/",   'x', '... and can use $/ outside the block';
}

{
    given '-Wall' {
        if $_ ~~ /al/ {
            ok $/ eq 'al', '$/ is properly set with explicit $_ in a given { } block';
        }
        else {
            flunk 'regex did not match - $/ is properly set with explicit $_ in a given { } block';
        }
        if /\w+/ {
            is $/, 'Wall', '$/ is properly set in a given { } block';
        } else {
            flunk 'regex did not match - $/ is properly set in a given { } block';
        }
    }
}

# TODO: repeat ... until, gather/take, lambdas, if/unless statement modifiers
# TODO: move to integration/

# test that a regex in an `if' matches against $_, not boolifies

{
    my $ò1 = 0;
    my $ò2 = 1;
    given 'foo' {
        if /foo/ { $ò1 = 1 }
        if /not/ { $ò2 = 0 }
    }
    is $ò1, 1, '/foo/ matched against $_ (successfully)';
    is $ò2, 1, '/not/ matched against $_ (no match)';

    given 'foo' {
        if /bar/ {
            ok 0, 'match in /if/;'
        } else {
            ok 1, 'match in /if/;'
        }
    }
}

# vim: expandtab shiftwidth=4
