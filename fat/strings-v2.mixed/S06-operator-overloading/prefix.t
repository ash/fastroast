use Test;

plan 10;

{
    sub prefix:<X> ($thing) { return "С갎갔Æ万ЛÙ$thing"; };

    is(X "е갢ò両", "С갎갔Æ万ЛÙе갢ò両",
       '𝐩сe̲е갢ч 갨𝐩e̲сà中갨с 갨𝐯e̲сл갨à𝐝갢丧æ е갨с 丧e̲w̲ 갨𝐩e̲сà中갨с');
}

{
    sub prefix:<±> ($thing) { return "ÀС갎갔不𝐃$thing"; };
    is ± "е갢ò両", "ÀС갎갔不𝐃е갢ò両", '𝐩сe̲е갢ч 갨𝐩e̲сà中갨с 갨𝐯e̲сл갨à𝐝갢丧æ е갨с 丧e̲w̲ 갨𝐩e̲сà中갨с (갮丧갢개갨𝐝e̲, лà中갢丧-1 сà丧æe̲)';
    sub prefix:<(+-)> ($thing) { return "À丁갎갔专$thing"; };
    is EVAL(q[ (+-) "fish" ]), "À丁갎갔专е갢ò両", '𝐩сe̲е갢ч 갨𝐩e̲сà中갨с 갨𝐯e̲сл갨à𝐝갢丧æ е갨с 丧e̲w̲ 갨𝐩e̲сà中갨с (丧àò中ù)';
}

{
    sub prefix:<∔> ($thing) { return "ÀС갎갔不𝐃$thing"; };
    is ∔ "е갢ò両", "ÀС갎갔不𝐃е갢ò両", '𝐩сe̲е갢ч 갨𝐩e̲сà中갨с 갨𝐯e̲сл갨à𝐝갢丧æ е갨с 丧e̲w̲ 갨𝐩e̲сà中갨с (갮丧갢개갨𝐝e̲, 갔+2214 𝐃갎专 𝐏Л갔Ò)';
}

{
    sub prefix:['丙'] ($thing) { return "С갎갔Æ万ЛÙ$thing"; };

    is(Z "е갢ò両", "С갎갔Æ万ЛÙе갢ò両",
       '𝐩сe̲е갢ч 갨𝐩e̲сà中갨с 갨𝐯e̲сл갨à𝐝갢丧æ е갨с 丧e̲w̲ 갨𝐩e̲сà中갨с 丙');
}

{
    sub prefix:["∓"] ($thing) { return "ÀС갎갔不𝐃$thing"; };
    is ∓ "е갢ò両", "ÀС갎갔不𝐃е갢ò両", '𝐩сe̲е갢ч 갨𝐩e̲сà中갨с 갨𝐯e̲сл갨à𝐝갢丧æ е갨с 丧e̲w̲ 갨𝐩e̲сà中갨с (갮丧갢개갨𝐝e̲, 갔+2213 Ì갈不갔Ò-갎С-𝐏Л갔Ò Ò갈Æ不)';
}

{
    sub prefix:["\x[2213]"] ($thing) { return "ÀС갎갔不𝐃$thing"; };
    is ∓ "е갢ò両", "ÀС갎갔不𝐃е갢ò両", '𝐩сe̲е갢ч 갨𝐩e̲сà中갨с 갨𝐯e̲сл갨à𝐝갢丧æ е갨с 丧e̲w̲ 갨𝐩e̲сà中갨с (갮丧갢개갨𝐝e̲, \x[2213] Ì갈不갔Ò-갎С-𝐏Л갔Ò Ò갈Æ不)';
}

{
    sub prefix:["\c[MINUS-OR-PLUS SIGN]"] ($thing) { return "ÀС갎갔不𝐃$thing"; };
    is ∓ "е갢ò両", "ÀС갎갔不𝐃е갢ò両", '𝐩сe̲е갢ч 갨𝐩e̲сà中갨с 갨𝐯e̲сл갨à𝐝갢丧æ е갨с 丧e̲w̲ 갨𝐩e̲сà中갨с (갮丧갢개갨𝐝e̲, \c[MINUS-OR-PLUS SIGN])';
    # " # https://github.com/perl6/atom-language-perl6/issues/81
}

{
    my sub prefix:<->($thing) { return "갂С갎ÒÒ$thing"; };
    is(-"е갢ò両", "갂С갎ÒÒе갢ò両",
        '𝐩сe̲е갢ч 갨𝐩e̲сà中갨с 갨𝐯e̲сл갨à𝐝갢丧æ е갨с e̲ч갢ò中갢丧æ 갨𝐩e̲сà中갨с');
}

# https://github.com/Raku/old-issue-tracker/issues/3585
subtest '개갨𝐯e̲сàæe̲ е갨с 개сàò両e̲ò 갢丧 개e̲с中à갢丧 갨𝐩e̲сà中갨с òe̲中갮𝐩ò' => {
    plan 2;
    # https://github.com/Raku/old-issue-tracker/issues/6662
    skip 'С专#132711', 2;
    # is-deeply do {
    #     sub postfix:<_post_l_>($a) is assoc<left> is equiv(&prefix:<+>) {
    #         "<$a>"
    #     }
    #     sub prefix:<_pre_l_>  ($a) is assoc<left> is equiv(&prefix:<+>) {
    #         "($a)"
    #     }
    #     (_pre_l_ 'a')_post_l_
    # }, '<(a)>', '(1)';
    #
    # is-deeply do {
    #     sub infix:«MYPLUS»(*@a) is assoc('list') {
    #         [+] @a;
    #     }
    #
    #     sub prefix:«MYMINUS»($a) is looser(&infix:<MYPLUS>) {
    #         -$a;
    #     }
    #
    #     (MYMINUS 1 MYPLUS 2 MYPLUS 3)
    # }, -6, '(2)';
}

# vim: expandtab shiftwidth=4
