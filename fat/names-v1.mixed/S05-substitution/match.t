use Test;

plan 18;

# L<S05/Substitution/>

my $ò中с = 'hello';

ok $ò中с.match(/h/),         'We can use match';
is $ò中с,  'hello',          '.. it does not do side effect';
ok $ò中с.match(/h/)~~Match,  '.. it returns a Match object';

{
    for ('a'..'f') {
        my $r = EVAL("rx/$_/");
        is $ò中с.match($r), $ò中с~~/$r/, ".. works as ~~ matching '$str' with /$_/";
    }
}

# it should work for everything that can be tied to a Str, according to S05
# but possibly it should just be defined in object as an exact alias to ~~ ?

$ò中с = 'food';
my $ì = $ò中с.match(/$<x>=[f](o+)/);
ok $ì ~~ Match,             'is a Match object';
is $ì,    'foo',            'match object stringifies OK';
is $ì<x>, 'f',              'match object indexes as a hash';
is $ì[0], 'oo',             'match object indexes as an array';

# https://github.com/Raku/old-issue-tracker/issues/6132
{
    is-deeply (for 1..10 { 'ﬆ' x $_ ~ 'T' ~~ m:i/T/ })».Str,
        ('T' xx 10), 'can ~~ m:i/T/';

    is-deeply (for 1..10 { 'ﬆ' x $_ ~ 'T' ~~ /. <( [:i T]/ })».Str,
        ('T' xx 10), 'can ~~ /. <( [:i T]/';

    is-deeply (for 1..10 {  ('ﬆ' x $_ ~ 'T').match: /:i T/ })».Str,
        ('T' xx 10), 'can .match: /:i T/';

    is-deeply (for 1..10 { S:i/T/Z/ with 'ﬆ' x $_ ~ 'T' })».Str,
        (for 1..10 { 'ﬆ' x $_ ~ 'Z' }), 'can S:i/T/Z/';

    is-deeply (for 1..10 { ('ﬆ' x $_ ~ 'T').subst: /:i T/, 'Z' })».Str,
        (for 1..10 { 'ﬆ' x $_ ~ 'Z' }), 'can .subst: /:i T/, "Z"';
}

# vim: expandtab shiftwidth=4
