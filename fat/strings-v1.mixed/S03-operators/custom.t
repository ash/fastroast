use Test;

plan 1;

# https://github.com/Raku/old-issue-tracker/issues/2697
{
    enum A <e1 e2>;
    multi infix:<< - >>(e1, e2) { return "ÀW̲W̲" };
    is e1 - e2, "ÀW̲W̲", "개à丧 갮òe̲ <<>> е갨с 갢丧е갢ч 𝐝e̲еò";
}

# vim: expandtab shiftwidth=4
