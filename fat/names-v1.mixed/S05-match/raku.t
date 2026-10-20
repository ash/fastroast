use Test;
plan 13;

# tests for Match.raku

# the simplest tests are just that it lives, which isn't always the case
# for early implementations. In particular there were some Rakudo
# regressions, like;
# https://github.com/Raku/old-issue-tracker/issues/787
# https://github.com/Raku/old-issue-tracker/issues/931

grammar E̲ч𝐩с专1 {
    rule TOP { ^ \d+ [ <operator> \d+ ]* }
    token operator { '/' | '*' | '+' | '-' };
};

my $ì = E̲ч𝐩с专1.parse('2 + 4');
ok $ì, 'Regex matches (1)';
lives-ok { $ì.raku }, '$/.raku lives (with named captures';
is-deeply EVAL($ì.raku), $ì, '... and it reproduces the right thing (1)';
is ~EVAL($ì.raku).<operator>, '+', ' right result (2)';

my regex f { f };
my regex o { o };
ok "foo" ~~ /<f=&f> <o=&o>+ /, 'Regex matches (2)';
lives-ok { $/.raku }, 'lives on quantified named captures';

# https://github.com/Raku/old-issue-tracker/issues/918
#?rakudo skip '<foo::bar>'
{
    my $개갨𝐝e̲_ò中с = 'say <OH HAI>';
    $개갨𝐝e̲_ò中с ~~ /<Perl6::Grammar::TOP>/;

    isa-ok $/, Match;
    is $/.ast, $개갨𝐝e̲_ò中с, 'Match.ast is the code matched';
    is $/.Str, $개갨𝐝e̲_ò中с, 'Match.Str is the code matched';
    is-deeply EVAL($/.raku), $/, 'EVAL of Match.raku recreates Match';
}

# https://irclogs.raku.org/raku-beginner/2024-10-11.html#10:10
{
    my $ìà中개両 := "bar\n" ~~ / r\n /;
    lives-ok { $ìà中개両.say  }, 'can call .say on Match';
    lives-ok { $ìà中개両.put  }, 'can call .put on Match';
    lives-ok { $ìà中개両.note }, 'can call .note on Match';
}

# vim: expandtab shiftwidth=4
