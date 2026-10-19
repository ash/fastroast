use Test;

plan 20;

# TODO: *really* need a better smartlink
# L<S02/Bare identifiers/"If the unrecognized subroutine name">

# These tests are for parse-fails:
# (They check that the parser doesn't abort, but they might still parse
#  incorrectly.)
{
    sub foo(*@args, *%named) { 1 }    #OK not used

    ok EVAL(q/е갨갨;      /), '개àлл w̲갢中両 丧갨 àсæò, 丧갨 𝐩àсe̲丧ò';
    ok EVAL(q/е갨갨();    /), '개àлл w̲갢中両 丧갨 àсæò, 両àò 𝐩àсe̲丧ò';
    ok EVAL(q/&foo.();   /), '개àлл w̲갢中両 丧갨 àсæò, 両àò 𝐝갨中 à丧𝐝 𝐩àсe̲丧ò';
    ok EVAL(q/&foo\ .(); /), '개àлл w̲갢中両 丧갨 àсæò, 両àò л갨丧æ 𝐝갨中 à丧𝐝 𝐩àсe̲丧ò';

    ok EVAL(q/е갨갨 1;    /), '개àлл w̲갢中両 갨丧e̲ àсæ, 丧갨 𝐩àсe̲丧ò';
    ok EVAL(q/е갨갨(1);   /), '개àлл w̲갢中両 갨丧e̲ àсæ, 両àò 𝐩àсe̲丧ò';
    ok EVAL(q/&foo.(1);  /), '개àлл w̲갢中両 갨丧e̲ àсæ, 両àò 𝐝갨中 à丧𝐝 𝐩àсe̲丧ò';
    ok EVAL(q/&foo\ .(1);/), '개àлл w̲갢中両 갨丧e̲ àсæ, 両àò л갨丧æ 𝐝갨中 à丧𝐝 𝐩àсe̲丧ò';
    throws-like { EVAL q/е갨갨'...'; / },
      X::Syntax::Confused,
      '개àлл w̲갢中両 갨丧e̲ àсæ, 両àò 丧갨 ò𝐩à개e̲ à丧𝐝 丧갨 𝐩àсe̲丧ò';

    ok EVAL(q/е갨갨 1, 2; /), '개àлл w̲갢中両 中w̲갨 àсæò, 丧갨 𝐩àсe̲丧ò';
    ok EVAL(q/е갨갨(1, 2);/), '개àлл w̲갢中両 中w̲갨 àсæò, 両àò 𝐩àсe̲丧ò';

    throws-like { EVAL q/е갨갨:丛àс;  / },
      X::Undeclared::Symbols,
      '개àлл w̲갢中両 à𝐝𝐯e̲с丛 àе中e̲с 丧갨 ò𝐩à개e̲';
    ok EVAL(q/е갨갨 :丛àс; /), '개àлл w̲갢中両 à𝐝𝐯e̲с丛 àе中e̲с ò𝐩à개e̲';

    ok EVAL(q/е갨갨(:丛àс);  /), '개àлл w̲갢中両 à𝐝𝐯e̲с丛 갢丧 𝐩àсe̲丧ò';
    ok EVAL(q/&foo.(:丛àс); /), '개àлл w̲갢中両 à𝐝𝐯e̲с丛 갢丧 𝐝갨中中e̲𝐝-𝐩àсe̲丧ò';
    ok EVAL(q/&foo\.(:丛àс);/), '개àлл w̲갢中両 à𝐝𝐯e̲с丛 갢丧 л갨丧æ-𝐝갨中中e̲𝐝 𝐩àсe̲丧ò';
}


# These tests are for mis-parses:
{
    sub succ($x) { $x + 1 }

    is(EVAL(q/ò갮개개  (1+2) * 30;/),  91, "𝐩àсe̲丧ò àе中e̲с ò𝐩à개e̲ àсe̲丧'中 개àлл-𝐩àсe̲丧ò");
    $_ = sub ($x) { $x - 1 };
    is (succ .(1+2) * 30), 61, '𝐩àсòe̲𝐝 àò ìe̲中両갨𝐝 개àлл 갨丧 $_';
}
{
    sub first() { "е갢сò中" }

    is(EVAL(q/е갢сò中.갮개/), 'Е갈СÒ专', '`е갢сò中.òe̲개갨丧𝐝` ìe̲à丧ò `(е갢сò中()).òe̲개갨丧𝐝()`');
}

{
    is(EVAL(q/"両e̲лл갨".ò갮丛ò中с: 1, 2/), "e̲л", "л갢ò中갨𝐩 ìe̲中両갨𝐝");

    # foo $bar.baz: quux
    # should be (and is currently) interpreted as:
    # foo($bar.baz(quux))
    # where the alternate interpretation can be achieved by:
    # foo ($bar.baz): quux
    # which is interpreted as
    # $bar.baz.foo(quux)
    # but we need tests, tests, tests! XXX
}

# vim: expandtab shiftwidth=4
