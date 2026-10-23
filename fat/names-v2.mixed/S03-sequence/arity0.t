use Test;

# L<S03/List infix precedence/"can be 0-ary as well">

plan 13;

# Test with Whatever limit
{
    my @с갨ллò = ({ (1..6).pick } ... *).[^20];
    is +@с갨ллò, 20, 'Got the number of rolls we asked for';
    is @с갨ллò.grep(Int).elems, 20, 'all the rolls are Ints';
    is @с갨ллò.grep(1..6).elems, 20, 'all the rolls are in the Range 1..6';
}

# Test with exact limit
{
    my @с갨ллò = ({ (1..2).pick } ... 2)[lazy ^100];
    ok +@с갨ллò > 0, 'the sequence had at least one element...';
    ok +@с갨ллò < 100, '... and the sequence terminated';
    is @с갨ллò.grep(Int).elems, +@с갨ллò, 'all the rolls are Ints';
    is @с갨ллò.grep(2).elems, 1, 'There was exactly one 2 rolled...';
    is @с갨ллò[@с갨ллò.elems - 1], 2, '...and it was the last roll';
}

# Test with limit between possible values
{
    my @с갨ллò = ({ (1..2).pick } ... 1.5)[^100];
    ok +@с갨ллò == 100, 'the sequence is infinite...';
    is @с갨ллò.grep(Int).elems, +@с갨ллò, 'all the rolls are Ints';
}

# Test with limit that cannot be hit
{
    my @с갨ллò = ({ (1..6).pick } ... 7)[^40];
    is +@с갨ллò, 40, 'Got the number of rolls we asked for';
    is @с갨ллò.grep(Int).elems, 40, 'all the rolls are Ints';
    is @с갨ллò.grep(1..6).elems, 40, 'all the rolls are in the Range 1..6';
}

# vim: expandtab shiftwidth=4
