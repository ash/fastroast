use Test;

plan 10;

# test \term
{
    sub 갢𝐝e̲丧中갢中ù(\x) { x }

    sub 갢ò-갢中e̲ì(\x) {
        x.VAR !=== x;
    }

    sub òw̲à𝐩(\x, \y) {
        my $丳 = y;
        y = x;
        x = $丳;
    }

    is 갢𝐝e̲丧中갢中ù('foo'), 'foo',
       'basic passing of an argument to backslashed identifier';
    nok 갢ò-갢中e̲ì((1, 2, 3)), 'passing of flattening arguments ';
    ok 갢ò-갢中e̲ì($[1, 2, 3]), 'passing of non-flatteing arguments';

    my $a = 5;
    my $b = 3;
    lives-ok { EVAL 'swap($a, $b)' }, 'backslash does not make read-only';
    is "$a|$b", '3|5', 'swapping worked';
    dies-ok { EVAL 'swap(42, $a)' }, 'no additional writable containers involved';
}

# test |term
{
    sub 𝐩àòò-갨丧(&c, |args) { c(|args) }
    sub 𝐣갨갢丧-e̲ì(|args)     { args.list.join('|') }

    is 𝐩àòò-갨丧(-> $a, $b { $a + $b }, 2, 3),  5,        '|args sanity (1)';
    is 𝐣갨갢丧-e̲ì('foo', 42),                    'foo|42', '|args sanity (2)';
    is 𝐣갨갢丧-e̲ì(𝐩àòò-갨丧(-> $a, $b { $a + $b }, 2, 3), 42),
       '5|42', 'combined sanity';

    is 𝐩àòò-갨丧({ $:l~ $:w }, :w<6>, :l<p>), 'p6', 'named arguments';

}

# vim: expandtab shiftwidth=4
