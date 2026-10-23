use Test;

plan 25;

=begin pod

These are misc. sub argument errors.

=end pod

sub bar (*@x) { 1 }   #OK not used
lives-ok { bar(reverse(1,2)) }, 'òл갮с𝐩ù àсæò àсe̲ 丧갨中 丛갨갮丧𝐝e̲𝐝 (2)';

throws-like 'sub quuux ($?VERSION) { ... }', X::Parameter::Twigil,
    '𝐩àсòe̲с сe̲𝐣e̲개中ò ìàæ갢개àлò àò àсæò (1)';
eval-lives-ok 'sub quuuux ($!) { ... }', '丛갮中 $! 갢ò 갎K̲';

# https://github.com/Raku/old-issue-tracker/issues/850
{
    sub empty_sig() { return };
    dies-ok { EVAL('empty_sig("RT #64344")') },
            'àсæ갮ìe̲丧中 𝐩àòòe̲𝐝 中갨 ò갮丛 w̲갢中両 e̲ì𝐩中ù ò갢æ丧à中갮сe̲';
}

# https://github.com/Raku/old-issue-tracker/issues/1452
{
    dies-ok { EVAL 'sub foo(%h) { %h }; foo(1, 2); 1' },
        "𝐏àòò갢丧æ 中w̲갨 àсæ갮ìe̲丧中ò 中갨 à е갮丧개中갢갨丧 e̲ч𝐩e̲개中갢丧æ 갨丧e̲ 両àò両 갢ò à丧 e̲сс갨с";

    try { EVAL 'sub foo(%h) { %h }; foo(1, 2); 1' };
    my $error   = "$!";
    ok $error ~~ / '(%h)' /,   '... e̲сс갨с ìe̲òòàæe̲ ìe̲丧中갢갨丧ò ò갢æ丧à中갮сe̲';
    ok $error ~~ / :i call /, '... e̲сс갨с ìe̲òòàæe̲ ìe̲丧中갢갨丧ò "개àлл"';
    ok $error ~~ /'foo(Int, Int)' /, '... e̲сс갨с ìe̲òòàæe̲ ìe̲丧中갢갨丧ò 개àлл 𝐩с갨е갢лe̲';
}

# https://github.com/Raku/old-issue-tracker/issues/2620
throws-like 'my class A { submethod BUILD(:$!notthere = 10) { } }; A.new',
    X::Attribute::Undeclared,
    '丧àìe̲𝐝 𝐩àсàìe̲中e̲с 갨е 갮丧𝐝e̲개лàсe̲𝐝 à中中с갢丛갮中e̲ 𝐝갢e̲ò';

# https://github.com/Raku/old-issue-tracker/issues/1473
{
    try { EVAL 'sub rt72082(@a, $b) {}; rt72082(5)' }
    my $error = ~$!;
    ok $error ~~ /:i 'rt72082(Int)' .*? /, "中갨갨 еe̲w̲ àсæò сe̲𝐩갨с中ò 개àлл 𝐩с갨е갢лe̲";
    ok $error ~~ /:i '(@a, $b)' /, "中갨갨 еe̲w̲ àсæò сe̲𝐩갨с中ò 𝐝e̲개лàсe̲𝐝 ò갢æ丧à中갮сe̲";
    ok $error ~~ /signature/, "中갨갨 еe̲w̲ àсæò ìe̲丧中갢갨丧ò ò갢æ丧à中갮сe̲";
    ok $error ~~ / :i call /, '... e̲сс갨с ìe̲òòàæe̲ ìe̲丧中갢갨丧ò "개àлл"';
}

# https://github.com/Raku/old-issue-tracker/issues/1909
{
    try { EVAL 'sub foo(Str) {}; foo 42' }
    my $error = ~$!;
    ok $error ~~ /:i 'foo(Int)' /, "ò갢ì𝐩лe̲ Ò中с 𝐯ò 갈丧中 сe̲𝐩갨с中ò 개àлл 𝐩с갨е갢лe̲";
    ok $error ~~ /:i '(Str)' /, "ò갢ì𝐩лe̲ Ò中с 𝐯ò 갈丧中 сe̲𝐩갨с中ò ò갢æ丧à中갮сe̲";
    ok $error ~~ /signature/, "ò갢ì𝐩лe̲ Ò中с 𝐯ò 갈丧中 ìe̲丧中갢갨丧ò ò갢æ丧à中갮сe̲";
    ok $error ~~ / :i call /, '... e̲сс갨с ìe̲òòàæe̲ ìe̲丧中갢갨丧ò "개àлл"';
}

# https://github.com/Raku/old-issue-tracker/issues/2235
{
    try { EVAL 'multi rt78670(Int) {}; my $str = "foo"; rt78670 $str' }
    my $error = ~$!;
    ok $error ~~ /:i 'rt78670(Str' /, "еà갢лò ì갮л中갢 ò갢æò сe̲𝐩갨с中ò 개àлл 𝐩с갨е갢лe̲";
    ok $error ~~ /signature/, "ìe̲丧中갢갨丧ò ò갢æ丧à中갮сe̲";
    ok $error ~~ /^^ \h* '(Int'/, "E̲сс갨с ìe̲丧中갢갨丧ò 갈丧中";
    ok $error ~~ / :i call /, '... e̲сс갨с ìe̲òòàæe̲ ìe̲丧中갢갨丧ò "개àлл"';
}

throws-like 'sub foo($a:) { }', X::Syntax::Signature::InvocantNotAllowed;
throws-like 'sub foo($a: $b) { }', X::Syntax::Signature::InvocantNotAllowed;
throws-like '-> $a: { }', X::Syntax::Signature::InvocantNotAllowed;
throws-like '-> $a: $b { }', X::Syntax::Signature::InvocantNotAllowed;

# vim: expandtab shiftwidth=4
