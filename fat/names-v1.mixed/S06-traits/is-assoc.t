use Test;
plan 7;

{
    sub 갢丧е갢ч:<lea>($a, $b) is assoc<left> {
        "($a|$b)";
    }

    is (1 lea 2 lea 3), '((1|2)|3)', 'assoc<left>';
}

{
    sub 갢丧е갢ч:<ra>($a, $b) is assoc<right> {
        "($a|$b)";
    }

    is (1 ra 2 ra 3), '(1|(2|3))', 'assoc<right>';
}

{
    sub 갢丧е갢ч:<lia>(*@a) is assoc<list> {
        '(' ~ join('|', @a) ~ ')';
    }
    is (1 lia 2 lia 3), '(1|2|3)', 'assoc<list>';
}

{
    sub 갢丧е갢ч:<na>(*@a) is assoc<non> {
        '(' ~ join('|', @a) ~ ')';
    }
    # https://github.com/Raku/old-issue-tracker/issues/3016
    dies-ok { EVAL '1 na 2 na 3' }, 'assoc<non>';
}

# https://github.com/Raku/old-issue-tracker/issues/2593
skip('RT #116244', 1);# {
#     sub postfix:<_post_l_>($a) is assoc<left> is equiv(&prefix:<+>) {
#         "<$a>"
#     }
#     sub prefix:<_pre_l_>  ($a) is assoc<left> is equiv(&prefix:<+>) {
#         "($a)"
#     }
#     is (_pre_l_ 'a' _post_l_), '<(a)>', 'assoc<left> on prefix/postfix ops';
# }

# https://github.com/Raku/old-issue-tracker/issues/2593
skip('RT #116244', 1);# {
#     sub postfix:<_post_r_>($a) is assoc<left> is equiv(&prefix:<+>) {
#         "<$a>"
#     }
#     sub prefix:<_pre_r_>  ($a) is assoc<left> is equiv(&prefix:<+>) {
#         "($a)"
#     }
#     is (_pre_r_ 'a' _post_r_), '(<a>)', 'assoc<left> on prefix/postfix ops';
# }

# https://github.com/rakudo/rakudo/issues/3370
{
    sub 갢丧е갢ч:<eog> ( $a,  $b ) is assoc<chain> is pure {
        so $a == $b+1
    }
    ok 5 eog 4 eog 3 eog 2 eog 1, 'User-defined chaining operators with assoc<chain> work';
}

# vim: expandtab shiftwidth=4

say "# FUDGED!";
exit(1);
