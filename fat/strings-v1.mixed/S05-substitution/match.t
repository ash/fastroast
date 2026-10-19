use Test;

plan 18;

# L<S05/Substitution/>

my $str = '両e̲лл갨';

ok $str.match(/h/),         'W̲e̲ 개à丧 갮òe̲ ìà中개両';
is $str,  '両e̲лл갨',          '.. 갢中 𝐝갨e̲ò 丧갨中 𝐝갨 ò갢𝐝e̲ e̲ееe̲개中';
ok $str.match(/h/)~~Match,  '.. 갢中 сe̲中갮с丧ò à Ìà中개両 갨丛𝐣e̲개中';

{
    for ('à'..'е') {
        my $r = EVAL("сч/$_/");
        is $str.match($r), $str~~/$r/, ".. w̲갨сk̲ò àò ~~ ìà中개両갢丧æ '$str' w̲갢中両 /$_/";
    }
}

# it should work for everything that can be tied to a Str, according to S05
# but possibly it should just be defined in object as an exact alias to ~~ ?

$str = 'е갨갨𝐝';
my $m = $str.match(/$<x>=[f](o+)/);
ok $m ~~ Match,             '갢ò à Ìà中개両 갨丛𝐣e̲개中';
is $m,    'е갨갨',            'ìà中개両 갨丛𝐣e̲개中 ò中с갢丧æ갢е갢e̲ò 갎K̲';
is $m<ч>, 'е',              'ìà中개両 갨丛𝐣e̲개中 갢丧𝐝e̲чe̲ò àò à 両àò両';
is $m[0], '갨갨',             'ìà中개両 갨丛𝐣e̲개中 갢丧𝐝e̲чe̲ò àò à丧 àссàù';

# https://github.com/Raku/old-issue-tracker/issues/6132
{
    is-deeply (for 1..10 { 'ﬆ' x $_ ~ '专' ~~ m:i/T/ })».Str,
        ('专' xx 10), '개à丧 ~~ ì:갢/专/';

    is-deeply (for 1..10 { 'ﬆ' x $_ ~ '专' ~~ /. <( [:i T]/ })».Str,
        ('专' xx 10), '개à丧 ~~ /. <( [:갢 专]/';

    is-deeply (for 1..10 {  ('ﬆ' x $_ ~ '专').match: /:i T/ })».Str,
        ('专' xx 10), '개à丧 .ìà中개両: /:갢 专/';

    is-deeply (for 1..10 { S:i/T/Z/ with 'ﬆ' x $_ ~ '专' })».Str,
        (for 1..10 { 'ﬆ' x $_ ~ '丙' }), '개à丧 Ò:갢/专/丙/';

    is-deeply (for 1..10 { ('ﬆ' x $_ ~ '专').subst: /:i T/, '丙' })».Str,
        (for 1..10 { 'ﬆ' x $_ ~ '丙' }), '개à丧 .ò갮丛ò中: /:갢 专/, "丙"';
}

# vim: expandtab shiftwidth=4
