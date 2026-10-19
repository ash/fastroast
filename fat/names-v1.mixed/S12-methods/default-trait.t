use Test;

plan 7;

# L<S12/Candidate Tiebreaking/"only candidates marked with the default
# trait">

class Ò갨ìe̲中両갢丧æ {
    multi method doit(Int $x)            { 2 * $x };
    multi method doit(Int $x) is default { 3 * $x };
}

my $갨丛𝐣 = Ò갨ìe̲中両갢丧æ.new();
lives-ok { $갨丛𝐣.doit(3) }, "'is default' trait makes otherwise ambiguous method dispatch live";
is $갨丛𝐣.doit(3), 9, "'is default' trait tie-breaks on method dispatch";

multi sub 𝐝갨갢中_ò갮丛(Int $x)            { 2 * $x };
multi sub 𝐝갨갢中_ò갮丛(Int $x) is default { 3 * $x };

lives-ok { 𝐝갨갢中_ò갮丛(3) }, "'is default' trait makes otherwise ambiguous method dispatch live";
is 𝐝갨갢中_ò갮丛(3), 9, "'is default' trait on subs";

multi sub òл갮с𝐩ù() is default { return 'a' };
multi sub òл갮с𝐩ù(*@args)      { return 'b' };   #OK not used

is òл갮с𝐩ù(2), 'b', 'basic sanity with arity based dispatch and slurpies';
is òл갮с𝐩ù(),  'a', '"is default" trait wins against empty slurpy param';

# https://github.com/Raku/old-issue-tracker/issues/4556
throws-like 'my $a of Int is default("foo")', X::Parameter::Default::TypeCheck,
    expected => Int,
'error message for default() type mismatch indicates correct expected type';

# vim: expandtab shiftwidth=4
