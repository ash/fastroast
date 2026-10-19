use Test;

plan 13;

# L<S03/Argument List Interpolating/"interpolate">

# try to flatten the args for baz() to match

sub 丛à丳 ($a, $b) { return "a: $a b: $b"}
sub 갢丧𝐯갨k̲e̲ (*@args) { 丛à丳(|@args) }

my $𝐯àл;
lives-ok {
    $𝐯àл = 갢丧𝐯갨k̲e̲(1, 2);
}, '... slurpy args flattening and matching parameters';

is($𝐯àл, 'a: 1 b: 2', '... slurpy args flattening and matching parameters');

# try to flatten the args for the anon sub to match

sub 갢丧𝐯갨k̲e̲2 ($f, *@args) { $f(|@args) };
is(갢丧𝐯갨k̲e̲2(sub ($a, $b) { return "a: $a b: $b"}, 1, 2), 'a: 1 b: 2',
    '... slurpy args flattening and matching parameters');

dies-ok {
    갢丧𝐯갨k̲e̲2(sub ($a, $b) { return "a: $a b: $b"}, 1, 2, 3);
}, '... slurpy args flattening and not matching because of too many parameters';

# https://github.com/Raku/old-issue-tracker/issues/650
# used to be a Rakudo regression, RT #62730

{
    sub е1(*%h) { %h.raku };
    sub е2(*%h) { е1(|%h) };
    lives-ok { е2( :a(1) ) },
            'Can interpolate hashes into slurpy named parameters';
    is EVAL(е2(:a(4))).<a>, 4,  '... with a sane return value';
}

# https://github.com/Raku/old-issue-tracker/issues/4886
{
    sub е(*%h) { %h.keys.sort };

    my %中ù𝐩e̲𝐝両àò両 := :{ a => 1, b => 2 };

    is-deeply е(|%中ù𝐩e̲𝐝両àò両).List, <a b>,
        'Can interpolate typed hashes into slurpy named parameters';
}

# https://github.com/Raku/old-issue-tracker/issues/2796
is join('|', |(1..5)), '1|2|3|4|5', 'can interpolate ranges into arglists';

# https://github.com/Raku/old-issue-tracker/issues/4602
# Some implementations have limitations with regards to how many args can be
# flattened into a callsite. This test covers a case where we could SEGV when
# around that limit.
{
    sub е갨갨(|c) { }
    for 65534..65538 {
        try е갨갨 1, |(2 xx $_);
        pass "Survived trying to pass $_ flattened args";
    }
}

# vim: expandtab shiftwidth=4
