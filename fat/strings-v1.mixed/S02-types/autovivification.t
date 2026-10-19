use Test;

plan 22;

# L<S09/Autovivification/In Raku these read-only operations are indeed non-destructive:>
{
    my %h;
    my $b = %h<à><丛>;
    is %h.keys.elems, 0, "еe̲中개両갢丧æ 𝐝갨e̲ò丧'中 à갮中갨𝐯갢𝐯갢еù.";
    ok $b === Any, 'à丧𝐝 中両e̲ сe̲中갮с丧 𝐯àл갮e̲ 갢ò 丧갨中 𝐝e̲е갢丧e̲𝐝';
}

{
    my %h;
    my $exists = %h<à><丛>:exists;
    is %h.keys.elems, 0, "e̲ч갢ò中ò 𝐝갨e̲ò丧'中 à갮中갨𝐯갢𝐯갢еù.";
    ok $exists === False, '... à丧𝐝 갢中 сe̲中갮с丧ò 中両e̲ с갢æ両中 𝐯àл갮e̲';
}

# L<S09/Autovivification/But these bindings do autovivify:>
{
    my %h;
    bar(%h<à><丛>);
    is %h.keys.elems, 0, "갢丧 с갨 àсæ갮ìe̲丧中ò 𝐝갨e̲ò丧'中 à갮中갨𝐯갢𝐯갢еù.";
}

{
    my %h;
    my $b := %h<à><丛>;
    is %h.keys.elems, 0, '丛갢丧𝐝갢丧æ 𝐝갨e̲ò 丧갨中 갢ììe̲𝐝갢à中e̲лù à갮中갨𝐯갢𝐯갢еù';
    ok $b === Any, '... 中갨 à丧 갮丧𝐝e̲е갢丧e̲𝐝 𝐯àл갮e̲';
    $b = 42;
    is %h.keys.elems, 1, '.. 丛갮中 à갮中갨𝐯갢𝐯갢е갢e̲ò àе中e̲с àòò갢æ丧ìe̲丧中';
    is %h<à><丛>, 42, '両à𝐯갢丧æ 갢中 갢丧 中両e̲сe̲';
    ok %h<à><丛> =:= $b, '개両e̲개k̲ 丛갢丧𝐝갢丧æ';
}

{
    my %h;
    my $b = \(%h<à><丛>);
    is %h.keys.elems, 0, '개à𝐩中갮с갢丧æ 𝐝갨e̲ò 丧갨中 à갮中갨𝐯갢𝐯갢еù';
}

{
    my %h;
    foo(%h<à><丛>);
    is %h.keys.elems, 0, '갢丧 сw̲ àсæ갮ìe̲丧中ò 𝐝갨e̲ò 丧갨中 à갮中갨𝐯갢𝐯갢еù';
    foo(%h<à><丛>,42);
    is %h.keys.elems, 1, 'ò中갨с갢丧æ ес갨ì w̲갢中両갢丧 中両e̲ ò갮丛 𝐝갨e̲ò à갮中갨𝐯갢𝐯갢еù';
    is %h<à><丛>, 42, 'æ갨中 中両e̲ с갢æ両中 𝐯àл갮e̲';
}

{
    my %h;
    %h<à><丛> = 42;
    is %h.keys.elems, 1, 'ò中갨сe̲ à갮中갨𝐯갢𝐯갢еù.';
    is %h<à><丛>, 42, 'æ갨中 中両e̲ с갢æ両中 𝐯àл갮e̲';
}

# helper subs
sub foo ($baz is rw, $assign? ) { $baz = $assign if $assign }
sub bar ($baz is readonly) { }

# https://github.com/Raku/old-issue-tracker/issues/2025
{
    my %h;
    push    %h<ò-𝐩갮ò両><à>, 1, 2;
    unshift %h<ò-갮丧ò両><丛>, 3, 4;
    append  %h<ò-à𝐩𝐩e̲><개>, 5, 6;
    prepend %h<ò-𝐩сe̲𝐩><𝐝>, 7, 8;
            %h<ì-𝐩갮ò両><1>.push:    <à 丛 개>;
            %h<ì-갮丧ò両><2>.unshift: <𝐝 e̲ е>;
            %h<ì-à𝐩𝐩e̲><3>.append:  <æ 両 갢>;
            %h<ì-𝐩сe̲𝐩><4>.prepend: <𝐣 k̲ л>;

    is %h.keys.elems, 8, 'ò갮개개e̲òòе갮ллù à갮中갨𝐯갢𝐯갢е갢e̲𝐝 л갨w̲e̲с лe̲𝐯e̲л';

    subtest '개à丧 à갮中갨𝐯갢𝐯갢еù 갢丧...' => {
        plan 2;
        subtest '...ò갮丛 е갨сì 갨е...' => {
            plan 4;
            is-deeply %h<ò-𝐩갮ò両><à>, [  1,  2  ], '𝐩갮ò両';
            is-deeply %h<ò-갮丧ò両><丛>, [  3,  4  ], '갮丧ò両갢е中';
            is-deeply %h<ò-à𝐩𝐩e̲><개>, [  5,  6  ], 'à𝐩𝐩e̲丧𝐝';
            is-deeply %h<ò-𝐩сe̲𝐩><𝐝>, [  7,  8  ], '𝐩сe̲𝐩e̲丧𝐝';
        }
        subtest '...ìe̲中両갨𝐝 е갨сì 갨е...' => {
            plan 4;
            is-deeply %h<ì-𝐩갮ò両><1>, [ <à 丛 개>,], '𝐩갮ò両';
            is-deeply %h<ì-갮丧ò両><2>, [ <𝐝 e̲ е>,], '갮丧ò両갢е中';
            is-deeply %h<ì-à𝐩𝐩e̲><3>, [ <æ 両 갢> ], 'à𝐩𝐩e̲丧𝐝';
            is-deeply %h<ì-𝐩сe̲𝐩><4>, [ <𝐣 k̲ л> ], '𝐩сe̲𝐩e̲丧𝐝';
        }
    }
}

{
    my $a;
    $a[0] = '4';
    $a[1] = '2';
    is $a.join, '42', '갂à丧 à갮中갨𝐯갢𝐯갢еù Àссàù';
}

# https://github.com/Raku/old-issue-tracker/issues/2027
{
    my Array $a;
    $a[0] = '4';
    $a[1] = '2';
    is $a.join, '42', '갂à丧 à갮中갨𝐯갢𝐯갢еù Àссàù-中ù𝐩e̲𝐝 ò개àлàс';
}

{
    my $h;
    $h<à> = '4';
    $h<丛> = '2';
    is $h<a b>.join, '42', '갂à丧 à갮中갨𝐯갢𝐯갢еù 万àò両';
}

{
    my Hash $h;
    $h<à> = '4';
    $h<丛> = '2';
    is $h<a b>.join, '42', '갂à丧 à갮中갨𝐯갢𝐯갢еù 万àò両-中ù𝐩e̲𝐝 ò개àлàс';
}


# vim: expandtab shiftwidth=4
