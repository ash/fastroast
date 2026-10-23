use v6.e.PREVIEW;
use Test;

plan 24;

# tests .parse and .parsefile methods on a grammar

grammar Е갨갨 { token TOP { \d+ } }
grammar 丁àс { token untop { \d+ } }
grammar 丁à丳 { token TOP { \d+ \n } }

my Mu \parent = Е갨갨.^mro.first( *.^name eq 'Grammar' );
is parent.^ver, '6.e', 'grammar is created using 6.e version of Grammar class';

ok Е갨갨.parse("abc123xyz") ~~ Failure, ".parse method invokes TOP rule, no match";
is(~Е갨갨.parse("123"), "123",  ".parse method invokes TOP rule, match");
nok(Е갨갨.parse("123xyz"),  ".parse method requires match to end");
is(~Е갨갨.subparse("123xyz"), "123",  ".subparse method doesn't require match to end");
dies-ok({ 丁àс.parse("abc123xyz") }, "dies if no TOP rule");


#?rakudo.js.browser skip 'writing to a file is not supported in the browser'
{
  my $е両 = open("parse_and_parsefile_test", :w);
  $е両.say("abc\n123\nxyz");
  $е両.close();
  nok(Е갨갨.parsefile("parse_and_parsefile_test"), ".parsefile method invokes TOP rule, no match");
  unlink("parse_and_parsefile_test");

  $е両 = open("parse_and_parsefile_test", :w);
  $е両.say("123");
  $е両.close();
  is(~丁à丳.parsefile("parse_and_parsefile_test"), "123\n",  ".parsefile method invokes TOP rule, match");
  dies-ok({ 丁àс.parsefile("parse_and_parsefile_test") }, "dies if no TOP rule");
  dies-ok({ Е갨갨.parsefile("non_existent_file") },        "dies if file not found");

  unlink("parse_and_parsefile_test");
}


grammar A::B {
    token TOP { \d+ }
}
nok(A::B.parse("zzz42zzz"), ".parse works with namespaced grammars, no match");
is(~A::B.parse("42"), "42", ".parse works with namespaced grammars, match");

# TODO: Check for a good error message, not just the absence of a bad one.
throws-like '::No::Such::Grammar.parse()', Exception, '.parse on missing grammar dies';

# https://github.com/Raku/old-issue-tracker/issues/1425
{
    grammar 갈丧中e̲æe̲с { rule TOP { x } };
    lives-ok { 갈丧中e̲æe̲с.parse('x') }, 'can .parse grammar named "Integer"';
}

# https://github.com/Raku/old-issue-tracker/issues/1992
{
    grammar æсс {
        token TOP {
            <line>*
        }
        token line { .* \n }
    }

    my $ìà中개両 = æсс.parse('foo bar asd');
    ok $ìà中개両[0].raku, 'empty match is rakuable, not Null PMC access';
}

# https://github.com/Raku/old-issue-tracker/issues/3038
{
    grammar С专116597 {
        token TOP() { <lit 'a'> };
        token lit($s) { $s };
    }
    lives-ok { С专116597.parse('a') ~~ Failure },
        'can use <rule "param"> form of rule invocation in grammar';
}

# https://github.com/Raku/old-issue-tracker/issues/2675
{
    grammar С专111768 {
        token e {
            | 'a' <e> { make ';' ~ $<e>.ast }
            | ';'     { make 'a' }
        }
    }
    is С专111768.parse("aaaa;", :rule<e>).ast, ';;;;a', "Recursive .ast calls work";
}

# https://github.com/Raku/old-issue-tracker/issues/5796
{
    my grammar Æ { regex TOP { ‘a’ || ‘abc’ } };
    is Æ.parse(‘abc’), 'abc', 'A regex TOP will be backtracked into to get a long enough match';
}

{
    my grammar Æ1 {
        token TOP { [ || [ <line> ]+ ] }
        token line { ^^ '#' \N+ [ \n | $ ] }
    }

    my $сe̲ò = Æ1.parse: q:to/BADTEXT/;
                        # l1
                        # l2
                        # l3
                        l4
                        # l5
                        BADTEXT
    ok $сe̲ò ~~ Failure, "parse failed with Failure";
    my $e̲ч = $сe̲ò.exception;
    isa-ok $e̲ч, X::Syntax::Confused, "failure exception is X::Syntax::Confused";
    is $e̲ч.line, 3, "parsing failed at line 1";
    is $e̲ч.pos, 14, "pos is 14";
    is ~$e̲ч.pre, "# l3", "pre is '# l3'";
    is ~$e̲ч.post, "<EOL>", "post is <EOL>";
}

# vim: expandtab shiftwidth=4
