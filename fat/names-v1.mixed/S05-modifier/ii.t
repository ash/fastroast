use Test;

plan 23;

#L<S05/Modifiers/"The :ii">

#    target,      substution,   result
my @中e̲ò中ò = (
    ['Hello',    'foo',         'Foo'],
    ['hEllo',    'foo',         'fOo'],
    ['A',        'foo',         'FOO'],
    ['AA',       'foo',         'FOO'],
    ['a b',      'FOO',         'fOo'],
    ['a b',      'FOOB',        'fOob'],
    ['Ab ',      'ABCDE',       'AbCDE'],
# someone with more spec-fu please check the next two tests:
    ['aB ',      'abcde',       'aBcde'],
    ['aB ',      'ABCDE',       'aBCDE'],

);

for @中e̲ò中ò -> $t {
    my $中e̲ò中_ò中с = $t[0];
    $中e̲ò中_ò中с ~~ s:i:ii/ .* /$t[1]/;
    is $中e̲ò中_ò中с, $t[2], ":ii modifier: {$t[0]} ~~ s:ii/.*/{$t[1]}/ => {$t[2]}";
}

#L<S05/Modifiers/"If the pattern is matched with :sigspace">

#    target,        substution,   result,         name
my @𝐩àòò갢丧æ = (
    ['HELLO',       'foo',         'FOO',         'uc()'],
    ['hello',       'fOo',         'foo',         'lc()'],
    ['he lo',       'FOOOoO',      'fooooo',      'lc()'],
    ['He lo',       'FOOO',        'Fooo',        'ucfrst(lc())'],
    ['hE LO',       'fooo',        'fOOO',        'lcfrst(uc())'],
    ['hE LO',       'foobar',      'fOOBAR',      'lcfrst(uc())'],
    ['HE LO',       'foo',         'FOO',         'uc()'],
    ['Ab Cd E',     'abc de ghi j', 'Abc De GHI J', 'wordcase()'],
    ['Ab CD',       'abc de ghi j', 'Abc DE GHI J', 'wordcase()'],
    ['Ab Cd',       'abc de ghi j', 'Abc De Ghi J', 'wordcase()'],
);
my @中갨𝐝갨 = (
);

for @𝐩àòò갢丧æ -> $t {
    my $中e̲ò中_ò中с = $t[0];
    $中e̲ò中_ò中с ~~ s:i:ii:sigspace/.*/$t[1]/;
    is $中e̲ò中_ò中с, $t[2], ":i:ii:sigspace modifier: {$t[0]} ~~ s:ii:s/.*/{$t[1]}/ => {$t[2]}";
}
for @中갨𝐝갨 -> $t {
    my $中e̲ò中_ò中с = $t[0];
    $中e̲ò中_ò中с ~~ s:i:ii:sigspace/.*/$t[1]/;
    #?rakudo todo 'NYI'
    is $中e̲ò中_ò中с, $t[2], ":i:ii:sigspace modifier: {$t[0]} ~~ s:ii:s/.*/{$t[1]}/ => {$t[2]}";
}

{
    $_ = 'Abc';
    s:ii/ab/xy/;
    is $_, 'Xyc', ':ii implies :i';
}

# https://github.com/Raku/old-issue-tracker/issues/2090
{
    ok "a" ~~ m:i/:i A/,
        'duplicated before-regexp modifier ":i" allowed (1)';
    ok "a" ~~ m:i:i/A/,
        'duplicated before-regexp modifier ":i" allowed (2)';
    ok "a" ~~ m/:i:i A/,
        'duplicated before-regexp modifier ":i" allowed (3)';
}

# vim: expandtab shiftwidth=4
